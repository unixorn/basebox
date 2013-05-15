#!/bin/sh

# INSTALL
wget -O- http://hydra.nixos.org/build/4954109/download/1/nix-1.5.2-x86_64-linux.tar.bz2 \
    | tar xj -C /
sudo -i nix-finish-install

# DEFAULT PROFILE
ln -sf /nix/var/nix/profiles/default/etc/profile.d/nix.sh \
    /etc/profile.d/nix.sh

# NIX-DEFEXPR DIR
echo '[ ! -d $HOME/.nix-defexpr ] && mkdir $HOME/.nix-defexpr' \
    | tee /etc/profile.d/nix-defexpr.sh

# DAEMON USERS
grep '/bin/false' /etc/shells||(echo '/bin/false'|tee -a /etc/shells)
groupadd -r nixbld
for i in `seq 1 10`; do
    useradd -r                 \
        -g nogroup             \
        -G nixbld              \
        -d /var/empty          \
        -s /bin/false          \
        -c "Nix Build User $i" \
        nixbld$i;
done

# DAEMON PERMS
chgrp nixbld /nix/store
chmod 1775   /nix/store
mkdir -p     /nix/var/nix/profiles/per-user
chmod 1777   /nix/var/nix/profiles/per-user /nix/var/nix/profiles

# DAEMON CONFIG
mkdir /etc/nix
echo 'build-users-group = nixbld' | tee /etc/nix/nix.conf
echo 'export NIX_REMOTE=daemon'   | tee /etc/profile.d/nix-worker.sh
cat >/etc/init/nix-worker.conf <<\EOF
start on runlevel [2345]
stop  on runlevel [016]
respawn
exec /nix/var/nix/profiles/default/bin/nix-worker --daemon
EOF

# NIX UPDATE
service nix-worker start
sudo -i nix-channel --update
sudo -i nix-env -u nix-1.5.2
sudo -i nix-collect-garbage -d
