module Permutation
  extend self

  # Ensure we didn't shuffle to the identical senders
  def permutation_is_identical?(first, second)
    first == second
  end

  # Ensure sender and receiver are distinct
  def forever_alone_participant?(receipients)
    receipients.detect do |receipient|
      receipient[:from] == receipient[:to]
    end.nil?
  end

  def create_receipients_map(senders, receipients)
    senders.map.with_index do |sender, idx|
      {
        from: sender,
        to: receipients[idx]
      }
    end
  end
end
