{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			./pkgs/default.nix
			./config/default.nix
		];

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.grub.useOSProber = true;

	networking.hostName = "newbee"; # Define your hostname.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Asia/Ho_Chi_Minh";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_GB.utf8";

	# Enable the X11 windowing system.
	services.xserver.enable = true;
	hardware.nvidia.modesetting.enable = true;
	services.xserver.videoDrivers = [ "nvidia" ];
	hardware.opengl.enable = true;

	# Optionally, you may need to select the appropriate driver version for your specific GPU.
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

	hardware.bluetooth.enable = true;


	# Enable the KDE Plasma Desktop Environment.
	# services.xserver.displayManager.sddm.enable = true;
	# services.xserver.desktopManager.plasma5.enable = true;

	# Configure keymap in X11
	services.xserver = {
		layout = "us";
		xkbVariant = "";
	};

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# If you want to use JACK applications, uncomment this
		jack.enable = true;

		# use the example session manager (no others are packaged yet so this is enabled by default,
		# no need to redefine it in your config for now)
		#media-session.enable = true;
	};

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.newbee = {
		isNormalUser = true;
		createHome = true;
		description = "newbee";
		extraGroups = [ "networkmanager" "wheel" ];
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#	 enable = true;
	#	 enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;
	services.unbound.enable = true;
	zramSwap = {
		enable = true;
		algorithm = "zstd";
		memoryPercent = 150;
	};

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "22.05"; # Did you read the comment?
}
