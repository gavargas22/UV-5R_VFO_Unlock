require 'rubygems'
require 'serialport' #gem install serialport
require 'green_shoes' #gem install green_shoes
#don't even think about bothering with ocra on this one guys

##copyright
#This software is licensed under GPL version 2. See file
#COPYING for details.
#
#(c) 2014 Harold Giddings, KR0SIV
##End Copyright

Shoes.app title: "KR0SIV Software: BFB-251 VFO Patcher", width: 420, height: 120 do
	background gray
	@note = para "This Patcher is for use ONLY with Firmware BFB251"
    #@note = para "This software does NOT confirm your model at this time."
    #@note = para "Hold down the 3 key while powering on the unit to confirm it's version"
    @note = para "I take no responsibility for any damanges or misuse."
	para "Select your COM port: "

    @my_list_box = list_box(
    items: ["COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9", "COM10"], 
    width: 120,) 
	button "Begin Patching Process" do
	alert "Ensure Firmware 251 Before Pressing OK. Hold key 3 while powering on radio."
	alert "Patching May Brick Your Device, Press OK to Patch NOW"
	port = @my_list_box.text
	serial = SerialPort.new("#{port}", 9600)
	serial.read_timeout = 200
	serial.write("\x50\xBB\xFF\x01\x25\x98\x4D") #contains initialization to program
	serial.readlines
	serial.write("\x02") #requests firmware version
	serial.readlines
	serial.write("\x06")
	serial.readlines
	serial.write("\x58\x1f\xc0\x10\x00\x00\x00\x02\x02\x02\x01\x00\x00\x00\x01\x01\x34\x01\x80\x00") #contains VHF freqs (\x01\x34\x01\x80)
	serial.readlines
	serial.write("\x06\x58\x1f\xd0\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x04\x00\x05\x20\x00") #contains UHF freqs (x01\x04\x00\x05\x20)
	serial.readlines
	serial.write("\x06\x58\x1e\xe0\x10\x20\x20\x56\x46\x4f\x20\x20\x55\x4e\x4c\x4f\x43\x4b\x20\x00\x00") #contains pwr on msg (ASCII)
	alert "Programming Complete"
    end
	end