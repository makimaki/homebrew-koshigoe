require 'formula'

class Pgmodeler < Formula
  homepage 'http://pgmodeler.com.br/'
  head 'https://github.com/pgmodeler/pgmodeler.git', :revision => '339bb545177c5b4d974c57f66cea7a427ad22ec7'

  depends_on 'qt5'
  depends_on 'postgresql'
  depends_on 'libxml2'

  patch DATA

  def install
    system "/usr/local/opt/qt5/bin/qmake PREFIX+=#{prefix}/pgmodeler.app/Contents pgmodeler.pro"
    system "make"
    system "make install"
  end
end

__END__
diff --git a/pgmodeler.pri b/pgmodeler.pri
index 5b07b98..a2951c0 100644
--- a/pgmodeler.pri
+++ b/pgmodeler.pri
@@ -113,7 +113,8 @@ macx {
   !defined(SCHEMASDIR, var):    SCHEMASDIR = $$BINDIR/schemas

   # Specifies where to find the libraries at runtime
-  QMAKE_RPATHDIR += @executable_path/../Frameworks
+  QMAKE_RPATHDIR += @executable_path/../Frameworks\
+  QMAKE_LFLAGS_SONAME = -Wl,-install_name,@rpath/
 }

 # Creating constants based upon the custom paths so the GlobalAttributes
@@ -145,10 +146,10 @@ unix:!macx {
 }

 macx {
-  PGSQL_LIB = /Library/PostgreSQL/9.4/lib/libpq.dylib
-  PGSQL_INC = /Library/PostgreSQL/9.4/include
-  XML_INC = /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/include/libxml2
-  XML_LIB = /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk/usr/lib/libxml2.dylib
+  PGSQL_LIB = /usr/local/opt/postgresql/lib/libpq.dylib
+  PGSQL_INC = /usr/local/opt/postgresql/include
+  XML_INC = /usr/local/opt/libxml2/include/libxml2
+  XML_LIB = /usr/local/opt/libxml2/lib/libxml2.dylib

   INCLUDEPATH += $$PGSQL_INC $$XML_INC
 }

