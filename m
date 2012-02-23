From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8] ARM: OMAP1: Move most of plat/io.h into local
 iomap.h
Date: Thu, 23 Feb 2012 15:44:47 -0800
Message-ID: <20120223234447.GH18185@atomide.com>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234044.18709.32045.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29015 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307Ab2BWXou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 18:44:50 -0500
Content-Disposition: inline
In-Reply-To: <20120221234044.18709.32045.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120221 15:09]:
> There's no need to have these in plat/io.h.
> 
> While at it, clean up the includes to group them
> like they typically are grouped.
...

> diff --git a/arch/arm/mach-omap1/iomap.h b/arch/arm/mach-omap1/iomap.h
> new file mode 100644
> index 0000000..c2cdf71
> --- /dev/null
> +++ b/arch/arm/mach-omap1/iomap.h
> @@ -0,0 +1,18 @@
> +#ifdef __ASSEMBLER__
> +#define IOMEM(x)		(x)
> +#else
> +#define IOMEM(x)		((void __force __iomem *)(x))
> +#endif
> +
> +#define OMAP1_IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
> +#define OMAP1_IO_ADDRESS(pa)	IOMEM((pa) - OMAP1_IO_OFFSET)
> +
> +/*
> + * ----------------------------------------------------------------------------
> + * Omap1 specific IO mapping
> + * ----------------------------------------------------------------------------
> + */
> +
> +#define OMAP1_IO_PHYS		0xFFFB0000
> +#define OMAP1_IO_SIZE		0x40000
> +#define OMAP1_IO_VIRT		(OMAP1_IO_PHYS - OMAP1_IO_OFFSET)

Looks like the iomap.h is missing license, so updated patch below.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 14:52:39 -0800
Subject: [PATCH] ARM: OMAP1: Move most of plat/io.h into local iomap.h

There's no need to have these in plat/io.h.

While at it, clean up the includes to group them
like they typically are grouped.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index c1c5fb6..399c4c4 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -15,11 +15,12 @@
 
 #include <linux/linkage.h>
 
-#include <plat/io.h>
 #include <plat/board-ams-delta.h>
 
 #include <mach/ams-delta-fiq.h>
 
+#include "iomap.h"
+
 /*
  * GPIO related definitions, copied from arch/arm/plat-omap/gpio.c.
  * Unfortunately, those were not placed in a separate header file.
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index 152b32c..fcce7ff 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -22,6 +22,7 @@
 #include <plat/board-ams-delta.h>
 
 #include <asm/fiq.h>
+
 #include <mach/ams-delta-fiq.h>
 
 static struct fiq_handler fh = {
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 88909cc..ac65d7d 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -20,25 +20,27 @@
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/export.h>
+#include <linux/io.h>
 
 #include <media/soc_camera.h>
 
 #include <asm/serial.h>
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/io.h>
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
+#include "iomap.h"
+#include "common.h"
 
 static u8 ams_delta_latch1_reg;
 static u16 ams_delta_latch2_reg;
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 0b9464b..079292c 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -22,7 +22,6 @@
 #include <linux/input.h>
 #include <linux/smc91x.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -32,9 +31,13 @@
 #include <plat/flash.h>
 #include <plat/fpga.h>
 #include <plat/keypad.h>
-#include "common.h"
 #include <plat/board.h>
 
+#include <mach/hardware.h>
+
+#include "iomap.h"
+#include "common.h"
+
 /* fsample is pretty close to p2-sample */
 
 #define fsample_cpld_read(reg) __raw_readb(reg)
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 00ad6b2..03e0050 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -31,8 +31,6 @@
 #include <linux/i2c/tps65010.h>
 #include <linux/smc91x.h>
 
-#include <mach/hardware.h>
-
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -43,9 +41,11 @@
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
index 4a7f251..f304fe2 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -33,21 +33,21 @@
 
 #include <asm/setup.h>
 #include <asm/page.h>
