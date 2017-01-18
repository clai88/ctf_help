require 'minitest/autorun'
require 'minitest/pride'
require_relative 'shift.rb'
require_relative 'railfence.rb'
require 'pry'

class Test < Minitest::Test
    def test_instantiate
        assert Shift
        assert Railfence
    end

    def test_with_no_shift
        sup = Shift.new("this is a test")
        assert_equal("this is a test", sup.return_best_guess)
    end

    
    def test_with_small_shift
        sup = Shift.new("wklv lv d whvw")
        assert_equal("this is a test", sup.return_best_guess)
    end

    def test_caesarian_shift
        sup = Shift.new("pb urrppdwh shqhwudwhv zkhdw vxev")
        assert_equal("my roommate penetrates wheat subs", sup.return_best_guess)        
    end

    def test_railfence_three_rails
        hey = Railfence.new("wooglecmtteodielehof")
        assert_equal("welcometothegoodlife", hey.return_best_guess)
    end

    def test_railfence_lotta_rails
        hey = Railfence.new("oontbcdeeeniicwrhetpndrtnetasomstuthihesegabynamr")
        assert_equal("onceiwenttothegymnasiumandtriedtobenchpressthebar", 
            hey.return_best_guess)
    end
end