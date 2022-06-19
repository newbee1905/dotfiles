# frozen_string_literal: true

Dir
	.entries(".")
	.select { |dir| File.directory?(File.join(".", dir)) && dir[0] != "." }
	.each do |dir|
		# puts "Linking #{dir}'s config..."
		Dir.entries("./#{dir}").each do |file| 
			next if file == "." || file == ".."
			if File.directory?(File.join("/home/newbee", file))
				`rm -rf /home/newbee/#{file}/#{dir}`
			else
				`rm /home/newbee/#{file}`
			end
		end
		`stow #{dir}`
	end
