From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: =?UTF-8?q?=5BPATCH=202/4=5D=20ARM=3A=20OMAP=3A=20DMA=3A=20Move=20plat/dma=20hearder=20to=20platform=5Fdata/dma-omap?=
Date: Fri, 28 Sep 2012 19:10:07 +0530
Message-ID: <1348839609-10456-3-git-send-email-lokeshvutla@ti.com>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38158 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758112Ab2I1Nk2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Sep 2012 09:40:28 -0400
In-Reply-To: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, lokeshvutla@ti.com

Move plat/dma.h header to platform_data/dma-omap.h as
part of the single zImage work.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap1/board-h2.c                                     |  =
  2 +-
 arch/arm/mach-omap1/board-h3.c                                     |  =
  2 +-
 arch/arm/mach-omap1/board-palmte.c                                 |  =
  2 +-
 arch/arm/mach-omap1/board-palmtt.c                                 |  =
  2 +-
 arch/arm/mach-omap1/board-palmz71.c                                |  =
  2 +-
 arch/arm/mach-omap1/board-sx1.c                                    |  =
  2 +-
 arch/arm/mach-omap1/devices.c                                      |  =
  2 +-
 arch/arm/mach-omap1/dma.c                                          |  =
  2 +-
 arch/arm/mach-omap1/io.c                                           |  =
  2 +-
 arch/arm/mach-omap1/lcd_dma.c                                      |  =
  3 +--
 arch/arm/mach-omap1/mcbsp.c                                        |  =
  2 +-
 arch/arm/mach-omap1/pm.c                                           |  =
  2 +-
 arch/arm/mach-omap2/board-3430sdp.c                                |  =
  2 +-
 arch/arm/mach-omap2/board-h4.c                                     |  =
  2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c                       |  =
  2 +-
 arch/arm/mach-omap2/board-rx51.c                                   |  =
  2 +-
 arch/arm/mach-omap2/devices.c                                      |  =
  2 +-
 arch/arm/mach-omap2/dma.c                                          |  =
  2 +-
 arch/arm/mach-omap2/io.c                                           |  =
  2 +-
 arch/arm/mach-omap2/mcbsp.c                                        |  =
  2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c                         |  =
  2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c                         |  =
  2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c            |  =
  3 ++-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c                 |  =
  2 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c                         |  =
  2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c                         |  =
  2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c                         |  =
  2 +-
 arch/arm/mach-omap2/pm24xx.c                                       |  =
  2 +-
 arch/arm/mach-omap2/pm34xx.c                                       |  =
  2 +-
 arch/arm/mach-omap2/serial.c                                       |  =
  2 +-
 arch/arm/plat-omap/common.c                                        |  =
  2 +-
 arch/arm/plat-omap/dma.c                                           |  =
  2 +-
 drivers/crypto/omap-aes.c                                          |  =
  2 +-
 drivers/crypto/omap-sham.c                                         |  =
  3 ++-
 drivers/dma/omap-dma.c                                             |  =
  2 +-
 drivers/media/platform/omap/omap_vout.c                            |  =
  2 +-
 drivers/media/platform/omap/omap_vout_vrfb.c                       |  =
  2 +-
 drivers/media/platform/omap3isp/ispstat.h                          |  =
  3 ++-
 drivers/media/platform/soc_camera/omap1_camera.c                   |  =
  4 +---
 drivers/mmc/host/omap.c                                            |  =
  2 +-
 drivers/mtd/nand/omap2.c                                           |  =
  2 +-
 drivers/mtd/onenand/omap2.c                                        |  =
  2 +-
 drivers/usb/gadget/omap_udc.c                                      |  =
  3 +--
 drivers/usb/musb/tusb6010_omap.c                                   |  =
  2 +-
 drivers/video/omap/lcdc.c                                          |  =
  2 +-
 drivers/video/omap/omapfb_main.c                                   |  =
  3 +--
 drivers/video/omap/sossi.c                                         |  =
  3 +--
 .../include/plat/dma.h =3D> include/linux/platform_data/dma-omap.h   |=
    2 +-
 48 files changed, 51 insertions(+), 54 deletions(-)
 rename arch/arm/plat-omap/include/plat/dma.h =3D> include/linux/platfo=
rm_data/dma-omap.h (99%)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board=
-h2.c
index a2e53e1..d567bf2 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -33,13 +33,13 @@
 #include <linux/omapfb.h>
 #include <linux/leds.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
=20
 #include <mach/mux.h>
-#include <plat/dma.h>
 #include <plat/tc.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board=
-h3.c
index fa98327..ad533bd 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -33,6 +33,7 @@
 #include <linux/omapfb.h>
 #include <linux/leds.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -43,7 +44,6 @@
 #include <mach/mux.h>
 #include <plat/tc.h>
 #include <linux/platform_data/keypad-omap.h>
