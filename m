From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc6-omap 1/2] H3 stops using <mach/gpioexpander.h>
Date: Mon, 24 Nov 2008 10:28:15 -0800
Message-ID: <200811241028.15876.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:25020 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751288AbYKXS3g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2008 13:29:36 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Update board-h3.c to use standard GPIO calls to set up the
IRDA transceiver, not legacy OMAP-only gpioexpander code.

Also, move the #include <.../ov9640.h>; the header is gone,
there's currently no driver for that camera sensor.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
COMPILE TESTED ONLY ... but obviously, nobody's built this
board in a while, or the ov9640 header would have been seen.

 arch/arm/mach-omap1/board-h3.c |  112 ++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 43 deletions(-)

--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -26,8 +26,11 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
-#include <linux/i2c/tps65010.h>
 #include <linux/clk.h>
+
+#include <linux/i2c/tps65010.h>
+#include <linux/i2c/pcf857x.h>
+
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc210x.h>
 
@@ -45,7 +48,6 @@
 
 #include <mach/gpio.h>
 #include <mach/gpio-switch.h>
-#include <mach/gpioexpander.h>
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/tc.h>
@@ -58,8 +60,6 @@
 #include <mach/mcbsp.h>
 #include <mach/omap-alsa.h>
 
-#include <../drivers/media/video/ov9640.h>
-
 #define H3_TS_GPIO	48
 
 static int h3_keymap[] = {
@@ -284,29 +284,15 @@ static struct platform_device h3_kp_devi
 
 /* Select between the IrDA and aGPS module
  */
-static int h3_select_irda(struct device *dev, int state)
-{
-	unsigned char expa;
-	int err = 0;
 
-	if ((err = read_gpio_expa(&expa, 0x26))) {
-		printk(KERN_ERR "Error reading from I/O EXPANDER \n");
-		return err;
-	}
+static int gpio_irda_enable;
+static int gpio_irda_x;
+static int gpio_irda_fir;
 
-	/* 'P6' enable/disable IRDA_TX and IRDA_RX */
-	if (state & IR_SEL) { /* IrDA */
-		if ((err = write_gpio_expa(expa | 0x40, 0x26))) {
-			printk(KERN_ERR "Error writing to I/O EXPANDER \n");
-			return err;
-		}
-	} else {
-		if ((err = write_gpio_expa(expa & ~0x40, 0x26))) {
-			printk(KERN_ERR "Error writing to I/O EXPANDER \n");
-			return err;
-		}
-	}
-	return err;
+static int h3_select_irda(struct device *dev, int state)
+{
+	gpio_set_value_cansleep(gpio_irda_enable, state & IR_SEL);
+	return 0;
 }
 
 static void set_trans_mode(struct work_struct *work)
@@ -314,24 +300,9 @@ static void set_trans_mode(struct work_s
 	struct omap_irda_config *irda_config =
 		container_of(work, struct omap_irda_config, gpio_expa.work);
 	int mode = irda_config->mode;
-	unsigned char expa;
-	int err = 0;
-
-	if ((err = read_gpio_expa(&expa, 0x27)) != 0) {
-		printk(KERN_ERR "Error reading from I/O expander\n");
-	}
 
-	expa &= ~0x03;
-
-	if (mode & IR_SIRMODE) {
-		expa |= 0x01;
-	} else { /* MIR/FIR */
-		expa |= 0x03;
-	}
-
-	if ((err = write_gpio_expa(expa, 0x27)) != 0) {
-		printk(KERN_ERR "Error writing to I/O expander\n");
-	}
+	gpio_set_value_cansleep(gpio_irda_x, 1);
+	gpio_set_value_cansleep(gpio_irda_fir, !(mode & IR_SIRMODE));
 }
 
 static int h3_transceiver_mode(struct device *dev, int mode)
@@ -441,7 +412,6 @@ static struct platform_device *devices[]
 	&nand_device,
         &smc91x_device,
 	&intlat_device,
-	&h3_irda_device,
 	&h3_kp_device,
 	&h3_lcd_device,
 	&h3_mcbsp1_device,
@@ -483,6 +453,9 @@ static int nand_dev_ready(struct omap_na
 }
 
 #if defined(CONFIG_VIDEO_OV9640) || defined(CONFIG_VIDEO_OV9640_MODULE)
+
+#include <../drivers/media/video/ov9640.h>
+
 /*
  * Common OV9640 register initialization for all image sizes, pixel formats,
  * and frame rates
@@ -576,8 +549,61 @@ static struct ov9640_platform_data h3_ov
 };
 #endif
 
+static int h3_pcf_setup(struct i2c_client *client, int gpio,
+		unsigned ngpio, void *context)
+{
+	int	status;
+
+	/* REVISIT someone with schematics should look up the rest
+	 * of these signals, and configure them appropriately ...
+	 * camera and audio seem to be involved, too.
+	 */
+
+	/* P0 - ? */
+	gpio_irda_x = gpio + 0;
+	status = gpio_request(gpio_irda_x, "irda_x");
+	if (status < 0)
+		goto done;
+	status = gpio_direction_output(gpio_irda_x, 0);
+	if (status < 0)
+		goto done;
+
+	/* P1 - set if MIR/FIR */
+	gpio_irda_fir = gpio + 1;
+	status = gpio_request(gpio_irda_fir, "irda_fir");
+	if (status < 0)
+		goto done;
+	status = gpio_direction_output(gpio_irda_fir, 0);
+	if (status < 0)
+		goto done;
+
+	/* 'P6' enable/disable IRDA_TX and IRDA_RX ... default, off */
+	gpio_irda_enable = gpio + 6;
+	status = gpio_request(gpio_irda_enable, "irda_enable");
+	if (status < 0)
+		goto done;
+	status = gpio_direction_output(gpio_irda_enable, 0);
+	if (status < 0)
+		goto done;
+
+	/* register the IRDA device now that it can be operated */
+	status = platform_device_register(&h3_irda_device);
+
+done:
+	return status;
+}
+
+static struct pcf857x_platform_data h3_pcf_data = {
+	/* assign these GPIO numbers right after the MPUIO lines */
+	.gpio_base	= OMAP_MAX_GPIO_LINES + 16,
+	.setup		= h3_pcf_setup,
+};
+
 static struct i2c_board_info __initdata h3_i2c_board_info[] = {
        {
+		I2C_BOARD_INFO("pcf8574", 0x27),
+		.platform_data = &h3_pcf_data,
+       }, {
 		I2C_BOARD_INFO("tps65013", 0x48),
                /* .irq         = OMAP_GPIO_IRQ(??), */
        },
