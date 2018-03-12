require './lib/file_transformer'

RSpec.describe FileTransformer do
  describe "transform file method" do
    it "returns transformed file" do
      expect(described_class.transform("./lib/translations_simple.yml")).to eq(
        {
          'en' => {
            'pets' => {
              'types' => {
                'cat' => 'Cat',
                'dog' => 'Dog'
              }
            },
            'title' => 'My lovely pets',
            'actions' => {
              'add' => 'Add',
              'remove' => 'Remove'
            },
            'language' => '<strong>Language</strong>'
          }
        }.to_yaml
      )
    end
  end
end