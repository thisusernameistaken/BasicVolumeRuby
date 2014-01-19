volx = "sudo amixer set Master 5%+ unmute"
volx = `#{volx}`
vol = "amixer sget Master | grep %"
vol = `#{vol}`
vols = vol.split(" ")
exec("notify-send -t 325 #{vols[4]}")

