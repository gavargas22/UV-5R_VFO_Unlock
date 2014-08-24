require 'rubygems'
require 'serialport' #gem install serialport
exit if Object.const_defined?(:Ocra) #allow ocra to create an exe without executing the entire script

puts "This Patcher is for use ONLY with Firmware BFB251"
puts "This software does NOT confirm your model at this time."
puts "Hold down the 3 key while powering on the unit to confirm it's version"
puts "I take no responsibility for any damanges or misuse."
puts ""
puts "Turn on radio, connect cable, enter port NUMBER and hit enter to begin"
print "Enter Com port #: "
port = gets.chomp

serial = SerialPort.new("COM#{port}", 9600)
serial.read_timeout = 200
serial.write("\x50\xBB\xFF\x01\x25\x98\x4D") #contains initialization to program
serial.readlines
serial.write("\x02") #requests firmware version
serial.readlines
serial.write("\x06")
serial.readlines
serial.write("\x58\x1f\xc0\x10\x00\x00\x00\x02\x02\x02\x01\x00\x00\x00\x01\x01\x34\x01\x80\x00") #contains VHF freqs
serial.readlines
serial.write("\x06\x58\x1f\xd0\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x04\x00\x05\x20\x00") #contains UHF freqs
serial.readlines
serial.write("\x06\x58\x1e\xe0\x10\x20\x20\x56\x46\x4f\x20\x20\x55\x4e\x4c\x4f\x43\x4b\x20\x00\x00") #contains pwr on msg


puts "Programming complete"
puts "Patch applied"
puts "New Ranges: 130-180Mhz and 400-520Mhz"
sleep(10)

##figure out read-timeout value to ensure script stops to read