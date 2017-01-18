require 'pry'
class Railfence
    def initialize(string)
        if string =~ /^[a-zA-Z\s]*$/
            @string = string
            @encrypted_length = string.length
            generate_possibilities
        else
            puts "not a valid sequence of characters"
        end
    end

    def offset(even, rails, rail)
        return (rails - 1) * 2 if (rail == 0 || rail == (rails - 1))
        return even ? 2* rail :  2* (rails - 1 - rail)
    end
    
    def decrypt_rail_fence(rails)
        array = Array.new(rails) { Array.new(@encrypted_length, ' ') }
        read = 0
        decoded = ""

        rails.times do |rail|
            pos = offset(1, rails, rail)
            even = false

            rail == 0 ? pos = 0 : pos = (pos/2).to_i

            # puts rail
            while pos < @encrypted_length
                break if read == @encrypted_length

                array[rail][pos] = @string[read]
                read += 1

                # puts "#{even} #{rails} #{rail} output:#{offset(even, rails, rail)}"
                pos = pos + offset(even, rails, rail)
                even = !even
            end
        end

        # print array

        @encrypted_length.times do |x|
            rails.times { |y| decoded += array[y][x] if array[y][x] != " " }
        end
        decoded
    end

    def generate_possibilities
        possibilities = {}
        25.times do  |i| 
            decoded = decrypt_rail_fence(i)
            possibilities[decoded] = 0 unless decoded.length < @encrypted_length
        end
        # possibilities.keys.each {|i| puts i unless (i.length < @encrypted_length)}
        best_fit(possibilities)
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


