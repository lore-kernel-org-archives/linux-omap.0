From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] omap: headers: Move remaining headers from
	include/mach to include/plat
Date: Wed, 14 Oct 2009 16:16:38 -0700
Message-ID: <20091014231637.GB14531@atomide.com>
References: <20091014213748.30227.71513.stgit@kaulin.muru.com>
	<20091014215009.30227.1464.stgit@kaulin.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20091014215009.30227.1464.stgit@kaulin.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Looks like this got caught because of the size on the
linux-arm-kernel list. Here's a repost without the
diffstat and the diff command line left out to keep
it under 100Kb.

---

Move the remaining headers under plat-omap/include/mach
to plat-omap/include/plat. Also search and replace the
files using these headers to include using the right path.

This was done with:

#!/bin/bash
mach_dir_old="arch/arm/plat-omap/include/mach"
plat_dir_new="arch/arm/plat-omap/include/plat"
headers=$(cd $mach_dir_old && ls *.h)
omap_dirs="arch/arm/*omap*/ \
drivers/video/omap \
sound/soc/omap"
other_files="drivers/leds/leds-ams-delta.c \
drivers/mfd/menelaus.c \
drivers/mfd/twl4030-core.c \
drivers/mtd/nand/ams-delta.c"

for header in $headers; do
	old="#include <mach\/$header"
	new="#include <plat\/$header"
	for dir in $omap_dirs; do
		find $dir -type f -name \*.[chS] | \
			xargs sed -i "s/$old/$new/"
	done
	find drivers/ -type f -name \*omap*.[chS] | \
		xargs sed -i "s/$old/$new/"
	for file in $other_files; do
		sed -i "s/$old/$new/" $file
	done
done

