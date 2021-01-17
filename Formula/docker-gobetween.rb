require 'formula'

class DockerGobetween < Formula
  url "https://github.com/bassrock/homebrew-docker-gobetween.git", :using => :git, :branch => "main"
  version "0.0.1"
  revision 1

  depends_on 'coreutils'
  depends_on 'curl'
  depends_on 'jq'
  depends_on 'docker'
  depends_on 'docker-machine'

  resource "gobetween" do
    url "https://github.com/yyyar/gobetween/releases/download/0.8.0/gobetween_0.8.0_darwin_amd64.zip"
    sha256 "15efec9cef9dc01c4e195042df62def95f189090e470678d5b6f024afa71e1b0"
  end

  def install
    resource("gobetween").stage do
      bin.install "gobetween"
    end
    (buildpath/"gobetween.toml").write <<~EOS
      [api]
      enabled = true
      bind = "127.0.0.1:8181"
    EOS
    (etc/"docker-gobetween").mkpath
    etc.install "gobetween.toml" => 'docker-gobetween/gobetween.toml'

    bin.install "bin/gobetween-init"
  end

  def caveats
      s = <<~EOS
        Docker GoBetween was installed
      EOS
      s
    end

    def plist; <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/gobetween-init</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>/tmp</string>
      </dict>
      </plist>
    EOS
    end
end
