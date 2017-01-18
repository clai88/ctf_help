require 'pry'

class ShiftNoSpaces
    def initialize(string)
        #test only contains characters
        if string =~ /^[a-zA-Z(\s)]*$/
            @string = string
            possibilities = generate_possibilities
            best_fit(possibilities)
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

    def best_fit(results)
            results_clone = results.clone
            word_list = File.read("/usr/share/dict/words").split.sort_by {|word | -word.size}[0..117942]
            word_list_two = File.read("/usr/share/dict/words").split.sort_by {|word | -word.size}[117943..234254]

            regex = Regexp.union(*word_list)
            regex_two = Regexp.union(*word_list_two)

            results_clone.each do |guess, v|
                guess1 = check_against_wordlist(guess, regex)
                guess2 = check_against_wordlist(guess, regex_two)
                # results[guess] = guess1.concat(guess2).length

                split_words = guess1.concat(guess2).reduce(0){ |sum, word| sum + (word.length*word.length)}
                results[guess] = split_words

            end

            results = results.sort_by {|k,v| -v}
            counter = 0
            results.each do |guess, score|
                puts "#{guess}....#{score}" if counter < 3
                counter += 1
            end
            @results = results
    end

    def check_against_wordlist(word, regex)
        word.scan(regex)
    end

    def return_best_guess
        @results[0][0]
    end
end







