class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    version "1.5.7"
    $url_linux_x64 = "https://github.com/MarksonHon/homebrew-v2raya/releases/download/1.5.7-9/v2raya-x86_64-linux.zip"
    $sha_linux_x64 = "3BC57DAE8BEBC4BB39C8F8F28C3CABC4E34022F297BAB19CBEC1B8E1EF452FA1"
    $url_macos_x64 = "https://github.com/MarksonHon/homebrew-v2raya/releases/download/1.5.7-9/v2raya-x86_64-macos.zip"
    $sha_macos_x64 = "808387E83008C39854856563F09606FB13EA3E9404EF48B35CAE9ECB9280BE5A"
    $url_macos_arm64 = "https://github.com/MarksonHon/homebrew-v2raya/releases/download/1.5.7-9/v2raya-aarch64-macos.zip"
    $sha_macos_arm64 = "5B3D839ED9854D41F031A2266B99C027975DCBC711FC562BE477DF5E9C29A6F8"
    $OS_Kernel = $(system "uname")
    $OS_CPU = $(system "uname", "-m")

   if $OS_Kernel = "Linux"
       url $url_linux_x64
       sha256 $sha_linux_x64
   elsif $OS_Kernel = "Darwin" 
    if $OS_CPU = "x86_64"
       url $url_macos_x64
       sha256 $sha_macos_x64
    else
       url $url_macos_arm64
       sha256 $sha_macos_arm64
    end
   end

   depends_on "v2ray"

   def install
    bin.install "v2raya"
   end

   service do
    environment_variables V2RAY_LOCATION_ASSET: "#{HOMEBREW_PREFIX}/share/v2ray/", 
                          V2RAYA_V2RAY_BIN: "#{HOMEBREW_PREFIX}/bin/v2ray", 
                          V2RAYA_LOG_FILE: "/tmp/v2raya.log"
    run [bin/"v2raya", "--lite"]
    keep_alive true
  end
end