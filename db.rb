# frozen_string_literal: true

require 'json'

class DB
  INITIAL_RECORD = { nextID: 0, memos: [] }.freeze

  def initialize(db_name)
    make_db(db_name) unless File.exist?(db_name)
    @db = db_name
  end

  def read
    JSON.load_file(@db, symbolize_names: true)
  end

  def create(memo)
    records = read
    records[:memos] << memo
    records[:nextID] += 1
    dump_to_db(records)
  end

  def update(memo)
    records = read
    records[:memos].each do |record|
      records[:memos][records[:memos].index(record)] = memo if record[:id] == memo[:id]
    end
    dump_to_db(records)
  end

  def delete(id)
    records = read
    records[:memos].delete_if { |m| m[:id] == id }
    dump_to_db(records)
  end

  private

  def make_db(db_name)
    File.open(db_name, 'w') do |f|
      f.write(JSON.dump(INITIAL_RECORD))
    end
  end

  def dump_to_db(records)
    File.open(@db, 'w') do |f|
      f.write(JSON.dump(records))
    end
  end
end
