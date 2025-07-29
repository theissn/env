sudo pacman -S --needed \
	vim base-devel git libx11 libxft xorg-server xorg-xinit ttf-font-awesome ttf-dejavu firefox chromium bluez bluez-utils neovim btop \
	ripgrep fzf tmux openssh xclip dunst libnotify gnome-keyring newsboat pavucontrol \
	yt-dlp mpv ffmpeg zathura zathura-pdf-mupdf tesseract-data-eng slock man-db gnome-themes-extra \
	wireguard-tools openresolv mise \
	php php-sqlite composer \
	brightnessctl noto-fonts


systemctl --user start ssh-agent.service
sudo systemctl enable --now bluetooth.service
