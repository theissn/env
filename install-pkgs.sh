sudo pacman --needed -S \
	chromium firefox \
	docker docker-compose \
	php php-sqlite composer \
	git lazygit \
	go \
	hyprland hyprlock hyprshot brightnessctl mako waybar wofi hypridle \
	xdg-desktop-portal-hyprland hyprpolkitagent polkit-gnome \
	cliphist \
	gnome-themes-extra \
	uwsm libnewt \
	bluez bluez-utils blueman \
	bash-completion \
	btop \
	mise \
	openssh \
	pipewire wireplumber pavucontrol \
	ttf-font-awesome noto-fonts-emoji ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk \
	tmux \
	zathura zathura-pdf-poppler \
	neovim vim \
	tlp tlp-rdw \
	tree \
	ripgrep fzf \
	ghostty \
	yt-dlp mpv \
	wlsunset \
	man-db less \
	cups cups-pdf cups-filters system-config-printer

sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now cups.service

sudo systemctl enable tlp.service
sudo systemctl enable NetworkManager-dispatcher.service
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket

systemctl --user enable --now hypridle.service

mise use -g node@22
mise use -g ruby@3
