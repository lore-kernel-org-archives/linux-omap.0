From: Steve Sakoman <sakoman@gmail.com>
Subject: [PATCH/RFC] ARM: Add ADS7846 touchscreen support to Overo platform
Date: Sun, 1 Feb 2009 22:42:23 -0800
Message-ID: <5e088bd90902012242q2bc7a272p244a02e9b54002ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:56312 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbZBBGm0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 01:42:26 -0500
Received: by fxm13 with SMTP id 13so1269258fxm.13
        for <linux-omap@vger.kernel.org>; Sun, 01 Feb 2009 22:42:24 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

An upcoming Overo expansion board includes an ADS7846 touchscreen controller.

This patch adds support via the ads7846 driver when enabled in the
kernel config.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-overo.c             |   61 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/board-overo.h |    1 +
 2 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index 032a2c9..2521b21 100644
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
@@ -296,6 +356,7 @@ static void __init overo_init(void)
 	usb_ehci_init();
 	overo_flash_init();
 	overo_init_smsc911x();
+	overo_ads7846_init();

 	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
 			  "OVERO_GPIO_W2W_NRESET") == 0) &&
diff --git a/arch/arm/plat-omap/include/mach/board-overo.h
b/arch/arm/plat-omap/include/mach/board-overo.h
index 8635171..aca717d 100644
--- a/arch/arm/plat-omap/include/mach/board-overo.h
+++ b/arch/arm/plat-omap/include/mach/board-overo.h
@@ -18,6 +18,7 @@

 #define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
+#define OVERO_GPIO_PENDOWN	114
 #define OVERO_GPIO_BT_NRESET	164
 #define OVERO_GPIO_USBH_CPEN	168
 #define OVERO_GPIO_USBH_NRESET	183
-- 
1.5.6.3
