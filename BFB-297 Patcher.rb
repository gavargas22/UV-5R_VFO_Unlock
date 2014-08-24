require 'rubygems'
require 'serialport' #gem install serialport
exit if Object.const_defined?(:Ocra) #allow ocra to create an exe without executing the entire script

puts "This Patcher is for use ONLY with Firmware BFB297"
puts "This software does NOT confirm your model at this time."
puts "Hold down the 3 key while powering on the unit to confirm it's version"
puts "I take no responsibility for any damanges or misuse."
puts ""
puts "Turn on radio, connect cable, enter port NUMBER and hit enter to begin"
print "Enter Com port #: "
port = gets.chomp

serial = SerialPort.new("COM#{port}", 9600)
serial.read_timeout = 200
serial.write("\x50\xbb\xff\x20\x12\x07\x25") #contains initialization to program
serial.readlines
serial.write("\x02") #requests firmware version
serial.readlines
serial.write("\x06")
serial.readlines
serial.write("\x58\x1f\xc0\x10\x01\x01\x30\x01\x80\x01\x04\x00\x05\x20\x01\x0e\x0f\x10\x11\x15") #contains VHF/UHF freqs
serial.readlines
serial.write("\x06\x58\x1e\xe0\x10\x20\x20\x56\x46\x4f\x20\x20\x55\x4e\x4c\x4f\x43\x4b\x44\x00\x00") #contains pwr on msg


puts "Programming complete"
puts "Patch applied"
puts "New Ranges: 130-180Mhz and 400-520Mhz"
sleep(10)