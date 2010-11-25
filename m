From: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Subject: [PATCH 1/3] tsc2005 driver support on rx51
Date: Thu, 25 Nov 2010 17:49:37 +0200
Message-ID: <1290700177-26602-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:45769 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023Ab0KYPup (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 10:50:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>

To support  tsc2005 driver on rx51,added tsc2005
intialization data ,functions to enable/disable
tsc2005 and loading driver on rx51.

Signed-off-by: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   46 ++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3fec4d6..e56d6d7 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -15,6 +15,7 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
 #include <linux/wl12xx.h>
+#include <linux/spi/tsc2005.h>
 #include <linux/i2c.h>
 #include <linux/i2c/twl.h>
 #include <linux/clk.h>
@@ -49,6 +50,9 @@
 #define RX51_WL1251_POWER_GPIO		87
 #define RX51_WL1251_IRQ_GPIO		42
 
+#define RX51_TSC2005_RESET_GPIO		104
+#define RX51_TSC2005_IRQ_GPIO		100
+
 /* list all spi devices here */
 enum {
 	RX51_SPI_WL1251,
@@ -57,6 +61,7 @@ enum {
 };
 
 static struct wl12xx_platform_data wl1251_pdata;
+static struct tsc2005_platform_data tsc2005_pdata;
 
 #if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
 static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
@@ -100,10 +105,10 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 		.modalias		= "tsc2005",
 		.bus_num		= 1,
 		.chip_select		= 0,
-		/* .irq = OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),*/
+		.irq			= OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),
 		.max_speed_hz		= 6000000,
 		.controller_data	= &tsc2005_mcspi_config,
-		/* .platform_data = &tsc2005_config,*/
+		.platform_data		= &tsc2005_pdata,
 	},
 };
 
@@ -836,6 +841,42 @@ static inline void board_onenand_init(void)
 
 #endif
 
+static struct tsc2005_platform_data tsc2005_pdata = {
+	.ts_pressure_max   = 2048,
+	.ts_pressure_fudge = 2,
+	.ts_x_max	   = 4096,
+	.ts_x_fudge	   = 4,
+	.ts_y_max	   = 4096,
+	.ts_y_fudge	   = 7,
+	.ts_x_plate_ohm	   = 280,
+	.esd_timeout_ms	   = 8000,
+};
+
+static void rx51_tsc2005_set_reset(bool enable)
+{
+	gpio_set_value(RX51_TSC2005_RESET_GPIO, enable);
+}
+
+static void __init rx51_init_tsc2005(void)
+{
+	int r;
+
+	r = gpio_request(RX51_TSC2005_IRQ_GPIO, "tsc2005 IRQ");
+	if (r >= 0)
+		gpio_direction_input(RX51_TSC2005_IRQ_GPIO);
+	else
+		printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 IRQ");
+
+	r = gpio_request(RX51_TSC2005_RESET_GPIO, "tsc2005 reset");
+	if (r >= 0) {
+		gpio_direction_output(RX51_TSC2005_RESET_GPIO, 1);
+		tsc2005_pdata.set_reset = rx51_tsc2005_set_reset;
+	} else {
+		printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 reset");
+		tsc2005_pdata.esd_timeout_ms = 0;
+	}
+}
+
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
 static struct omap_smc91x_platform_data board_smc91x_data = {
@@ -920,6 +961,7 @@ void __init rx51_peripherals_init(void)
 	board_smc91x_init();
 	rx51_add_gpio_keys();
 	rx51_init_wl1251();
+	rx51_init_tsc2005();
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));
 	omap2_hsmmc_init(mmc);
-- 
1.7.1

