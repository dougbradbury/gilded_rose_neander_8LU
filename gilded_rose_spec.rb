require 'gilded_rose'

describe "#update_quality" do

  context "with a single" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before(:each) { update_quality([item]) }

    context "normal item" do
      let(:name) { "NORMAL ITEM" }

      it { item.sell_in.should == initial_sell_in-1 }

      context "before sell date" do
        it { item.quality.should == initial_quality-1 }
      end
      
      it "does two updates" do
        update_quality([item])
        item.sell_in.should == initial_sell_in - 2
      end


      context "on sell date" do
        let(:initial_sell_in) { 0 }
        it { item.quality.should == initial_quality-2 }
      end

      context "after sell date" do
        let(:initial_sell_in) { -10 }
        it { item.quality.should == initial_quality-2 }
      end

      context "of zero quality" do
        let(:initial_quality) { 0 }
        it { item.quality.should == 0 }
      end
    end

    context "Aged Brie" do
      let(:name) { "Aged Brie" }

      xit { item.sell_in.should == initial_sell_in-1 }

      context "before sell date" do
        xit { item.quality.should == initial_quality+1 }

        context "with max quality" do
          let(:initial_quality) { 50 }
          xit { item.quality.should == initial_quality }
        end
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }
        xit { item.quality.should == initial_quality+2 }

        context "near max quality" do
          let(:initial_quality) { 49 }
          xit { item.quality.should == 50 }
        end

        context "with max quality" do
          let(:initial_quality) { 50 }
          xit { item.quality.should == initial_quality }
        end
      end

      context "after sell date" do
        let(:initial_sell_in) { -10 }
        xit { item.quality.should == initial_quality+2 }

        context "with max quality" do
          let(:initial_quality) { 50 }
          xit { item.quality.should == initial_quality }
        end
      end
    end

    context "Sulfuras" do
      let(:initial_quality) { 80 }
      let(:name) { "Sulfuras, Hand of Ragnaros" }

      xit { item.sell_in.should == initial_sell_in }

      context "before sell date" do
        xit { item.quality.should == initial_quality }
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }
        xit { item.quality.should == initial_quality }
      end

      context "after sell date" do
        let(:initial_sell_in) { -10 }
        xit { item.quality.should == initial_quality }
      end
    end

    context "Backstage pass" do
      let(:name) { "Backstage passes to a TAFKAL80ETC concert" }

      xit { item.sell_in.should == initial_sell_in-1 }

      context "long before sell date" do
        let(:initial_sell_in) { 11 }
        xit { item.quality.should == initial_quality+1 }

        context "at max quality" do
          let(:initial_quality) { 50 }
        end
      end

      context "medium close to sell date (upper bound)" do
        let(:initial_sell_in) { 10 }
        xit { item.quality.should == initial_quality+2 }

        context "at max quality" do
          let(:initial_quality) { 50 }
          xit { item.quality.should == initial_quality }
        end
      end

      context "medium close to sell date (lower bound)" do
        let(:initial_sell_in) { 6 }
        xit { item.quality.should == initial_quality+2 }

        context "at max quality" do
          let(:initial_quality) { 50 }
          xit { item.quality.should == initial_quality }
        end
      end

      context "very close to sell date (upper bound)" do
        let(:initial_sell_in) { 5 }
        xit { item.quality.should == initial_quality+3 }

        context "at max quality" do
          let(:initial_quality) { 50 }
          xit { item.quality.should == initial_quality }
        end
      end

      context "very close to sell date (lower bound)" do
        let(:initial_sell_in) { 1 }
        xit { item.quality.should == initial_quality+3 }

        context "at max quality" do
          let(:initial_quality) { 50 }
          xit { item.quality.should == initial_quality }
        end
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }
        xit { item.quality.should == 0 }
      end

      context "after sell date" do
        let(:initial_sell_in) { -10 }
        xit { item.quality.should == 0 }
      end
    end

    context "conjured item" do
      let(:name) { "Conjured Mana Cake" }

      xit { item.sell_in.should == initial_sell_in-1 }

      context "before the sell date" do
        let(:initial_sell_in) { 5 }
        xit { item.quality.should == initial_quality-2 }

        context "at zero quality" do
          let(:initial_quality) { 0 }
          xit { item.quality.should == initial_quality }
        end
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }
        xit { item.quality.should == initial_quality-4 }

        context "at zero quality" do
          let(:initial_quality) { 0 }
          xit { item.quality.should == initial_quality }
        end
      end

      context "after sell date" do
        let(:initial_sell_in) { -10 }
        xit { item.quality.should == initial_quality-4 }

        context "at zero quality" do
          let(:initial_quality) { 0 }
          xit { item.quality.should == initial_quality }
        end
      end
    end
  end

  context "with several objects" do
    let(:items) {
      [
        Item.new("NORMAL ITEM", 5, 10),
        Item.new("Aged Brie", 3, 10),
      ]
    }

    before(:each) { update_quality(items) }

    xit { items[0].quality.should == 9 }
    xit { items[0].sell_in.should == 4 }

    xit { items[1].quality.should == 11 }
    xit { items[1].sell_in.should == 2 }
  end
end
