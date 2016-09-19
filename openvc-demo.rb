#!/usr/bin/env ruby

require 'opencv'
include OpenCV

if ARGV.size != 1
  puts "Usage: ruby #{__FILE__} Image"
  exit
end

image = nil
begin
  image = IplImage.load ARGV[0], 1
rescue
  puts 'Could not open or find the image.'
  exit
end

image = image.resize(CvSize.new(1024,768))
detector = CvHaarClassifierCascade::load '/usr/share/opencv/haarcascades/haarcascade_mcs_nose.xml'
detector.detect_objects(image).each do |region|
  color = CvColor::Blue
  image.rectangle! region.top_left, region.bottom_right, :color => color
end

window = GUI::Window.new('opencv-demo')
window.show image
GUI::wait_key
