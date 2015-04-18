class Cube < Formula
  homepage "http://apps.fz-juelich.de/scalasca/"
  url "http://apps.fz-juelich.de/scalasca/releases/cube/4.3/dist/cube-4.3.tar.gz"
  sha256 "5a77474e67ba6c2ef6d0451b506b413d9caefb2e8572958c1d1c219a1730c828"

  depends_on "qt" => :recommended

  def install
    ENV.deparallelize

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"cube-config", "--version"
  end
end
