# word_list = File.read("/usr/share/dict/words").split.sort_by {|word | -word.size}[99990..231000]
word_list = File.read("/usr/share/dict/words").split.sort_by {|word | -word.size}[0..117942]
word_list_2 = File.read("/usr/share/dict/words").split.sort_by {|word | -word.size}[117943..234254]

#find out where 2 letter words end


# word_list = File.read("/usr/share/dict/words")
# word_list = word_list.split.sort_by {|word | -word.size}[100000..230000]

# word_list = File.read("./ten_thousand.txt").split.sort_by {|word | -word.size}
# word_list = %w(blue berry blueberry muffins are delicious muff).sort_by{|i| -i.size}
# puts word_list[117942]

# puts word_list
# puts word_list.index("milliarium") 
puts "--------------------------"
WORD_REGEXP = Regexp.union(*word_list)
WORD_REGEXP_2 = Regexp.union(*word_list_2)

def best_fit(string, regex)
    string.scan(regex)
end

a = best_fit("blueberrymuffinsaredelicious", WORD_REGEXP)
b = best_fit("blueberrymuffinsaredelicious", WORD_REGEXP_2)
puts "b's #{b}"
puts "a's #{a}"  
a = a.concat(b)
p a
