# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160329045307) do

  create_table "api_logs", force: :cascade do |t|
    t.text "logs", limit: 65535
  end

  create_table "user_informations", force: :cascade do |t|
    t.float    "source_lat",    limit: 24
    t.float    "source_lng",    limit: 24
    t.float    "des_lat",       limit: 24
    t.float    "des_lng",       limit: 24
    t.string   "email",         limit: 255
    t.datetime "time_to_reach"
    t.float    "kms",           limit: 24
    t.boolean  "email_sent",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_informations", ["des_lat", "des_lng"], name: "index_user_informations_on_des_lat_and_des_lng", using: :btree
  add_index "user_informations", ["email"], name: "index_user_informations_on_email", using: :btree
  add_index "user_informations", ["kms"], name: "index_user_informations_on_kms", using: :btree
  add_index "user_informations", ["source_lat", "source_lng"], name: "index_user_informations_on_source_lat_and_source_lng", using: :btree

end
