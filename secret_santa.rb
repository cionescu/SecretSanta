require 'yaml'

class SecretSanta
  attr_reader :senders, :participants

  def initialize
    @participants = YAML.load_file("participants.yml")
    @senders = participants.keys
  end

  def run
    receipients = senders.shuffle
    puts senders.inspect, receipients.inspect
    puts permutation_is_identical?(senders, receipients)
    puts forever_alone_participant?(create_receipients_map(senders, receipients))
  end

  private

  def set_participants

  end

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

  def send_email
    Pony.mail(
      to: "catalin.ionescu282@gmail.com",
      subject: "[Secret Santa] Partenerul Tau",
      via: :smtp,
      via_options: {
        address: "smtp.gmail.com",
        port: "587",
        enable_starttls_auto: true,
        user_name: YAML.load_file("credentials.yml")["username"],
        password: YAML.load_file("credentials.yml")["password"],
        authentication: :plain,
        domain: "localhost.localdomain"
      },
      body: <<~BODY
        This is the body of the email.
        Blah Blah Blah
      BODY
    )
  end
end

SecretSanta.new.run
