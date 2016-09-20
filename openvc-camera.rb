#!/usr/bin/env ruby
# coding: utf-8

require 'opencv'
include OpenCV

# マシンに接続されているカメラのうち, 1番めのカメラを利用する
camera = CvCapture.open(0)
window = GUI::Window.new('camera')

# このループ内で何かする
# 今回はただ表示するだけ
while true
  # Iplimageクラスの画像データをキャプチャする
  image = camera.query

  detector = CvHaarClassifierCascade::load '/usr/share/opencv/haarcascades/haarcascade_profileface.xml'
  detector.detect_objects(image).each do |region|
    now = Time.now
    puts "#{now}.#{now.usec}: (#{region.top_left.x}, #{region.top_left.y}, #{region.bottom_right.x}, #{region.bottom_right.y})"
    color = CvColor::Blue
    image.rectangle! region.top_left, region.bottom_right, :color => color
  end

  window.show image

  key = GUI::wait_key 10

  # キーボードでqを入力したら終了
  break if key == 113
end
