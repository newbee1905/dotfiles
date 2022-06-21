{ config, pkgs, ... }:

{
	imports = [ ];

	services.xserver = {
		displayManager = { 
			defaultSession = "dwm"; 
			sessionCommands = ''
				${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource modesetting NVIDIA-0
				LEFT='DP-2'
				LEFT_REFRESH_RATE=144
				RIGHT='HDMI-0'
				RIGHT_REFRESH_RATE=75
				${pkgs.xorg.xrandr}/bin/xrandr --output $LEFT --primary --auto --rotate normal --rate $LEFT_REFRESH_RATE --output $RIGHT --auto --rotate normal --rate $RIGHT_REFRESH_RATE --left-of $LEFT
			'';
			lightdm = { 
				enable = true; 
			}; 
		};
		windowManager = {
			dwm.enable = true;
		};
	};
}
