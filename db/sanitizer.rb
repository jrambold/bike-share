require 'csv'
require 'fileutils'

dest_folder = './db/truncated_data'
Dir.mkdir(dest_folder) unless Dir.exists?(dest_folder)

FileUtils.cp('./db/csv/station.csv', dest_folder)
FileUtils.cp('./db/csv/weather.csv', dest_folder)

@stations = CSV.readlines('./db/csv/station.csv', headers: true, header_converters: :symbol)
@trips = []
@statuses = []

def truncate_trips
  data = CSV.open('./db/csv/trip.csv')
  @trips << data.shift
  @stations.reduce(Hash.new(0)) do |station_count, station_row|
    CSV.foreach('./db/csv/trip.csv', headers: true, header_converters: :symbol) do |trip_row|
      if trip_row[:start_station_id] == station_row[:id]
        @trips << trip_row
        station_count[station_row[:id]] += 1
        if station_count[station_row[:id]] == 20
          break
        end
      end
    end
    station_count
  end
  CSV.open('./db/truncated_data/trip.csv', 'w') do |csv|
    @trips.each do |row|
      csv << row
    end
  end
end

def truncate_statuses
  data = CSV.open('./db/csv/status.csv')
  @statuses << data.shift
  (1...141).each do |num|
    5.times { @statuses << data.shift }
    130240.times { data.shift }
    puts "sample #{num} complete"
  end
  CSV.open('./db/truncated_data/status.csv', 'w') do |csv|
    @statuses.each do |row|
      csv << row
    end
  end
end

truncate_trips
truncate_statuses
