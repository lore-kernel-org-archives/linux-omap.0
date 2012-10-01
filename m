From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: =?UTF-8?q?=5BPATCH=20V2=204/7=5D=20ARM=3A=20OMAP=3A=20DMA=3A=20Move=20plat/dma=2Eh=20to=20plat-omap/dma-omap=2Eh?=
Date: Tue, 2 Oct 2012 00:17:03 +0530
Message-ID: <1349117226-4980-5-git-send-email-lokeshvutla@ti.com>
References: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35942 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab2JASrn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Oct 2012 14:47:43 -0400
In-Reply-To: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, lokeshvutla@ti.com

Move plat/dma.h to plat-omap/dma-omap.h as part of single
zImage work

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap1/board-h2.c                                  |    2=
 +-
 arch/arm/mach-omap1/board-h3.c                                  |    2=
 +-
 arch/arm/mach-omap1/board-palmte.c                              |    2=
 +-
 arch/arm/mach-omap1/board-palmtt.c                              |    2=
 +-
 arch/arm/mach-omap1/board-palmz71.c                             |    2=
 +-
 arch/arm/mach-omap1/board-sx1.c                                 |    2=
 +-
 arch/arm/mach-omap1/devices.c                                   |    2=
 +-
 arch/arm/mach-omap1/dma.c                                       |    2=
 +-
 arch/arm/mach-omap1/io.c                                        |    2=
 +-
 arch/arm/mach-omap1/lcd_dma.c                                   |    2=
 +-
 arch/arm/mach-omap1/mcbsp.c                                     |    2=
 +-
 arch/arm/mach-omap1/pm.c                                        |    2=
 +-
 arch/arm/mach-omap2/board-3430sdp.c                             |    2=
 +-
 arch/arm/mach-omap2/board-h4.c                                  |    2=
 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c                    |    2=
 +-
 arch/arm/mach-omap2/board-rx51.c                                |    2=
 +-
 arch/arm/mach-omap2/devices.c                                   |    2=
 +-
 arch/arm/mach-omap2/dma.c                                       |    2=
 +-
 arch/arm/mach-omap2/io.c                                        |    2=
 +-
 arch/arm/mach-omap2/mcbsp.c                                     |    2=
 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c                      |    2=
 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c                      |    2=
 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c         |    2=
 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c              |    2=
 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c                      |    2=
 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c                      |    2=
 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c                      |    2=
 +-
 arch/arm/mach-omap2/pm24xx.c                                    |    2=
 +-
 arch/arm/mach-omap2/pm34xx.c                                    |    2=
 +-
 arch/arm/mach-omap2/serial.c                                    |    2=
 +-
 arch/arm/plat-omap/common.c                                     |    2=
 +-
 arch/arm/plat-omap/dma.c                                        |    2=
 +-
 arch/arm/plat-omap/include/{plat/dma.h =3D> plat-omap/dma-omap.h} |   =
 2 +-
 drivers/crypto/omap-aes.c                                       |    2=
 +-
 drivers/crypto/omap-sham.c                                      |    2=
 +-
 drivers/dma/omap-dma.c                                          |    2=
 +-
 drivers/media/platform/omap/omap_vout.c                         |    2=
 +-
 drivers/media/platform/omap/omap_vout_vrfb.c                    |    2=
 +-
 drivers/media/platform/omap3isp/ispstat.h                       |    2=
 +-
 drivers/media/platform/soc_camera/omap1_camera.c                |    3=
 +--
 drivers/mmc/host/omap.c                                         |    2=
 +-
 drivers/mtd/nand/omap2.c                                        |    2=
 +-
 drivers/mtd/onenand/omap2.c                                     |    2=
 +-
 drivers/usb/gadget/omap_udc.c                                   |    2=
 +-
 drivers/usb/musb/tusb6010_omap.c                                |    2=
 +-
 drivers/video/omap/lcdc.c                                       |    2=
 +-
 drivers/video/omap/omapfb_main.c                                |    2=
 +-
 drivers/video/omap/sossi.c                                      |    2=
 +-
 48 files changed, 48 insertions(+), 49 deletions(-)
 rename arch/arm/plat-omap/include/{plat/dma.h =3D> plat-omap/dma-omap.=
h} (99%)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board=
-h2.c
index 72855ce..4c2cb8e 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -39,8 +39,8 @@
 #include <asm/mach/map.h>
