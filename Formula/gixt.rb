class Gixt < Formula
  desc "Command-line tool for working with GitHub Gists"
  homepage "https://github.com/leolaurindo/gixt"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_darwin_arm64.tar.gz"
      sha256 "7137df368b34bce0f81eab6981099f9f3a5da68b48d7eb3e6b47f3539020111a"
    end

    on_intel do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_darwin_amd64.tar.gz"
      sha256 "1fa7ad55ebcc9f9cd7fa9de7ab9c1d21a428543f5f059ea56de878ce4b7dbc7e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_linux_arm64.tar.gz"
      sha256 "17db696f66652f7242793b3f89db636ffad9e7b32628c3781a48efeb167b1af3"
    end

    on_intel do
      url "https://github.com/leolaurindo/gixt/releases/download/v#{version}/gixt_v#{version}_linux_amd64.tar.gz"
      sha256 "596c7ab43997bcf72eef4f8beb16cc355acc0284e2bc6429d8cb8d7026242855"
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
