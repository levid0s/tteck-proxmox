#!/usr/bin/env bash

# Copyright (c) 2021-2025 tteck
# Author: MickLesk
# License: MIT
# https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

function header_info {
  clear
  cat <<"EOF"
   __  __          __      __          ____                 
  / / / /___  ____/ /___ _/ /____     / __ \___  ____  ____ 
 / / / / __ \/ __  / __ `/ __/ _ \   / /_/ / _ \/ __ \/ __ \
/ /_/ / /_/ / /_/ / /_/ / /_/  __/  / _, _/  __/ /_/ / /_/ /
\____/ .___/\__,_/\__,_/\__/\___/  /_/ |_|\___/ .___/\____/ 
    /_/                                      /_/            
EOF
}

set -eEuo pipefail
BL=$(echo "\033[36m")
RD=$(echo "\033[01;31m")
GN=$(echo "\033[1;92m")
CL=$(echo "\033[m")

header_info
echo "Loading..."
NODE=$(hostname)

function update_container() {
  container=$1
  os=$(pct config "$container" | awk '/^ostype/ {print $2}')

  if [[ "$os" == "ubuntu" || "$os" == "debian" ]]; then
      :
  else
    echo -e "${BL}[Info]${GN} Skipping ${BL}$container${CL} (not Debian/Ubuntu)\n"
  fi
}

header_info
for container in $(pct list | awk '{if(NR>1) print $1}'); do
  update_container "$container"
done

header_info
echo -e "${GN}The process is complete.\n"
