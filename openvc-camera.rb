#!/usr/bin/env ruby
# coding: utf-8

require 'opencv'
require 'active_record'
require 'yaml'

dbconfig = YAML.load_file( 'config/database.yml' )
ActiveRecord::Base.establish_connection(dbconfig[ENV['ENV']])

class VisitorLog < ActiveRecord::Base; end

include OpenCV


camera = CvCapture.open(0)
window = GUI::Window.new('camera')
detector = CvHaarClassifierCascade::load '/usr/share/opencv/haarcascades/haarcascade_frontalface_alt2.xml'
i = 0

while true
  # Iplimageクラスの画像データをキャプチャする
  image = camera.query
  now = Time.now
  
  if ( i >= 5)
    puts "#{now}.#{now.usec}:"
    obj = detector.detect_objects(image)
    #VisitorLog.create!(visit_at: now, visit_count: obj.count) if obj.count > 0
    obj.each do |region|
      puts "#{now}.#{now.usec}: (#{region.top_left.x}, #{region.top_left.y}, #{region.bottom_right.x}, #{region.bottom_right.y})"
      color = CvColor::Blue
      image.rectangle! region.top_left, region.bottom_right, :color => color
    end
    window.show image
    i = 0
    sleep 0.1
  end
  i += 1
#  window.show image

  key = GUI::wait_key 1

  # キーボードでqを入力したら終了
  break if key == 113

end