-#include <plat/dma.h>
 #include <mach/flash.h>
=20
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/b=
oard-palmte.c
index 1c578d5..8018ed9 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -29,6 +29,7 @@
 #include <linux/apm-emulation.h>
 #include <linux/omapfb.h>
 #include <linux/platform_data/omap1_bl.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -37,7 +38,6 @@
 #include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/tc.h>
-#include <plat/dma.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
=20
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/b=
oard-palmtt.c
index 9715809..2ecb8d5 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/platform_data/omap1_bl.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -36,7 +37,6 @@
 #include <plat/led.h>
 #include <mach/flash.h>
 #include <mach/mux.h>
-#include <plat/dma.h>
 #include <plat/tc.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/=
board-palmz71.c
index e311032..a48a941 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -31,6 +31,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/platform_data/omap1_bl.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -38,7 +39,6 @@
=20
 #include <mach/flash.h>
 #include <mach/mux.h>
-#include <plat/dma.h>
 #include <plat/tc.h>
 #include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/boar=
d-sx1.c
index 13bf2cc..dcc63ee 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -29,6 +29,7 @@
 #include <linux/export.h>
 #include <linux/omapfb.h>
 #include <linux/platform_data/keypad-omap.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -36,7 +37,6 @@
=20
 #include <mach/flash.h>
 #include <mach/mux.h>
-#include <plat/dma.h>
 #include <mach/irda.h>
 #include <plat/tc.h>
 #include <mach/board-sx1.h>
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/device=
s.c
index 0cc54dd..b050980 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -16,12 +16,12 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach/map.h>
=20
 #include <plat/tc.h>
 #include <mach/mux.h>
-#include <plat/dma.h>
 #include <plat/mmc.h>
=20
 #include <mach/omap7xx.h>
diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 29007fe..a81a659 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -24,8 +24,8 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/platform_data/dma-omap.h>
=20
-#include <plat/dma.h>
 #include <plat/tc.h>
=20
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 6a5baab..1b129c9 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -12,13 +12,13 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
=20
 #include <mach/mux.h>
 #include <plat/tc.h>
-#include <plat/dma.h>
=20
 #include "iomap.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap1/lcd_dma.c b/arch/arm/mach-omap1/lcd_dm=
a.c
index ed42628..b5cc8c8 100644
--- a/arch/arm/mach-omap1/lcd_dma.c
+++ b/arch/arm/mach-omap1/lcd_dma.c
@@ -26,8 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-
-#include <plat/dma.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <mach/hardware.h>
 #include <mach/lcdc.h>
diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index bdc2e75..5e65d4a 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -18,8 +18,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/platform_data/dma-omap.h>
=20
-#include <plat/dma.h>
 #include <mach/mux.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 47ec161..223c748 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -43,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/atomic.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/system_misc.h>
 #include <asm/irq.h>
@@ -54,7 +55,6 @@
 #include <plat/sram.h>
 #include <plat/tc.h>
 #include <mach/mux.h>
-#include <plat/dma.h>
 #include <plat/dmtimer.h>
=20
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/=
board-3430sdp.c
index 96cd369..a05e9aa 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -25,6 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -32,7 +33,6 @@
=20
 #include <plat/usb.h>
 #include "common.h"
-#include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-tfp410.h>
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board=
-h4.c
index f6c48dd..4b6d000 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -26,13 +26,13 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
=20
 #include <plat/menelaus.h>
-#include <plat/dma.h>
 #include <plat/gpmc.h>
 #include "debug-devices.h"
=20
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
index ed85fb8..7393361 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -27,11 +27,11 @@
 #include <linux/power/isp1704_charger.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/system_info.h>
=20
 #include "common.h"
-#include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <plat/omap-pm.h>
 #include "gpmc-smc91x.h"
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/boa=
rd-rx51.c
index 7bbb05d..351f249 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -18,13 +18,13 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
=20
 #include "common.h"
-#include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
=20
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/device=
s.c
index d092d2a8..6979ee5 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -19,12 +19,12 @@
 #include <linux/of.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/omap4-keypad.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
=20
 #include "iomap.h"
-#include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include "omap4-keypad.h"
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index ff75abe..0d35896 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -27,10 +27,10 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
-#include <plat/dma.h>
=20
 #define OMAP2_DMA_STRIDE	0x60
=20
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4234d28..b837e31 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
@@ -31,7 +32,6 @@
 #include <plat/omap-pm.h>
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
-#include <plat/dma.h>
=20
 #include "soc.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 37f8f94..a6cada4 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -19,8 +19,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
