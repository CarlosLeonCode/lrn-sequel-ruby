require 'sequel'
DB = Sequel.connect('sqlite://library.db')

DB.create_table? :books do
  primary_key :id

  String :name
  String :author
end

class Book < Sequel::Model
  # ! Relations
  # many_to_one :author
  # one_to_many :comments
  # one_to_one :first_comment, :class=>:Comment, :order=>:id
  # many_to_many :tags
  # one_through_one :first_tag, :class=>:Tag, :order=>:name, :right_key=>:tag_id

  def before_create
    super
    puts 'This is the before create hook'
  end

  def after_destroy
    super
    puts 'hook when some record is distroy, executed'
  end
end

book = Book.new

book.name = 'Takis'
book.author = 'Mex'

p book.name
book.save

Book.all.map { |r| r.destroy }
# We can use |delete| or |destroy| to delete records
# The only difference it's that destroy execute hooks and delete not
