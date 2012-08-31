From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/9] ARM: OMAP: Move gpio.h to include/linux/platform_data
Date: Thu, 30 Aug 2012 17:52:34 -0700
Message-ID: <20120831005234.28732.10624.stgit@muffinssi.local>
References: <20120831004828.28732.902.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:22472 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753058Ab2HaAwi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 20:52:38 -0400
In-Reply-To: <20120831004828.28732.902.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org

This way we can remove includes of plat/gpio.h which won't work
with the single zImage support.

Note that we also remove the cpu_class_is_omap2() check
in gpio-omap.c as the drivers should not call it as we need to
make it local to arch/arm/mach-omap2 for single zImage support.

While at it, arrange the related includes in the standard way.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mtd@lists.infradead.org
Cc: alsa-devel@alsa-project.org
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-ams-delta.c              |    3 ++-
 arch/arm/mach-omap1/board-osk.c                    |    1 +
 arch/arm/mach-omap1/gpio15xx.c                     |    1 +
 arch/arm/mach-omap1/gpio16xx.c                     |    1 +
 arch/arm/mach-omap1/gpio7xx.c                      |    1 +
 arch/arm/mach-omap1/include/mach/gpio.h            |    2 --
 arch/arm/mach-omap1/leds-h2p2-debug.c              |    4 +++-
 arch/arm/mach-omap1/leds.c                         |    1 +
 arch/arm/mach-omap2/board-am3517evm.c              |    9 ++++++---
 arch/arm/mach-omap2/board-cm-t35.c                 |   12 +++++++-----
 arch/arm/mach-omap2/board-zoom-display.c           |    6 +++++-
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    1 +
 arch/arm/mach-omap2/gpio.c                         |    1 +
 arch/arm/mach-omap2/hsmmc.c                        |    5 ++++-
 arch/arm/mach-omap2/include/mach/gpio.h            |    2 --
 arch/arm/mach-omap2/msdi.c                         |    1 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 +++---
 arch/arm/mach-omap2/pm24xx.c                       |    1 +
 arch/arm/mach-omap2/pm34xx.c                       |    2 ++
 drivers/gpio/gpio-omap.c                           |   15 ++++++++-------
 drivers/mtd/nand/ams-delta.c                       |    8 ++++++--
 include/linux/platform_data/gpio-omap.h            |   15 ++-------------
 sound/soc/omap/sdp3430.c                           |    1 +
 27 files changed, 65 insertions(+), 49 deletions(-)
 rename arch/arm/plat-omap/include/plat/gpio.h => include/linux/platform_data/gpio-omap.h (94%)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 147d665..4b5578b 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -26,6 +26,8 @@
 #include <linux/export.h>
 #include <linux/omapfb.h>
 #include <linux/io.h>
+#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/keypad-omap.h>
 
 #include <media/soc_camera.h>
 
@@ -35,7 +37,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/board-ams-delta.h>
-#include <linux/platform_data/keypad-omap.h>
 #include <plat/mux.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 9413fd3..c780a1b 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -39,6 +39,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/i2c/tps65010.h>
+#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/omap1_bl.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index ebef15e..98e6f39 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
 #define OMAP1510_GPIO_BASE		0xFFFCE000
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 2a48cd2..33f4192 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #define OMAP1610_GPIO1_BASE		0xfffbe400
 #define OMAP1610_GPIO2_BASE		0xfffbec00
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index acf12b7..958ce9a 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #define OMAP7XX_GPIO1_BASE		0xfffbc000
 #define OMAP7XX_GPIO2_BASE		0xfffbc800
diff --git a/arch/arm/mach-omap1/include/mach/gpio.h b/arch/arm/mach-omap1/include/mach/gpio.h
index e737706..ebf86c0 100644
--- a/arch/arm/mach-omap1/include/mach/gpio.h
+++ b/arch/arm/mach-omap1/include/mach/gpio.h
@@ -1,5 +1,3 @@
 /*
  * arch/arm/mach-omap1/include/mach/gpio.h
  */
-
-#include <plat/gpio.h>
diff --git a/arch/arm/mach-omap1/leds-h2p2-debug.c b/arch/arm/mach-omap1/leds-h2p2-debug.c
index f6b14a1..3ea12c7 100644
--- a/arch/arm/mach-omap1/leds-h2p2-debug.c
+++ b/arch/arm/mach-omap1/leds-h2p2-debug.c
@@ -14,13 +14,15 @@
 #include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/io.h>
