class Gixt < Formula
  desc "Command-line tool for working with GitHub Gists"
  homepage "https://github.com/leolaurindo/gixt"
  version "0.4.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_darwin_arm64.tar.gz"
      sha256 "b8ab0d6c34c041b5dda7070c260c48c64b34fbae18eee1a085f56882021f644f"
    end

    on_intel do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_darwin_amd64.tar.gz"
      sha256 "28f235dc48b8e849167b6073dc5bd27b6914d77104152a0d91a6e41fdd5c75e1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_linux_arm64.tar.gz"
      sha256 "9877c7eebf069d937336bd3bb09dfaca51f7531c08b8f2be895e8d2487d75666"
    end

    on_intel do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_linux_amd64.tar.gz"
      sha256 "4c95718817f12cb3a31b3a362bc02b94608f829f504e5185e5a33461121e027e"
    end
  end

  def install
    bin.install "gixt"
    chmod 0555, bin/"gixt"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gixt --version")
  end
end
