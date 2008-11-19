From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH] HSMMC: Update mmc configuration for Overo
Date: Tue, 18 Nov 2008 22:05:10 -0800
Message-ID: <5e088bd90811182205rf6fefb5vdbc145dcdc3980d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:24633 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYKSGFM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 01:05:12 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2725494fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 22:05:10 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch adds card detect support for mmc1

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-overo.c |   44 +++++++++++++++++++++---------------
 1 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index a1b3aba..386eb67 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -26,7 +26,6 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/twl4030.h>

 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -147,10 +146,36 @@ static struct omap_uart_config overo_uart_config
__initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };

+static struct twl4030_hsmmc_info mmc[] = {
+	{
+		.mmc		= 1,
+		.wires		= 4,
+		.gpio_wp	= -EINVAL,
+	},
+	{
+		.mmc		= 2,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+	},
+	{}	/* Terminator */
+};
+
+static int overo_twl_gpio_setup(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
+	mmc[0].gpio_cd = gpio + 0;
+	hsmmc_init(mmc);
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data overo_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.setup		= overo_twl_gpio_setup,
 };

 static struct twl4030_usb_data overo_usb_data = {
@@ -208,22 +233,6 @@ static struct platform_device *overo_devices[]
__initdata = {
 	&overo_lcd_device,
 };

-static struct twl4030_hsmmc_info mmc[] __initdata = {
-	{
-		.mmc		= 1,
-		.wires		= 4,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{
-		.mmc		= 2,
-		.wires		= 4,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{}	/* Terminator */
-};
-
 static void __init overo_init(void)
 {
 	overo_i2c_init();
@@ -231,7 +240,6 @@ static void __init overo_init(void)
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
 	omap_serial_init();
-	hsmmc_init(mmc);
 	usb_musb_init();
 	usb_ehci_init();
 	overo_flash_init();
-- 
1.5.4.5
