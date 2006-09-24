From: "Amit Verma" <vermanamit@gmail.com>
Subject: X Windows;
	Xlibs cross-compiled+linked files overbloated for OMAP1710
Date: Sun, 24 Sep 2006 13:54:01 +0530
Message-ID: <5a2ffe1f0609240124v5b456504u7e1899ed96246c35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Sokolovsky <pmiscml@gmail.com>, david.cohen@indt.org.br, marek.vasut@gmail.com, linux-omap-open-source@linux.omap.com, carlos.aguiar@indt.org.br, h6300-port@handhelds.org
List-Id: linux-omap@vger.kernel.org

I'm trying to put X Windows on OMAP1710-H3 board (with 32MB NOR
memory). My "X" is becoming huge after cross-comipiling and
cross-linking.

STEPS:-
[ 1 ]. I have configured Scratchbox for cross
compilation(arm-linux-gcc-3.3_3.3.4-glibc-2.3.2.ds1) for ARM processor
[ 2 ]. Installed "ZLIB"
[ 3 ]. Installed "TSLIB"
[ 4 ] . Compiled and installed following "XLIBS" (in the order)

Randr
Render
XExtensions
FixesExt
DamageExt
Xproto
xtrans
Xfont
Xau
CompositeExt
ResourceExt
RecordExt
Xdmcp
XCalibrateExt
X11
Xext

I'm using following commands to cross-compile and install these libs
a) ./autogen.sh --disable-maintainer-mode --disable-debug
--enable-optimization --prefix=/usr --host=arm-linux-gnu
b) make install

But the size of shared objects ".so" is coming so BIG, libX11.so.xxx
is coming 20MB and others are also coming big.

[ 5 ] then I'have compiled & installed Xserver
(anoncvs_at_cvs.freedesktop.org:/cvs/xserver) using following commands
a) ./autogen.sh
b) ./configure --prefix=/usr --host=arm-linux-gnu --disable-glx
--disable-dri --disable-ipv6 --disable-xglserver --disable-xglxserver
--disable-xsdlserver --disable-xwinserver --disable-xnestserver

This will give the framebuffered xserver, "Xfbdev" which is coming as 9.4MB.

When I copy these files to my FileSystem, kernel doesn't boots up, it
gets hanged after saying "booting kernel..." thats obvious b'coz size
of FS has overbloated than the available memory on the board.

I have limited memory (32MB - NOR) on my OMAP1710-H3 board. So, plz
tell me how to reduce the sixe of X Windows so that it can fit in.
ALso tell the non-dependable X-libs so that i can remove them so that
minimal "X" can be put on the board
I'm wondering how the size has come so large!!!

Plz help. Thanks! in advance
-Amit Verma
