require 'formula'

class Exiftool < Formula
  homepage 'http://www.sno.phy.queensu.ca/~phil/exiftool/index.html'
  url 'http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-9.28.tar.gz'
  sha1 'a1959056ff0705b220499f4f9f5ba6867ff82011'

  def install
    system "perl", "Makefile.PL"
    system "make", "test"

    # Install privately to the Cellar
    libexec.install "exiftool", "lib"

    # Link the executable script into "bin"
    (bin + 'exiftool').write <<-EOBIN
#!/bin/bash

exiftool=`perl -MCwd -e 'print Cwd::abs_path($ARGV[0])' "$0"`
dirname_exiftool=`dirname "$exiftool"`
"$dirname_exiftool"/../libexec/exiftool "$@"
EOBIN
  end

  def test
    system "#{libexec}/exiftool"
  end
end
