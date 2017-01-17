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
        if (rail == 0 || rail == rails - 1)
            return (rails - 1) * 2
        end

        return even ?  2 * rail : 2 * (rails - 1 - rail)

        # if even
        #     return 2* rail
        # else
        #     return 2*(rails - 1 - rail)
        # end
    end

    def decrypt_rail_fence(rails)
        array = Array.new(rails) { Array.new(@encrypted_length, ' ') }
        read = 0
        decoded = ""

        rails.times do |rail|
            pos = offset(1, rails, rail)
            even = 0

            rail == 0 ? pos = 0 : pos = (pos/2).to_i

            # if rail == 0
            #     pos = 0
            # else
            #     pos = (pos/2).to_i
            # end

            while pos < @encrypted_length
                break if read == @encrypted_length
                array[rail][pos] = @string[read]
                read = read + 1

                pos = pos + offset(even, rails, rail)
                even = !even
            end
        end

        @encrypted_length.times do |x|
            rails.times { |y| decoded += array[y][x] if array[y][x] != " " }
        end
        decoded
    end

    def generate_possibilities
        possibilities = {}
        26.times { |i| possibilities[decrypt_rail_fence(i)] = 0 }

        puts decrypt_rail_fence(3)
        # puts possibilities
    end
end
