From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [GIT PULL] omap2 sparse fixes
Date: Wed, 22 Sep 2010 14:19:02 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A38F9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1655537261=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============1655537261==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_E0D41E29EB0DAC4E9F3FF173962E9E9402785A38F9dbde02enttico_"

--_000_E0D41E29EB0DAC4E9F3FF173962E9E9402785A38F9dbde02enttico_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

Please pull omap2 sparse fixes from:

  git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git sparse_fixes

Regards,
Manjunath


The following changes since commit 8b15575cae7a93a784c3005c42b069edd9ba64dd=
:
  Sage Weil (1):
        fs: {lock,unlock}_flocks() stubs to prepare for BKL removal

are available in the git repository at:

  git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git sparse_fixes

G, Manjunath Kondaiah (10):
      OMAP: mach-omap2: Fix incorrect assignment warnings
      OMAP: mach-omap2: Fix static declaration warnings
      OMAP: mach-omap2: Fix static function warnings
      OMAP: mach-omap2: Fix miscellaneous sparse warnings
      OMAP: plat-omap: Fix static function warnings
      OMAP: NAND: Fix static declaration warning
      TWL CORE: Fix sparse warning
      TWL IRQ: Fix fucntion declaration warnings
      OMAP2/3: Convert write/read functions to raw read/write
      OMAP3: Keypad: Fix incorrect type initializer

 arch/arm/mach-omap2/board-3430sdp.c            |    2 +-
 arch/arm/mach-omap2/board-am3517evm.c          |    5 +--
 arch/arm/mach-omap2/board-cm-t35.c             |    2 +-
 arch/arm/mach-omap2/board-devkit8000.c         |    2 +-
 arch/arm/mach-omap2/board-igep0020.c           |    4 +-
 arch/arm/mach-omap2/board-ldp.c                |    2 +-
 arch/arm/mach-omap2/board-n8x0.c               |   16 +------------
 arch/arm/mach-omap2/board-omap3evm.c           |    8 +++---
 arch/arm/mach-omap2/board-omap3stalker.c       |    4 +-
 arch/arm/mach-omap2/board-omap3touchbook.c     |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c   |    4 ++-
 arch/arm/mach-omap2/board-rx51-sdram.c         |    2 +-
 arch/arm/mach-omap2/board-rx51-video.c         |    2 +
 arch/arm/mach-omap2/board-zoom-debugboard.c    |    2 +
 arch/arm/mach-omap2/board-zoom-peripherals.c   |    4 ++-
 arch/arm/mach-omap2/control.c                  |    5 ++-
 arch/arm/mach-omap2/gpmc-onenand.c             |    8 +++---
 arch/arm/mach-omap2/include/mach/board-flash.h |    2 +
 arch/arm/mach-omap2/include/mach/board-rx51.h  |   11 +++++++++
 arch/arm/mach-omap2/irq.c                      |    1 -
 arch/arm/mach-omap2/mux2420.c                  |    2 +-
 arch/arm/mach-omap2/mux2430.c                  |    2 +-
 arch/arm/mach-omap2/mux34xx.c                  |   12 +++++-----
 arch/arm/mach-omap2/pm-debug.c                 |    2 +-
 arch/arm/mach-omap2/pm34xx.c                   |    2 +-
 arch/arm/mach-omap2/powerdomain.c              |   28 --------------------=
----
 arch/arm/mach-omap2/prcm.c                     |    2 +-
 arch/arm/mach-omap2/timer-gp.c                 |    1 +
 arch/arm/plat-omap/cpu-omap.c                  |    4 +-
 arch/arm/plat-omap/dmtimer.c                   |    6 ++--
 arch/arm/plat-omap/fb.c                        |    1 +
 arch/arm/plat-omap/include/plat/dmtimer.h      |    4 ++-
 arch/arm/plat-omap/include/plat/sdrc.h         |    1 +
 arch/arm/plat-omap/mcbsp.c                     |   10 ++++----
 arch/arm/plat-omap/sram.c                      |   13 ++++++-----
 drivers/mfd/twl-core.c                         |    2 +-
 drivers/mtd/nand/omap2.c                       |    6 ++--
 drivers/mtd/onenand/omap2.c                    |    2 +-
 include/linux/i2c/twl.h                        |    5 ++++
 include/linux/omapfb.h                         |    5 ++++
 40 files changed, 96 insertions(+), 102 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/board-rx51.h

