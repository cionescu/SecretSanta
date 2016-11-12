require 'yaml'
require_relative 'permutation'

class SecretSanta
  attr_reader :senders, :participants

  def initialize
    @participants = YAML.load_file("lib/participants.yml")
    @senders = participants.keys
  end

  def run
    receipients = senders.shuffle
    puts senders.inspect, receipients.inspect
    puts Permutation.permutation_is_identical?(senders, receipients)
    puts Permutation.forever_alone_participant?(Permutation.create_receipients_map(senders, receipients))
  end

  private

  def set_participants

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
        user_name: YAML.load_file("lib/credentials.yml")["username"],
        password: YAML.load_file("lib/credentials.yml")["password"],
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