for header in $(ls $mach_dir_old/*.h); do
	git mv $header $plat_dir_new/
done

Signed-off-by: Tony Lindgren <tony@atomide.com>

index 42920f9..7214ff4 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -25,13 +25,13 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-ams-delta.h>
+#include <plat/board-ams-delta.h>
 #include <mach/gpio.h>
-#include <mach/keypad.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/board.h>
-#include <mach/common.h>
+#include <plat/keypad.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/board.h>
+#include <plat/common.h>
 
 static u8 ams_delta_latch1_reg;
 static u16 ams_delta_latch2_reg;
index a7ead1b..d9ddd3e 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -26,14 +26,14 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <mach/tc.h>
+#include <plat/tc.h>
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/fpga.h>
-#include <mach/nand.h>
-#include <mach/keypad.h>
-#include <mach/common.h>
-#include <mach/board.h>
+#include <plat/mux.h>
+#include <plat/fpga.h>
+#include <plat/nand.h>
+#include <plat/keypad.h>
+#include <plat/common.h>
+#include <plat/board.h>
 
 /* fsample is pretty close to p2-sample */
 
index fb47239..aaea018 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -23,10 +23,10 @@
 #include <asm/mach/map.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/board.h>
-#include <mach/common.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/board.h>
+#include <plat/common.h>
 
 static void __init omap_generic_init_irq(void)
 {
index 46098f5..b30c499 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -16,7 +16,7 @@
 
 #include <linux/i2c/tps65010.h>
 
-#include <mach/mmc.h>
+#include <plat/mmc.h>
 #include <mach/gpio.h>
 
 #include "board-h2.h"
index aab8603..89ba8ec 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -37,14 +37,14 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <mach/mux.h>
-#include <mach/dma.h>
-#include <mach/tc.h>
-#include <mach/nand.h>
-#include <mach/irda.h>
-#include <mach/usb.h>
-#include <mach/keypad.h>
-#include <mach/common.h>
+#include <plat/mux.h>
+#include <plat/dma.h>
+#include <plat/tc.h>
+#include <plat/nand.h>
+#include <plat/irda.h>
+#include <plat/usb.h>
+#include <plat/keypad.h>
+#include <plat/common.h>
 
 #include "board-h2.h"
 
index 5e8877c..54b0f06 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -16,7 +16,7 @@
 
 #include <linux/i2c/tps65010.h>
 
-#include <mach/mmc.h>
+#include <plat/mmc.h>
 #include <mach/gpio.h>
 
 #include "board-h3.h"
index 89586b8..f5cc0a7 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -40,13 +40,13 @@
 #include <asm/mach/map.h>
 
 #include <mach/irqs.h>
-#include <mach/mux.h>
-#include <mach/tc.h>
-#include <mach/nand.h>
-#include <mach/usb.h>
-#include <mach/keypad.h>
-#include <mach/dma.h>
-#include <mach/common.h>
+#include <plat/mux.h>
+#include <plat/tc.h>
+#include <plat/nand.h>
+#include <plat/usb.h>
+#include <plat/keypad.h>
+#include <plat/dma.h>
+#include <plat/common.h>
 
 #include "board-h3.h"
 
index cc2abbb..68462c5 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -30,14 +30,14 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <mach/mux.h>
-#include <mach/fpga.h>
+#include <plat/mux.h>
+#include <plat/fpga.h>
 #include <mach/gpio.h>
-#include <mach/tc.h>
-#include <mach/usb.h>
-#include <mach/keypad.h>
-#include <mach/common.h>
-#include <mach/mmc.h>
+#include <plat/tc.h>
+#include <plat/usb.h>
+#include <plat/keypad.h>
+#include <plat/common.h>
+#include <plat/mmc.h>
 
 /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
 #define INNOVATOR1610_ETHR_START	0x04000300
index ed2a48a..5a275ba 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -26,17 +26,17 @@
 #include <asm/mach/map.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/board.h>
-#include <mach/keypad.h>
-#include <mach/common.h>
-#include <mach/dsp_common.h>
-#include <mach/omapfb.h>
-#include <mach/hwa742.h>
-#include <mach/lcd_mipid.h>
-#include <mach/mmc.h>
-#include <mach/clock.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/board.h>
+#include <plat/keypad.h>
+#include <plat/common.h>
+#include <plat/dsp_common.h>
+#include <plat/omapfb.h>
+#include <plat/hwa742.h>
+#include <plat/lcd_mipid.h>
+#include <plat/mmc.h>
+#include <plat/clock.h>
 
 #define ADS7846_PENDOWN_GPIO	15
 
index ed891b8..50c92c1 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -47,10 +47,10 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
-#include <mach/usb.h>
-#include <mach/mux.h>
-#include <mach/tc.h>
-#include <mach/common.h>
+#include <plat/usb.h>
+#include <plat/mux.h>
+#include <plat/tc.h>
+#include <plat/common.h>
 
 /* At OMAP5912 OSK the Ethernet is directly connected to CS1 */
 #define OMAP_OSK_ETHR_START		0x04800300
@@ -312,7 +312,7 @@ static struct omap_board_config_kernel osk_config[] __initdata = {
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
-#include <mach/keypad.h>
+#include <plat/keypad.h>
 
 static struct at24_platform_data at24c04 = {
 	.byte_len	= SZ_4K / 8,
index 90dd043..73d115e 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -34,14 +34,14 @@
 #include <asm/mach/flash.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/tc.h>
-#include <mach/dma.h>
-#include <mach/board.h>
-#include <mach/irda.h>
-#include <mach/keypad.h>
-#include <mach/common.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/tc.h>
+#include <plat/dma.h>
+#include <plat/board.h>
+#include <plat/irda.h>
+#include <plat/keypad.h>
+#include <plat/common.h>
 
 #define PALMTE_USBDETECT_GPIO	0
 #define PALMTE_USB_OR_DC_GPIO	1
index 8256139..81dd74d 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -29,16 +29,16 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
-#include <mach/led.h>
+#include <plat/led.h>
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/dma.h>
-#include <mach/tc.h>
-#include <mach/board.h>
-#include <mach/irda.h>
-#include <mach/keypad.h>
-#include <mach/common.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/dma.h>
+#include <plat/tc.h>
+#include <plat/board.h>
+#include <plat/irda.h>
+#include <plat/keypad.h>
+#include <plat/common.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
index 81b6bde..427ad3a 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -33,15 +33,15 @@
 #include <asm/mach/flash.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/dma.h>
-#include <mach/tc.h>
-#include <mach/board.h>
-#include <mach/irda.h>
-#include <mach/keypad.h>
-#include <mach/common.h>
-#include <mach/omap-alsa.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/dma.h>
+#include <plat/tc.h>
+#include <plat/board.h>
+#include <plat/irda.h>
+#include <plat/keypad.h>
+#include <plat/common.h>
+#include <plat/omap-alsa.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
index 8340669..1994a2f 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -26,14 +26,14 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <mach/tc.h>
+#include <plat/tc.h>
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/fpga.h>
-#include <mach/nand.h>
-#include <mach/keypad.h>
-#include <mach/common.h>
-#include <mach/board.h>
+#include <plat/mux.h>
+#include <plat/fpga.h>
+#include <plat/nand.h>
+#include <plat/keypad.h>
+#include <plat/common.h>
+#include <plat/board.h>
 
 static int p2_keymap[] = {
 	KEY(0,0,KEY_UP),
index 58a46e4..5b33ae8 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -15,9 +15,9 @@
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
-#include <mach/mmc.h>
+#include <plat/mmc.h>
 #include <mach/gpio.h>
-#include <mach/board-sx1.h>
+#include <plat/board-sx1.h>
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
index 02c85ca..b3bb01b 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -33,15 +33,15 @@
 #include <asm/mach/map.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/dma.h>
-#include <mach/irda.h>
-#include <mach/usb.h>
-#include <mach/tc.h>
-#include <mach/board.h>
-#include <mach/common.h>
-#include <mach/keypad.h>
-#include <mach/board-sx1.h>
+#include <plat/mux.h>
+#include <plat/dma.h>
+#include <plat/irda.h>
+#include <plat/usb.h>
+#include <plat/tc.h>
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/keypad.h>
+#include <plat/board-sx1.h>
 
 /* Write to I2C device */
 int sx1_i2c_write_byte(u8 devaddr, u8 regoffset, u8 value)
index c06e7a5..ba9db21 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -29,11 +29,11 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <mach/common.h>
+#include <plat/common.h>
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/tc.h>
-#include <mach/usb.h>
+#include <plat/mux.h>
+#include <plat/tc.h>
+#include <plat/usb.h>
 
 static struct plat_serial8250_port voiceblue_ports[] = {
 	{
index 436eed2..ba3e717 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -22,10 +22,10 @@
 #include <asm/mach-types.h>
 #include <asm/clkdev.h>
 
-#include <mach/cpu.h>
-#include <mach/usb.h>
-#include <mach/clock.h>
-#include <mach/sram.h>
+#include <plat/cpu.h>
+#include <plat/usb.h>
+#include <plat/clock.h>
+#include <plat/sram.h>
 
 static const struct clkops clkops_generic;
 static const struct clkops clkops_uart;
index 0680843..6d2f72d 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -18,11 +18,11 @@
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
 
-#include <mach/tc.h>
-#include <mach/board.h>
-#include <mach/mux.h>
+#include <plat/tc.h>
+#include <plat/board.h>
+#include <plat/mux.h>
 #include <mach/gpio.h>
-#include <mach/mmc.h>
+#include <plat/mmc.h>
 
 /*-------------------------------------------------------------------------*/
 
index 4f2b8a7..5cfce16 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -27,7 +27,7 @@
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 
-#include <mach/fpga.h>
+#include <plat/fpga.h>
 #include <mach/gpio.h>
 
 static void fpga_mask_irq(unsigned int irq)
index e5dcdf7..a0e3560 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <mach/cpu.h>
+#include <plat/cpu.h>
 
 #define OMAP_DIE_ID_0		0xfffe1800
 #define OMAP_DIE_ID_1		0xfffe1804
index 7030f92..58e9bb1 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -15,8 +15,8 @@
 
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
-#include <mach/mux.h>
-#include <mach/tc.h>
+#include <plat/mux.h>
+#include <plat/tc.h>
 
 extern int omap1_clk_init(void);
 extern void omap_check_revision(void);
index de03c84..4350f9e 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -46,7 +46,7 @@
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <mach/gpio.h>
-#include <mach/cpu.h>
+#include <plat/cpu.h>
 
 #define IRQ_BANK(irq) ((irq) >> 5)
 #define IRQ_BIT(irq)  ((irq) & 0x1f)
index 17c9d0e..b4f9be5 100644
--- a/arch/arm/mach-omap1/leds-h2p2-debug.c
+++ b/arch/arm/mach-omap1/leds-h2p2-debug.c
@@ -19,7 +19,7 @@
 #include <asm/system.h>
 #include <asm/mach-types.h>
 
-#include <mach/fpga.h>
+#include <plat/fpga.h>
 #include <mach/gpio.h>
 
 #include "leds.h"
index 8cbf256..277f356 100644
--- a/arch/arm/mach-omap1/leds.c
+++ b/arch/arm/mach-omap1/leds.c
@@ -10,7 +10,7 @@
 #include <asm/mach-types.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
+#include <plat/mux.h>
 
 #include "leds.h"
 
index 6810b4a..caf889a 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <mach/mailbox.h>
+#include <plat/mailbox.h>
 #include <mach/irqs.h>
 
 #define MAILBOX_ARM2DSP1		0x00
index 505d98c..8926e14 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -18,11 +18,11 @@
 #include <linux/platform_device.h>
 
 #include <mach/irqs.h>
-#include <mach/dma.h>
-#include <mach/mux.h>
-#include <mach/cpu.h>
-#include <mach/mcbsp.h>
-#include <mach/dsp_common.h>
+#include <plat/dma.h>
+#include <plat/mux.h>
+#include <plat/cpu.h>
+#include <plat/mcbsp.h>
+#include <plat/dsp_common.h>
 
 #define DPS_RSTCT2_PER_EN	(1 << 0)
 #define DSP_RSTCT2_WD_PER_EN	(1 << 1)
index 721e0d9..403c176 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -29,7 +29,7 @@
 
 #include <asm/system.h>
 
-#include <mach/mux.h>
+#include <plat/mux.h>
 
 #ifdef CONFIG_OMAP_MUX
 
index 5218943..7a01ca3 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -48,14 +48,14 @@
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
 
-#include <mach/cpu.h>
+#include <plat/cpu.h>
 #include <mach/irqs.h>
-#include <mach/clock.h>
-#include <mach/sram.h>
-#include <mach/tc.h>
-#include <mach/mux.h>
-#include <mach/dma.h>
-#include <mach/dmtimer.h>
+#include <plat/clock.h>
+#include <plat/sram.h>
+#include <plat/tc.h>
+#include <plat/mux.h>
+#include <plat/dma.h>
+#include <plat/dmtimer.h>
 
 #include "pm.h"
 
index d496e50..961a2b3 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -22,10 +22,10 @@
 
 #include <asm/mach-types.h>
 
-#include <mach/board.h>
-#include <mach/mux.h>
+#include <plat/board.h>
+#include <plat/mux.h>
 #include <mach/gpio.h>
-#include <mach/fpga.h>
+#include <plat/fpga.h>
 
 static struct clk * uart1_ck;
 static struct clk * uart2_ck;
index fd3f739..9ad1185 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -52,7 +52,7 @@
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
-#include <mach/dmtimer.h>
+#include <plat/dmtimer.h>
 
 struct sys_timer omap_timer;
 
index 42217b3..0613522 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -31,12 +31,12 @@
 #include <asm/mach/flash.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/board.h>
-#include <mach/common.h>
-#include <mach/gpmc.h>
-#include <mach/usb.h>
-#include <mach/gpmc-smc91x.h>
+#include <plat/mux.h>
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/gpmc.h>
+#include <plat/usb.h>
+#include <plat/gpmc-smc91x.h>
 
 #include "mmc-twl4030.h"
 
index efaf053..e668236 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -29,17 +29,17 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/mcspi.h>
-#include <mach/mux.h>
-#include <mach/board.h>
-#include <mach/usb.h>
-#include <mach/common.h>
-#include <mach/dma.h>
-#include <mach/gpmc.h>
-
-#include <mach/control.h>
-#include <mach/keypad.h>
-#include <mach/gpmc-smc91x.h>
+#include <plat/mcspi.h>
+#include <plat/mux.h>
+#include <plat/board.h>
+#include <plat/usb.h>
+#include <plat/common.h>
+#include <plat/dma.h>
+#include <plat/gpmc.h>
+
+#include <plat/control.h>
+#include <plat/keypad.h>
+#include <plat/gpmc-smc91x.h>
 
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
index eb37c40..fd56950 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -23,10 +23,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board.h>
-#include <mach/common.h>
-#include <mach/control.h>
-#include <mach/timer-gp.h>
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/control.h>
+#include <plat/timer-gp.h>
 #include <asm/hardware/gic.h>
 
 static struct platform_device sdp4430_lcd_device = {
index a113228..608ddbc 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -33,13 +33,13 @@
 #include <asm/mach/flash.h>
 
 #include <mach/gpio.h>
-#include <mach/led.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/board.h>
-#include <mach/common.h>
-#include <mach/gpmc.h>
-#include <mach/control.h>
+#include <plat/led.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/gpmc.h>
+#include <plat/control.h>
 
 /* LED & Switch macros */
 #define LED0_GPIO13		13
index 2e09a1c..2c3ee1a 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -26,10 +26,10 @@
 #include <asm/mach/map.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/board.h>
-#include <mach/common.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/board.h>
+#include <plat/common.h>
 
 static struct omap_board_config_kernel generic_config[] = {
 };
index eaa02d0..8867c40 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -31,16 +31,16 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
-#include <mach/control.h>
+#include <plat/control.h>
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/board.h>
-#include <mach/common.h>
-#include <mach/keypad.h>
-#include <mach/menelaus.h>
-#include <mach/dma.h>
-#include <mach/gpmc.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/keypad.h>
+#include <plat/menelaus.h>
+#include <plat/dma.h>
+#include <plat/gpmc.h>
 
 #define H4_FLASH_CS	0
 #define H4_SMC91X_CS	1
index d110a7f..7174715 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -32,16 +32,16 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/mcspi.h>
+#include <plat/mcspi.h>
 #include <mach/gpio.h>
-#include <mach/board.h>
-#include <mach/common.h>
-#include <mach/gpmc.h>
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/gpmc.h>
 
 #include <asm/delay.h>
-#include <mach/control.h>
-#include <mach/usb.h>
-#include <mach/keypad.h>
+#include <plat/control.h>
+#include <plat/usb.h>
+#include <plat/keypad.h>
 
 #include "mmc-twl4030.h"
 
index 8341632..729e9a7 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -23,12 +23,12 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
-#include <mach/board.h>
-#include <mach/common.h>
+#include <plat/board.h>
+#include <plat/common.h>
 #include <mach/irqs.h>
-#include <mach/mcspi.h>
-#include <mach/onenand.h>
-#include <mach/serial.h>
+#include <plat/mcspi.h>
+#include <plat/onenand.h>
+#include <plat/serial.h>
 
 static struct omap2_mcspi_device_config p54spi_mcspi_config = {
 	.turbo_mode	= 0,
index 70df6b4..74b3f47 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -37,13 +37,13 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
-#include <mach/board.h>
-#include <mach/common.h>
-#include <mach/gpmc.h>
-#include <mach/nand.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/timer-gp.h>
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/gpmc.h>
+#include <plat/nand.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/timer-gp.h>
 
 #include "mmc-twl4030.h"
 
index e4ec0c5..c9014bc 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -32,12 +32,12 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/common.h>
-#include <mach/mcspi.h>
-#include <mach/keypad.h>
+#include <plat/board.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/common.h>
+#include <plat/mcspi.h>
+#include <plat/keypad.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
index 7f6bf87..9b9bb21 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -33,14 +33,14 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board.h>
-#include <mach/common.h>
+#include <plat/board.h>
+#include <plat/common.h>
 #include <mach/gpio.h>
 #include <mach/hardware.h>
-#include <mach/mcspi.h>
-#include <mach/usb.h>
-#include <mach/keypad.h>
-#include <mach/mux.h>
+#include <plat/mcspi.h>
+#include <plat/usb.h>
+#include <plat/keypad.h>
+#include <plat/mux.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
index 9917d2f..75dbb6c 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -38,14 +38,14 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <mach/board.h>
-#include <mach/common.h>
+#include <plat/board.h>
+#include <plat/common.h>
 #include <mach/gpio.h>
-#include <mach/gpmc.h>
+#include <plat/gpmc.h>
 #include <mach/hardware.h>
-#include <mach/nand.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
+#include <plat/nand.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
@@ -67,7 +67,7 @@
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
 	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 
-#include <mach/mcspi.h>
+#include <plat/mcspi.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
index c1af532..3f68bc8 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -21,15 +21,15 @@
 #include <linux/gpio.h>
 #include <linux/mmc/host.h>
 
-#include <mach/mcspi.h>
-#include <mach/mux.h>
-#include <mach/board.h>
-#include <mach/common.h>
-#include <mach/dma.h>
-#include <mach/gpmc.h>
-#include <mach/keypad.h>
-#include <mach/onenand.h>
-#include <mach/gpmc-smc91x.h>
+#include <plat/mcspi.h>
+#include <plat/mux.h>
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/dma.h>
+#include <plat/gpmc.h>
+#include <plat/keypad.h>
+#include <plat/onenand.h>
+#include <plat/gpmc-smc91x.h>
 
 #include "mmc-twl4030.h"
 
index f9196c3..7cb2e3c 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -22,14 +22,14 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/mcspi.h>
-#include <mach/mux.h>
-#include <mach/board.h>
-#include <mach/common.h>
-#include <mach/keypad.h>
-#include <mach/dma.h>
-#include <mach/gpmc.h>
-#include <mach/usb.h>
+#include <plat/mcspi.h>
+#include <plat/mux.h>
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/keypad.h>
+#include <plat/dma.h>
+#include <plat/gpmc.h>
+#include <plat/usb.h>
 
 static struct omap_lcd_config rx51_lcd_config = {
 	.ctrl_name	= "internal",
index 1f13e2a..91ecddc 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -14,7 +14,7 @@
 #include <linux/smsc911x.h>
 #include <linux/interrupt.h>
 
-#include <mach/gpmc.h>
+#include <plat/gpmc.h>
 
 #define ZOOM2_SMSC911X_CS	7
 #define ZOOM2_SMSC911X_GPIO	158
index b7b3220..099a8e5 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -20,9 +20,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/common.h>
-#include <mach/usb.h>
-#include <mach/keypad.h>
+#include <plat/common.h>
+#include <plat/usb.h>
+#include <plat/keypad.h>
 
 #include "mmc-twl4030.h"
 
index f2a92d6..4716206 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -24,13 +24,13 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 
-#include <mach/clock.h>
-#include <mach/clockdomain.h>
-#include <mach/cpu.h>
-#include <mach/prcm.h>
+#include <plat/clock.h>
+#include <plat/clockdomain.h>
+#include <plat/cpu.h>
+#include <plat/prcm.h>
 #include <asm/div64.h>
 
-#include <mach/sdrc.h>
+#include <plat/sdrc.h>
 #include "sdrc.h"
 #include "clock.h"
 #include "prm.h"
index 9ae7540..43b6bed 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -16,7 +16,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK_H
 
-#include <mach/clock.h>
+#include <plat/clock.h>
 
 /* The maximum error between a target DPLL rate and the rounded rate in Hz */
 #define DEFAULT_DPLL_RATE_TOLERANCE	50000
index bc5d3ac..a031bd2 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -28,13 +28,13 @@
 #include <linux/cpufreq.h>
 #include <linux/bitops.h>
 
-#include <mach/clock.h>
-#include <mach/sram.h>
-#include <mach/prcm.h>
+#include <plat/clock.h>
+#include <plat/sram.h>
+#include <plat/prcm.h>
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
-#include <mach/sdrc.h>
+#include <plat/sdrc.h>
 #include "clock.h"
 #include "prm.h"
 #include "prm-regbits-24xx.h"
index 489556e..c258f87 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -27,13 +27,13 @@
 #include <linux/limits.h>
 #include <linux/bitops.h>
 
-#include <mach/cpu.h>
-#include <mach/clock.h>
-#include <mach/sram.h>
+#include <plat/cpu.h>
+#include <plat/clock.h>
+#include <plat/sram.h>
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
-#include <mach/sdrc.h>
+#include <plat/sdrc.h>
 #include "clock.h"
 #include "prm.h"
 #include "prm-regbits-34xx.h"
index c811978..a1b3de7 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -19,7 +19,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
 
-#include <mach/control.h>
+#include <plat/control.h>
 
 #include "clock.h"
 #include "cm.h"
index 4ef7b4f..edcf1bd 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -28,14 +28,14 @@
 
 #include <linux/bitops.h>
 
-#include <mach/clock.h>
+#include <plat/clock.h>
 
 #include "prm.h"
 #include "prm-regbits-24xx.h"
 #include "cm.h"
 
-#include <mach/powerdomain.h>
-#include <mach/clockdomain.h>
+#include <plat/powerdomain.h>
+#include <plat/clockdomain.h>
 
 /* clkdm_list contains all registered struct clockdomains */
 static LIST_HEAD(clkdm_list);
index fe319ae..c4ee076 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -10,7 +10,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_H
 
-#include <mach/clockdomain.h>
+#include <plat/clockdomain.h>
 
 /*
  * OMAP2/3-common clockdomains
index 5f3aad9..6adb360 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -15,8 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include <mach/common.h>
-#include <mach/control.h>
+#include <plat/common.h>
+#include <plat/control.h>
 
 static void __iomem *omap2_ctrl_base;
 
index faf7a1e..7d4513b 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -20,12 +20,12 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
-#include <mach/control.h>
-#include <mach/tc.h>
-#include <mach/board.h>
-#include <mach/mux.h>
+#include <plat/control.h>
+#include <plat/tc.h>
+#include <plat/board.h>
+#include <plat/mux.h>
 #include <mach/gpio.h>
-#include <mach/mmc.h>
+#include <plat/mmc.h>
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
@@ -250,7 +250,7 @@ static inline void omap_init_sti(void) {}
 
 #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
 
-#include <mach/mcspi.h>
+#include <plat/mcspi.h>
 
 #define OMAP2_MCSPI1_BASE		0x48098000
 #define OMAP2_MCSPI2_BASE		0x4809a000
index 54fec53..7bb6922 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -17,9 +17,9 @@
 
 #include <asm/mach/flash.h>
 
-#include <mach/onenand.h>
-#include <mach/board.h>
-#include <mach/gpmc.h>
+#include <plat/onenand.h>
+#include <plat/board.h>
+#include <plat/gpmc.h>
 
 static struct omap_onenand_platform_data *gpmc_onenand_data;
 
index df99d31..6083e21 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -17,9 +17,9 @@
 #include <linux/io.h>
 #include <linux/smc91x.h>
 
-#include <mach/board.h>
-#include <mach/gpmc.h>
-#include <mach/gpmc-smc91x.h>
+#include <plat/board.h>
+#include <plat/gpmc.h>
+#include <plat/gpmc-smc91x.h>
 
 static struct omap_smc91x_platform_data *gpmc_cfg;
 
index 1587682..004da69 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -24,9 +24,9 @@
 #include <linux/module.h>
 
 #include <asm/mach-types.h>
-#include <mach/gpmc.h>
+#include <plat/gpmc.h>
 
-#include <mach/sdrc.h>
+#include <plat/sdrc.h>
 
 /* GPMC register offsets */
 #define GPMC_REVISION		0x00
index a98201c..d28e6fe 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -21,9 +21,9 @@
 
 #include <asm/cputype.h>
 
-#include <mach/common.h>
-#include <mach/control.h>
-#include <mach/cpu.h>
+#include <plat/common.h>
+#include <plat/control.h>
+#include <plat/cpu.h>
 
 static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
index aafa0f6..840ef5f 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -15,8 +15,8 @@
 #include <mach/irqs.h>
 #include <asm/hardware/gic.h>
 
-#include <mach/omap24xx.h>
-#include <mach/omap34xx.h>
+#include <plat/omap24xx.h>
+#include <plat/omap34xx.h>
 
 /* REVISIT: This should be set dynamically if CONFIG_MULTI_OMAP2 is selected */
 #if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430)
@@ -25,7 +25,7 @@
 #define OMAP2_VA_IC_BASE		OMAP2_IO_ADDRESS(OMAP34XX_IC_BASE)
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
-#include <mach/omap44xx.h>
+#include <plat/omap44xx.h>
 #endif
 #define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
 #define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
index e3a3bad..6c35bd2 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -27,24 +27,24 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/mux.h>
-#include <mach/omapfb.h>
-#include <mach/sram.h>
-#include <mach/sdrc.h>
-#include <mach/gpmc.h>
-#include <mach/serial.h>
+#include <plat/mux.h>
+#include <plat/omapfb.h>
+#include <plat/sram.h>
+#include <plat/sdrc.h>
+#include <plat/gpmc.h>
+#include <plat/serial.h>
 
 #ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready */
 #include "clock.h"
 
-#include <mach/omap-pm.h>
-#include <mach/powerdomain.h>
+#include <plat/omap-pm.h>
+#include <plat/powerdomain.h>
 #include "powerdomains.h"
 
-#include <mach/clockdomain.h>
+#include <plat/clockdomain.h>
 #include "clockdomains.h"
 #endif
-#include <mach/omap_hwmod.h>
+#include <plat/omap_hwmod.h>
 #include "omap_hwmod_2420.h"
 #include "omap_hwmod_2430.h"
 #include "omap_hwmod_34xx.h"
index 4a0e1cd..6f4b7cc 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/stringify.h>
 
-#include <mach/iommu.h>
+#include <plat/iommu.h>
 
 /*
  * omap2 architecture specific register bit definitions
index c035ad3..46e1f2e 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -15,7 +15,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <mach/mailbox.h>
+#include <plat/mailbox.h>
 #include <mach/irqs.h>
 
 #define MAILBOX_REVISION		0x000
index a846aa1..baa4517 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -18,10 +18,10 @@
 #include <linux/platform_device.h>
 
 #include <mach/irqs.h>
-#include <mach/dma.h>
-#include <mach/mux.h>
-#include <mach/cpu.h>
-#include <mach/mcbsp.h>
+#include <plat/dma.h>
+#include <plat/mux.h>
+#include <plat/cpu.h>
+#include <plat/mcbsp.h>
 
 static void omap2_mcbsp2_mux_setup(void)
 {
index c9c59a2..3403914 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -20,9 +20,9 @@
 #include <linux/regulator/consumer.h>
 
 #include <mach/hardware.h>
-#include <mach/control.h>
-#include <mach/mmc.h>
-#include <mach/board.h>
+#include <plat/control.h>
+#include <plat/mmc.h>
+#include <plat/board.h>
 
 #include "mmc-twl4030.h"
 
index b5fac32..32c953e 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -30,8 +30,8 @@
 
 #include <asm/system.h>
 
-#include <mach/control.h>
-#include <mach/mux.h>
+#include <plat/control.h>
+#include <plat/mux.h>
 
 #ifdef CONFIG_OMAP_MUX
 
index 194189c..6a9bf4f 100644
--- a/arch/arm/mach-omap2/omap3-iommu.c
+++ b/arch/arm/mach-omap2/omap3-iommu.c
@@ -12,7 +12,7 @@
 
 #include <linux/platform_device.h>
 
-#include <mach/iommu.h>
+#include <plat/iommu.h>
 
 #define OMAP3_MMU1_BASE	0x480bd400
 #define OMAP3_MMU2_BASE	0x5d000000
index d2e0f1c..196fd35 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -45,11 +45,11 @@
 #include <linux/mutex.h>
 #include <linux/bootmem.h>
 
-#include <mach/cpu.h>
-#include <mach/clockdomain.h>
-#include <mach/powerdomain.h>
-#include <mach/clock.h>
-#include <mach/omap_hwmod.h>
+#include <plat/cpu.h>
+#include <plat/clockdomain.h>
+#include <plat/powerdomain.h>
+#include <plat/clock.h>
+#include <plat/omap_hwmod.h>
 
 #include "cm.h"
 
index 767e496..a9ca1b9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420.h
+++ b/arch/arm/mach-omap2/omap_hwmod_2420.h
@@ -16,10 +16,10 @@
 
 #ifdef CONFIG_ARCH_OMAP2420
 
-#include <mach/omap_hwmod.h>
+#include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
-#include <mach/cpu.h>
-#include <mach/dma.h>
+#include <plat/cpu.h>
+#include <plat/dma.h>
 
 #include "prm-regbits-24xx.h"
 
index a412be6..59a208b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430.h
+++ b/arch/arm/mach-omap2/omap_hwmod_2430.h
@@ -16,10 +16,10 @@
 
 #ifdef CONFIG_ARCH_OMAP2430
 
-#include <mach/omap_hwmod.h>
+#include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
-#include <mach/cpu.h>
-#include <mach/dma.h>
+#include <plat/cpu.h>
+#include <plat/dma.h>
 
 #include "prm-regbits-24xx.h"
 
index 1e069f8..b6076b9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
+++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
@@ -14,10 +14,10 @@
 
 #ifdef CONFIG_ARCH_OMAP34XX
 
-#include <mach/omap_hwmod.h>
+#include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
-#include <mach/cpu.h>
-#include <mach/dma.h>
+#include <plat/cpu.h>
+#include <plat/dma.h>
 
 #include "prm-regbits-34xx.h"
 
index 2fc4d6a..4aa733d 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -26,10 +26,10 @@
 #include <linux/io.h>
 #include <linux/module.h>
 
-#include <mach/clock.h>
-#include <mach/board.h>
-#include <mach/powerdomain.h>
-#include <mach/clockdomain.h>
+#include <plat/clock.h>
+#include <plat/board.h>
+#include <plat/powerdomain.h>
+#include <plat/clockdomain.h>
 
 #include "prm.h"
 #include "cm.h"
index 8400f57..85b6fac 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -11,7 +11,7 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PM_H
 #define __ARCH_ARM_MACH_OMAP2_PM_H
 
-#include <mach/powerdomain.h>
+#include <plat/powerdomain.h>
 
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
index bff5c4e..cba05b9 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -36,12 +36,12 @@
 #include <asm/mach-types.h>
 
 #include <mach/irqs.h>
-#include <mach/clock.h>
-#include <mach/sram.h>
-#include <mach/control.h>
-#include <mach/mux.h>
-#include <mach/dma.h>
-#include <mach/board.h>
+#include <plat/clock.h>
+#include <plat/sram.h>
+#include <plat/control.h>
+#include <plat/mux.h>
+#include <plat/dma.h>
+#include <plat/board.h>
 
 #include "prm.h"
 #include "prm-regbits-24xx.h"
@@ -50,8 +50,8 @@
 #include "sdrc.h"
 #include "pm.h"
 
-#include <mach/powerdomain.h>
-#include <mach/clockdomain.h>
+#include <plat/powerdomain.h>
+#include <plat/clockdomain.h>
 
 static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctrl,
index 378c2f6..10aa923 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -23,11 +23,11 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 
-#include <mach/sram.h>
-#include <mach/clockdomain.h>
-#include <mach/powerdomain.h>
-#include <mach/control.h>
-#include <mach/serial.h>
+#include <plat/sram.h>
+#include <plat/clockdomain.h>
+#include <plat/powerdomain.h>
+#include <plat/control.h>
+#include <plat/serial.h>
 
 #include "cm.h"
 #include "cm-regbits-34xx.h"
index f00289a..b6990e3 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -31,9 +31,9 @@
 #include "prm.h"
 #include "prm-regbits-34xx.h"
 
-#include <mach/cpu.h>
-#include <mach/powerdomain.h>
-#include <mach/clockdomain.h>
+#include <plat/cpu.h>
+#include <plat/powerdomain.h>
+#include <plat/clockdomain.h>
 
 #include "pm.h"
 
index 691470e..057b2e3 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -63,7 +63,7 @@
  * XXX encode hardware fixed wakeup dependencies -- esp. for 3430 CORE
  */
 
-#include <mach/powerdomain.h>
+#include <plat/powerdomain.h>
 
 #include "prcm-common.h"
 #include "prm.h"
index 9f08dc3..bd249a4 100644
--- a/arch/arm/mach-omap2/powerdomains24xx.h
+++ b/arch/arm/mach-omap2/powerdomains24xx.h
@@ -20,7 +20,7 @@
  * the array in mach-omap2/powerdomains.h.
  */
 
-#include <mach/powerdomain.h>
+#include <plat/powerdomain.h>
 
 #include "prcm-common.h"
 #include "prm.h"
index 4dcf94b..f70eb2d 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -20,7 +20,7 @@
  * the array in mach-omap2/powerdomains.h.
  */
 
-#include <mach/powerdomain.h>
+#include <plat/powerdomain.h>
 
 #include "prcm-common.h"
 #include "prm.h"
index ced555a..b0d3ad0 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -19,8 +19,8 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 
-#include <mach/common.h>
-#include <mach/prcm.h>
+#include <plat/common.h>
+#include <plat/prcm.h>
 
 #include "clock.h"
 #include "prm.h"
index 02e1c2d..a391b49 100644
--- a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
+++ b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
@@ -14,7 +14,7 @@
 #ifndef ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H32M32LF
 #define ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H32M32LF
 
-#include <mach/sdrc.h>
+#include <plat/sdrc.h>
 
 /* Micron MT46H32M32LF-6 */
 /* XXX Using ARE = 0x1 (no autorefresh burst) -- can this be changed? */
index 3751d29..0e518a7 100644
--- a/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
+++ b/arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
@@ -14,7 +14,7 @@
 #ifndef ARCH_ARM_MACH_OMAP2_SDRAM_QIMONDA_HYB18M512160AF6
 #define ARCH_ARM_MACH_OMAP2_SDRAM_QIMONDA_HYB18M512160AF6
 
-#include <mach/sdrc.h>
+#include <plat/sdrc.h>
 
 /* Qimonda HYB18M512160AF-6 */
 static struct omap_sdrc_params hyb18m512160af6_sdrc_params[] = {
index 9e3bd4f..07000de 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -23,13 +23,13 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <mach/common.h>
-#include <mach/clock.h>
-#include <mach/sram.h>
+#include <plat/common.h>
+#include <plat/clock.h>
+#include <plat/sram.h>
 
 #include "prm.h"
 
-#include <mach/sdrc.h>
+#include <plat/sdrc.h>
 #include "sdrc.h"
 
 static struct omap_sdrc_params *sdrc_init_params_cs0, *sdrc_init_params_cs1;
index 0837eda..7ff0c03 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -15,7 +15,7 @@
  */
 #undef DEBUG
 
-#include <mach/sdrc.h>
+#include <plat/sdrc.h>
 
 #ifndef __ASSEMBLER__
 extern void __iomem *omap2_sdrc_base;
index feaec7e..0f4d27a 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -24,13 +24,13 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <mach/common.h>
-#include <mach/clock.h>
-#include <mach/sram.h>
+#include <plat/common.h>
+#include <plat/clock.h>
+#include <plat/sram.h>
 
 #include "prm.h"
 #include "clock.h"
-#include <mach/sdrc.h>
+#include <plat/sdrc.h>
 #include "sdrc.h"
 
 /* Memory timing, DLL mode flags */
index ae21868..af5d483 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -24,10 +24,10 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <mach/common.h>
-#include <mach/board.h>
-#include <mach/clock.h>
-#include <mach/control.h>
+#include <plat/common.h>
+#include <plat/board.h>
+#include <plat/clock.h>
+#include <plat/control.h>
 
 #include "prm.h"
 #include "pm.h"
index 130aadb..c7780cc 100644
--- a/arch/arm/mach-omap2/sleep24xx.S
+++ b/arch/arm/mach-omap2/sleep24xx.S
@@ -29,7 +29,7 @@
 #include <asm/assembler.h>
 #include <mach/io.h>
 
-#include <mach/omap24xx.h>
+#include <plat/omap24xx.h>
 
 #include "sdrc.h"
 
index e5e2553..6a749f2 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -27,7 +27,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <mach/io.h>
-#include <mach/control.h>
+#include <plat/control.h>
 
 #include "prm.h"
 #include "sdrc.h"
index e2338c0..691f65c 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -37,7 +37,7 @@
 #include <linux/clockchips.h>
 
 #include <asm/mach/time.h>
-#include <mach/dmtimer.h>
+#include <plat/dmtimer.h>
 #include <asm/localtimer.h>
 
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
index 1145a25..a80441d 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -28,8 +28,8 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
 
 #ifdef CONFIG_USB_MUSB_SOC
 
index 8622c24..10a2013 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -16,8 +16,8 @@
 
 #include <linux/usb/musb.h>
 
-#include <mach/gpmc.h>
-#include <mach/mux.h>
+#include <plat/gpmc.h>
+#include <plat/mux.h>
 
 
 static u8		async_cs, sync_cs;
index bf880e9..681bfc3 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -24,7 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/io.h>
 
-#include <mach/clock.h>
+#include <plat/clock.h>
 
 static LIST_HEAD(clocks);
 static DEFINE_MUTEX(clocks_mutex);
index 3a4768d..f54895a 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -29,13 +29,13 @@
 #include <asm/mach/map.h>
 #include <asm/setup.h>
 
-#include <mach/common.h>
-#include <mach/board.h>
-#include <mach/control.h>
-#include <mach/mux.h>
-#include <mach/fpga.h>
+#include <plat/common.h>
+#include <plat/board.h>
+#include <plat/control.h>
+#include <plat/mux.h>
+#include <plat/fpga.h>
 
-#include <mach/clock.h>
+#include <plat/clock.h>
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 # include "../mach-omap2/sdrc.h"
index 1868c0d..4e85389 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -23,7 +23,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <mach/clock.h>
+#include <plat/clock.h>
 #include <asm/system.h>
 
 #define VERY_HI_RATE	900000000
index f668483..09c1107 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -16,7 +16,7 @@
 
 #include <mach/hardware.h>
 
-#include <mach/board.h>
+#include <plat/board.h>
 #include <mach/gpio.h>
 
 
index 9395898..6c768b7 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -18,7 +18,7 @@
 #include <asm/system.h>
 #include <asm/mach-types.h>
 
-#include <mach/fpga.h>
+#include <plat/fpga.h>
 #include <mach/gpio.h>
 
 
index a64b692..3a2651f 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -19,15 +19,15 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
-#include <mach/tc.h>
-#include <mach/control.h>
-#include <mach/board.h>
-#include <mach/mmc.h>
-#include <mach/mux.h>
+#include <plat/tc.h>
+#include <plat/control.h>
+#include <plat/board.h>
+#include <plat/mmc.h>
+#include <plat/mux.h>
 #include <mach/gpio.h>
-#include <mach/menelaus.h>
-#include <mach/mcbsp.h>
-#include <mach/dsp_common.h>
+#include <plat/menelaus.h>
+#include <plat/mcbsp.h>
+#include <plat/dsp_common.h>
 
 #if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 
index fd3154a..2e86b29 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -32,9 +32,9 @@
 
 #include <asm/system.h>
 #include <mach/hardware.h>
-#include <mach/dma.h>
+#include <plat/dma.h>
 
-#include <mach/tc.h>
+#include <plat/tc.h>
 
 #undef DEBUG
 
index d325b54..026963b 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -38,7 +38,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <mach/hardware.h>
-#include <mach/dmtimer.h>
+#include <plat/dmtimer.h>
 #include <mach/irqs.h>
 
 /* register offsets */
index 3746222..78a4ce5 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -32,9 +32,9 @@
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
 
-#include <mach/board.h>
-#include <mach/sram.h>
-#include <mach/omapfb.h>
+#include <plat/board.h>
+#include <plat/sram.h>
+#include <plat/omapfb.h>
 
 #if defined(CONFIG_FB_OMAP) || defined(CONFIG_FB_OMAP_MODULE)
 
index 8b84839..c08362d 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -27,7 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <mach/irqs.h>
-#include <mach/mux.h>
+#include <plat/mux.h>
 
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
similarity index 100%
rename from arch/arm/plat-omap/include/mach/blizzard.h
rename to arch/arm/plat-omap/include/plat/blizzard.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/board-ams-delta.h
rename to arch/arm/plat-omap/include/plat/board-ams-delta.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/board-sx1.h
rename to arch/arm/plat-omap/include/plat/board-sx1.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/board-voiceblue.h
rename to arch/arm/plat-omap/include/plat/board-voiceblue.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/board.h
rename to arch/arm/plat-omap/include/plat/board.h
index 8e913c3..c4fc69f 100644
--- a/arch/arm/plat-omap/include/mach/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -12,7 +12,7 @@
 
 #include <linux/types.h>
 
-#include <mach/gpio-switch.h>
+#include <plat/gpio-switch.h>
 
 /* Different peripheral ids */
 #define OMAP_TAG_CLOCK		0x4f01
similarity index 100%
rename from arch/arm/plat-omap/include/mach/clock.h
rename to arch/arm/plat-omap/include/plat/clock.h
similarity index 97%
rename from arch/arm/plat-omap/include/mach/clockdomain.h
rename to arch/arm/plat-omap/include/plat/clockdomain.h
index 99ebd88..eb73482 100644
--- a/arch/arm/plat-omap/include/mach/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -16,9 +16,9 @@
 #ifndef __ASM_ARM_ARCH_OMAP_CLOCKDOMAIN_H
 #define __ASM_ARM_ARCH_OMAP_CLOCKDOMAIN_H
 
-#include <mach/powerdomain.h>
-#include <mach/clock.h>
-#include <mach/cpu.h>
+#include <plat/powerdomain.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
 
 /* Clockdomain capability flags */
 #define CLKDM_CAN_FORCE_SLEEP			(1 << 0)
similarity index 100%
rename from arch/arm/plat-omap/include/mach/common.h
rename to arch/arm/plat-omap/include/plat/common.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/control.h
rename to arch/arm/plat-omap/include/plat/control.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/cpu.h
rename to arch/arm/plat-omap/include/plat/cpu.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/dma.h
rename to arch/arm/plat-omap/include/plat/dma.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/dmtimer.h
rename to arch/arm/plat-omap/include/plat/dmtimer.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/dsp_common.h
rename to arch/arm/plat-omap/include/plat/dsp_common.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/fpga.h
rename to arch/arm/plat-omap/include/plat/fpga.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/gpio-switch.h
rename to arch/arm/plat-omap/include/plat/gpio-switch.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/gpmc-smc91x.h
rename to arch/arm/plat-omap/include/plat/gpmc-smc91x.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/gpmc.h
rename to arch/arm/plat-omap/include/plat/gpmc.h
index f746c9d..1ef342a 100644
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ b/arch/arm/plat-omap/include/plat/hardware.h
@@ -39,9 +39,9 @@
 #include <asm/sizes.h>
 #ifndef __ASSEMBLER__
 #include <asm/types.h>
-#include <mach/cpu.h>
+#include <plat/cpu.h>
 #endif
-#include <mach/serial.h>
+#include <plat/serial.h>
 
 /*
  * ---------------------------------------------------------------------------
@@ -280,11 +280,11 @@
  * ---------------------------------------------------------------------------
  */
 
-#include <mach/omap730.h>
-#include <mach/omap1510.h>
-#include <mach/omap16xx.h>
-#include <mach/omap24xx.h>
-#include <mach/omap34xx.h>
-#include <mach/omap44xx.h>
+#include <plat/omap730.h>
+#include <plat/omap1510.h>
+#include <plat/omap16xx.h>
+#include <plat/omap24xx.h>
+#include <plat/omap34xx.h>
+#include <plat/omap44xx.h>
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
similarity index 100%
rename from arch/arm/plat-omap/include/mach/hwa742.h
rename to arch/arm/plat-omap/include/plat/hwa742.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/iommu.h
rename to arch/arm/plat-omap/include/plat/iommu.h
index 46d41ac..0752af9 100644
--- a/arch/arm/plat-omap/include/mach/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -107,7 +107,7 @@ struct iommu_platform_data {
 #if defined(CONFIG_ARCH_OMAP1)
 #error "iommu for this processor not implemented yet"
 #else
-#include <mach/iommu2.h>
+#include <plat/iommu2.h>
 #endif
 
 /*
similarity index 100%
rename from arch/arm/plat-omap/include/mach/iommu2.h
rename to arch/arm/plat-omap/include/plat/iommu2.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/iovmm.h
rename to arch/arm/plat-omap/include/plat/iovmm.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/irda.h
rename to arch/arm/plat-omap/include/plat/irda.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/keypad.h
rename to arch/arm/plat-omap/include/plat/keypad.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/lcd_mipid.h
rename to arch/arm/plat-omap/include/plat/lcd_mipid.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/led.h
rename to arch/arm/plat-omap/include/plat/led.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/mailbox.h
rename to arch/arm/plat-omap/include/plat/mailbox.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/mcbsp.h
rename to arch/arm/plat-omap/include/plat/mcbsp.h
index e0d6eca..06b1b96 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -28,7 +28,7 @@
 #include <linux/spinlock.h>
 
 #include <mach/hardware.h>
-#include <mach/clock.h>
+#include <plat/clock.h>
 
 #define OMAP730_MCBSP1_BASE	0xfffb1000
 #define OMAP730_MCBSP2_BASE	0xfffb1800
similarity index 100%
rename from arch/arm/plat-omap/include/mach/mcspi.h
rename to arch/arm/plat-omap/include/plat/mcspi.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/menelaus.h
rename to arch/arm/plat-omap/include/plat/menelaus.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/mmc.h
rename to arch/arm/plat-omap/include/plat/mmc.h
index 7229b95..2993713 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -15,7 +15,7 @@
 #include <linux/device.h>
 #include <linux/mmc/host.h>
 
-#include <mach/board.h>
+#include <plat/board.h>
 
 #define OMAP15XX_NR_MMC		1
 #define OMAP16XX_NR_MMC		2
similarity index 100%
rename from arch/arm/plat-omap/include/mach/mux.h
rename to arch/arm/plat-omap/include/plat/mux.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/nand.h
rename to arch/arm/plat-omap/include/plat/nand.h
similarity index 98%
rename from arch/arm/plat-omap/include/mach/omap-alsa.h
rename to arch/arm/plat-omap/include/plat/omap-alsa.h
index bdf30a0..b53055b 100644
--- a/arch/arm/plat-omap/include/mach/omap-alsa.h
+++ b/arch/arm/plat-omap/include/plat/omap-alsa.h
@@ -40,10 +40,10 @@
 #ifndef __OMAP_ALSA_H
 #define __OMAP_ALSA_H
 
-#include <mach/dma.h>
+#include <plat/dma.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
-#include <mach/mcbsp.h>
+#include <plat/mcbsp.h>
 #include <linux/platform_device.h>
 
 #define DMA_BUF_SIZE	(1024 * 8)
similarity index 100%
rename from arch/arm/plat-omap/include/mach/omap-pm.h
rename to arch/arm/plat-omap/include/plat/omap-pm.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/omap1510.h
rename to arch/arm/plat-omap/include/plat/omap1510.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/omap16xx.h
rename to arch/arm/plat-omap/include/plat/omap16xx.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/omap24xx.h
rename to arch/arm/plat-omap/include/plat/omap24xx.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/omap34xx.h
rename to arch/arm/plat-omap/include/plat/omap34xx.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/omap44xx.h
rename to arch/arm/plat-omap/include/plat/omap44xx.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/omap730.h
rename to arch/arm/plat-omap/include/plat/omap730.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/omap850.h
rename to arch/arm/plat-omap/include/plat/omap850.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/omap_device.h
rename to arch/arm/plat-omap/include/plat/omap_device.h
index bd0e136..11a9773 100644
--- a/arch/arm/plat-omap/include/mach/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -34,7 +34,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
-#include <mach/omap_hwmod.h>
+#include <plat/omap_hwmod.h>
 
 /* omap_device._state values */
 #define OMAP_DEVICE_STATE_UNKNOWN	0
similarity index 99%
rename from arch/arm/plat-omap/include/mach/omap_hwmod.h
rename to arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1f79c20..dbdd123 100644
--- a/arch/arm/plat-omap/include/mach/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -35,7 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 
-#include <mach/cpu.h>
+#include <plat/cpu.h>
 
 struct omap_device;
 
similarity index 99%
rename from arch/arm/plat-omap/include/mach/omapfb.h
rename to arch/arm/plat-omap/include/plat/omapfb.h
index b226bdf..bfef7ab 100644
--- a/arch/arm/plat-omap/include/mach/omapfb.h
+++ b/arch/arm/plat-omap/include/plat/omapfb.h
@@ -168,7 +168,7 @@ enum omapfb_update_mode {
 #include <linux/fb.h>
 #include <linux/mutex.h>
 
-#include <mach/board.h>
+#include <plat/board.h>
 
 #define OMAP_LCDC_INV_VSYNC             0x0001
 #define OMAP_LCDC_INV_HSYNC             0x0002
similarity index 100%
rename from arch/arm/plat-omap/include/mach/onenand.h
rename to arch/arm/plat-omap/include/plat/onenand.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/param.h
rename to arch/arm/plat-omap/include/plat/param.h
similarity index 99%
rename from arch/arm/plat-omap/include/mach/powerdomain.h
rename to arch/arm/plat-omap/include/plat/powerdomain.h
index fa64614..3d45ee1 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -19,7 +19,7 @@
 
 #include <asm/atomic.h>
 
-#include <mach/cpu.h>
+#include <plat/cpu.h>
 
 
 /* Powerdomain basic power states */
similarity index 100%
rename from arch/arm/plat-omap/include/mach/prcm.h
rename to arch/arm/plat-omap/include/plat/prcm.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/sdrc.h
rename to arch/arm/plat-omap/include/plat/sdrc.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/serial.h
rename to arch/arm/plat-omap/include/plat/serial.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/sram.h
rename to arch/arm/plat-omap/include/plat/sram.h
index ed8ec74..c58a4ef 100644
--- a/arch/arm/plat-omap/include/plat/system.h
+++ b/arch/arm/plat-omap/include/plat/system.h
@@ -9,7 +9,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 
-#include <mach/prcm.h>
+#include <plat/prcm.h>
 
 #ifndef CONFIG_MACH_VOICEBLUE
 #define voiceblue_reset()		do {} while (0)
similarity index 100%
rename from arch/arm/plat-omap/include/mach/tc.h
rename to arch/arm/plat-omap/include/plat/tc.h
similarity index 100%
rename from arch/arm/plat-omap/include/mach/timer-gp.h
rename to arch/arm/plat-omap/include/plat/timer-gp.h
index 0814c5f..2214fbb 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -19,7 +19,7 @@
 
 #include <linux/types.h>
 #include <linux/serial_reg.h>
-#include <mach/serial.h>
+#include <plat/serial.h>
 
 unsigned int system_rev;
 
similarity index 99%
rename from arch/arm/plat-omap/include/mach/usb.h
rename to arch/arm/plat-omap/include/plat/usb.h
index f337e17..33e72ca 100644
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -3,7 +3,7 @@
 #ifndef	__ASM_ARCH_OMAP_USB_H
 #define	__ASM_ARCH_OMAP_USB_H
 
-#include <mach/board.h>
+#include <plat/board.h>
 
 /*-------------------------------------------------------------------------*/
 
index b6defa2..ed1217e 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -13,12 +13,12 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 
-#include <mach/omap730.h>
-#include <mach/omap1510.h>
-#include <mach/omap16xx.h>
-#include <mach/omap24xx.h>
-#include <mach/omap34xx.h>
-#include <mach/omap44xx.h>
+#include <plat/omap730.h>
+#include <plat/omap1510.h>
+#include <plat/omap16xx.h>
+#include <plat/omap24xx.h>
+#include <plat/omap34xx.h>
+#include <plat/omap44xx.h>
 
 #define BETWEEN(p,st,sz)	((p) >= (st) && (p) < ((st) + (sz)))
 #define XLATE(p,pst,vst)	((void __iomem *)((p) - (pst) + (vst)))
index c799b3b..afd1c27 100644
--- a/arch/arm/plat-omap/iommu-debug.c
+++ b/arch/arm/plat-omap/iommu-debug.c
@@ -17,8 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/debugfs.h>
 
-#include <mach/iommu.h>
-#include <mach/iovmm.h>
+#include <plat/iommu.h>
+#include <plat/iovmm.h>
 
 #include "iopgtable.h"
 
index 4b60127..aa84729 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -20,7 +20,7 @@
 
 #include <asm/cacheflush.h>
 
-#include <mach/iommu.h>
+#include <plat/iommu.h>
 
 #include "iopgtable.h"
 
index dc3fac3..0ce36bb 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -18,8 +18,8 @@
 #include <asm/cacheflush.h>
 #include <asm/mach/map.h>
 
-#include <mach/iommu.h>
-#include <mach/iovmm.h>
+#include <plat/iommu.h>
+#include <plat/iovmm.h>
 
 #include "iopgtable.h"
 
index 40424ed..734bff3 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -26,7 +26,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 
-#include <mach/mailbox.h>
+#include <plat/mailbox.h>
 
 static int enable_seq_bit;
 module_param(enable_seq_bit, bool, 0);
index 88ac976..041e6ed 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -24,8 +24,8 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 
-#include <mach/dma.h>
-#include <mach/mcbsp.h>
+#include <plat/dma.h>
+#include <plat/mcbsp.h>
 
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count;
index 8d329fb..05aebca 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -28,7 +28,7 @@
 #include <linux/io.h>
 #include <asm/system.h>
 #include <linux/spinlock.h>
-#include <mach/mux.h>
+#include <plat/mux.h>
 
 #ifdef CONFIG_OMAP_MUX
 
index e98f0a2..186bca8 100644
--- a/arch/arm/plat-omap/omap-pm-noop.c
+++ b/arch/arm/plat-omap/omap-pm-noop.c
@@ -22,9 +22,9 @@
 #include <linux/device.h>
 
 /* Interface documentation is in mach/omap-pm.h */
-#include <mach/omap-pm.h>
+#include <plat/omap-pm.h>
 
-#include <mach/powerdomain.h>
+#include <plat/powerdomain.h>
 
 struct omap_opp *dsp_opps;
 struct omap_opp *mpu_opps;
index 2c409fc..d852439 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -82,8 +82,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <mach/omap_device.h>
-#include <mach/omap_hwmod.h>
+#include <plat/omap_device.h>
+#include <plat/omap_hwmod.h>
 
 /* These parameters are passed to _omap_device_{de,}activate() */
 #define USE_WAKEUP_LAT			0
index 75d1f26..94f6ad4 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -25,11 +25,11 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/sram.h>
-#include <mach/board.h>
-#include <mach/cpu.h>
+#include <plat/sram.h>
+#include <plat/board.h>
+#include <plat/cpu.h>
 
-#include <mach/control.h>
+#include <plat/control.h>
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 # include "../mach-omap2/prm.h"
index 509f2ed..79ca9ec 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -33,10 +33,10 @@
 #include <asm/system.h>
 #include <mach/hardware.h>
 
-#include <mach/control.h>
-#include <mach/mux.h>
-#include <mach/usb.h>
-#include <mach/board.h>
+#include <plat/control.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+#include <plat/board.h>
 
 #ifdef CONFIG_ARCH_OMAP1
 
index bba85ad..1a494d5 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -35,12 +35,12 @@
 #include <linux/mutex.h>
 #include <linux/errno.h>
 #include <mach/gpio.h>
-#include <mach/keypad.h>
-#include <mach/menelaus.h>
+#include <plat/keypad.h>
+#include <plat/menelaus.h>
 #include <asm/irq.h>
 #include <mach/hardware.h>
 #include <asm/io.h>
-#include <mach/mux.h>
+#include <plat/mux.h>
 
 #undef NEW_BOARD_LEARNING_MODE
 
index 4460507..b982603 100644
--- a/drivers/leds/leds-ams-delta.c
+++ b/drivers/leds/leds-ams-delta.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
-#include <mach/board-ams-delta.h>
+#include <plat/board-ams-delta.h>
 
 /*
  * Our context
index 4b364ba..970afa1 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -44,7 +44,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/gpio.h>
-#include <mach/menelaus.h>
+#include <plat/menelaus.h>
 
 #define DRIVER_NAME			"menelaus"
 
index e424cf6..3bb12b5 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -39,7 +39,7 @@
 #include <linux/i2c/twl4030.h>
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-#include <mach/cpu.h>
+#include <plat/cpu.h>
 #endif
 
 /*
index e7a331d..5d773b8 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -30,12 +30,12 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include <mach/board.h>
-#include <mach/mmc.h>
+#include <plat/board.h>
+#include <plat/mmc.h>
 #include <mach/gpio.h>
-#include <mach/dma.h>
-#include <mach/mux.h>
-#include <mach/fpga.h>
+#include <plat/dma.h>
+#include <plat/mux.h>
+#include <plat/fpga.h>
 
 #define	OMAP_MMC_REG_CMD	0x00
 #define	OMAP_MMC_REG_ARGL	0x04
index 4487cc0..c8f3e02 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -30,11 +30,11 @@
 #include <linux/mmc/core.h>
 #include <linux/io.h>
 #include <linux/semaphore.h>
-#include <mach/dma.h>
+#include <plat/dma.h>
 #include <mach/hardware.h>
-#include <mach/board.h>
-#include <mach/mmc.h>
-#include <mach/cpu.h>
+#include <plat/board.h>
+#include <plat/mmc.h>
+#include <plat/cpu.h>
 
 /* OMAP HSMMC Host Controller Registers */
 #define OMAP_HSMMC_SYSCONFIG	0x0010
index a244781..ead0b2f 100644
--- a/drivers/mtd/maps/omap_nor.c
+++ b/drivers/mtd/maps/omap_nor.c
@@ -45,7 +45,7 @@
 #include <asm/io.h>
 #include <mach/hardware.h>
 #include <asm/mach/flash.h>
-#include <mach/tc.h>
+#include <plat/tc.h>
 
 #ifdef CONFIG_MTD_PARTITIONS
 static const char *part_probes[] = { /* "RedBoot", */ "cmdlinepart", NULL };
index 005b91f..2548e10 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -25,7 +25,7 @@
 #include <mach/hardware.h>
 #include <asm/sizes.h>
 #include <mach/gpio.h>
-#include <mach/board-ams-delta.h>
+#include <plat/board-ams-delta.h>
 
 /*
  * MTD structure for E3 (Delta)
index 090ab87..1bb799f 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -18,9 +18,9 @@
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
 
-#include <mach/dma.h>
-#include <mach/gpmc.h>
-#include <mach/nand.h>
+#include <plat/dma.h>
+#include <plat/gpmc.h>
+#include <plat/nand.h>
 
 #define GPMC_IRQ_STATUS		0x18
 #define GPMC_ECC_CONFIG		0x1F4
index 0108ed4..86c4f6d 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -36,13 +36,13 @@
 #include <linux/io.h>
 
 #include <asm/mach/flash.h>
-#include <mach/gpmc.h>
-#include <mach/onenand.h>
+#include <plat/gpmc.h>
+#include <plat/onenand.h>
 #include <mach/gpio.h>
 
-#include <mach/dma.h>
+#include <plat/dma.h>
 
-#include <mach/board.h>
+#include <plat/board.h>
 
 #define DRIVER_NAME "omap2-onenand"
 
index 68570bc..663781d 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -23,8 +23,8 @@
 #include <asm/io.h>
 #include <asm/sizes.h>
 
-#include <mach/mux.h>
-#include <mach/tc.h>
+#include <plat/mux.h>
+#include <plat/tc.h>
 
 
 /* NOTE:  don't expect this to support many I/O cards.  The 16xx chips have
index ba1a872..bf5f95a 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -35,8 +35,8 @@
 
 #include <linux/spi/spi.h>
 
-#include <mach/dma.h>
-#include <mach/clock.h>
+#include <plat/dma.h>
+#include <plat/clock.h>
 
 
 #define OMAP2_MCSPI_MAX_FREQ		48000000
index e75ba9b..6ef2153 100644
--- a/drivers/spi/omap_uwire.c
+++ b/drivers/spi/omap_uwire.c
@@ -51,8 +51,8 @@
 #include <asm/io.h>
 #include <asm/mach-types.h>
 
-#include <mach/mux.h>
-#include <mach/omap730.h>	/* OMAP730_IO_CONF registers */
+#include <plat/mux.h>
+#include <plat/omap730.h>	/* OMAP730_IO_CONF registers */
 
 
 /* FIXME address is now a platform device resource,
index a2db0e1..b836efe 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -52,9 +52,9 @@
 #include <asm/unaligned.h>
 #include <asm/mach-types.h>
 
-#include <mach/dma.h>
-#include <mach/usb.h>
-#include <mach/control.h>
+#include <plat/dma.h>
+#include <plat/usb.h>
+#include <plat/control.h>
 
 #include "omap_udc.h"
 
index 83cbecd..5645f70 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -24,10 +24,10 @@
 #include <asm/io.h>
 #include <asm/mach-types.h>
 
-#include <mach/mux.h>
+#include <plat/mux.h>
 #include <mach/irqs.h>
-#include <mach/fpga.h>
-#include <mach/usb.h>
+#include <plat/fpga.h>
+#include <plat/usb.h>
 
 
 /* OMAP-1510 OHCI has its own MMU for DMA */
index 3487520..6761d20 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -35,7 +35,7 @@
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
-#include <mach/mux.h>
+#include <plat/mux.h>
 
 #include "musb_core.h"
 #include "omap2430.h"
index dc76707..fbede77 100644
--- a/drivers/usb/musb/omap2430.h
+++ b/drivers/usb/musb/omap2430.h
@@ -12,7 +12,7 @@
 
 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
 #include <mach/hardware.h>
-#include <mach/usb.h>
+#include <plat/usb.h>
 
 /*
  * OMAP2430-specific definitions
index 7e073a0..e13c770 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -15,8 +15,8 @@
 #include <linux/usb.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <mach/dma.h>
-#include <mach/mux.h>
+#include <plat/dma.h>
+#include <plat/mux.h>
 
 #include "musb_core.h"
 
index 77a5f41..d54460a 100644
--- a/drivers/usb/otg/isp1301_omap.c
+++ b/drivers/usb/otg/isp1301_omap.c
@@ -36,8 +36,8 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/usb.h>
-#include <mach/mux.h>
+#include <plat/usb.h>
+#include <plat/mux.h>
 
 
 #ifndef	DEBUG
index cbad67e..8693e5f 100644
--- a/drivers/video/backlight/omap1_bl.c
+++ b/drivers/video/backlight/omap1_bl.c
@@ -26,8 +26,8 @@
 #include <linux/backlight.h>
 
 #include <mach/hardware.h>
-#include <mach/board.h>
-#include <mach/mux.h>
+#include <plat/board.h>
+#include <plat/mux.h>
 
 #define OMAPBL_MAX_INTENSITY		0xff
 
index 70dadf9..f5d75f2 100644
--- a/drivers/video/omap/blizzard.c
+++ b/drivers/video/omap/blizzard.c
@@ -26,9 +26,9 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 
-#include <mach/dma.h>
-#include <mach/omapfb.h>
-#include <mach/blizzard.h>
+#include <plat/dma.h>
+#include <plat/omapfb.h>
+#include <plat/blizzard.h>
 
 #include "dispc.h"
 
index f16e421..41bf7ff 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -25,9 +25,9 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <mach/sram.h>
-#include <mach/omapfb.h>
-#include <mach/board.h>
+#include <plat/sram.h>
+#include <plat/omapfb.h>
+#include <plat/board.h>
 
 #include "dispc.h"
 
index ca51583..17a975e 100644
--- a/drivers/video/omap/hwa742.c
+++ b/drivers/video/omap/hwa742.c
@@ -26,9 +26,9 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 
-#include <mach/dma.h>
-#include <mach/omapfb.h>
-#include <mach/hwa742.h>
+#include <plat/dma.h>
+#include <plat/omapfb.h>
+#include <plat/hwa742.h>
 
 #define HWA742_REV_CODE_REG       0x0
 #define HWA742_CONFIG_REG         0x2
index 393712b..fea7fee 100644
--- a/drivers/video/omap/lcd_2430sdp.c
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -27,8 +27,8 @@
 #include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
 
-#include <mach/mux.h>
-#include <mach/omapfb.h>
+#include <plat/mux.h>
+#include <plat/omapfb.h>
 #include <asm/mach-types.h>
 
 #define SDP2430_LCD_PANEL_BACKLIGHT_GPIO	91
index 1f74399..3d52772 100644
--- a/drivers/video/omap/lcd_ams_delta.c
+++ b/drivers/video/omap/lcd_ams_delta.c
@@ -25,9 +25,9 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 
-#include <mach/board-ams-delta.h>
+#include <plat/board-ams-delta.h>
 #include <mach/hardware.h>
-#include <mach/omapfb.h>
+#include <plat/omapfb.h>
 
 #define AMS_DELTA_DEFAULT_CONTRAST	112
 
index 626ae3a..4c5cefc 100644
--- a/drivers/video/omap/lcd_apollon.c
+++ b/drivers/video/omap/lcd_apollon.c
@@ -25,8 +25,8 @@
 #include <linux/platform_device.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/omapfb.h>
+#include <plat/mux.h>
+#include <plat/omapfb.h>
 
 /* #define USE_35INCH_LCD 1 */
 
index 417ae5e..240b4fb 100644
--- a/drivers/video/omap/lcd_h3.c
+++ b/drivers/video/omap/lcd_h3.c
@@ -24,7 +24,7 @@
 #include <linux/i2c/tps65010.h>
 
 #include <mach/gpio.h>
-#include <mach/omapfb.h>
+#include <plat/omapfb.h>
 
 #define MODULE_NAME	"omapfb-lcd_h3"
 
index 0c398bd..720625d 100644
--- a/drivers/video/omap/lcd_h4.c
+++ b/drivers/video/omap/lcd_h4.c
@@ -22,7 +22,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include <mach/omapfb.h>
+#include <plat/omapfb.h>
 
 static int h4_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)
 {
index cdbd8bb..aafe9b4 100644
--- a/drivers/video/omap/lcd_inn1510.c
+++ b/drivers/video/omap/lcd_inn1510.c
@@ -23,8 +23,8 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <mach/fpga.h>
-#include <mach/omapfb.h>
+#include <plat/fpga.h>
+#include <plat/omapfb.h>
 
 static int innovator1510_panel_init(struct lcd_panel *panel,
 				    struct omapfb_device *fbdev)
index 268f7f8..0de3382 100644
--- a/drivers/video/omap/lcd_inn1610.c
+++ b/drivers/video/omap/lcd_inn1610.c
@@ -23,7 +23,7 @@
 #include <linux/platform_device.h>
 
 #include <mach/gpio.h>
-#include <mach/omapfb.h>
+#include <plat/omapfb.h>
 
 #define MODULE_NAME	"omapfb-lcd_h3"
 
index dbfe897..6a260df 100644
--- a/drivers/video/omap/lcd_ldp.c
+++ b/drivers/video/omap/lcd_ldp.c
@@ -27,8 +27,8 @@
 #include <linux/i2c/twl4030.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/omapfb.h>
+#include <plat/mux.h>
+#include <plat/omapfb.h>
 #include <asm/mach-types.h>
 
 #define LCD_PANEL_BACKLIGHT_GPIO	(15 + OMAP_MAX_GPIO_LINES)
index 918ee89..2162eb0 100644
--- a/drivers/video/omap/lcd_mipid.c
+++ b/drivers/video/omap/lcd_mipid.c
@@ -23,8 +23,8 @@
 #include <linux/workqueue.h>
 #include <linux/spi/spi.h>
 
-#include <mach/omapfb.h>
-#include <mach/lcd_mipid.h>
+#include <plat/omapfb.h>
+#include <plat/lcd_mipid.h>
 
 #define MIPID_MODULE_NAME		"lcd_mipid"
 
index 7a2bbe2..e1a38ab 100644
--- a/drivers/video/omap/lcd_omap2evm.c
+++ b/drivers/video/omap/lcd_omap2evm.c
@@ -26,8 +26,8 @@
 #include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
 
-#include <mach/mux.h>
-#include <mach/omapfb.h>
+#include <plat/mux.h>
+#include <plat/omapfb.h>
 #include <asm/mach-types.h>
 
 #define LCD_PANEL_ENABLE_GPIO	154
index 4011910..ccec084 100644
--- a/drivers/video/omap/lcd_omap3beagle.c
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -25,8 +25,8 @@
 #include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
 
-#include <mach/mux.h>
-#include <mach/omapfb.h>
+#include <plat/mux.h>
+#include <plat/omapfb.h>
 #include <asm/mach-types.h>
 
 #define LCD_PANEL_ENABLE_GPIO       170
index b6a4c2c..556eb31 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -25,8 +25,8 @@
 #include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
 
-#include <mach/mux.h>
-#include <mach/omapfb.h>
+#include <plat/mux.h>
+#include <plat/omapfb.h>
 #include <asm/mach-types.h>
 
 #define LCD_PANEL_ENABLE_GPIO       153
index b3fa88b..bb21d7d 100644
--- a/drivers/video/omap/lcd_osk.c
+++ b/drivers/video/omap/lcd_osk.c
@@ -24,8 +24,8 @@
 #include <linux/platform_device.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/omapfb.h>
+#include <plat/mux.h>
+#include <plat/omapfb.h>
 
 static int osk_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)
 {
index 2bc5c92..b0f86e5 100644
--- a/drivers/video/omap/lcd_overo.c
+++ b/drivers/video/omap/lcd_overo.c
@@ -24,8 +24,8 @@
 #include <linux/i2c/twl4030.h>
 
 #include <mach/gpio.h>
-#include <mach/mux.h>
-#include <mach/omapfb.h>
+#include <plat/mux.h>
+#include <plat/omapfb.h>
 #include <asm/mach-types.h>
 
 #define LCD_ENABLE       144
index 4bf3c79..d302896 100644
--- a/drivers/video/omap/lcd_palmte.c
+++ b/drivers/video/omap/lcd_palmte.c
@@ -23,8 +23,8 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <mach/fpga.h>
-#include <mach/omapfb.h>
+#include <plat/fpga.h>
+#include <plat/omapfb.h>
 
 static int palmte_panel_init(struct lcd_panel *panel,
 				struct omapfb_device *fbdev)
index 48ea1f9..557424f 100644
--- a/drivers/video/omap/lcd_palmtt.c
+++ b/drivers/video/omap/lcd_palmtt.c
@@ -30,7 +30,7 @@ GPIO13 - screen blanking
 #include <linux/io.h>
 
 #include <mach/gpio.h>
-#include <mach/omapfb.h>
+#include <plat/omapfb.h>
 
 static int palmtt_panel_init(struct lcd_panel *panel,
 	struct omapfb_device *fbdev)
index 0697d29..5f4b5b2 100644
--- a/drivers/video/omap/lcd_palmz71.c
+++ b/drivers/video/omap/lcd_palmz71.c
@@ -24,7 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#include <mach/omapfb.h>
+#include <plat/omapfb.h>
 
 static int palmz71_panel_init(struct lcd_panel *panel,
 			      struct omapfb_device *fbdev)
index ab39492..5f32caf 100644
--- a/drivers/video/omap/lcdc.c
+++ b/drivers/video/omap/lcdc.c
@@ -29,8 +29,8 @@
 #include <linux/vmalloc.h>
 #include <linux/clk.h>
 
-#include <mach/dma.h>
-#include <mach/omapfb.h>
+#include <plat/dma.h>
+#include <plat/omapfb.h>
 
 #include <asm/mach-types.h>
 
index 0d0c8c8..f900a43 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -28,8 +28,8 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 
-#include <mach/dma.h>
-#include <mach/omapfb.h>
+#include <plat/dma.h>
+#include <plat/omapfb.h>
 
 #include "lcdc.h"
 #include "dispc.h"
index ee01e84..c90fa39 100644
--- a/drivers/video/omap/rfbi.c
+++ b/drivers/video/omap/rfbi.c
@@ -27,7 +27,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <mach/omapfb.h>
+#include <plat/omapfb.h>
 
 #include "dispc.h"
 
index a769462..79dc84f 100644
--- a/drivers/video/omap/sossi.c
+++ b/drivers/video/omap/sossi.c
@@ -24,8 +24,8 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 
-#include <mach/dma.h>
-#include <mach/omapfb.h>
+#include <plat/dma.h>
+#include <plat/omapfb.h>
 
 #include "lcdc.h"
 
index 3ed571a..429ea99 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -43,7 +43,7 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <mach/hardware.h>
-#include <mach/prcm.h>
+#include <plat/prcm.h>
 
 #include "omap_wdt.h"
 
index 5a5166a..3f1a6c1 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -31,8 +31,8 @@
 
 #include <asm/mach-types.h>
 
-#include <mach/board-ams-delta.h>
-#include <mach/mcbsp.h>
+#include <plat/board-ams-delta.h>
+#include <plat/mcbsp.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
index 0a50593..08e09d7 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -32,7 +32,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <linux/gpio.h>
-#include <mach/mcbsp.h>
+#include <plat/mcbsp.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
index 3341f49..e8e63ba 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -31,9 +31,9 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include <mach/control.h>
-#include <mach/dma.h>
-#include <mach/mcbsp.h>
+#include <plat/control.h>
+#include <plat/dma.h>
+#include <plat/mcbsp.h>
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
 
index 5735945..1169d2e 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -28,7 +28,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <mach/dma.h>
+#include <plat/dma.h>
 #include "omap-pcm.h"
 
 static const struct snd_pcm_hardware omap_pcm_hardware = {
index 027e1a4..c7adea3 100644
--- a/sound/soc/omap/omap2evm.c
+++ b/sound/soc/omap/omap2evm.c
@@ -31,7 +31,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/gpio.h>
-#include <mach/mcbsp.h>
+#include <plat/mcbsp.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
index b0cff9f..d88ad5c 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -29,7 +29,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/gpio.h>
-#include <mach/mcbsp.h>
+#include <plat/mcbsp.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
index 9114c26..41a91b5 100644
--- a/sound/soc/omap/omap3evm.c
+++ b/sound/soc/omap/omap3evm.c
@@ -27,7 +27,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/gpio.h>
-#include <mach/mcbsp.h>
+#include <plat/mcbsp.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
index a4e149b..498ca2e 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -31,7 +31,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <linux/gpio.h>
-#include <mach/mcbsp.h>
+#include <plat/mcbsp.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
index ec4f8fd..624f40e 100644
--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -29,7 +29,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/gpio.h>
-#include <mach/mcbsp.h>
+#include <plat/mcbsp.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
index 4a3f62d..c071f96 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -34,7 +34,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/gpio.h>
-#include <mach/mcbsp.h>
+#include <plat/mcbsp.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
index f90b45f..f90a2ac 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -29,7 +29,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/gpio.h>
-#include <mach/mcbsp.h>
+#include <plat/mcbsp.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