-#include <mach/hardware.h>
-
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/irqs.h>
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
index 731cc3d..fa52d14 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -27,7 +27,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
-#include <linux/io.h>
+#include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/i2c.h>
@@ -41,7 +41,6 @@
 #include <asm/mach/arch.h>
 
 #include <plat/omap7xx.h>
-#include "common.h"
 #include <plat/board.h>
 #include <plat/keypad.h>
 #include <plat/usb.h>
@@ -49,7 +48,7 @@
 
 #include <mach/irqs.h>
 
-#include <linux/delay.h>
+#include "common.h"
 
 /* LCD register definition */
 #define       OMAP_LCDC_CONTROL               (0xfffec000 + 0x00)
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 309369e..289a6b8 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -26,7 +26,6 @@
 #include <linux/input.h>
 #include <linux/smc91x.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -37,9 +36,13 @@
 #include <plat/tc.h>
 #include <plat/usb.h>
 #include <plat/keypad.h>
-#include "common.h"
 #include <plat/mmc.h>
 
+#include <mach/hardware.h>
+
+#include "iomap.h"
+#include "common.h"
+
 /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
 #define INNOVATOR1610_ETHR_START	0x04000300
 
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index f9efc03..abdbdb0 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -21,7 +21,6 @@
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -30,12 +29,15 @@
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
index 675de06..e2d7ae4 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -34,15 +34,11 @@
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
@@ -51,6 +47,9 @@
 #include <plat/usb.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
+
+#include <mach/hardware.h>
+
 #include "common.h"
 
 /* At OMAP5912 OSK the Ethernet is directly connected to CS1 */
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 81fa27f..04efa7e 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -28,7 +28,6 @@
 #include <linux/interrupt.h>
 #include <linux/apm-emulation.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -41,6 +40,9 @@
 #include <plat/board.h>
 #include <plat/irda.h>
 #include <plat/keypad.h>
+
+#include <mach/hardware.h>
+
 #include "common.h"
 
 #define PALMTE_USBDETECT_GPIO	0
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 81cb821..acd1f36 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -24,8 +24,9 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/leds.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -39,10 +40,10 @@
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
index e881945..c1cd0f2 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -27,8 +27,9 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -41,10 +42,10 @@
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
index c000bed..83f5b76 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -22,7 +22,6 @@
 #include <linux/input.h>
 #include <linux/smc91x.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -32,9 +31,13 @@
 #include <plat/fpga.h>
 #include <plat/flash.h>
 #include <plat/keypad.h>
-#include "common.h"
 #include <plat/board.h>
 
