require 'gtk2'

class VolCntrl < Gtk::Window

	def initialize
		super
		
		signal_connect "destroy" do 
            Gtk.main_quit 
        end
		
		fixed = Gtk::Fixed.new
		add fixed
		
		vol = "amixer sget Master | grep %"
		vol = `#{vol}`
		vols = vol.split(" ")
		currentVol = vols[4]
		currentVol= currentVol[1,currentVol.length-3].to_i
		puts currentVol
		
		
		slider = Gtk::HScale.new 0, 100, 1
		slider.set_size_request 200, 50
		slider.value = currentVol
		slider.signal_connect "value-changed" do
			cmd = "amixer set Master #{slider.value.to_i}%"
			cmd = `#{cmd}`
		end
		
		button = Gtk::Button.new "Mute/UnMute"
		button.set_size_request 130, 40
		button.signal_connect "clicked" do
			cmdMute = "amixer set Master toggle"
			cmdMute = `#{cmdMute}`
		end
		button.signal_connect "released" do
			vol = "amixer sget Master | grep %"
			vol = `#{vol}`
			vols = vol.split(" ")
			currentVol = vols[4]
			currentVol= currentVol[1,currentVol.length-3].to_i
			cmdR = "notify-send -t 325 #{vols[6]}"
			cmdR = `#{cmdR}`
		end
		
		
		fixed.put slider, 10, 10
		fixed.put button, 220, 10
		set_title "Volume Control"
		
		set_default_size 340, 50
		
		
		
		show_all
	end
	
end

Gtk.init 
	window = VolCntrl.new
Gtk.main
