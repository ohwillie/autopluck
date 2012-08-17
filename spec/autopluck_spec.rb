require 'require_relative'
require_relative '../lib/autopluck'

describe Autopluck do
  before(:all) { described_class.activate! }

  let(:model_class) { Class.new(ActiveRecord::Base) { self.table_name = :posts } }

  before do
    ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
    ActiveRecord::Base.connection.create_table(:posts)
  end

  after { ActiveRecord::Base.connection.disconnect! }

  it 'should convert a map into a pluck if the column exists' do
    add_column
    model_class.create!
    model_class.scoped.map(&:body).should == [nil]
  end

  it 'should not convert a map into a pluck if there is a method overriding the column' do
    add_column
    model_class.class_eval { define_method(:body) { 'bar' } }
    model_class.create!
    model_class.scoped.map(&:body).should == %w[bar]
  end

  it 'should not convert a map into a pluck if there is no column' do
    model_class.scoped.tap do |scoped|
      scoped.should_not_receive(:pluck)
      scoped.map(&:asdf)
    end
  end

  it 'should just pass through if the map call was not specified with a converted symbol' do
    add_column
    model_class.create!
    model_class.scoped.tap do |scoped|
      scoped.should_not_receive(:pluck)
      scoped.map { |model| model.body }.should == [nil]
    end
  end

  it 'should not pluck if the records are loaded' do
    add_column
    model_class.create!
    model_class.scoped.tap do |scoped|
      scoped.should_not_receive(:pluck)
      scoped.to_a
      scoped.map(&:body).should == [nil]
    end
  end

  it 'should not pluck if Autopluck is deactivated' do
    begin
      described_class.deactivate!
      add_column
      model_class.create!
      model_class.scoped.tap do |scoped|
        scoped.should_not_receive(:pluck)
        scoped.map(&:body).should == [nil]
      end
    ensure
      described_class.activate!
    end
  end

  def add_column
    ActiveRecord::Base.connection.add_column(:posts, :body, :text)
  end
end
