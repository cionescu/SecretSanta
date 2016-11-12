require "participants"

RSpec.describe Participants do
  context "group_participants" do
    let(:participants) { [1, 2, 3] }

    it "groups the first participant with the second" do
      group = subject.group_participants(participants).first

      expect(group[:from]).to eq 1
      expect(group[:to]).to eq 2
    end

    it "groups the last participant with the first" do
      group = subject.group_participants(participants).last

      expect(group[:from]).to eq 3
      expect(group[:to]).to eq 1
    end
  end
end
