From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: OMAP3: Add ADS7846 touchscreen support to
	Overo platform, v2
Date: Mon, 16 Mar 2009 13:38:55 -0700
Message-ID: <20090316203855.GM19229@atomide.com>
References: <20090313224259.8810.3283.stgit@localhost> <20090313224610.8810.93492.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nb8zVy0QMK3AA1xu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50764 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529AbZCPUiz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 16:38:55 -0400
Content-Disposition: inline
In-Reply-To: <20090313224610.8810.93492.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>


--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090313 15:46]:
> From: Steve Sakoman <sakoman@gmail.com>
> 
> An upcoming Overo expansion board includes an ADS7846 touchscreen controller.
> 
> This patch adds support via the ads7846 driver when enabled in the
> kernel config.

Here's this one refreshed to apply without the smsc911x patch.

Tony

--nb8zVy0QMK3AA1xu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="overo-ads7846-v2.patch"

>From b4b560d6323bd56a7c450b81263d09464d8c6e36 Mon Sep 17 00:00:00 2001
From: Steve Sakoman <sakoman@gmail.com>
Date: Mon, 16 Mar 2009 13:28:00 -0700
Subject: [PATCH] ARM: OMAP3: Add ADS7846 touchscreen support to Overo platform, v2

An upcoming Overo expansion board includes an ADS7846 touchscreen controller.

This patch adds support via the ads7846 driver when enabled in the
kernel config.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d785aa8..4d03b70 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -52,6 +52,66 @@
 #define GPMC_CS0_BASE  0x60
 #define GPMC_CS_SIZE   0x30
 
+#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
+	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
+
+#include <mach/mcspi.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+
+static struct omap2_mcspi_device_config ads7846_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,	/* 0: slave, 1: master */
+};
+
+
+static int ads7846_get_pendown_state(void)
+{
+	return !gpio_get_value(OVERO_GPIO_PENDOWN);
+}
+
+static struct ads7846_platform_data ads7846_config = {
+	.x_max			= 0x0fff,
+	.y_max			= 0x0fff,
+	.x_plate_ohms		= 180,
+	.pressure_max		= 255,
+	.debounce_max		= 10,
+	.debounce_tol		= 3,
+	.debounce_rep		= 1,
+	.get_pendown_state	= ads7846_get_pendown_state,
+	.keep_vref_on		= 1,
+};
+
+static struct spi_board_info overo_spi_board_info[] __initdata = {
+	{
+		.modalias		= "ads7846",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		.max_speed_hz		= 1500000,
+		.controller_data	= &ads7846_mcspi_config,
+		.irq			= OMAP_GPIO_IRQ(OVERO_GPIO_PENDOWN),
+		.platform_data		= &ads7846_config,
+	}
+};
+
+static void __init overo_ads7846_init(void)
+{
+	if ((gpio_request(OVERO_GPIO_PENDOWN, "ADS7846_PENDOWN") == 0) &&
+	    (gpio_direction_input(OVERO_GPIO_PENDOWN) == 0)) {
+		gpio_export(OVERO_GPIO_PENDOWN, 0);
+	} else {
+		printk(KERN_ERR "could not obtain gpio for ADS7846_PENDOWN\n");
+		return;
+	}
+
+	spi_register_board_info(overo_spi_board_info,
+			ARRAY_SIZE(overo_spi_board_info));
+}
+
+#else
+static inline void __init overo_ads7846_init(void) { return; }
+#endif
+
 static struct mtd_partition overo_nand_partitions[] = {
 	{
 		.name           = "xloader",
@@ -225,6 +285,7 @@ static void __init overo_init(void)
 	twl4030_mmc_init(mmc);
 	overo_flash_init();
 	usb_musb_init();
+	overo_ads7846_init();
 
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") == 0) &&

--nb8zVy0QMK3AA1xu--
