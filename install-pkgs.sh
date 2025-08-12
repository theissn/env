sudo pacman --needed -S \
	chromium firefox \
	docker docker-compose \
	php php-sqlite composer \
	git lazygit \
	go \
	hyprland hyprlock hyprshot brightnessctl mako waybar wofi hypridle \
	xdg-desktop-portal-hyprland hyprpolkitagent polkit-gnome gnome-keyring \
	cliphist \
	gnome-themes-extra \
	uwsm libnewt \
	bluez bluez-utils blueberry \
	bash-completion \
	btop \
	mise \
	openssh \
	pipewire wireplumber pavucontrol \
	ttf-font-awesome noto-fonts-emoji ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk \
	ttf-ubuntu-mono-nerd ttf-ubuntu-nerd ttf-ubuntu-font-family \
	tmux \
	zathura zathura-pdf-mupdf tesseract-data-eng \
	nautilus sushi ffmpegthumbnailer \
	vim \
	tlp tlp-rdw \
	tree \
	ripgrep fzf \
	ghostty \
	yt-dlp mpv \
	wlsunset \
	man-db less \
	cups cups-pdf cups-filters system-config-printer \
	transmission-cli \
	wireguard-tools systemd-resolvconf nmap cifs-utils afpfs-ng \
	fwupd impala rust rsync code newsboat \
	telegram-desktop

sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now cups.service

sudo systemctl enable tlp.service
sudo systemctl enable NetworkManager-dispatcher.service
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket

systemctl --user enable --now hypridle.service
