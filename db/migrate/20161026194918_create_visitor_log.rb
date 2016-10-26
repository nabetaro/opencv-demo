# coding: utf-8
class CreateVisitorLog < ActiveRecord::Migration
  def self.up
    create_table :visitor_logs do |t|
      t.timestamp :visit_at
      t.integer :visit_count

      t.timestamps
    end
  end

  def self.down
    drop_table :visitor_log
  end
end
