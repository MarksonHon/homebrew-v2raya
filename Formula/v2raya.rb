class V2raya < Formula
    desc "Web-based GUI client of Project V"
    homepage "https://v2raya.org"
    license "AGPL-3.0-only"
    url_linux_x64 = 
    sha_linux_x64 = 
    url_macos_x64 = 
    sha_macos_x64 = 
    url_macos_arm64 =
    sha_macos_arm64 =
    OS_Kernel = {system "uname", "--kernel-name"}
    OS_CPU = {system "uname", "--processor"}
   if OS_Kernel = Linux
       url = url_linux_x64
       sha = sha_linux_x64
   elsif OS_Kernel = Darwin and OS_CPU = x86_64
       url = url_macos_x64
       sha = sha_macos_x64
   else
       url = url_macos_arm64
       sha = sha_macos_arm64
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