=20
 #include <mach/mux.h>
-#include <plat/dma.h>
 #include <plat/tc.h>
+#include <plat-omap/dma-omap.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <mach/flash.h>
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board=
-h3.c
index fa98327..3e638b8 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -43,7 +43,7 @@
 #include <mach/mux.h>
 #include <plat/tc.h>
 #include <linux/platform_data/keypad-omap.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <mach/flash.h>
=20
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/b=
oard-palmte.c
index 75ac3cd..eac94c2 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -37,7 +37,7 @@
 #include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/tc.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
=20
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/b=
oard-palmtt.c
index 14e1847..3c06c0b 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -36,10 +36,10 @@
 #include <plat/led.h>
 #include <mach/flash.h>
 #include <mach/mux.h>
-#include <plat/dma.h>
 #include <plat/tc.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
+#include <plat-omap/dma-omap.h>
=20
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/=
board-palmz71.c
index e403bc9..be16edd 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -38,10 +38,10 @@
=20
 #include <mach/flash.h>
 #include <mach/mux.h>
-#include <plat/dma.h>
 #include <plat/tc.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
+#include <plat-omap/dma-omap.h>
=20
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/boar=
d-sx1.c
index 1248fcc..f4c5db9 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -36,7 +36,7 @@
=20
 #include <mach/flash.h>
 #include <mach/mux.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <mach/irda.h>
 #include <plat/tc.h>
 #include <mach/board-sx1.h>
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/device=
s.c
index 890db8f..efd20c3 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -21,8 +21,8 @@
=20
 #include <plat/tc.h>
 #include <mach/mux.h>
-#include <plat/dma.h>
 #include <plat/mmc.h>
+#include <plat-omap/dma-omap.h>
=20
 #include <mach/omap7xx.h>
 #include <mach/camera.h>
diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 40f1dc4..9159417 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -25,7 +25,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
=20
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/tc.h>
=20
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 6a5baab..244cc75 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -18,7 +18,7 @@
=20
 #include <mach/mux.h>
 #include <plat/tc.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #include "iomap.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap1/lcd_dma.c b/arch/arm/mach-omap1/lcd_dm=
a.c
index 9a54d3b..7ed8c18 100644
--- a/arch/arm/mach-omap1/lcd_dma.c
+++ b/arch/arm/mach-omap1/lcd_dma.c
@@ -27,7 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
=20
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #include <mach/hardware.h>
 #include <mach/lcdc.h>
diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index b92f15a..3d461e1 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
=20
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <mach/mux.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 47ec161..8f9726f 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -54,8 +54,8 @@
 #include <plat/sram.h>
 #include <plat/tc.h>
 #include <mach/mux.h>
-#include <plat/dma.h>
 #include <plat/dmtimer.h>
+#include <plat-omap/dma-omap.h>
=20
 #include <mach/irqs.h>
=20
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/=
board-3430sdp.c
index 96cd369..2abbd6a 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -32,7 +32,7 @@
=20
 #include <plat/usb.h>
 #include "common.h"
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/gpmc.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-tfp410.h>
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board=
-h4.c
index f6c48dd..be92783 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -32,7 +32,7 @@
 #include <asm/mach/map.h>
=20
 #include <plat/menelaus.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/gpmc.h>
 #include "debug-devices.h"
=20
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
index ed85fb8..67369ef 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -31,7 +31,7 @@
 #include <asm/system_info.h>
=20
 #include "common.h"
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/gpmc.h>
 #include <plat/omap-pm.h>
 #include "gpmc-smc91x.h"
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/boa=
rd-rx51.c
index 7bbb05d..d255572 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -24,9 +24,9 @@
 #include <asm/mach/map.h>
=20
 #include "common.h"
-#include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
+#include <plat-omap/dma-omap.h>
=20
 #include "mux.h"
 #include "pm.h"
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/device=
s.c
index 998152c..53084e2 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -24,7 +24,7 @@
 #include <asm/mach/map.h>