--_000_E0D41E29EB0DAC4E9F3FF173962E9E9402785A38F9dbde02enttico_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1"=
>
<META content=3D"MSHTML 6.00.2900.5969" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3D"Courier New" size=3D2>Hi&nbsp;<SPAN=20
class=3D344354008-22092010>Tony</SPAN>,</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>Please pull&nbsp;<SPAN=20
class=3D344354008-22092010>omap2 </SPAN><SPAN class=3D344354008-22092010>sp=
arse=20
fixes</SPAN>&nbsp;from:</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>&nbsp;=20
git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git=20
sparse_fixes</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT><FONT face=3D"Courier New"=
=20
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>Regards,</FONT></DIV>
<DIV><SPAN class=3D344354008-22092010><FONT face=3D"Courier New"=20
size=3D2>Manjunath</FONT></SPAN></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>The following changes since commit=
=20
8b15575cae7a93a784c3005c42b069edd9ba64dd:<BR>&nbsp; Sage Weil=20
(1):<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fs: {lock,unlock}_flocks=
()=20
stubs to prepare for BKL removal</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>are available in the git repositor=
y=20
at:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>&nbsp;=20
git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git=20
sparse_fixes</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>G, Manjunath Kondaiah=20
(10):<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OMAP: mach-omap2: Fix incorrect=20
assignment warnings<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OMAP: mach-omap2: Fix=
=20
static declaration warnings<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OMAP: mach-om=
ap2:=20
Fix static function warnings<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OMAP: mach-o=
map2:=20
Fix miscellaneous sparse warnings<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OMAP:=20
plat-omap: Fix static function warnings<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; O=
MAP:=20
NAND: Fix static declaration warning<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TWL =
CORE:=20
Fix sparse warning<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TWL IRQ: Fix fucntion=
=20
declaration warnings<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OMAP2/3: Convert=20
write/read functions to raw read/write<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OM=
AP3:=20
Keypad: Fix incorrect type initializer</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New"=20
size=3D2>&nbsp;arch/arm/mach-omap2/board-3430sdp.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;arch/arm/mach-omap2/board-am3517evm.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 5=20
+--<BR>&nbsp;arch/arm/mach-omap2/board-cm-t35.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;arch/arm/mach-omap2/board-devkit8000.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;arch/arm/mach-omap2/board-igep0020.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 4=20
+-<BR>&nbsp;arch/arm/mach-omap2/board-ldp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;arch/arm/mach-omap2/board-n8x0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp; 16=20
+------------<BR>&nbsp;arch/arm/mach-omap2/board-omap3evm.c&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 8=20
+++---<BR>&nbsp;arch/arm/mach-omap2/board-omap3stalker.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 4=20
+-<BR>&nbsp;arch/arm/mach-omap2/board-omap3touchbook.c&nbsp;&nbsp;&nbsp;&nb=
sp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;arch/arm/mach-omap2/board-rx51-peripherals.c&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 4=20
++-<BR>&nbsp;arch/arm/mach-omap2/board-rx51-sdram.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;arch/arm/mach-omap2/board-rx51-video.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+<BR>&nbsp;arch/arm/mach-omap2/board-zoom-debugboard.c&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+<BR>&nbsp;arch/arm/mach-omap2/board-zoom-peripherals.c&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 4=20
++-<BR>&nbsp;arch/arm/mach-omap2/control.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 5=20
++-<BR>&nbsp;arch/arm/mach-omap2/gpmc-onenand.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 8=20
+++---<BR>&nbsp;arch/arm/mach-omap2/include/mach/board-flash.h=20
|&nbsp;&nbsp;&nbsp; 2=20
+<BR>&nbsp;arch/arm/mach-omap2/include/mach/board-rx51.h&nbsp; |&nbsp;&nbsp=
; 11=20
+++++++++<BR>&nbsp;arch/arm/mach-omap2/irq.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 1=20
-<BR>&nbsp;arch/arm/mach-omap2/mux2420.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;arch/arm/mach-omap2/mux2430.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;arch/arm/mach-omap2/mux34xx.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp; 12=20
+++++-----<BR>&nbsp;arch/arm/mach-omap2/pm-debug.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;arch/arm/mach-omap2/pm34xx.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;arch/arm/mach-omap2/powerdomain.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp; 28=20
------------------------<BR>&nbsp;arch/arm/mach-omap2/prcm.c&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;arch/arm/mach-omap2/timer-gp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 1=20
+<BR>&nbsp;arch/arm/plat-omap/cpu-omap.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 4=20
+-<BR>&nbsp;arch/arm/plat-omap/dmtimer.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 6=20
++--<BR>&nbsp;arch/arm/plat-omap/fb.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 1=20
+<BR>&nbsp;arch/arm/plat-omap/include/plat/dmtimer.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 4=20
++-<BR>&nbsp;arch/arm/plat-omap/include/plat/sdrc.h&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 1=20
+<BR>&nbsp;arch/arm/plat-omap/mcbsp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
|&nbsp;&nbsp; 10=20
++++----<BR>&nbsp;arch/arm/plat-omap/sram.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp; 13=20
++++++-----<BR>&nbsp;drivers/mfd/twl-core.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;drivers/mtd/nand/omap2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 6=20
++--<BR>&nbsp;drivers/mtd/onenand/omap2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
|&nbsp;&nbsp;&nbsp; 2=20
+-<BR>&nbsp;include/linux/i2c/twl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 5=20
++++<BR>&nbsp;include/linux/omapfb.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
|&nbsp;&nbsp;&nbsp; 5 ++++<BR>&nbsp;40 files changed, 96 insertions(+), 102=
=20
deletions(-)<BR>&nbsp;create mode 100644=20
arch/arm/mach-omap2/include/mach/board-rx51.h<BR></FONT></DIV></BODY></HTML=
>

--_000_E0D41E29EB0DAC4E9F3FF173962E9E9402785A38F9dbde02enttico_--


--===============1655537261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1655537261==--