+#include <mach/hardware.h>
+
+#include "iomap.h"
+#include "common.h"
+
 static const unsigned int p2_keymap[] = {
 	KEY(0, 0, KEY_UP),
 	KEY(1, 0, KEY_RIGHT),
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 7bcd82a..fed4435 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -28,7 +28,6 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -40,10 +39,13 @@
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
index f83a502..659d0f7 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -27,18 +27,20 @@
 #include <linux/smc91x.h>
 #include <linux/export.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
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
index 0c50df0..0e8c176 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -16,7 +16,6 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/clk.h>
-#include <linux/io.h>
 #include <linux/clkdev.h>
 
 #include <asm/mach-types.h>
@@ -27,6 +26,7 @@
 #include <plat/sram.h>
 #include <plat/clkdev_omap.h>
 
+#include "iomap.h"
 #include "clock.h"
 #include "opp.h"
 
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 94699a8..10b7451 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -18,7 +18,6 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
-#include <linux/io.h>
 
 #include <asm/mach-types.h>  /* for machine_is_* */
 
@@ -28,6 +27,7 @@
 #include <plat/sram.h>	/* for omap_sram_reprogram_clock() */
 #include <plat/usb.h>   /* for OTG_BASE */
 
+#include "iomap.h"
 #include "clock.h"
 
 /* Some ARM_IDLECT1 bit shifts - used in struct arm_idlect1_clk */
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 1d76a63..d06c714 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -15,14 +15,10 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/io.h>
 #include <linux/spi/spi.h>
 
-#include <mach/camera.h>
-#include <mach/hardware.h>
 #include <asm/mach/map.h>
 
-#include "common.h"
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <plat/mux.h>
@@ -30,6 +26,10 @@
 #include <plat/omap7xx.h>
 #include <plat/mcbsp.h>
 
+#include <mach/camera.h>
+#include <mach/hardware.h>
+
+#include "common.h"
 #include "clock.h"
 
 /*-------------------------------------------------------------------------*/
diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index f5a5220..3ef7d52 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -19,11 +19,11 @@
  */
 
 #include <linux/err.h>
-#include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/io.h>
 
 #include <plat/dma.h>
 #include <plat/tc.h>
diff --git a/arch/arm/mach-omap1/flash.c b/arch/arm/mach-omap1/flash.c
index 1749cb3..98d29a0 100644
--- a/arch/arm/mach-omap1/flash.c
+++ b/arch/arm/mach-omap1/flash.c
@@ -6,10 +6,10 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 
-#include <plat/io.h>
 #include <plat/tc.h>
 #include <plat/flash.h>
 
diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 0a17a1a..76c67b3 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -24,12 +24,15 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 
 #include <plat/fpga.h>
 
+#include <mach/hardware.h>
+
+#include "iomap.h"
+
 static void fpga_mask_irq(struct irq_data *d)
 {
 	unsigned int irq = d->irq - OMAP_FPGA_IRQ_BASE;
diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index a0e3560..7483db2 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+
 #include <plat/cpu.h>
 
 #define OMAP_DIE_ID_0		0xfffe1800
diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
index bfb4fb1..68d2679 100644
--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -9,10 +9,12 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
+
 #include <mach/hardware.h>
 #include <mach/io.h>
 #include <mach/irqs.h>
-#include <asm/hardware/gic.h>
+
+#include "../../iomap.h"
 
  		.macro	disable_fiq
 		.endm
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 8e55b6f..56fb444 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -15,9 +15,12 @@
 
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
+
 #include <plat/mux.h>
 #include <plat/tc.h>
 
+#include "iomap.h"
+#include "common.h"
 #include "clock.h"
 
 extern void omap_check_revision(void);
diff --git a/arch/arm/mach-omap1/iomap.h b/arch/arm/mach-omap1/iomap.h
new file mode 100644
index 0000000..d681757
--- /dev/null
+++ b/arch/arm/mach-omap1/iomap.h
@@ -0,0 +1,42 @@
+/*
+ * IO mappings for OMAP1
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifdef __ASSEMBLER__
+#define IOMEM(x)		(x)
+#else
+#define IOMEM(x)		((void __force __iomem *)(x))
+#endif
+
+#define OMAP1_IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
+#define OMAP1_IO_ADDRESS(pa)	IOMEM((pa) - OMAP1_IO_OFFSET)
+
+/*
+ * ----------------------------------------------------------------------------
+ * Omap1 specific IO mapping
+ * ----------------------------------------------------------------------------
+ */
+
+#define OMAP1_IO_PHYS		0xFFFB0000
+#define OMAP1_IO_SIZE		0x40000
+#define OMAP1_IO_VIRT		(OMAP1_IO_PHYS - OMAP1_IO_OFFSET)
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index e5b104b..4448114 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -42,11 +42,13 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
+
 #include <plat/cpu.h>
 
+#include <mach/hardware.h>
+
 #define IRQ_BANK(irq) ((irq) >> 5)
 #define IRQ_BIT(irq)  ((irq) & 0x1f)
 
diff --git a/arch/arm/mach-omap1/lcd_dma.c b/arch/arm/mach-omap1/lcd_dma.c
index 4538093..123a0df 100644
--- a/arch/arm/mach-omap1/lcd_dma.c
+++ b/arch/arm/mach-omap1/lcd_dma.c
@@ -27,9 +27,10 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 
+#include <plat/dma.h>
+
 #include <mach/hardware.h>
 #include <mach/lcdc.h>
-#include <plat/dma.h>
 
 int omap_lcd_dma_running(void)
 {
diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 91f9abb..3082d60 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -19,12 +19,15 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <mach/irqs.h>
 #include <plat/dma.h>
 #include <plat/mux.h>
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
 
+#include <mach/irqs.h>
+
+#include "iomap.h"
+
 #define DPS_RSTCT2_PER_EN	(1 << 0)
 #define DSP_RSTCT2_WD_PER_EN	(1 << 1)
 
diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 89ea20c..c06bb40 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -42,14 +42,13 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/atomic.h>
 
 #include <asm/irq.h>
-#include <linux/atomic.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
 #include <plat/cpu.h>
-#include <mach/irqs.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/tc.h>
@@ -57,6 +56,9 @@
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
 
+#include <mach/irqs.h>
+
+#include "iomap.h"
 #include "pm.h"
 
 static unsigned int arm_sleep_save[ARM_SLEEP_SAVE_SIZE];
diff --git a/arch/arm/mach-omap1/reset.c b/arch/arm/mach-omap1/reset.c
index 91d199b..f255b15 100644
--- a/arch/arm/mach-omap1/reset.c
+++ b/arch/arm/mach-omap1/reset.c
@@ -4,9 +4,10 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <plat/prcm.h>
 
+#include <mach/hardware.h>
+
 void omap1_restart(char mode, const char *cmd)
 {
 	/*
diff --git a/arch/arm/mach-omap1/sleep.S b/arch/arm/mach-omap1/sleep.S
index c875bdc..0779db1 100644
--- a/arch/arm/mach-omap1/sleep.S
+++ b/arch/arm/mach-omap1/sleep.S
@@ -33,8 +33,12 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+
 #include <mach/io.h>
+
+#include "iomap.h"
 #include "pm.h"
 
 		.text
diff --git a/arch/arm/mach-omap1/sram.S b/arch/arm/mach-omap1/sram.S
index 692587d..2ce0b9a 100644
--- a/arch/arm/mach-omap1/sram.S
+++ b/arch/arm/mach-omap1/sram.S
@@ -9,10 +9,14 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/assembler.h>
+
 #include <mach/io.h>
 #include <mach/hardware.h>
 
+#include "iomap.h"
+
 	.text
 
 /*
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index b8faffa..2fae6a2 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -45,14 +45,15 @@
 #include <linux/io.h>
 
 #include <asm/system.h>
-#include <mach/hardware.h>
 #include <asm/leds.h>
 #include <asm/irq.h>
 #include <asm/sched_clock.h>
 
+#include <mach/hardware.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
+#include "iomap.h"
 #include "common.h"
 
 #ifdef CONFIG_OMAP_MPU_TIMER
diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 9a54ef4..a2e6d07 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -47,14 +47,17 @@
 #include <linux/io.h>
 
 #include <asm/system.h>
-#include <mach/hardware.h>
 #include <asm/leds.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
-#include "common.h"
+
 #include <plat/dmtimer.h>
 
+#include <mach/hardware.h>
+
+#include "common.h"
+
 /*
  * ---------------------------------------------------------------------------
  * 32KHz OS timer
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 28cd796..e5e8e08 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -60,9 +60,6 @@
 #define IOMEM(x)		((void __force __iomem *)(x))
 #endif
 
-#define OMAP1_IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
-#define OMAP1_IO_ADDRESS(pa)	IOMEM((pa) - OMAP1_IO_OFFSET)
-
 #define OMAP2_L3_IO_OFFSET	0x90000000
 #define OMAP2_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L3_IO_OFFSET) /* L3 */
 
@@ -87,16 +84,6 @@
 
 /*
  * ----------------------------------------------------------------------------
- * Omap1 specific IO mapping
- * ----------------------------------------------------------------------------
- */
-
-#define OMAP1_IO_PHYS		0xFFFB0000
-#define OMAP1_IO_SIZE		0x40000
-#define OMAP1_IO_VIRT		(OMAP1_IO_PHYS - OMAP1_IO_OFFSET)
-
-/*
- * ----------------------------------------------------------------------------
  * Omap2 specific IO mapping
  * ----------------------------------------------------------------------------
  */
