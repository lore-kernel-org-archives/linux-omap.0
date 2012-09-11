From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/17] ARM: OMAP: Move gpio.h to
	include/linux/platform_data
Date: Mon, 10 Sep 2012 22:30:56 -0700
Message-ID: <20120911053056.29637.57554.stgit@muffinssi.local>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120911052934.29637.9190.stgit@muffinssi.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

This way we can remove includes of plat/gpio.h which won't work
with the single zImage support.

Note that we also remove the cpu_class_is_omap2() check
in gpio-omap.c as the drivers should not call it as we need to
make it local to arch/arm/mach-omap2 for single zImage support.

While at it, arrange the related includes in the standard way.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-mtd@lists.infradead.org
Cc: alsa-devel@alsa-project.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-ams-delta.c              |    1 +
 arch/arm/mach-omap1/board-osk.c                    |    1 +
 arch/arm/mach-omap1/gpio15xx.c                     |    1 +
 arch/arm/mach-omap1/gpio16xx.c                     |    1 +
 arch/arm/mach-omap1/gpio7xx.c                      |    1 +
 arch/arm/mach-omap1/include/mach/gpio.h            |    2 --
 arch/arm/mach-omap1/leds-h2p2-debug.c              |    1 +
 arch/arm/mach-omap1/leds.c                         |    1 +
 arch/arm/mach-omap2/board-am3517evm.c              |    1 +
 arch/arm/mach-omap2/board-cm-t35.c                 |    1 +
 arch/arm/mach-omap2/board-zoom-display.c           |    2 ++
 arch/arm/mach-omap2/board-zoom-peripherals.c       |    1 +
 arch/arm/mach-omap2/gpio.c                         |    1 +
 arch/arm/mach-omap2/hsmmc.c                        |    2 ++
 arch/arm/mach-omap2/include/mach/gpio.h            |    2 --
 arch/arm/mach-omap2/msdi.c                         |    1 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +-
 arch/arm/mach-omap2/pm24xx.c                       |    1 +
 arch/arm/mach-omap2/pm34xx.c                       |    2 ++
 arch/arm/plat-omap/debug-leds.c                    |    1 +
 drivers/gpio/gpio-omap.c                           |   15 ++++++++-------
 drivers/mtd/nand/ams-delta.c                       |    8 ++++++--
 include/linux/platform_data/gpio-omap.h            |   15 ++-------------
 sound/soc/omap/sdp3430.c                           |    1 +
 28 files changed, 40 insertions(+), 31 deletions(-)
 rename arch/arm/plat-omap/include/plat/gpio.h => include/linux/platform_data/gpio-omap.h (94%)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c162369..6f192c4 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -26,6 +26,7 @@
 #include <linux/export.h>
 #include <linux/omapfb.h>
 #include <linux/io.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <media/soc_camera.h>
 
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 569b687..3b2d907 100644
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
index f6b14a1..7f4bba9 100644
--- a/arch/arm/mach-omap1/leds-h2p2-debug.c
+++ b/arch/arm/mach-omap1/leds-h2p2-debug.c
@@ -14,6 +14,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/io.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <mach/hardware.h>
 #include <asm/leds.h>
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
index 00abda1..029ebdf 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -25,6 +25,7 @@
 #include <linux/can/platform/ti_hecc.h>
 #include <linux/davinci_emac.h>
 #include <linux/mmc/host.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <mach/hardware.h>
 #include <mach/am35xx.h>
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index ea34109..34cb904 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -23,6 +23,7 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <linux/i2c/at24.h>
 #include <linux/i2c/twl.h>
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index 28187f1..d64f35f 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -18,6 +18,8 @@
 #include <video/omapdss.h>
 #include <mach/board-zoom.h>
 
+#include <plat/cpu.h>
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
index a9675d8..80399d7 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -15,6 +15,8 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <mach/hardware.h>
+#include <linux/platform_data/gpio-omap.h>
+
 #include <plat/mmc.h>
 #include <plat/omap-pm.h>
 #include <plat/mux.h>
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
index 50cfab6..5b49ebf 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -18,7 +18,6 @@
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/i2c.h>
-#include <plat/gpio.h>
 #include <plat/mcspi.h>
 #include <plat/dmtimer.h>
 #include <plat/l3_2xxx.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 58b5bc1..1fd66f0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -18,7 +18,6 @@
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/i2c.h>
-#include <plat/gpio.h>
 #include <plat/mcbsp.h>
 #include <plat/mcspi.h>
 #include <plat/dmtimer.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index afad69c..c6416c9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -10,7 +10,7 @@
  */
 #include <plat/omap_hwmod.h>
 #include <plat/serial.h>
-#include <plat/gpio.h>
+#include <linux/platform_data/gpio-omap.h>
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
 #include <plat/mcspi.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c9e3820..5820c73 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -15,6 +15,7 @@
  * XXX these should be marked initdata for multi-OMAP kernels
  */
 #include <linux/power/smartreflex.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
@@ -24,7 +25,6 @@
 #include <plat/l3_3xxx.h>
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
-#include <plat/gpio.h>
 #include <plat/mmc.h>
 #include <plat/mcbsp.h>
 #include <plat/mcspi.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 242aee4..fe987f8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -19,12 +19,12 @@
  */
 
 #include <linux/io.h>
+#include <linux/platform_data/gpio-omap.h>
 #include <linux/power/smartreflex.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
 #include <plat/i2c.h>
-#include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/mcspi.h>
 #include <plat/mcbsp.h>
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
index 05bd8f0..90480f7 100644
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
diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 39407cb..195aaae 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/leds.h>
 #include <linux/io.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <mach/hardware.h>
 #include <asm/leds.h>
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
index 0e28322..78e1419 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -34,6 +34,7 @@
 #include <mach/hardware.h>
 #include <mach/gpio.h>
 #include <plat/mcbsp.h>
+#include <linux/platform_data/gpio-omap.h>
 
 /* Register descriptions for twl4030 codec part */
 #include <linux/mfd/twl4030-audio.h>
