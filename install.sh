#!/bin/bash

cat << "EOF"
╔═════════════════════════════════════════╗
║                                         ║
║                    -`                   ║
║                   .o+`                  ║
║                  `ooo/                  ║
║                 `+oooo:                 ║
║                `+oooooo:                ║
║                -+oooooo+:               ║
║              `/:-:++oooo+:              ║
║             `/++++/+++++++:             ║
║            `/++++++++++++++:            ║
║           `/+++ooooooooooooo/`          ║
║          ./ooosssso++osssssso+`         ║
║         .oossssso-````/ossssss+`        ║
║        -osssssso.      :ssssssso.       ║
║       :osssssss/        osssso+++.      ║
║      /ossssssss/        +ssssooo/-      ║
║    `/ossssso+/:-        -:/+osssso+-    ║
║   `+sso+:-`                 `.-/+oso:   ║
║  `++:.                           `-/+/  ║
║  .`                                 `/  ║
║                                         ║
╟─────────────────────────────────────────╢
║                   A I S                 ║
╟─────────────────────────────────────────╢
║       Automated Installation Script     ║
╚═════════════════════════════════════════╝
EOF

# Check if the user is root
if [ "$EUID" -ne 0 ]
  then printf "\nYou don't have administrator privileges. Please run this script with sudo.\n"
  exit
fi

pacman --noconfirm -Syu
printf "\n>> System updated\n"

printf "\n>> Packages installation\n"
packages_list=packages2install.txt
while read -r pkg_name
do
    echo "Installing $pkg_name"
    pacman --noconfirm --needed -S "$pkg_name"
done < "$packages_list"

systemctl enable lightdm

printf "The installation is complete. The system will reboot in :\n"

seconds=5     # set the number of seconds for the timer
interval=0.25 # set the interval for the quarter second timer

for ((i=seconds; i>=0; i--)); do
    sleep $interval
    printf "%s" "$i"
    if [ "$i" != 0 ]; then
        for ((j=1; j<=3; j++)); do
            sleep $interval
            printf "%s" "."
        done
    fi
done

printf "\n\nReboot now. Thanks for using AIS !\n"
sleep 2

reboot now
