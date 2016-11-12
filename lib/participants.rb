module Participants
  extend self

  def group_participants(participants)
    participants.map.with_index do |sender, idx|
      receipient = (idx+1) == participants.size ? participants[0] : participants[idx+1]
      {
        from: sender,
        to: receipient
      }
    end
  end
end