=20
 #include "iomap.h"
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include "omap4-keypad.h"
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index ff75abe..4e3ac6b 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -30,7 +30,7 @@
=20
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #define OMAP2_DMA_STRIDE	0x60
=20
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4234d28..42a4b9c 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -31,7 +31,7 @@
 #include <plat/omap-pm.h>
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #include "soc.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 37f8f94..b2c7f23 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -20,7 +20,7 @@
 #include <linux/slab.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
=20
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/omap_device.h>
 #include <linux/pm_runtime.h>
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2420_data.c
index 10575a1..3b275c8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -15,7 +15,7 @@
 #include <linux/platform_data/spi-omap2-mcspi.h>
=20
 #include <plat/omap_hwmod.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/serial.h>
 #include <plat/i2c.h>
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2430_data.c
index 60de70f..7e44a63 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -16,7 +16,7 @@
 #include <linux/platform_data/spi-omap2-mcspi.h>
=20
 #include <plat/omap_hwmod.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/serial.h>
 #include <plat/i2c.h>
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/=
arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index 04b99de..f5756bd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -11,8 +11,8 @@
  */
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
-#include <plat/dma.h>
 #include <plat/common.h>
+#include <plat-omap/dma-omap.h>
 #include "hdq1w.h"
=20
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/=
arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index feeb401..e3f889e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -11,7 +11,7 @@
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
 #include <linux/platform_data/gpio-omap.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/dmtimer.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_33xx_data.c
index 59d5c1c..f7f3c2d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -18,7 +18,7 @@
 #include <plat/cpu.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/mmc.h>
 #include <plat/i2c.h>
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_3xxx_data.c
index deff845..c96a197 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -17,8 +17,8 @@
 #include <linux/power/smartreflex.h>
 #include <linux/platform_data/gpio-omap.h>
=20
+#include <plat-omap/dma-omap.h>
 #include <plat/omap_hwmod.h>
-#include <plat/dma.h>
 #include <plat/serial.h>
 #include "l3_3xxx.h"
 #include "l4_3xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 4c92f23..2f6a416 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -24,7 +24,7 @@
=20
 #include <plat/omap_hwmod.h>
 #include <plat/i2c.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <plat/mmc.h>
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.=
c
index 8af6cd6..601a49b 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -38,7 +38,7 @@
=20
 #include <plat/clock.h>
 #include <plat/sram.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #include "common.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index ba670db..baee872 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -41,7 +41,7 @@
 #include <plat/sdrc.h>
 #include <plat/prcm.h>
 #include <plat/gpmc.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #include "common.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index 0405c81..67c4196 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -29,7 +29,7 @@
=20
 #include <plat/omap-serial.h>
 #include "common.h"
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include <plat/omap-pm.h>
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 111315a..b388e87 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -19,7 +19,7 @@
 #include <plat/common.h>
 #include <plat/vram.h>
 #include <linux/platform_data/dsp-omap.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #include <plat/omap-secure.h>
=20
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c76ed8b..53c970d 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -37,8 +37,8 @@
 #include <linux/delay.h>
=20
 #include <plat/cpu.h>
-#include <plat/dma.h>
 #include <plat/tc.h>
+#include <plat-omap/dma-omap.h>
=20
 /*
  * MAX_LOGICAL_DMA_CH_COUNT: the maximum number of logical DMA
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap=
/include/plat-omap/dma-omap.h
similarity index 99%
rename from arch/arm/plat-omap/include/plat/dma.h
rename to arch/arm/plat-omap/include/plat-omap/dma-omap.h
index 3f81458..222be7e 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat-omap/dma-omap.h
@@ -1,5 +1,5 @@
 /*
- *  arch/arm/plat-omap/include/mach/dma.h
+ *  OMAP DMA handling defines and function
  *
  *  Copyright (C) 2003 Nokia Corporation
  *  Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 093a8af..3e61feb 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -30,7 +30,7 @@
 #include <crypto/aes.h>
=20
 #include <plat/cpu.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 /* OMAP TRM gives bitfields as start:end, where start is the higher bi=
t
    number. For example 7:0 */
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index a3fd6fc..6d79695 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -38,7 +38,7 @@
 #include <crypto/internal/hash.h>
=20
 #include <plat/cpu.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <mach/irqs.h>
=20
 #define SHA_REG_DIGEST(x)		(0x00 + ((x) * 0x04))
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index bb2d8e7..0b4fa50 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -20,7 +20,7 @@
 #include "virt-dma.h"
