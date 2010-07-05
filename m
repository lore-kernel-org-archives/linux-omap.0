From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] omap3: pandora: add NAND and wifi support
Date: Mon, 5 Jul 2010 13:05:43 +0300
Message-ID: <20100705100542.GQ15951@atomide.com>
References: <1278014301-24645-1-git-send-email-notasas@gmail.com>
 <1278014301-24645-3-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Izn7cH1Com+I3R9J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53406 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab0GEKFu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 06:05:50 -0400
Content-Disposition: inline
In-Reply-To: <1278014301-24645-3-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Grazvydas Ignotas <notasas@gmail.com> [100701 22:52]:
> Add platform data for NAND and wifi, also setup all GPIOs
> needed to use the wifi chip.

I've applied this after tweaking it a bit to apply as the
SDIO series is getting merged via Andrew. Updated patch
below.

Regards,

Tony

--Izn7cH1Com+I3R9J
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="pandora-wifi-nand.patch"

>From ebc8d2747c38e35d3baf7967ac722b5e828d5800 Mon Sep 17 00:00:00 2001
From: Grazvydas Ignotas <notasas@gmail.com>
Date: Thu, 1 Jul 2010 19:58:21 +0000
Subject: [PATCH] Add platform data for NAND and wifi, also setup all GPIOs
 needed to use the wifi chip.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 7a12729..7cee651 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -29,6 +29,9 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/gpio_keys.h>
+#include <linux/spi/wl12xx.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -41,13 +44,50 @@
 #include <plat/mcspi.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/nand.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
 
+#define PANDORA_WIFI_IRQ_GPIO		21
+#define PANDORA_WIFI_NRESET_GPIO	23
 #define OMAP3_PANDORA_TS_GPIO		94
 
+#define NAND_BLOCK_SIZE			SZ_128K
+
+static struct mtd_partition omap3pandora_nand_partitions[] = {
+	{
+		.name           = "xloader",
+		.offset         = 0,
+		.size           = 4 * NAND_BLOCK_SIZE,
+		.mask_flags     = MTD_WRITEABLE
+	}, {
+		.name           = "uboot",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 15 * NAND_BLOCK_SIZE,
+	}, {
+		.name           = "uboot-env",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 1 * NAND_BLOCK_SIZE,
+	}, {
+		.name           = "boot",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 80 * NAND_BLOCK_SIZE,
+	}, {
+		.name           = "rootfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_nand_platform_data pandora_nand_data = {
+	.cs		= 0,
+	.devsize	= 1,	/* '0' for 8-bit, '1' for 16-bit device */
+	.parts		= omap3pandora_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(omap3pandora_nand_partitions),
+};
+
 static struct gpio_led pandora_gpio_leds[] = {
 	{
 		.name			= "pandora::sd1",
@@ -246,12 +286,33 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 static int omap3pandora_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+	int ret, gpio_32khz;
+
 	/* gpio + {0,1} is "mmc{0,1}_cd" (input/IRQ) */
 	omap3pandora_mmc[0].gpio_cd = gpio + 0;
 	omap3pandora_mmc[1].gpio_cd = gpio + 1;
 	omap2_hsmmc_init(omap3pandora_mmc);
 
+	/* gpio + 13 drives 32kHz buffer for wifi module */
+	gpio_32khz = gpio + 13;
+	ret = gpio_request(gpio_32khz, "wifi 32kHz");
+	if (ret < 0) {
+		pr_err("Cannot get GPIO line %d, ret=%d\n", gpio_32khz, ret);
+		goto fail;
+	}
+
+	ret = gpio_direction_output(gpio_32khz, 1);
+	if (ret < 0) {
+		pr_err("Cannot set GPIO line %d, ret=%d\n", gpio_32khz, ret);
+		goto fail_direction;
+	}
+
 	return 0;
+
+fail_direction:
+	gpio_free(gpio_32khz);
+fail:
+	return -ENODEV;
 }
 
 static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
@@ -530,10 +591,67 @@ static void __init omap3pandora_init_irq(void)
 	omap_gpio_init();
 }
 
+static void pandora_wl1251_set_power(bool enable)
+{
+	/*
+	 * Keep power always on until wl1251_sdio driver learns to re-init
+	 * the chip after powering it down and back up.
+	 */
+}
+
+static struct wl12xx_platform_data pandora_wl1251_pdata = {
+	.set_power	= pandora_wl1251_set_power,
+	.use_eeprom	= true,
+};
+
+static struct platform_device pandora_wl1251_data = {
+	.name           = "wl1251_data",
+	.id             = -1,
+	.dev		= {
+		.platform_data	= &pandora_wl1251_pdata,
+	},
+};
+
+static void pandora_wl1251_init(void)
+{
+	int ret;
+
+	ret = gpio_request(PANDORA_WIFI_IRQ_GPIO, "wl1251 irq");
+	if (ret < 0)
+		goto fail;
+
+	ret = gpio_direction_input(PANDORA_WIFI_IRQ_GPIO);
+	if (ret < 0)
+		goto fail_irq;
+
+	pandora_wl1251_pdata.irq = gpio_to_irq(PANDORA_WIFI_IRQ_GPIO);
+	if (pandora_wl1251_pdata.irq < 0)
+		goto fail_irq;
+
+	ret = gpio_request(PANDORA_WIFI_NRESET_GPIO, "wl1251 nreset");
+	if (ret < 0)
+		goto fail_irq;
+
+	/* start powered so that it probes with MMC subsystem */
+	ret = gpio_direction_output(PANDORA_WIFI_NRESET_GPIO, 1);
+	if (ret < 0)
+		goto fail_nreset;
+
+	return;
+
+fail_nreset:
+	gpio_free(PANDORA_WIFI_NRESET_GPIO);
+fail_irq:
+	gpio_free(PANDORA_WIFI_IRQ_GPIO);
+fail:
+	printk(KERN_ERR "wl1251 board initialisation failed\n");
+}
+
 static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_leds_gpio,
 	&pandora_keys_gpio,
 	&pandora_dss_device,
+	&pandora_wl1251_data,
 };
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
@@ -566,6 +684,7 @@ static void __init omap3pandora_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3pandora_i2c_init();
+	pandora_wl1251_init();
 	platform_add_devices(omap3pandora_devices,
 			ARRAY_SIZE(omap3pandora_devices));
 	omap_serial_init();
@@ -574,6 +693,7 @@ static void __init omap3pandora_init(void)
 	omap3pandora_ads7846_init();
 	usb_ehci_init(&ehci_pdata);
 	usb_musb_init(&musb_board_data);
+	gpmc_nand_init(&pandora_nand_data);
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);

--Izn7cH1Com+I3R9J--
