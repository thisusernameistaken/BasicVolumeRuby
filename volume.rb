vol = "amixer sget Master | grep %"
vol = `#{vol}`
vols = vol.split(" ")
puts "#{vols[4]}#{vols[6]}"
