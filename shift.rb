require 'pry'

class Shift
    def initialize(string)
        #test only contains characters
        if string =~ /^[a-zA-Z(\s)]*$/
            @string = string
            possibilities = generate_possibilities
            check_against_wordlist(possibilities)
        else
            puts "not a string of characters"
        end
    end

    def generate_possibilities
        possibilities = {}
        splitted = @string.chars
        
        26.times do  |i|
            word = []
            splitted.each do |letter|
                if letter == " "
                    word.push(" ") 
                else
                    shifted_letter = increment_ascii(letter, i)
                    word.push(shifted_letter)
                end
            end
            word = word.join
            possibilities[word] = 0
        end
        possibilities
    end

    def increment_ascii(letter, shift)
        # check if letter is lowercase
        pre = (letter.ord)+shift
        if letter.ord.between?(97,122)
            if !(pre.between?(97,122))
                return (pre-26).chr
            else
                return pre.chr
            end
        else
            if !(pre.between?(65,90))
                return(pre-26).chr
            else
                return pre.chr
            end
        end
    end

    def check_against_wordlist(results)
        results_copy = results.clone
        word_list = File.read("/usr/share/dict/words").split(" ")
        results_copy.each do |key,v|
            words = key.split(/[\W]/)
            words.each do |word|
                word_list.each do |guess|
                    # if word == guess
                    if (word.casecmp(guess) == 0)
                        results[key]? results[key] += 1 : results[key] = 1
                        break
                    end
                end
            end
        end
        results = results.sort_by {|k,v| v}.reverse
        index = 0
        results.each do |key, value|
            puts "#{key} ........#{value}" if (value > 0 && index < 3)
            index+=1
        end
        @results = results
    end

    def return_best_guess
        @results[0][0]
    end
end







