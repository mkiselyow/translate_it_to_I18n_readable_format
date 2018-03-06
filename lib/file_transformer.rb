class FileTransformer
  def self.transform(file_path)
    File.open(file_path, 'r').read
  end
end