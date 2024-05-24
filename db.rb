# frozen_string_literal: true

require 'pg'

class Memo
  def initialize(db_name)
    @conn = PG.connect(dbname: db_name)
  end

  def read
    @conn.exec('SELECT * FROM memos')
  end

  def find_by_id(id)
    @conn.exec('SELECT * FROM memos WHERE id = $1;', [id])
  end

  def create(title, content)
    @conn.exec('INSERT INTO memos (title, content) VALUES ($1, $2);', [title, content])
  end

  def update(id, title, content)
    @conn.exec('UPDATE memos SET title = $1, content = $2 WHERE id = $3;', [title, content, id])
  end

  def delete(id)
    @conn.exec('DELETE FROM memos WHERE id = $1', [id])
  end
end
