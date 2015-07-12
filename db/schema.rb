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

ActiveRecord::Schema.define(version: 20150711055433) do

  create_table "account_op_logs", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.float    "money",      default: 0.0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "balances", force: :cascade do |t|
    t.integer  "account_id"
    t.float    "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "units",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "numbers", force: :cascade do |t|
    t.integer  "i"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_courses", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.integer  "units",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
