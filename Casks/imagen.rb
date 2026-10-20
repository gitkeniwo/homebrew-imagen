cask "imagen" do
  version "0.1.0"
  sha256 "e38e7fd05337dfde0774727cb9be81dfe5d8e2bd536f786bef764f917a63f0fc"

  url "https://github.com/gitkeniwo/imagen/releases/download/v#{version}/Imagen_#{version}_aarch64.dmg"
  name "Imagen"
  desc "Image-to-image studio for Google's Nano Banana models via Vertex AI"
  homepage "https://github.com/gitkeniwo/imagen"

  depends_on arch: :arm64
  depends_on macos: ">= :sequoia"

  app "Imagen.app"

  # The app is ad-hoc signed and not notarized; drop the download quarantine
  # so Gatekeeper does not report it as damaged on first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Imagen.app"]
  end

  # The user's image library lives wherever they chose and is never removed.
  zap trash: [
    "~/.config/imagen/desktop.json",
    "~/.config/imagen/ui.json",
    "~/.config/imagen/logs",
    "~/Library/WebKit/com.gitkeniwo.imagen",
    "~/Library/Caches/com.gitkeniwo.imagen",
  ]
end
