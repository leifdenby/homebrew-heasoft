class Heasoft < Formula
  desc "HEASoft (NASA): A Unified Release of the FTOOLS and XANADU Software Packages"
  homepage "https://heasarc.gsfc.nasa.gov/docs/software/lheasoft/"
  url "http://heasarc.gsfc.nasa.gov/FTP/software/lheasoft/lheasoft6.17/heasoft-6.17src.tar.gz"
  mirror "http://darts.isas.jaxa.jp/pub/legacy.gsfc.nasa.gov/software/lheasoft/lheasoft6.17/heasoft-6.17src.tar.gz"
  version "6.17"
  sha256 "847b9e850c2db466f5207508eab6766a4551dbe566c68af456fc112e0f2dacce"

  depends_on :fortran
  depends_on :x11
  depends_on :macos => :el_capitan

  def install
    cd "BUILD_DIR" do
      ENV.deparallelize

      system "./configure", "--disable-debug",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--prefix=#{prefix}"

      ohai "Compiling takes around 30min, ☕️  time..."

      system "make"
      system "make", "install"
    end
  end

  def post_install
      ENV["HEADAS"] = "#{prefix}"
      system ". $HEADAS/x86_64-apple-darwin15.2.0/headas-init.sh"
      ohai
  end

  def caveats; <<-EOS.undent
    To set up the correct paths in every shell add the following to your ~/.bashrc:

      export HEADAS=#{prefix}/x86_64-apple-darwin15.2.0/
      . $HEADAS/headas-init.sh

    Have fun :)
    EOS
  end
end