=20
 #include <plat/cpu.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 struct omap_dmadev {
 	struct dma_device ddev;
diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/pl=
atform/omap/omap_vout.c
index c9783fb..fd5b4c7 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -45,7 +45,7 @@
 #include <media/v4l2-ioctl.h>
=20
 #include <plat/cpu.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/vrfb.h>
 #include <video/omapdss.h>
=20
diff --git a/drivers/media/platform/omap/omap_vout_vrfb.c b/drivers/med=
ia/platform/omap/omap_vout_vrfb.c
index 11d7a29..bed4cbb 100644
--- a/drivers/media/platform/omap/omap_vout_vrfb.c
+++ b/drivers/media/platform/omap/omap_vout_vrfb.c
@@ -16,7 +16,7 @@
 #include <media/videobuf-dma-contig.h>
 #include <media/v4l2-device.h>
=20
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/vrfb.h>
=20
 #include "omap_voutdef.h"
diff --git a/drivers/media/platform/omap3isp/ispstat.h b/drivers/media/=
platform/omap3isp/ispstat.h
index 9b7c865..5a1c8c8 100644
--- a/drivers/media/platform/omap3isp/ispstat.h
+++ b/drivers/media/platform/omap3isp/ispstat.h
@@ -30,8 +30,8 @@
=20
 #include <linux/types.h>
 #include <linux/omap3isp.h>
-#include <plat/dma.h>
 #include <media/v4l2-event.h>
+#include <plat-omap/dma-omap.h>
=20
 #include "isp.h"
 #include "ispvideo.h"
diff --git a/drivers/media/platform/soc_camera/omap1_camera.c b/drivers=
/media/platform/soc_camera/omap1_camera.c
index 3046dba..cadb553 100644
--- a/drivers/media/platform/soc_camera/omap1_camera.c
+++ b/drivers/media/platform/soc_camera/omap1_camera.c
@@ -34,8 +34,7 @@
 #include <media/videobuf-dma-contig.h>
 #include <media/videobuf-dma-sg.h>
=20
-#include <plat/dma.h>
-
+#include <plat-omap/dma-omap.h>
=20
 #define DRIVER_NAME		"omap1-camera"
 #define DRIVER_VERSION		"0.0.2"
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 9664fa9..c59c4d2 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -30,7 +30,7 @@
 #include <linux/slab.h>
=20
 #include <plat/mmc.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #define	OMAP_MMC_REG_CMD	0x00
 #define	OMAP_MMC_REG_ARGL	0x01
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 3105f22..2cbdb8e 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -27,7 +27,7 @@
 #include <linux/bch.h>
 #endif
=20
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/gpmc.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
=20
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 1961be9..b846eaf 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -42,7 +42,7 @@
 #include <linux/platform_data/mtd-onenand-omap2.h>
 #include <asm/gpio.h>
=20
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
 #include <plat/cpu.h>
=20
 #define DRIVER_NAME "omap2-onenand"
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_ud=
c.c
index 024c0b9..23afa06 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -44,7 +44,7 @@
 #include <asm/unaligned.h>
 #include <asm/mach-types.h>
=20
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #include <mach/usb.h>
=20
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb60=
10_omap.c
index c032fc2..bfca114 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #include "musb_core.h"
 #include "tusb6010.h"
diff --git a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
index 7767338..c39d6e4 100644
--- a/drivers/video/omap/lcdc.c
+++ b/drivers/video/omap/lcdc.c
@@ -31,7 +31,7 @@
 #include <linux/gfp.h>
=20
 #include <mach/lcdc.h>
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #include <asm/mach-types.h>
=20
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omap=
fb_main.c
index 4351c43..1b5ee8e 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -30,7 +30,7 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
=20
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #include "omapfb.h"
 #include "lcdc.h"
diff --git a/drivers/video/omap/sossi.c b/drivers/video/omap/sossi.c
index f79c137..c510a44 100644
--- a/drivers/video/omap/sossi.c
+++ b/drivers/video/omap/sossi.c
@@ -25,7 +25,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
=20
-#include <plat/dma.h>
+#include <plat-omap/dma-omap.h>
=20
 #include "omapfb.h"
 #include "lcdc.h"
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
