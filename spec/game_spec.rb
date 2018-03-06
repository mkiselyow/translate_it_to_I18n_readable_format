require './lib/file_transformer'

RSpec.describe FileTransformer do
  describe "transform file method" do
    it "returns transformed file" do
      expect(described_class.transform("./lib/translations_simple.yml")).to eq('')
    end
  end
end