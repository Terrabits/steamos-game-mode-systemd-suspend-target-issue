#/usr/bin/env bash
set -o errexit  # Exit immediately if a command exits with a non-zero status
set -o pipefail # Return value of a pipeline is the status of the last command to exit with a non-zero status
set -o nounset  # Treat unset variables as an error when substituting
readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# copy services to system-level location
sudo cp "$ROOT_DIR/after-suspend.service" "$ROOT_DIR/before-suspend.service" /etc/systemd/system/
cp "$ROOT_DIR/after-suspend.sh" "$ROOT_DIR/before-suspend.sh" /home/deck/

# set permissions
sudo chown root:root /etc/systemd/system/after-suspend.service
sudo chmod 644 /etc/systemd/system/after-suspend.service

sudo chown root:root /etc/systemd/system/before-suspend.service
sudo chmod 644 /etc/systemd/system/before-suspend.service

chmod +x /home/deck/after-suspend.sh /home/deck/before-suspend.sh

# reload systemd services
sudo systemctl daemon-reload

# enable services
sudo systemctl enable after-suspend.service
sudo systemctl enable before-suspend.service

# start services
sudo systemctl start after-suspend.service
sudo systemctl start before-suspend.service
