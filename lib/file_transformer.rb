require 'yaml/store'

class FileTransformer
  def self.transform(file_path)
    file = File.open(file_path, 'r')
    lines = file.read.to_s.split("\n")
    answer = []
    lines.map do |line|
      value = line.split(': ')[1]
      key = line.split(': ')[0].gsub(/'/, '')
      keys_array = key.split('.')
      result = {}
      answer << get_key_and_value_from_keys_array(keys_array, value, result)
    end
    File.open('translations.yml', 'w+').write(answer.to_yaml)
    file.close
    answer.to_yaml
  end

  def self.get_key_and_value_from_keys_array(keys_array, value, result)
    keys_array.map do |key|
      if keys_array.length > 1
        keys_array.shift
        result[key] = {}
        { key => get_key_and_value_from_keys_array(keys_array, value, result[key])}
      else
        { key => value}
      end
    end
  end

end