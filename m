From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: OMAP: Introduce omap-iomap.h and convert files
 depending on current io.h to use it
Date: Mon, 13 Feb 2012 15:53:49 -0800
Message-ID: <20120213235349.26087.42997.stgit@kaulin.local>
References: <20120213235216.26087.66303.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50342 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab2BMXxv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 18:53:51 -0500
In-Reply-To: <20120213235216.26087.66303.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Introduce omap-iomap.h and convert files depending on current io.h
to use it.

This is needed to move most of io.h into omap-iomap.h in two smaller
patches without breaking build and booting.

While at it, clean-up the include ordering to separate asm, plat, mach
and local includes as the ordering has gotten confusing after earlier
search and replace changes to introduce the local common.h header.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/ams-delta-fiq-handler.S    |    1 +
 arch/arm/mach-omap1/ams-delta-fiq.c            |    3 +++
 arch/arm/mach-omap1/board-ams-delta.c          |    7 +++++--
 arch/arm/mach-omap1/board-fsample.c            |    7 +++++--
 arch/arm/mach-omap1/board-h2.c                 |    7 ++++---
 arch/arm/mach-omap1/board-h3.c                 |    9 +++++----
 arch/arm/mach-omap1/board-htcherald.c          |    5 +++--
 arch/arm/mach-omap1/board-innovator.c          |    7 +++++--
 arch/arm/mach-omap1/board-nokia770.c           |    7 +++++--
 arch/arm/mach-omap1/board-osk.c                |    8 ++++----
 arch/arm/mach-omap1/board-palmte.c             |    5 ++++-
 arch/arm/mach-omap1/board-palmtt.c             |   10 ++++++----
 arch/arm/mach-omap1/board-palmz71.c            |   10 ++++++----
 arch/arm/mach-omap1/board-perseus2.c           |    7 +++++--
 arch/arm/mach-omap1/board-sx1.c                |    7 +++++--
 arch/arm/mach-omap1/board-voiceblue.c          |    7 +++++--
 arch/arm/mach-omap1/clock.c                    |    1 +
 arch/arm/mach-omap1/clock_data.c               |    1 +
 arch/arm/mach-omap1/devices.c                  |    8 +++++---
 arch/arm/mach-omap1/dma.c                      |    1 +
 arch/arm/mach-omap1/flash.c                    |    1 +
 arch/arm/mach-omap1/fpga.c                     |    4 +++-
 arch/arm/mach-omap1/id.c                       |    2 ++
 arch/arm/mach-omap1/include/mach/entry-macro.S |    4 +++-
 arch/arm/mach-omap1/io.c                       |    2 ++
 arch/arm/mach-omap1/irq.c                      |    5 ++++-
 arch/arm/mach-omap1/lcd_dma.c                  |    4 +++-
 arch/arm/mach-omap1/mcbsp.c                    |    4 +++-
 arch/arm/mach-omap1/pm.c                       |    6 ++++--
 arch/arm/mach-omap1/reset.c                    |    4 +++-
 arch/arm/mach-omap1/sleep.S                    |    5 +++++
 arch/arm/mach-omap1/sram.S                     |    4 ++++
 arch/arm/mach-omap1/time.c                     |    4 +++-
 arch/arm/mach-omap1/timer32k.c                 |    8 ++++++--
 arch/arm/mach-omap1/usb.c                      |    1 +
 arch/arm/mach-omap2/board-flash.c              |    1 +
 arch/arm/mach-omap2/clock2420_data.c           |    1 +
 arch/arm/mach-omap2/clock2430.c                |    1 +
 arch/arm/mach-omap2/clock2430_data.c           |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c           |    1 +
 arch/arm/mach-omap2/clock44xx_data.c           |    2 ++
 arch/arm/mach-omap2/cm2xxx_3xxx.c              |    3 ++-
 arch/arm/mach-omap2/cm44xx.c                   |    3 ++-
 arch/arm/mach-omap2/cminst44xx.c               |    3 ++-
 arch/arm/mach-omap2/common.c                   |    3 ++-
 arch/arm/mach-omap2/control.c                  |    1 +
 arch/arm/mach-omap2/devices.c                  |    1 +
 arch/arm/mach-omap2/io.c                       |    3 ++-
 arch/arm/mach-omap2/irq.c                      |    5 ++++-
 arch/arm/mach-omap2/omap-smp.c                 |    4 +++-
 arch/arm/mach-omap2/pm24xx.c                   |    4 +++-
 arch/arm/mach-omap2/prcm_mpu44xx.c             |    3 ++-
 arch/arm/mach-omap2/prm44xx.c                  |    3 ++-
 arch/arm/mach-omap2/prminst44xx.c              |    3 ++-
 arch/arm/mach-omap2/sdrc2xxx.c                 |    5 +++--
 arch/arm/mach-omap2/sleep34xx.S                |    4 ++++
 arch/arm/mach-omap2/sram242x.S                 |    4 ++++
 arch/arm/mach-omap2/sram243x.S                 |    4 ++++
 arch/arm/mach-omap2/sram34xx.S                 |    5 ++++-
 arch/arm/plat-omap/devices.c                   |    4 +++-
 arch/arm/plat-omap/dma.c                       |    6 ++++--
 arch/arm/plat-omap/dmtimer.c                   |    1 +
 arch/arm/plat-omap/include/plat/omap-iomap.h   |    0 
 arch/arm/plat-omap/ocpi.c                      |    2 ++
 arch/arm/plat-omap/sram.c                      |    2 +-
 arch/arm/plat-omap/usb.c                       |    1 +
 drivers/gpio/gpio-omap.c                       |    7 +++++--
 drivers/pcmcia/omap_cf.c                       |    4 +++-
 drivers/spi/spi-omap-uwire.c                   |    4 +++-
 drivers/usb/host/ohci-omap.c                   |    6 ++++--
 drivers/usb/otg/isp1301_omap.c                 |    7 ++++---
 drivers/video/omap/lcd_ams_delta.c             |    2 ++
 drivers/video/omap/lcd_inn1510.c               |    2 ++
 drivers/video/omap/lcd_osk.c                   |    3 +++
 drivers/video/omap/lcdc.c                      |    7 ++++---
 drivers/video/omap/sossi.c                     |    1 +
 76 files changed, 223 insertions(+), 80 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/omap-iomap.h

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index c1c5fb6..878c27b 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -15,6 +15,7 @@
 
 #include <linux/linkage.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/io.h>
 #include <plat/board-ams-delta.h>
 
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index 152b32c..b909475 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -22,6 +22,9 @@
 #include <plat/board-ams-delta.h>
 
 #include <asm/fiq.h>
