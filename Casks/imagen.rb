cask "imagen" do
  version "0.2.10"
  sha256 "f9de0f450624d3456af5df20ef7d07c4be85ff9bd465d1f677b5b5816c72e212"

  url "https://github.com/gitkeniwo/imagen/releases/download/v#{version}/Imagen_#{version}_aarch64.dmg"
  name "Imagen"
  desc "Image-to-image studio for Google's Nano Banana models via Vertex AI"
  homepage "https://github.com/gitkeniwo/imagen"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Imagen.app"

  # Quit a running copy before replacing it: the app is a single-instance
  # shell, so a leftover old process would keep its old UI on screen.
  uninstall quit: "com.gitkeniwo.imagen"

  # The app is ad-hoc signed and not notarized; drop the download quarantine
  # so Gatekeeper does not report it as damaged on first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Imagen.app"],
        must_succeed: false
  end

  # The user's image library lives wherever they chose and is never removed.
  zap trash: [
    "~/.config/imagen/desktop.json",
    "~/.config/imagen/logs",
    "~/.config/imagen/ui.json",
    "~/Library/Caches/com.gitkeniwo.imagen",
    "~/Library/WebKit/com.gitkeniwo.imagen",
  ]
end
