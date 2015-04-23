class Fasttree < Formula
  homepage "http://meta.microbesonline.org/fasttree/"
  url "https://mirrors.kernel.org/debian/pool/main/f/fasttree/fasttree_2.1.8.orig.tar.gz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/f/fasttree/fasttree_2.1.8.orig.tar.gz"
  sha256 "bec10584efa788593065f065b0006d9fe54d37ad43d21ddc4e29233fb921e7c2"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/science"
    cellar :any
    sha1 "369bb09b371ed05d55a403750738c5749fb95c07" => :yosemite
    sha1 "829bfc5f6fc144a6642c29b8a2e6a4e078998e8c" => :mavericks
    sha1 "acad8b55ad7eb9f6a63cf6b96ef3961e1d01ed79" => :mountain_lion
  end

  needs :openmp

  fails_with :clang do
    build 425
    cause "segmentation fault when running Fasttree"
    # See also discussion to use -DNO_SSE (https://github.com/Homebrew/homebrew-science/pull/96)
  end

  def install
    system ENV.cc, "-DOPENMP", "-fopenmp", "-O3", "-finline-functions", "-funroll-loops", "-Wall", "-o", "FastTree", "fasttree.c", "-lm"
    bin.install "FastTree"
  end

  test do
    Pathname.new("test.fa").write <<-EOF.undent
      >1
      LCLYTHIGRNIYYGSYLYSETWNTTTMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
      >2
      LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGYVLPWGQMSFWGATVITNLFSAIPYIGTNLV
      >3
      LCLYTHIGRNIYYGSYLYSETWNTGIMLLLITMATAFMGTTLPWGQMSFWGATVITNLFSAIPYIGTNLV
    EOF
    `#{bin}/FastTree test.fa` =~ /1:0.\d+,2:0.\d+,3:0.\d+/ ? true : false
  end
end
