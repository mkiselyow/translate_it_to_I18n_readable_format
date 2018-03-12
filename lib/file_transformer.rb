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
    new_arr =  answer.drop(1).map {|hash| recurse_merge(answer[0], hash) }
    new_arr[0].to_yaml
  end

  def self.get_key_and_value_from_keys_array(keys_array, value, result)
    arr = keys_array.map do |key|
      if keys_array.length > 1
        keys_array.shift
        result[key] = {}
        { key => get_key_and_value_from_keys_array(keys_array, value, result[key])}
      else
        { key => value}
      end
    end
    arr[0]
  end

  def self.recurse_merge(a,b)
    a.merge!(b) do |_,x,y|
      (x.is_a?(Hash) && y.is_a?(Hash)) ? recurse_merge(x,y) : [*x,*y]
    end
  end
end