From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: omap: rx51: enable tsc2005 touchscreen
Date: Fri,  2 Dec 2011 18:29:13 +0200
Message-ID: <1322843353-16155-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:31826 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757007Ab1LBQ2H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Dec 2011 11:28:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: sre@debian.org

Enable TSC2005 touchscreen driver on the RX-51 board by providing the
needed platform data.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---

	Tony, this patch has been forgotten, any chance to get it
	into 3.3?

 arch/arm/mach-omap2/board-rx51-peripherals.c |   46 ++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ba1aa07..229754c 100644
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
@@ -58,6 +59,9 @@
 
 #define RX51_USB_TRANSCEIVER_RST_GPIO	67
 
+#define RX51_TSC2005_RESET_GPIO         104
+#define RX51_TSC2005_IRQ_GPIO           100
+
 /* list all spi devices here */
 enum {
 	RX51_SPI_WL1251,
@@ -66,6 +70,7 @@ enum {
 };
 
 static struct wl12xx_platform_data wl1251_pdata;
+static struct tsc2005_platform_data tsc2005_pdata;
 
 #if defined(CONFIG_SENSORS_TSL2563) || defined(CONFIG_SENSORS_TSL2563_MODULE)
 static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
@@ -167,10 +172,10 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
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
 
@@ -1086,6 +1091,42 @@ error:
 	 */
 }
 
+static struct tsc2005_platform_data tsc2005_pdata = {
+	.ts_pressure_max	= 2048,
+	.ts_pressure_fudge	= 2,
+	.ts_x_max		= 4096,
+	.ts_x_fudge		= 4,
+	.ts_y_max		= 4096,
+	.ts_y_fudge		= 7,
+	.ts_x_plate_ohm		= 280,
+	.esd_timeout_ms		= 8000,
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
+	r = gpio_request_one(RX51_TSC2005_IRQ_GPIO, GPIOF_IN, "tsc2005 IRQ");
+	if (r < 0) {
+		printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 IRQ");
+		rx51_peripherals_spi_board_info[RX51_SPI_TSC2005].irq = 0;
+	}
+
+	r = gpio_request_one(RX51_TSC2005_RESET_GPIO, GPIOF_OUT_INIT_HIGH,
+		"tsc2005 reset");
+	if (r >= 0) {
+		tsc2005_pdata.set_reset = rx51_tsc2005_set_reset;
+	} else {
+		printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 reset");
+		tsc2005_pdata.esd_timeout_ms = 0;
+	}
+}
+
 void __init rx51_peripherals_init(void)
 {
 	rx51_i2c_init();
@@ -1094,6 +1135,7 @@ void __init rx51_peripherals_init(void)
 	board_smc91x_init();
 	rx51_add_gpio_keys();
 	rx51_init_wl1251();
+	rx51_init_tsc2005();
 	rx51_init_si4713();
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));
-- 
1.7.2.5

