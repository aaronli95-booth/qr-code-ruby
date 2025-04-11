require "rqrcode"
require "pry"

user_qrcode = ""
user_input = ""
user_name = ""
send_name = ""
send_number = ""
message = ""
break_var, name_var, num_var, msg_var = true, true, true, true

#binding.pry

while break_var do

  while name_var do
    print "Enter your name: "; user_name = gets.chomp
    print "Hello #{user_name}! Let's make a QR code to send a text message. "
    name_var = false
  end

  while num_var do
    print "What number do you want to send to?\n"; send_number = gets.chomp
    print "Awesome! Just wanted to make sure the number is: #{send_number}, yes or no?\n"; user_input = gets.chomp
    if user_input.downcase.include?("yes") && !user_input.downcase.include?("not") && !user_input.downcase.include?("no")
      num_var = false
    else
      print "Okay, let's try this again\n"
    end
  end

  while msg_var do
    print "Awesome, the number you want to send to is #{send_number}. What message do you want to send this person?\n"; message = gets.chomp
    print "Awesome, your message to #{send_number} is #{message}. Is this okay, yes or no?\n"; user_input = gets.chomp
    if user_input.downcase.include?("yes") && !user_input.downcase.include?("not") && !user_input.downcase.include?("no")
      msg_var = false
    else
      print "Okay, let's try this again\n"
    end
  end

  print "Okay, #{user_name}! I plan to generate you a QR code sending to: #{send_number}, saying: #{message}. Is this okay, yes or no?\n"; user_input = gets.chomp
  if user_input.downcase.include?("yes") && !user_input.downcase.include?("not") && !user_input.downcase.include?("no")
    break_var = false
  else
    change_var = true
    change_iter = 0
    while change_var do
      print "What do you want to change, say number, message, or both?\n"; user_input = gets.chomp
      if (user_input.downcase.include?("number") && user_input.downcase.include?("message")) || user_input.downcase.include?("both")
        print "Okay let's go back and change the number and message.\n"
        num_var = true; msg_var = true
        change_var = false
      elsif user_input.downcase.include?("number")
        print "Okay let's go back and change the number\n"
        num_var = true
        change_var = false
      elsif user_input.downcase.include?("message")
        print "Okay let's go back and change the message\n"
        msg_var = true
        change_var = false
      else
        if change_iter < 4
          print "not sure what you are asking, but we'll start from the top\n"
          change_iter = change_iter + 1
        else
          print "not sure what what you're asking but we'll go all the way to the beginning now...\n"
          change_var = false
        end
      end
    end
  end
end

# Use the RQRCode::QRCode class to encode some text
qrcode = RQRCode::QRCode.new("SMSTO:#{send_number}: #{message}")

# Use the .as_png method to create a 500 pixels by 500 pixels image
png = qrcode.as_png({ :size => 500 })

# Write the image data to a file
user_qrcode = "#{user_name}_QR.png"
IO.binwrite(user_qrcode, png.to_s)

print "Awesome! Your QR code was generated as the file #{user_qrcode}\n"
