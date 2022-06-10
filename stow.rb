# frozen_string_literal: true

Dir
	.entries(".")
	.select { |dir| File.directory?(File.join(".", dir)) && dir[0] != "." }
	.each do |dir|
		puts "Linking #{dir}'s config..."
		puts(`stow #{dir}`)
	end
