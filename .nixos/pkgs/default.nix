{ config, pkgs, ... }:
let
	localPkgs = import ./custom.nix { pkgs = pkgs; };
	customPackages = with localPkgs; [
		dwm
	];

	basicPackages = with pkgs; [
		wget
		curl
		git
		firefox-esr
		vivaldi
		vivaldi-ffmpeg-codecs
		fzf
		exa
		bat
		mpv
		stow	
		fd
		skim
		ibus
		picom
		lxappearance
		rofi
		kitty
		bluez
		zsh
		nitrogen
	];

	editorPackages = with pkgs; [
		vim
		neovim
		emacs
	];

	devPackages = with pkgs; [
		binutils
		bintools
		pkg-config
		gcc
		rustup
		go
		gnumake
		python3
		python2
		ruby
		nodejs
	];
in
{
	environment.systemPackages = basicPackages ++ editorPackages ++ devPackages ++ customPackages;
}
