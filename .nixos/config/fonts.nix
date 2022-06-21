{ config, pkgs, ... }:

let
	normalFonts = with pkgs; [
		mplus-outline-fonts.githubRelease
	];

	nerdFonts = with pkgs; [
		(nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
	];
in
{
	imports = [ ];
	fonts.fonts = normalFonts ++ nerdFonts;
}