+#include <linux/platform_data/dma-omap.h>
=20
-#include <plat/dma.h>
 #include <plat/omap_device.h>
 #include <linux/pm_runtime.h>
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2420_data.c
index 10575a1..e1b437b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -13,9 +13,9 @@
  * XXX these should be marked initdata for multi-OMAP kernels
  */
 #include <linux/platform_data/spi-omap2-mcspi.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <plat/omap_hwmod.h>
-#include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/i2c.h>
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2430_data.c
index 60de70f..c69a109 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -14,9 +14,9 @@
  */
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <plat/omap_hwmod.h>
-#include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/i2c.h>
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/=
arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index 8851bbb..a0d1153 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -9,9 +9,10 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/platform_data/dma-omap.h>
+
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
-#include <plat/dma.h>
 #include <plat/common.h>
 #include "hdq1w.h"
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/=
arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index feeb401..7941119 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -11,9 +11,9 @@
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
 #include <linux/platform_data/gpio-omap.h>
-#include <plat/dma.h>
 #include <plat/dmtimer.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include "omap_hwmod_common_data.h"
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_33xx_data.c
index 59d5c1c..8a182aa 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -13,12 +13,12 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  */
+#include <linux/platform_data/dma-omap.h>
=20
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <plat/dma.h>
 #include <plat/mmc.h>
 #include <plat/i2c.h>
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_3xxx_data.c
index 94b38af..ab85cdd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -16,9 +16,9 @@
  */
 #include <linux/power/smartreflex.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <plat/omap_hwmod.h>
-#include <plat/dma.h>
 #include <plat/serial.h>
 #include "l3_3xxx.h"
 #include "l4_3xxx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 4c92f23..b361380 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -21,10 +21,10 @@
 #include <linux/io.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/power/smartreflex.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <plat/omap_hwmod.h>
 #include <plat/i2c.h>
-#include <plat/dma.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <plat/mmc.h>
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.=
c
index 8af6cd6..37c6392 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -30,6 +30,7 @@
 #include <linux/time.h>
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
@@ -38,7 +39,6 @@
=20
 #include <plat/clock.h>
 #include <plat/sram.h>
-#include <plat/dma.h>
=20
 #include "common.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index ba670db..3eba16c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <trace/events/power.h>
=20
@@ -41,7 +42,6 @@
 #include <plat/sdrc.h>
 #include <plat/prcm.h>
 #include <plat/gpmc.h>
-#include <plat/dma.h>
=20
 #include "common.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.=
c
index 0405c81..014dff7 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -26,10 +26,10 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/console.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <plat/omap-serial.h>
 #include "common.h"
-#include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include <plat/omap-pm.h>
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 111315a..18a837f 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -15,11 +15,11 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <plat/common.h>
 #include <plat/vram.h>
 #include <linux/platform_data/dsp-omap.h>
-#include <plat/dma.h>
=20
 #include <plat/omap-secure.h>
=20
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c76ed8b..aa12fc4 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -35,9 +35,9 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <plat/cpu.h>
-#include <plat/dma.h>
 #include <plat/tc.h>
=20
 /*
diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 093a8af..91fbc56 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -26,11 +26,11 @@
 #include <linux/io.h>
 #include <linux/crypto.h>
 #include <linux/interrupt.h>
+#include <linux/platform_data/dma-omap.h>
 #include <crypto/scatterwalk.h>
 #include <crypto/aes.h>
=20
 #include <plat/cpu.h>
-#include <plat/dma.h>
=20
 /* OMAP TRM gives bitfields as start:end, where start is the higher bi=
t
    number. For example 7:0 */
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index a3fd6fc..f523337 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -31,6 +31,8 @@
 #include <linux/delay.h>
 #include <linux/crypto.h>
 #include <linux/cryptohash.h>
+#include <linux/platform_data/dma-omap.h>
+
 #include <crypto/scatterwalk.h>
 #include <crypto/algapi.h>
 #include <crypto/sha.h>
@@ -38,7 +40,6 @@
 #include <crypto/internal/hash.h>
=20
 #include <plat/cpu.h>
-#include <plat/dma.h>
 #include <mach/irqs.h>
=20
 #define SHA_REG_DIGEST(x)		(0x00 + ((x) * 0x04))
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index bb2d8e7..b87cf89 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -16,11 +16,11 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include "virt-dma.h"
=20
 #include <plat/cpu.h>
