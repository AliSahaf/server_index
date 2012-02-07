require_relative  "./document.rb"
class Index
  attr_accessor :base_dir
  

  def initialize(base_dir)
    @base_dir = check base_dir
  end

  def base_dir=(dir)
    @base_dir = check dir
  end

  def crowl
    @current_index = []
    Dir.chdir @base_dir do 
      entries = Dir.glob("**/*").keep_if {|entry| File.file? entry}
      entries.each {|entry| @current_index.<< Document.new(entry) } 
    end
  end

  def report_to_file(file_name)
    File.open(file_name, 'w') do |f|
      f.puts "No. | name \t\t\t| path"
      f.puts "==================================================================="
      @current_index.each_with_index do |doc, index|
        f.puts "#{index} | #{doc.name} \t| #{doc.path}"
      end
    end
  end

  private
  def check(dir)
    absolute_path = File.absolute_path dir
    raise "Directory not found" unless File.exists? absolute_path
    raise "Not a Directory" unless File.directory? absolute_path
    absolute_path
  end
end