+#include <linux/platform_data/gpio-omap.h>
 
-#include <mach/hardware.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 
 #include <plat/fpga.h>
 
+#include <mach/hardware.h>
+
 #include "leds.h"
 
 
diff --git a/arch/arm/mach-omap1/leds.c b/arch/arm/mach-omap1/leds.c
index ae6dd93..7b1a383 100644
--- a/arch/arm/mach-omap1/leds.c
+++ b/arch/arm/mach-omap1/leds.c
@@ -6,6 +6,7 @@
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <asm/leds.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 00abda1..c6d63d7 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -25,19 +25,22 @@
 #include <linux/can/platform/ti_hecc.h>
 #include <linux/davinci_emac.h>
 #include <linux/mmc/host.h>
+#include <linux/platform_data/gpio-omap.h>
 
-#include <mach/hardware.h>
-#include <mach/am35xx.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include "common.h"
 #include <plat/usb.h>
+
+#include <mach/hardware.h>
+#include <mach/am35xx.h>
+
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
 #include <video/omap-panel-tfp410.h>
 
+#include "common.h"
 #include "am35xx-emac.h"
 #include "mux.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index ad83654..c2b2371 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -23,6 +23,9 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/mtd-nand-omap2.h>
+#include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include <linux/i2c/at24.h>
 #include <linux/i2c/twl.h>
@@ -37,17 +40,16 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include "common.h"
-#include <linux/platform_data/mtd-nand-omap2.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
+
+#include <mach/hardware.h>
+
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
 #include <video/omap-panel-tfp410.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
-
-#include <mach/hardware.h>
 
+#include "common.h"
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index 660a2932..0e48a51 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -15,9 +15,13 @@
 #include <linux/i2c/twl.h>
 #include <linux/spi/spi.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <video/omapdss.h>
+
+#include <plat/cpu.h>
+
 #include <mach/board-zoom.h>
 
+#include <video/omapdss.h>
+
 #define LCD_PANEL_RESET_GPIO_PROD	96
 #define LCD_PANEL_RESET_GPIO_PILOT	55
 #define LCD_PANEL_QVGA_GPIO		56
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 00f73b7..ae5d36b 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -19,6 +19,7 @@
 #include <linux/regulator/fixed.h>
 #include <linux/wl12xx.h>
 #include <linux/mmc/host.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 9ad7d48..7b52bdf 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index a9675d8..4b0e166 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -14,12 +14,15 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
-#include <mach/hardware.h>
+#include <linux/platform_data/gpio-omap.h>
+
 #include <plat/mmc.h>
 #include <plat/omap-pm.h>
 #include <plat/mux.h>
 #include <plat/omap_device.h>
 
+#include <mach/hardware.h>
+
 #include "mux.h"
 #include "hsmmc.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/include/mach/gpio.h b/arch/arm/mach-omap2/include/mach/gpio.h
index be4d290..5621cc5 100644
--- a/arch/arm/mach-omap2/include/mach/gpio.h
+++ b/arch/arm/mach-omap2/include/mach/gpio.h
@@ -1,5 +1,3 @@
 /*
  * arch/arm/mach-omap2/include/mach/gpio.h
  */
-
-#include <plat/gpio.h>
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index fb5bc6c..9e57b4a 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -23,6 +23,7 @@
 
 #include <linux/kernel.h>
 #include <linux/err.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 558c300..b305d7f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -18,7 +18,6 @@
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/i2c.h>
-#include <plat/gpio.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <plat/dmtimer.h>
 #include <plat/l3_2xxx.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index d662766..79ac236 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -12,15 +12,15 @@
  * XXX handle crossbar/shared link difference for L3?
  * XXX these should be marked initdata for multi-OMAP kernels
  */
+#include <linux/platform_data/dsp-mcbsp.h>
+#include <linux/platform_data/spi-omap2-mcspi.h>
+
 #include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/i2c.h>
-#include <plat/gpio.h>
-#include <linux/platform_data/dsp-mcbsp.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
 #include <plat/dmtimer.h>
 #include <plat/mmc.h>
 #include <plat/l3_2xxx.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 161ae0a..44e4764 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -10,9 +10,9 @@
  */
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
-#include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
+#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 656bb7f..15f617e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -15,6 +15,9 @@
  * XXX these should be marked initdata for multi-OMAP kernels
  */
 #include <linux/power/smartreflex.h>