-#include <plat/dma.h>
=20
 struct omap_dmadev {
 	struct dma_device ddev;
diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/pl=
atform/omap/omap_vout.c
index c9783fb..54340c7 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -39,13 +39,13 @@
 #include <linux/videodev2.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <media/videobuf-dma-contig.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-ioctl.h>
=20
 #include <plat/cpu.h>
-#include <plat/dma.h>
 #include <plat/vrfb.h>
 #include <video/omapdss.h>
=20
diff --git a/drivers/media/platform/omap/omap_vout_vrfb.c b/drivers/med=
ia/platform/omap/omap_vout_vrfb.c
index 4be26abf6c..cb1ec32 100644
--- a/drivers/media/platform/omap/omap_vout_vrfb.c
+++ b/drivers/media/platform/omap/omap_vout_vrfb.c
@@ -12,11 +12,11 @@
 #include <linux/sched.h>
 #include <linux/platform_device.h>
 #include <linux/videodev2.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <media/videobuf-dma-contig.h>
 #include <media/v4l2-device.h>
=20
-#include <plat/dma.h>
 #include <plat/vrfb.h>
=20
 #include "omap_voutdef.h"
diff --git a/drivers/media/platform/omap3isp/ispstat.h b/drivers/media/=
platform/omap3isp/ispstat.h
index 9b7c865..e36b939 100644
--- a/drivers/media/platform/omap3isp/ispstat.h
+++ b/drivers/media/platform/omap3isp/ispstat.h
@@ -30,7 +30,8 @@
=20
 #include <linux/types.h>
 #include <linux/omap3isp.h>
-#include <plat/dma.h>
+#include <linux/platform_data/dma-omap.h>
+
 #include <media/v4l2-event.h>
=20
 #include "isp.h"
diff --git a/drivers/media/platform/soc_camera/omap1_camera.c b/drivers=
/media/platform/soc_camera/omap1_camera.c
index fa08c76..46c22c2 100644
--- a/drivers/media/platform/soc_camera/omap1_camera.c
+++ b/drivers/media/platform/soc_camera/omap1_camera.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <media/omap1_camera.h>
 #include <media/soc_camera.h>
@@ -34,9 +35,6 @@
 #include <media/videobuf-dma-contig.h>
 #include <media/videobuf-dma-sg.h>
=20
-#include <plat/dma.h>
-
-
 #define DRIVER_NAME		"omap1-camera"
 #define DRIVER_VERSION		"0.0.2"
=20
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 48ad361..fe0765b 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -28,9 +28,9 @@
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <plat/mmc.h>
-#include <plat/dma.h>
=20
 #define	OMAP_MMC_REG_CMD	0x00
 #define	OMAP_MMC_REG_ARGL	0x01
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 5b31386..b885c6b 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -22,12 +22,12 @@
 #include <linux/omap-dma.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #ifdef CONFIG_MTD_NAND_OMAP_BCH
 #include <linux/bch.h>
 #endif
=20
-#include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
=20
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 1961be9..9c474b0 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -36,13 +36,13 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/mach/flash.h>
 #include <plat/gpmc.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 #include <asm/gpio.h>
=20
-#include <plat/dma.h>
 #include <plat/cpu.h>
=20
 #define DRIVER_NAME "omap2-onenand"
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_ud=
c.c
index 2a4749c..fc28da8 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -38,14 +38,13 @@
 #include <linux/err.h>
 #include <linux/prefetch.h>
 #include <linux/io.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <asm/byteorder.h>
 #include <asm/irq.h>
 #include <asm/unaligned.h>
 #include <asm/mach-types.h>
=20
-#include <plat/dma.h>
-
 #include <mach/usb.h>
=20
 #include "omap_udc.h"
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb60=
10_omap.c
index 7a62b95..b8c5828 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
-#include <plat/dma.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include "musb_core.h"
 #include "tusb6010.h"
diff --git a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
index 7767338..c6f82b3 100644
--- a/drivers/video/omap/lcdc.c
+++ b/drivers/video/omap/lcdc.c
@@ -29,9 +29,9 @@
 #include <linux/vmalloc.h>
 #include <linux/clk.h>
 #include <linux/gfp.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include <mach/lcdc.h>
-#include <plat/dma.h>
=20
 #include <asm/mach-types.h>
=20
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omap=
fb_main.c
index 4351c43..22e321b 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -29,8 +29,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
-
-#include <plat/dma.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include "omapfb.h"
 #include "lcdc.h"
diff --git a/drivers/video/omap/sossi.c b/drivers/video/omap/sossi.c
index f79c137..f857574 100644
--- a/drivers/video/omap/sossi.c
+++ b/drivers/video/omap/sossi.c
@@ -24,8 +24,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
-
-#include <plat/dma.h>
+#include <linux/platform_data/dma-omap.h>
=20
 #include "omapfb.h"
 #include "lcdc.h"
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/include/linux/plat=
form_data/dma-omap.h
similarity index 99%
rename from arch/arm/plat-omap/include/plat/dma.h
rename to include/linux/platform_data/dma-omap.h
index e413bd8..366ca27 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/include/linux/platform_data/dma-omap.h
@@ -1,5 +1,5 @@
 /*
- *  arch/arm/plat-omap/include/mach/dma.h
+ *  OMAP DMA handling defines and function
  *
  *  Copyright (C) 2003 Nokia Corporation
  *  Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
