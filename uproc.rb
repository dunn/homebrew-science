class Uproc < Formula
  homepage "http://uproc.gobics.de/"
  # tag "bioinformatics"
  url "http://uproc.gobics.de/downloads/uproc/uproc-1.2.0.tar.gz"
  sha256 "378afd1d2bb1564582e3893eabb95223bf80fb6950e571690064167fe0e779bc"

  head do
    url "https://github.com/gobics/uproc.git"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/science"
    cellar :any
    sha1 "e85ca47439010ba2bbed0676569516018647b12d" => :yosemite
    sha1 "a6d9496f7271755e9104ad7fa4af59476b982815" => :mavericks
    sha1 "6216fa194d8413b905d58b94993abb2eac531b48" => :mountain_lion
  end

  needs :openmp # => :recommended

  def install
    system "autoreconf", "-i" if build.head?
    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/uproc-dna", "--version"
  end
end
