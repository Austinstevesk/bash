# Adjust the keyboard backlight level for ASUS VivoBook (Ubuntu)

# How to install
  cp backLight.sh /usr/local/bin/backlight
  chmod +x /usr/local/bin/backlight

# This script requires sudo so it needs to add following line in 'sudoers' file
  your_username ALL=(root) NOPASSWD: /usr/local/bin/backlight

# Run command
  sudo backlight -e
  sudo backlight -d
