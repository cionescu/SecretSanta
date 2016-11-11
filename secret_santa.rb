require "pony"
require "yaml"

class SecretSanta

  def initialize
  end

  def run
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
