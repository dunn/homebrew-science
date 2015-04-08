class Rainbow < Formula
  homepage "https://sourceforge.net/projects/bio-rainbow/"
  url "https://downloads.sourceforge.net/project/bio-rainbow/rainbow_2.0.3.tar.gz"
  sha256 "1d3cc66294452316d46e5b1d7e88444029362e94cf9f4de5f3e31b90de9177cc"

  resource "mito" do
    url "http://last.cbrc.jp/tutorial/files/human-mito.fasta"
    sha256 "0bb98fa7d77160c60773b27d1aa5730bd3447d6b4363fb2511565887538678ce"
  end

  fails_with :clang do
    build 600
    cause "error: cannot specify -o when generating multiple output files"
  end

  def install
    system "make"
    bin.install %w[rainbow ezmsim rbasm rbmergetag]
  end

  test do
    resource("mito").stage do
      system bin/"ezmsim", "RAD", "-z",
             "GATCACAGGTCTATCACCCTATTAACCACTCACGGGAGCTCTCCATGCATTTGGTATTTTCGTCTGGGGG",
             "human-mito.fasta", testpath/"out1.fq", testpath/"out2.fq"
    end
  end
end
