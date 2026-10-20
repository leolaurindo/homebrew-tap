class Gixt < Formula
  desc "Command-line tool for working with GitHub Gists"
  homepage "https://github.com/leolaurindo/gixt"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/leolaurindo/gixt/releases/download/v0.5.0/gixt_v0.5.0_darwin_arm64.tar.gz"
      sha256 "2a552dfc2f4adff010e36e08f8eaee7bffa54363a18cc69e963560a5bff38716"
    end

    on_intel do
      url "https://github.com/leolaurindo/gixt/releases/download/v0.5.0/gixt_v0.5.0_darwin_amd64.tar.gz"
      sha256 "425239690531f95e494e2f24281da3c7116ce5d9f339e9acf0ef9495ec729e35"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/leolaurindo/gixt/releases/download/v0.5.0/gixt_v0.5.0_linux_arm64.tar.gz"
      sha256 "ec15c78ac462376e602437408482865493dbad1c9eef98ae2ddec690e7fbd1b7"
    end

    on_intel do
      url "https://github.com/leolaurindo/gixt/releases/download/v0.5.0/gixt_v0.5.0_linux_amd64.tar.gz"
      sha256 "12622612e6a05054695503109991c84f4d5b4e75b6c233b8991197f9d9d6fe53"
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
