class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "1.5.7-11"
    ## Install v2rayA
    $url_linux_x64 = "https://github.com/MarksonHon/homebrew-v2raya/releases/download/1.5.7-11/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "49A7A50907E632EB452D540527256C0C8F3EE08DA97048EC3C2CDE1F7E28AC3A"
    $url_macos_x64 = "https://github.com/MarksonHon/homebrew-v2raya/releases/download/1.5.7-11/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "47DA937C986684F7777A593F86327F896142A1FE08AD90E0E4444128384224CD"
    $url_macos_arm64 = "https://github.com/MarksonHon/homebrew-v2raya/releases/download/1.5.7-11/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "77162C461AF45F0BA36172905D815719AE94ACE8DEF390ACA8FC4CFB96CEBA35"
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
      environment_variables V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray", V2RAYA_LOG_FILE: "/tmp/v2raya.log", XDG_DATA_DIRS: "#{HOMEBREW_PREFIX}/share:"
      run [bin/"v2raya", "--lite"]
      keep_alive true
    end
end
