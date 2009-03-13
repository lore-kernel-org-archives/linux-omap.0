From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP3: Add ADS7846 touchscreen support to Overo
	platform
Date: Fri, 13 Mar 2009 15:46:10 -0700
Message-ID: <20090313224610.8810.93492.stgit@localhost>
References: <20090313224259.8810.3283.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64346 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759463AbZCMWqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 18:46:09 -0400
In-Reply-To: <20090313224259.8810.3283.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>

From: Steve Sakoman <sakoman@gmail.com>

An upcoming Overo expansion board includes an ADS7846 touchscreen controller.

This patch adds support via the ads7846 driver when enabled in the
kernel config.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-overo.c |   61 +++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index fbe1ce0..c057958 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -116,6 +116,66 @@ static inline void __init overo_init_smsc911x(void)
 static inline void __init overo_init_smsc911x(void) { return; }
 #endif
 
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
@@ -290,6 +350,7 @@ static void __init overo_init(void)
 	overo_flash_init();
 	usb_musb_init();
 	overo_init_smsc911x();
+	overo_ads7846_init();
 
 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") == 0) &&

