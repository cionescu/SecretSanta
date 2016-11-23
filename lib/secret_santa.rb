require 'yaml'
require 'pony'
require 'securerandom'
require_relative 'participants'

class SecretSanta
  attr_reader :participants

  def initialize
    @participants = YAML.load_file("lib/participants.yml")
    SecureRandom.random_number(20).times do
      @participants.shuffle!
    end
  end

  def run
    Participants.group_participants(participants).each do |group|
      send_email group
    end
  end

  private

  def send_email group
    Pony.mail(
      to: "#{group.dig(:from, 'name')} <#{group.dig(:from, 'email')}>",
      subject: "[Secret Santa] Woop Woop",
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
        #{group.dig(:from, 'name')},

        Anul acesta tu vei fi Secret Santa pentru #{group.dig(:to, 'name')}.

        Ho Ho Ho si Merry Christmas 🎅
      BODY
    )
  end
end
