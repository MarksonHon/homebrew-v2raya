class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "1.5.7-10"
    ## Install v2rayA
    $url_linux_x64 = "https://github.com/MarksonHon/homebrew-v2raya/releases/download/1.5.7-10/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "D653DC03BF6CDE5288786B09A33F417BA89BF87ABF9AF5EDAADFEBEFE82EDDA1"
    $url_macos_x64 = "https://github.com/MarksonHon/homebrew-v2raya/releases/download/1.5.7-10/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "9F979CBEA344E78E912E50C8F1FB1E4B908CFC3AC4F5E3A49397CC755261A2B9"
    $url_macos_arm64 = "https://github.com/MarksonHon/homebrew-v2raya/releases/download/1.5.7-10/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "937976D5EB1BBAFD2AE7E8036733C4BE1A4E54333B23CB054F343B0166B6B947"
    if OS.linux?
      url $url_linux_x64
      sha256 $sha_linux_x64
    elsif Hardware::CPU.intel?
      url $url_macos_x64
      sha256 $sha_macos_x64
      else
      url $url_macos_arm64
      sha256 $sha_macos_arm64
    end

    depends_on "v2ray"

    def install
      bin.install "v2raya"
    end

    service do
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray", V2RAYA_LOG_FILE: "/tmp/v2raya.log"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
