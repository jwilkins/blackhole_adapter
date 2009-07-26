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
    class << self
      def blackhole_connection(config)
        puts "ActiveRecord::Base.#{method_name} called"
        db = BlackHoleAdapter::Database.new()
        ConnectionAdapters::BlackHoleAdapter.new(db, logger, config)
      end
    end
  end

  module ConnectionAdapters
    class BlackHoleColumn < Column
    end

    class BlackHoleAdapter < AbstractAdapter
      def initialize(connection, logger, config)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        puts "  connection: #{connection}; logger: #{logger}, config: #{config}"
        super(connection, logger)
        @config = config
      end

      def adapter_name
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        'BlackHoleAdapter'
      end

      def disconnect!
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
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
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        s
      end

      def quote_column_name(name)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
        name
      end

      # Database statements
      def execute(sql, name = nil)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def update_sql(sql, name = nil)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def delete_sql(sql, name = nil)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def insert_sql(sql, name = nil)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def select_rows(sql, name = nil)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def begin_db_transaction
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def commit_db_transaction
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def rollback_db_transaction
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def add_lock!(sql, options)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def select(sql, name = nil)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
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

      def primary_key(table_name)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def remove_index(table_name, options={})
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def rename_table(name, new_name)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def valid_alter_table_options(type, options)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def add_column(table_name, column_name, type, options={})
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def remove_column(table_name, *column_names)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end
      alias :remove_columns :remove_column

      def change_column_default(table_name, column_name, default)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def change_column_null(table_name, column_name, null, default=nil)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def change_column(table_name, column_name, type, options={})
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def rename_column(table_name, column_name, new_column_name)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end

      def empty_insert_statement(table_name)
        puts "ActiveRecord::ConnectionAdapters::BlackHoleAdapter.#{method_name} called"
      end
    end
  end
end
