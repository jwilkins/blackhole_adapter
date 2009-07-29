# can't be named NullAdapter - ActiveRecord gets confused by Null/null
require 'active_record/connection_adapters/abstract_adapter'

module Kernel
  def method_name
    caller[0] =~ /`([^']*)'/ and $1
  end
end

module BlackHoleAdapter
  class Database
    def initialize()
      @handle = true
      @closed = false
    end
  end
end

module ActiveRecord
  class Base
    def method_missing(name, *args, &block)
      puts "ActiveRecord::Base::.#{name}(#{args.join(', ')}) called"
    end

    def self.blackhole_connection(config)
      puts "ActiveRecord::Base.#{method_name} called"
      db = BlackHoleAdapter::Database.new()
      ConnectionAdapters::BlackHoleAdapter.new(db, logger, config)
    end
  end

  module ConnectionAdapters
    class BlackHoleColumn < Column
    end

    class BlackHoleAdapter < AbstractAdapter
      def initialize(connection, logger, config)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        puts "  connection: #{connection}; logger: #{logger}"
        super(connection, logger)
        @config = config
      end

      def method_missing(name, *args, &block)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{name}(#{args.join(', ')}) called"
      end

      def adapter_name
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        'BlackHoleAdapter'
      end

      # Features
      def supports_ddl_transactions?
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        false
      end

      def supports_migrations?
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        false
      end

      def requires_reloading?
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        true
      end

      def supports_add_column?
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        false
      end

      def supports_count_distinct?
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        false
      end

      def supports_autoincrement?
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        false
      end

      def native_database_types
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        {
          :primary_key => 'INTEGER PRIMARY KEY NOT NULL'.freeze,
          :string      => { :name => 'string' },
          :text        => { :name => "text" },
          :integer     => { :name => "integer" },
          :float       => { :name => "float" },
          :decimal     => { :name => "decimal" },
          :datetime    => { :name => "datetime" },
          :timestamp   => { :name => "datetime" },
          :time        => { :name => "time" },
          :date        => { :name => "date" },
          :binary      => { :name => "blob" },
          :boolean     => { :name => "boolean" }
        }
      end

      # Quoting
      def quote_string(s)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name}(#{s}) called"
        s
      end

      def quote_column_name(name)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name}(#{name}) called"
        name
      end

      # Database statements
      def select(sql, name = nil)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name}(#{sql})"
        []
      end

      # Schema statements
      def tables(name = nil)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        []
      end

      def columns(table_name, name = nil)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        []
      end

      def indexes(table_name, name = nil)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        []
      end
    end
  end
end
