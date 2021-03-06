# Please only update to versions that are published on PyPi as there are too
# many releases for us to update to every single one:
# https://pypi.python.org/pypi/youtube_dl
class YoutubeDl < Formula
  desc "Download YouTube videos from the command-line"
  homepage "https://rg3.github.io/youtube-dl/"
  url "https://github.com/rg3/youtube-dl/releases/download/2016.10.19/youtube-dl-2016.10.19.tar.gz"
  sha256 "ed8d4a247c4cfffe2a1171b4f9c20be19e84d96bcf3716f46988c8503b1b7713"

  bottle do
    cellar :any_skip_relocation
    sha256 "0d3738284ab149ac3ceb0b49bd95f2955e46a6dbf1ff5d7c298773d4794d386a" => :sierra
    sha256 "0d3738284ab149ac3ceb0b49bd95f2955e46a6dbf1ff5d7c298773d4794d386a" => :el_capitan
    sha256 "0d3738284ab149ac3ceb0b49bd95f2955e46a6dbf1ff5d7c298773d4794d386a" => :yosemite
  end

  head do
    url "https://github.com/rg3/youtube-dl.git"
    depends_on "pandoc" => :build
  end

  depends_on "rtmpdump" => :optional

  def install
    system "make", "PREFIX=#{prefix}"
    bin.install "youtube-dl"
    man1.install "youtube-dl.1"
    bash_completion.install "youtube-dl.bash-completion"
    zsh_completion.install "youtube-dl.zsh" => "_youtube-dl"
    fish_completion.install "youtube-dl.fish"
  end

  def caveats
    "To use post-processing options, `brew install ffmpeg` or `brew install libav`."
  end

  test do
    system "#{bin}/youtube-dl", "--simulate", "https://www.youtube.com/watch?v=he2a4xK8ctk"
    system "#{bin}/youtube-dl", "--simulate", "--yes-playlist", "https://www.youtube.com/watch?v=AEhULv4ruL4&list=PLZdCLR02grLrl5ie970A24kvti21hGiOf"
  end
end
