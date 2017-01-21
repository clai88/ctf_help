require './shift.rb'
require './railfence.rb'
require './shift_no_spaces'

#Shift cipher with spaces
shift_key = "wklv lv d whvw skudvh iru brx wr fudfn"
kali = Shift.new(shift_key)

puts "-----------------------------------------------"

#shift cipher without spaces
shift_no_spaces_key = "rovvydrsckdocdzrbkcoMrbscvks"
arch = ShiftNoSpaces.new(shift_no_spaces_key)

puts "------------------------------------------------"

railfence_key = "wgeeolhoctdoolmtieef"
puppy = Railfence.new(railfence_key)

# miyyfdltolhgaeyiyucwkeeiprlseoefvsoenusinbfdlfouuneemtlbyhbereart

if ARGV[0] == "--luscious-wheat-subs"
    puts
    puts "best guess"
    puts "shift:                        #{kali.return_best_guess}" if kali
    puts "shift (no-spaces):            #{arch.return_best_guess}" if arch 
    puts "railfence:                    #{puppy.return_best_guess}" if puppy

end