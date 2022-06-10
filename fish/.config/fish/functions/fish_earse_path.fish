function fish_earse_path -a id -d "Remove fish's PATH[id]"
	set --erase --universal fish_user_paths[$id]
end
