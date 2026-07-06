#!/bin/bash

cat <<'EOL' | crontab -
SHELL=/bin/bash
BASH_ENV=/etc/profile

*/5 * * * * bash /root/setup/hosts.bash
EOL