+
+#include <plat/omap-iomap.h>
+
 #include <mach/ams-delta-fiq.h>
 
 static struct fiq_handler fh = {
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 88909cc..46700d9 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -29,16 +29,19 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/io.h>
 #include <plat/board-ams-delta.h>
 #include <plat/keypad.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/board.h>
-#include "common.h"
-#include <mach/camera.h>
 
+#include <mach/hardware.h>
 #include <mach/ams-delta-fiq.h>
+#include <mach/camera.h>
+
+#include "common.h"
 
 static u8 ams_delta_latch1_reg;
 static u16 ams_delta_latch2_reg;
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 0b9464b..5c99339 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -22,19 +22,22 @@
 #include <linux/input.h>
 #include <linux/smc91x.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/tc.h>
 #include <plat/mux.h>
 #include <plat/flash.h>
 #include <plat/fpga.h>
 #include <plat/keypad.h>
-#include "common.h"
 #include <plat/board.h>
 
+#include <mach/hardware.h>
+
+#include "common.h"
+
 /* fsample is pretty close to p2-sample */
 
 #define fsample_cpld_read(reg) __raw_readb(reg)
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 00ad6b2..8e3fa0d 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -31,21 +31,22 @@
 #include <linux/i2c/tps65010.h>
 #include <linux/smc91x.h>
 
-#include <mach/hardware.h>
-
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
 #include <plat/irda.h>
 #include <plat/usb.h>
 #include <plat/keypad.h>
-#include "common.h"
 #include <plat/flash.h>
 
+#include <mach/hardware.h>
+
+#include "common.h"
 #include "board-h2.h"
 
 /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 4a7f251..4400b10 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -33,21 +33,22 @@
 
 #include <asm/setup.h>
 #include <asm/page.h>
-#include <mach/hardware.h>
-
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/irqs.h>
+#include <plat/omap-iomap.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
 #include <plat/usb.h>
 #include <plat/keypad.h>
 #include <plat/dma.h>
-#include "common.h"
 #include <plat/flash.h>
 
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
+#include "common.h"
 #include "board-h3.h"
 
 /* In OMAP1710 H3 the Ethernet is directly connected to CS1 */
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 731cc3d..0eb2c48 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/i2c.h>
@@ -40,8 +41,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/omap7xx.h>
-#include "common.h"
 #include <plat/board.h>
 #include <plat/keypad.h>
 #include <plat/usb.h>
@@ -49,7 +50,7 @@
 
 #include <mach/irqs.h>
 
-#include <linux/delay.h>
+#include "common.h"
 
 /* LCD register definition */
 #define       OMAP_LCDC_CONTROL               (0xfffec000 + 0x00)
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 309369e..445703e 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -26,20 +26,23 @@
 #include <linux/input.h>
 #include <linux/smc91x.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/mux.h>
 #include <plat/flash.h>
 #include <plat/fpga.h>
 #include <plat/tc.h>
 #include <plat/usb.h>
 #include <plat/keypad.h>
-#include "common.h"
 #include <plat/mmc.h>
 
+#include <mach/hardware.h>
+
+#include "common.h"
+
 /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
 #define INNOVATOR1610_ETHR_START	0x04000300
 
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index f9efc03..1024273 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -21,21 +21,24 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/keypad.h>
-#include "common.h"
 #include <plat/hwa742.h>
 #include <plat/lcd_mipid.h>
 #include <plat/mmc.h>
 #include <plat/clock.h>
 
+#include <mach/hardware.h>
+
+#include "common.h"
+
 #define ADS7846_PENDOWN_GPIO	15
 
 static const unsigned int nokia770_keymap[] = {
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 675de06..fb41432 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -34,23 +34,23 @@
 #include <linux/i2c.h>
 #include <linux/leds.h>
 #include <linux/smc91x.h>
-
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
-
 #include <linux/i2c/tps65010.h>
 
-#include <mach/hardware.h>
-
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/flash.h>
 #include <plat/usb.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
+
+#include <mach/hardware.h>
+
 #include "common.h"
 
 /* At OMAP5912 OSK the Ethernet is directly connected to CS1 */
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 81fa27f..a6ba1ba 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -28,11 +28,11 @@
 #include <linux/interrupt.h>
 #include <linux/apm-emulation.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
@@ -41,6 +41,9 @@
 #include <plat/board.h>
 #include <plat/irda.h>
 #include <plat/keypad.h>
+
+#include <mach/hardware.h>
+
 #include "common.h"
 
 #define PALMTE_USBDETECT_GPIO	0
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 81cb821..19a3d47 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -24,12 +24,14 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/leds.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/led.h>
 #include <plat/flash.h>
 #include <plat/mux.h>
@@ -39,10 +41,10 @@
 #include <plat/board.h>
 #include <plat/irda.h>
 #include <plat/keypad.h>
-#include "common.h"
 
-#include <linux/spi/spi.h>
-#include <linux/spi/ads7846.h>
+#include <mach/hardware.h>
+
+#include "common.h"
 
 #define PALMTT_USBDETECT_GPIO	0
 #define PALMTT_CABLE_GPIO	1
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index e881945..1352c84 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -27,12 +27,14 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
@@ -41,10 +43,10 @@
 #include <plat/board.h>
 #include <plat/irda.h>
 #include <plat/keypad.h>
-#include "common.h"
 
-#include <linux/spi/spi.h>
-#include <linux/spi/ads7846.h>
+#include <mach/hardware.h>
+
+#include "common.h"
 
 #define PALMZ71_USBDETECT_GPIO	0
 #define PALMZ71_PENIRQ_GPIO	6
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index c000bed..4e487f0 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -22,19 +22,22 @@
 #include <linux/input.h>
 #include <linux/smc91x.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/tc.h>
 #include <plat/mux.h>
 #include <plat/fpga.h>
 #include <plat/flash.h>
 #include <plat/keypad.h>
-#include "common.h"
 #include <plat/board.h>
 
+#include <mach/hardware.h>
+
+#include "common.h"
+
 static const unsigned int p2_keymap[] = {
 	KEY(0, 0, KEY_UP),
 	KEY(1, 0, KEY_RIGHT),
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 7bcd82a..446fb50 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -28,11 +28,11 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/dma.h>
@@ -40,10 +40,13 @@
 #include <plat/usb.h>
 #include <plat/tc.h>
 #include <plat/board.h>
-#include "common.h"
 #include <plat/keypad.h>
 #include <plat/board-sx1.h>
 
+#include <mach/hardware.h>
+
+#include "common.h"
+
 /* Write to I2C device */
 int sx1_i2c_write_byte(u8 devaddr, u8 regoffset, u8 value)
 {
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index f83a502..8141c80 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -27,18 +27,21 @@
 #include <linux/smc91x.h>
 #include <linux/export.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/board-voiceblue.h>
-#include "common.h"
 #include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
 #include <plat/usb.h>
 
+#include <mach/hardware.h>
+
+#include "common.h"
+
 static struct plat_serial8250_port voiceblue_ports[] = {
 	{
 		.mapbase	= (unsigned long)(OMAP_CS1_PHYS + 0x40000),
diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 0c50df0..6305604 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -21,6 +21,7 @@
 
 #include <asm/mach-types.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/cpu.h>
 #include <plat/usb.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 94699a8..99463f4 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -22,6 +22,7 @@
 
 #include <asm/mach-types.h>  /* for machine_is_* */
 
+#include <plat/omap-iomap.h>
 #include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/clkdev_omap.h>
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 1d76a63..efbf656 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -18,11 +18,9 @@
 #include <linux/io.h>
 #include <linux/spi/spi.h>
 
-#include <mach/camera.h>
-#include <mach/hardware.h>
 #include <asm/mach/map.h>
 
-#include "common.h"
+#include <plat/omap-iomap.h>
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <plat/mux.h>
@@ -30,6 +28,10 @@
 #include <plat/omap7xx.h>
 #include <plat/mcbsp.h>
 
+#include <mach/camera.h>
+#include <mach/hardware.h>
+
+#include "common.h"
 #include "clock.h"
 
 /*-------------------------------------------------------------------------*/
diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index f5a5220..62ccd7f 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
 #include <plat/irqs.h>
diff --git a/arch/arm/mach-omap1/flash.c b/arch/arm/mach-omap1/flash.c
index 1749cb3..68becc4 100644
--- a/arch/arm/mach-omap1/flash.c
+++ b/arch/arm/mach-omap1/flash.c
@@ -9,6 +9,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/io.h>
 #include <plat/tc.h>
 #include <plat/flash.h>
diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 0a17a1a..2b2cdd0 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -24,12 +24,14 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/fpga.h>
 
+#include <mach/hardware.h>
+
 static void fpga_mask_irq(struct irq_data *d)
 {
 	unsigned int irq = d->irq - OMAP_FPGA_IRQ_BASE;
diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index a0e3560..3e8c628 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -15,6 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+
+#include <plat/omap-iomap.h>
 #include <plat/cpu.h>
 
 #define OMAP_DIE_ID_0		0xfffe1800
diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
index bfb4fb1..ef18af6 100644
--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -9,10 +9,12 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
+
+#include <plat/omap-iomap.h>
+
 #include <mach/hardware.h>
 #include <mach/io.h>
 #include <mach/irqs.h>
-#include <asm/hardware/gic.h>
 
  		.macro	disable_fiq
 		.endm
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 8e55b6f..331b042 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -15,6 +15,8 @@
 
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
+
+#include <plat/omap-iomap.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
 
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index e5b104b..dd3c053 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -42,11 +42,14 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
+
+#include <plat/omap-iomap.h>
 #include <plat/cpu.h>
 
+#include <mach/hardware.h>
+
 #define IRQ_BANK(irq) ((irq) >> 5)
 #define IRQ_BIT(irq)  ((irq) & 0x1f)
 
diff --git a/arch/arm/mach-omap1/lcd_dma.c b/arch/arm/mach-omap1/lcd_dma.c
index 4538093..aa4fe35 100644
--- a/arch/arm/mach-omap1/lcd_dma.c
+++ b/arch/arm/mach-omap1/lcd_dma.c
@@ -27,9 +27,11 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 
+#include <plat/omap-iomap.h>
+#include <plat/dma.h>
+
 #include <mach/hardware.h>
 #include <mach/lcdc.h>
-#include <plat/dma.h>
 
 int omap_lcd_dma_running(void)
 {
diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 91f9abb..30fb3ac 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -19,12 +19,14 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <mach/irqs.h>
+#include <plat/omap-iomap.h>
 #include <plat/dma.h>
 #include <plat/mux.h>
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
 
+#include <mach/irqs.h>
+
 #define DPS_RSTCT2_PER_EN	(1 << 0)
 #define DSP_RSTCT2_WD_PER_EN	(1 << 1)
 
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 89ea20c..9bdbddb 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -42,14 +42,14 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/atomic.h>
 
 #include <asm/irq.h>
-#include <linux/atomic.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/cpu.h>
-#include <mach/irqs.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/tc.h>
@@ -57,6 +57,8 @@
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
 
+#include <mach/irqs.h>
+
 #include "pm.h"
 
 static unsigned int arm_sleep_save[ARM_SLEEP_SAVE_SIZE];
diff --git a/arch/arm/mach-omap1/reset.c b/arch/arm/mach-omap1/reset.c
index 91d199b..eed1e32 100644
--- a/arch/arm/mach-omap1/reset.c
+++ b/arch/arm/mach-omap1/reset.c
@@ -4,9 +4,11 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
+#include <plat/omap-iomap.h>
 #include <plat/prcm.h>
 
+#include <mach/hardware.h>
+
 void omap1_restart(char mode, const char *cmd)
 {
 	/*
diff --git a/arch/arm/mach-omap1/sleep.S b/arch/arm/mach-omap1/sleep.S
index c875bdc..dd67918 100644
--- a/arch/arm/mach-omap1/sleep.S
+++ b/arch/arm/mach-omap1/sleep.S
@@ -33,8 +33,13 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+
+#include <plat/omap-iomap.h>
+
 #include <mach/io.h>
+
 #include "pm.h"
 
 		.text
diff --git a/arch/arm/mach-omap1/sram.S b/arch/arm/mach-omap1/sram.S
index 692587d..17a9451 100644
--- a/arch/arm/mach-omap1/sram.S
+++ b/arch/arm/mach-omap1/sram.S
@@ -9,7 +9,11 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+
+#include <plat/omap-iomap.h>
+
 #include <mach/io.h>
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index b8faffa..24e0a70 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -45,11 +45,13 @@
 #include <linux/io.h>
 
 #include <asm/system.h>
-#include <mach/hardware.h>
 #include <asm/leds.h>
 #include <asm/irq.h>
 #include <asm/sched_clock.h>
 
+#include <plat/omap-iomap.h>
+
+#include <mach/hardware.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 9a54ef4..6dd1274 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -47,14 +47,18 @@
 #include <linux/io.h>
 
 #include <asm/system.h>
-#include <mach/hardware.h>
 #include <asm/leds.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
-#include "common.h"
+
+#include <plat/omap-iomap.h>
 #include <plat/dmtimer.h>
 
+#include <mach/hardware.h>
+
+#include "common.h"
+
 /*
  * ---------------------------------------------------------------------------
  * 32KHz OS timer
diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 19de03b..f4d3b31 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -26,6 +26,7 @@
 
 #include <asm/irq.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/mux.h>
 #include <plat/usb.h>
 
diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 30a6f52..48a9edd 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <plat/irqs.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/onenand.h>
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 61ad385..81966fc 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/list.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/clkdev_omap.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
index d87bc9c..5fbb189 100644
--- a/arch/arm/mach-omap2/clock2430.c
+++ b/arch/arm/mach-omap2/clock2430.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/clock.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 0cc1287..472f49b 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/list.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/clkdev_omap.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d75e5f6..836ca17 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -20,6 +20,7 @@
 #include <linux/clk.h>
 #include <linux/list.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/clkdev_omap.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 08e86d7..f5bad14 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -26,6 +26,8 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/clk.h>
+
+#include <plat/omap-iomap.h>
 #include <plat/clkdev_omap.h>
 
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index 04d39cd..ec3224b 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -18,8 +18,9 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "common.h"
+#include <plat/omap-iomap.h>
 
+#include "common.h"
 #include "cm.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
index 6a83630..cb01011 100644
--- a/arch/arm/mach-omap2/cm44xx.c
+++ b/arch/arm/mach-omap2/cm44xx.c
@@ -18,8 +18,9 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "common.h"
+#include <plat/omap-iomap.h>
 
+#include "common.h"
 #include "cm.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 6204dea..27de63d 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -20,8 +20,9 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "common.h"
+#include <plat/omap-iomap.h>
 
+#include "common.h"
 #include "cm.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index aaf4211..1591153 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -17,12 +17,13 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "common.h"
+#include <plat/omap-iomap.h>
 #include <plat/board.h>
 #include <plat/mux.h>
 
 #include <plat/clock.h>
 
+#include "common.h"
 #include "sdrc.h"
 #include "control.h"
 
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 114c037..f2b304f 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 
 #include "common.h"
+#include <plat/omap-iomap.h>
 #include <plat/sdrc.h>
 
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 283d11e..f87c94f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -24,6 +24,7 @@
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <plat/mcbsp.h>
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index eb50c29..2fd855d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -27,6 +27,7 @@
 
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 #include <plat/serial.h>
@@ -35,7 +36,7 @@
 #include "clock3xxx.h"
 #include "clock44xx.h"
 
-#include "common.h"
+#include <plat/omap-iomap.h>
 #include <plat/omap-pm.h>
 #include "voltage.h"
 #include "powerdomain.h"
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 1fef061..6eca959 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -14,10 +14,13 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
+
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
+#include <plat/omap-iomap.h>
+
+#include <mach/hardware.h>
 
 /* selected INTC register offsets */
 
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index c1bf3ef..d687c84 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -23,11 +23,13 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
+
+#include <plat/omap-iomap.h>
+
 #include <mach/hardware.h>
 #include <mach/omap-secure.h>
 
 #include "common.h"
-
 #include "clockdomain.h"
 
 /* SCU base address */
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index b8822f8..971d10d 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -35,12 +35,14 @@
 #include <asm/mach/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/irqs.h>
+#include <plat/omap-iomap.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/dma.h>
 #include <plat/board.h>
 
+#include <mach/irqs.h>
+
 #include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.c b/arch/arm/mach-omap2/prcm_mpu44xx.c
index ca669b5..993f567 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.c
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.c
@@ -15,8 +15,9 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "common.h"
+#include <plat/omap-iomap.h>
 
+#include "common.h"
 #include "prcm_mpu44xx.h"
 #include "cm-regbits-44xx.h"
 
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 33dd655..418f90a 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -17,10 +17,11 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "common.h"
+#include <plat/omap-iomap.h>
 #include <plat/cpu.h>
 #include <plat/prcm.h>
 
+#include "common.h"
 #include "vp.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index f6de5bc..e79bfb3 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -16,8 +16,9 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "common.h"
+#include <plat/omap-iomap.h>
 
+#include "common.h"
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "prm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 791a63c..f588c3e 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -24,13 +24,14 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include "common.h"
+#include <plat/omap-iomap.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
+#include <plat/sdrc.h>
 
+#include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "clock.h"
-#include <plat/sdrc.h>
 #include "sdrc.h"
 
 /* Memory timing, DLL mode flags */
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index f2ea1bd..bc4048f 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -23,8 +23,12 @@
  * MA 02111-1307 USA
  */
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+
+#include <plat/omap-iomap.h>
 #include <plat/sram.h>
+
 #include <mach/io.h>
 
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index ff9b9db..e3cb8e2 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -29,7 +29,11 @@
  * These crashes may be intermittent.
  */
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+
+#include <plat/omap-iomap.h>
+
 #include <mach/io.h>
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index 7673020..6748584 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -29,7 +29,11 @@
  * These crashes may be intermittent.
  */
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+
+#include <plat/omap-iomap.h>
+
 #include <mach/io.h>
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 6f5849a..d981b99 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -26,9 +26,12 @@
  * MA 02111-1307 USA
  */
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
-#include <mach/hardware.h>
 
+#include <plat/omap-iomap.h>
+
+#include <mach/hardware.h>
 #include <mach/io.h>
 
 #include "sdrc.h"
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 60278f4..94beb28 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -17,17 +17,19 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <plat/mmc.h>
 #include <plat/menelaus.h>
 #include <plat/omap44xx.h>
 
+#include <mach/hardware.h>
+
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 002fb4d..424ab8a 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -37,11 +37,13 @@
 #include <linux/delay.h>
 
 #include <asm/system.h>
-#include <mach/hardware.h>
-#include <plat/dma.h>
 
+#include <plat/omap-iomap.h>
+#include <plat/dma.h>
 #include <plat/tc.h>
 
+#include <mach/hardware.h>
+
 #undef DEBUG
 
 #ifndef CONFIG_ARCH_OMAP1
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index af3b92b..402f4ea 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -41,6 +41,7 @@
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/dmtimer.h>
 
 static LIST_HEAD(omap_timer_list);
diff --git a/arch/arm/plat-omap/include/plat/omap-iomap.h b/arch/arm/plat-omap/include/plat/omap-iomap.h
new file mode 100644
index 0000000..e69de29
diff --git a/arch/arm/plat-omap/ocpi.c b/arch/arm/plat-omap/ocpi.c
index ebe0c73..fa48ee7 100644
--- a/arch/arm/plat-omap/ocpi.c
+++ b/arch/arm/plat-omap/ocpi.c
@@ -33,6 +33,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <plat/omap-iomap.h>
+
 #include <mach/hardware.h>
 
 #define OCPI_BASE		0xfffec320
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 4243bdc..1516f76 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -22,9 +22,9 @@
 
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
-
 #include <asm/mach/map.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/sram.h>
 #include <plat/board.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index f357088..0a2fe67 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/usb.h>
 #include <plat/board.h>
 
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 0b05629..e704bea 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -22,12 +22,15 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
-#include <mach/irqs.h>
 #include <asm/gpio.h>
 #include <asm/mach/irq.h>
 
+#include <plat/omap-iomap.h>
+
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
 struct gpio_bank {
 	unsigned long pbase;
 	void __iomem *base;
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 0ad06a3..ba71697 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -20,13 +20,15 @@
 
 #include <pcmcia/ss.h>
 
-#include <mach/hardware.h>
 #include <asm/io.h>
 #include <asm/sizes.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
 
+#include <mach/hardware.h>
+
 
 /* NOTE:  don't expect this to support many I/O cards.  The 16xx chips have
  * hard-wired timings to support Compact Flash memory cards; they won't work
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 610f739..6ad597f 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -49,13 +49,15 @@
 
 #include <asm/system.h>
 #include <asm/irq.h>
-#include <mach/hardware.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/mux.h>
 #include <plat/omap7xx.h>	/* OMAP7XX_IO_CONF registers */
 
+#include <mach/hardware.h>
+
 
 /* FIXME address is now a platform device resource,
  * and irqs should show there too...
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index db39686..021108a 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -20,15 +20,17 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 
-#include <mach/hardware.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/mux.h>
-#include <mach/irqs.h>
 #include <plat/fpga.h>
 #include <plat/usb.h>
 
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
 
 /* OMAP-1510 OHCI has its own MMU for DMA */
 #define OMAP1510_LB_MEMSIZE	32	/* Should be same as SDRAM size */
diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_omap.c
index 8c86787..910b7a7 100644
--- a/drivers/usb/otg/isp1301_omap.c
+++ b/drivers/usb/otg/isp1301_omap.c
@@ -33,12 +33,13 @@
 #include <linux/i2c.h>
 #include <linux/workqueue.h>
 
-#include <asm/irq.h>
-#include <asm/mach-types.h>
-
+#include <plat/omap-iomap.h>
 #include <plat/usb.h>
 #include <plat/mux.h>
 
+#include <asm/irq.h>
+#include <asm/mach-types.h>
+
 
 #ifndef	DEBUG
 #undef	VERBOSE
diff --git a/drivers/video/omap/lcd_ams_delta.c b/drivers/video/omap/lcd_ams_delta.c
index 0fdd6f6..3c7f16f 100644
--- a/drivers/video/omap/lcd_ams_delta.c
+++ b/drivers/video/omap/lcd_ams_delta.c
@@ -26,7 +26,9 @@
 #include <linux/delay.h>
 #include <linux/lcd.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/board-ams-delta.h>
+
 #include <mach/hardware.h>
 
 #include "omapfb.h"
diff --git a/drivers/video/omap/lcd_inn1510.c b/drivers/video/omap/lcd_inn1510.c
index b38b1dd..f4e77fe 100644
--- a/drivers/video/omap/lcd_inn1510.c
+++ b/drivers/video/omap/lcd_inn1510.c
@@ -23,7 +23,9 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/fpga.h>
+
 #include "omapfb.h"
 
 static int innovator1510_panel_init(struct lcd_panel *panel,
diff --git a/drivers/video/omap/lcd_osk.c b/drivers/video/omap/lcd_osk.c
index 5914220..c35a789 100644
--- a/drivers/video/omap/lcd_osk.c
+++ b/drivers/video/omap/lcd_osk.c
@@ -25,6 +25,9 @@
 
 #include <asm/gpio.h>
 #include <plat/mux.h>
+
+#include <plat/omap-iomap.h>
+
 #include "omapfb.h"
 
 static int osk_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)
diff --git a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
index 7767338..a884663 100644
--- a/drivers/video/omap/lcdc.c
+++ b/drivers/video/omap/lcdc.c
@@ -30,13 +30,14 @@
 #include <linux/clk.h>
 #include <linux/gfp.h>
 
-#include <mach/lcdc.h>
+#include <asm/mach-types.h>
+
+#include <plat/omap-iomap.h>
 #include <plat/dma.h>
 
-#include <asm/mach-types.h>
+#include <mach/lcdc.h>
 
 #include "omapfb.h"
-
 #include "lcdc.h"
 
 #define MODULE_NAME			"lcdc"
diff --git a/drivers/video/omap/sossi.c b/drivers/video/omap/sossi.c
index f79c137..43263f5 100644
--- a/drivers/video/omap/sossi.c
+++ b/drivers/video/omap/sossi.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 
+#include <plat/omap-iomap.h>
 #include <plat/dma.h>
 
 #include "omapfb.h"