+#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/dsp-mcbsp.h>
+#include <linux/platform_data/spi-omap2-mcspi.h>
 
 #include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
@@ -24,10 +27,7 @@
 #include <plat/l3_3xxx.h>
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
-#include <plat/gpio.h>
 #include <plat/mmc.h>
-#include <linux/platform_data/dsp-mcbsp.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
 #include <plat/dmtimer.h>
 
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 3a06e7d..c9edaf2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -19,15 +19,15 @@
  */
 
 #include <linux/io.h>
+#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/spi-omap2-mcspi.h>
+#include <linux/platform_data/dsp-mcbsp.h>
 #include <linux/power/smartreflex.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
 #include <plat/i2c.h>
-#include <plat/gpio.h>
 #include <plat/dma.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
-#include <linux/platform_data/dsp-mcbsp.h>
 #include <plat/mmc.h>
 #include <plat/dmtimer.h>
 #include <plat/common.h>
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index de1caf1..2708a8b 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -29,6 +29,7 @@
 #include <linux/irq.h>
 #include <linux/time.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e4fc88c..2a08978 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,6 +28,8 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/platform_data/gpio-omap.h>
+
 #include <trace/events/power.h>
 
 #include <asm/suspend.h>
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e6efd77..64fbce3 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -25,11 +25,9 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/irqdomain.h>
+#include <linux/gpio.h>
+#include <linux/platform_data/gpio-omap.h>
 
-#include <mach/hardware.h>
-#include <asm/irq.h>
-#include <mach/irqs.h>
-#include <asm/gpio.h>
 #include <asm/mach/irq.h>
 
 #define OFF_MODE	1
@@ -385,13 +383,16 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio,
 static int gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned gpio;
+	unsigned gpio = 0;
 	int retval;
 	unsigned long flags;
 
-	if (!cpu_class_is_omap2() && d->irq > IH_MPUIO_BASE)
+#ifdef CONFIG_ARCH_OMAP1
+	if (d->irq > IH_MPUIO_BASE)
 		gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
-	else
+#endif
+
+	if (!gpio)
 		gpio = irq_to_gpio(bank, d->irq);
 
 	if (type & ~IRQ_TYPE_SENSE_MASK)
diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index 861ca8f..78a524b 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -23,12 +23,16 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/gpio.h>
+#include <linux/platform_data/gpio-omap.h>
+
 #include <asm/io.h>
-#include <mach/hardware.h>
 #include <asm/sizes.h>
-#include <linux/gpio.h>
+
 #include <plat/board-ams-delta.h>
 
+#include <mach/hardware.h>
+
 /*
  * MTD structure for E3 (Delta)
  */
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/include/linux/platform_data/gpio-omap.h
similarity index 94%
rename from arch/arm/plat-omap/include/plat/gpio.h
rename to include/linux/platform_data/gpio-omap.h
index 50fb7cc..e8741c2 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/include/linux/platform_data/gpio-omap.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/plat-omap/include/mach/gpio.h
- *
  * OMAP GPIO handling defines and functions
  *
  * Copyright (C) 2003-2005 Nokia Corporation
@@ -155,6 +153,8 @@
 #define OMAP4_GPIO_CLEARDATAOUT		0x0190
 #define OMAP4_GPIO_SETDATAOUT		0x0194
 
+#define OMAP_MAX_GPIO_LINES		192
+
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
 
@@ -213,16 +213,5 @@ extern void omap2_gpio_prepare_for_idle(int off_mode);
 extern void omap2_gpio_resume_after_idle(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
-/*-------------------------------------------------------------------------*/
-
-/*
- * Wrappers for "new style" GPIO calls, using the new infrastructure
- * which lets us plug in FPGA, I2C, and other implementations.
- *
- * The original OMAP-specific calls should eventually be removed.
- */
-
-#include <linux/errno.h>
-#include <asm-generic/gpio.h>
 
 #endif
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 33f4ac2..da45b51 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -33,6 +33,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/gpio.h>
+#include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/dsp-mcbsp.h>
 
 /* Register descriptions for twl4030 codec part */

