class Document
	attr_accessor :title, :name, :id, :revision, :date, :path, :preparer, :checker, :approver

	def initialize(path)
    @path = check path
    @name = default_name
  end

  def default_name
    File.basename @path
  end

  def default_name!
    @name = default_name
  end

  def path=(path)
    @path = check path
  end

  def ==(other)
    if other.respond_to? :path
      self.path == other.path
    end
  end

  private
  def check(path)
    absolute_path = File.absolute_path path
    raise 'File not found' unless File.exists? absolute_path
    raise 'Not a Document' unless File.file? absolute_path
    absolute_path
  end
end