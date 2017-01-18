require "rspec"
require_relative "shift.rb"
require_relative "railfence.rb"

describe "Overall" do
    context "Test shift and railfence classes exist " do
        it "making sure they are there" do
            expect(Shift).to eq Shift
            expect(Railfence).to eq Railfence
        end
    end
end

describe Shift do
    it 'no shift applied' do 
        sup = Shift.new("this is a test")
        expect(sup.return_best_guess).to eq "this is a test"
    end

    it 'small shift applied' do
        sup = Shift.new("wklv lv d whvw")
        expect(sup.return_best_guess).to eq "this is a test"
    end

    it 'caesarian shift' do
        sup = Shift.new("pb urrppdwh shqhwudwhv zkhdw vxev")
        expect(sup.return_best_guess).to eq "my roommate penetrates wheat subs"
    end
end

describe Railfence do
    it 'no rails', :focus => true do
        hey = Shift.new("i am chris")
        expect(hey.return_best_guess).to eq "i am chris"
    end
    it 'three rails' do
        hey = Railfence.new("wooglecmtteodielehof")
        expect(hey.return_best_guess).to eq "welcometothegoodlife"
    end

    it 'many rails' do
        hey = Railfence.new("oontbcdeeeniicwrhetpndrtnetasomstuthihesegabynamr")
        expect(hey.return_best_guess).to eq "onceiwenttothegymnasiumandtriedtobenchpressthebar"
    end
end

