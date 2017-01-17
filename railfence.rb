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
        35.times do  |i| 
            decoded = decrypt_rail_fence(i)
            possibilities[decoded] = 0 unless decoded.length < @encrypted_length
        end
        # possibilities.keys.each {|i| puts i unless (i.length < @encrypted_length)}
        check_against_wordlist(possibilities)
    end

    def check_against_wordlist(results)
        results_copy = results.clone
        word_list = File.read("/usr/share/dict/words").split(" ")
        results_copy.each do |key,value|
            puts "checking #{key}"
            word_array = []
            for i in (0..key.length)
                word_array << key[0..i]
            end

            # puts word_array #three letter to seven letter character combos
            word_array.each do |word|
                results = check_match(key, word, word_list,results)
            end
        end

        results = results.sort_by {|k,v| v}.reverse
        list = 0

        results.each do |key, value|
            puts "#{key} ........#{value}" if (value > 0 && list < 3)
            list+=1
        end
    end

    def check_match(key, word, word_list, results)
            word_list.each do |guess|
                if word.casecmp(guess) == 0
                    results[key] ? results[key] += 1 : results[key] = 1                    
                end
            end
        results
    end
end


