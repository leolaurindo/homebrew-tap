class Gixt < Formula
  desc "Command-line tool for working with GitHub Gists"
  homepage "https://github.com/leolaurindo/gixt"
  version "0.4.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_darwin_arm64.tar.gz"
      sha256 "d35e9e96dc5cf25dc3027ae8ad0cecbdf2904b4f0c3e795c77e5a2632db03802"
    end

    on_intel do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_darwin_amd64.tar.gz"
      sha256 "6683edbe72703cba422bf7ef4820ebfe96748b438f0a7801d2230680deb6a807"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_linux_arm64.tar.gz"
      sha256 "d578b9ef24dc07baedcf4d44d1148374e7e1e9411708c47a22dace846b3a5562"
    end

    on_intel do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_linux_amd64.tar.gz"
      sha256 "2c265c585ce1527f2b965a5e828dbb1240fb36a95c37c9de8391c86bb2a247ee"
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
