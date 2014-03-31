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

ActiveRecord::Schema.define(version: 20140331022059) do

  create_table "events", force: true do |t|
    t.string   "title"
    t.integer  "start_time"
    t.integer  "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.string   "title"
    t.integer  "num_events"
    t.boolean  "has_events"
    t.integer  "day"
    t.integer  "start_time"
    t.integer  "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ss_es_relations", force: true do |t|
    t.integer  "schedule_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ss_es_relations", ["event_id"], name: "index_ss_es_relations_on_event_id"
  add_index "ss_es_relations", ["schedule_id", "event_id"], name: "index_ss_es_relations_on_schedule_id_and_event_id", unique: true
  add_index "ss_es_relations", ["schedule_id"], name: "index_ss_es_relations_on_schedule_id"

  create_table "us_es_relations", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "us_es_relations", ["event_id"], name: "index_us_es_relations_on_event_id"
  add_index "us_es_relations", ["user_id", "event_id"], name: "index_us_es_relations_on_user_id_and_event_id", unique: true
  add_index "us_es_relations", ["user_id"], name: "index_us_es_relations_on_user_id"

  create_table "us_ss_relations", force: true do |t|
    t.integer  "user_id"
    t.integer  "schedule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "us_ss_relations", ["schedule_id"], name: "index_us_ss_relations_on_schedule_id"
  add_index "us_ss_relations", ["user_id", "schedule_id"], name: "index_us_ss_relations_on_user_id_and_schedule_id", unique: true
  add_index "us_ss_relations", ["user_id"], name: "index_us_ss_relations_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "authentication_token"
    t.datetime "confirmed_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
