cask "neovim-nightly" do
  version :latest
  sha256 :no_check

  arch arm: "arm64", intel: "x86_64"
  url "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-#{arch}.tar.gz",
      verified: "github.com/neovim"

  name "Neovim"
  desc "Vim-fork focused on extensibility and usability"
  homepage "https://neovim.io"

  livecheck do
    url "https://api.github.com/repos/neovim/neovim/releases/tags/nightly"
    strategy :page_match do |page|
      JSON.parse(page)["name"].scan(/nightly-(.*)/).first&.first
    end
  end

  binary "nvim-macos-#{arch}/bin/nvim"

  postflight do
    system_command "xattr", args: ["-cr", "#{staged_path}"]
  end
end
