class OnchainDataMcp < Formula
  desc "MCP + REST server for blockchain data (EVM + Solana) with vendor routing and free-tier quotas"
  homepage "https://github.com/madlabs-tech/onchain-data-mcp"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/madlabs-tech/onchain-data-mcp/releases/download/v0.2.0/onchain-data-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "e171f56e82a45d01563e51f605f326c887689b625139ea8872baa81cace770d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/madlabs-tech/onchain-data-mcp/releases/download/v0.2.0/onchain-data-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "40a4786b228a61deb262826c4b5e452aae7a2f057c7f14eae281ea666a78ec73"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/madlabs-tech/onchain-data-mcp/releases/download/v0.2.0/onchain-data-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1831f74a86e265f0fbabc9b634eddb83cf3d75f5d66077276847bbad35538af5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/madlabs-tech/onchain-data-mcp/releases/download/v0.2.0/onchain-data-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "71a16a0036bbff9ffd5d698669684f08ea0e6b5dd33e71d7743bec34eff4acc8"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "onchain-data-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "onchain-data-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "onchain-data-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "onchain-data-mcp"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
