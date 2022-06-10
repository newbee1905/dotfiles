function fish_list_path -d "List fish's PATH"
	echo $fish_user_paths | tr " " "\n" | nl
end
