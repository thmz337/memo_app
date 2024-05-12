# frozen_string_literal: true

require 'json'

module DB
  def self.read(db)
    JSON.load_file(db, symbolize_names: true)
  end

  def self.create(db, memo)
    records = JSON.load_file(db, symbolize_names: true)
    records[:memos] << memo
    records[:nextID] += 1
    File.open(db, 'w') do |f|
      f.write(JSON.dump(records))
    end
  end

  def self.update(db, memo)
    records = JSON.load_file(db, symbolize_names: true)
    records[:memos].each do |record|
      records[:memos][records[:memos].index(record)] = memo if record[:id] == memo[:id]
    end

    File.open(db, 'w') do |f|
      f.write(JSON.dump(records))
    end
  end

  def self.delete(db, id)
    records = JSON.load_file(db, symbolize_names: true)
    records[:memos].delete_if { |m| m[:id] == id }
    File.open(db, 'w') do |f|
      f.write(JSON.dump(records))
    end
  end
end
