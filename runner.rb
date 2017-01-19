require './shift.rb'
require './railfence.rb'
require './shift_no_spaces'


#Shift cipher with spaces
shift_key = "wklv lv d whvw skudvh iru brx wr fudfn"
Shift.new(shift_key)

puts "-----------------------------------------------"

#shift cipher without spaces
shift_key = "rovvydrsckdocdzrbkcoMrbscvks"
ShiftNoSpaces.new(shift_key)

puts "------------------------------------------------"

railfence_key = "wgeeolhoctdoolmtieef"
Railfence.new(railfence_key)



# miyyfdltolhgaeyiyucwkeeiprlseoefvsoenusinbfdlfouuneemtlbyhbereart