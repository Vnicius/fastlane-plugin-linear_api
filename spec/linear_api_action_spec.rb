describe Fastlane::Actions::LinearApiAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The linear_api plugin is working!")

      Fastlane::Actions::LinearApiAction.run(nil)
    end
  end
end
