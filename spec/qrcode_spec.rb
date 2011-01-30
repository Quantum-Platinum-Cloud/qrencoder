require 'spec_helper'

describe QREncoder::QRCode do

  def test_img_data(string, version)
    QREncoder.encode(string, :version => version).data
  end

  before do
    @q = QREncoder.encode("hi", :version => 1)
  end

  it "should be a version 1 code" do
    @q.version.should == 1
  end

  it "should be 21 modules wide" do
    @q.width.should == 21
  end

  it "should provide raw data" do
    @q.data.should == test_img_data("hi", 1)
  end

  it "should have an equal height and width" do
    @q.width.should == @q.height
  end

  it "should provide pixel data" do
    arr = []
    test_img_data("hi", 1).each_slice(@q.width) do |a|
      arr << a.map { |p| p & 0x1 }
    end

    @q.pixels.should == arr
  end

  it "should provide point data" do
    arr = []
    y = 0

    test_img_data("hi", 1).each_slice(@q.width) do |r|
      x = 0;

      r.each do |p|
        if (p & 0x1) == 1
          arr << [x, y]
        end

        x += 1
      end

      y += 1
    end

    @q.points.should == arr
  end
end
