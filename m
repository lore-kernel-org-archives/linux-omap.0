From: Vladimir Zapolskiy <vladimir.zapolskiy@nokia.com>
Subject: [PATCH v3] OMAP3: RX-51: complete tsc2005 controller support
Date: Wed, 14 Dec 2011 17:41:19 +0200
Message-ID: <1323877279-10275-1-git-send-email-vladimir.zapolskiy@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:17751 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757430Ab1LNPln (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 10:41:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

This change adds initialization of TSC2005 touchscreen controller found on Nokia
RX-51 board.

The change is taken from MeeGo kernel adaptation for Nokia N900, it repeats the
work of Aaro Koskinen and Mika Laitio, the original discussion is at
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26749.html

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
---
Changes from v2 to v3:
* added explicit gpio pin mux definitions
* use gpio_array_request() for requesting multiple GPIOs

Changes from v1 to v2:
* whitespace fix

 arch/arm/mach-omap2/board-rx51-peripherals.c |   48 ++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ba1aa07..dc15ae8 100644
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
@@ -56,6 +57,9 @@
 #define RX51_FMTX_IRQ			53
 #define RX51_LP5523_CHIP_EN_GPIO	41
 
+#define RX51_TSC2005_RESET_GPIO		104
+#define RX51_TSC2005_IRQ_GPIO		100
+
 #define RX51_USB_TRANSCEIVER_RST_GPIO	67
 
 /* list all spi devices here */
@@ -146,6 +150,17 @@ static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
 	.single_channel	= 1,
 };
 
+static struct tsc2005_platform_data tsc2005_pdata = {
+	.ts_pressure_max	= 2048,
+	.ts_pressure_fudge	= 2,
+	.ts_x_max		= 4096,
+	.ts_x_fudge		= 4,
+	.ts_y_max		= 4096,
+	.ts_y_fudge		= 4,
+	.ts_x_plate_ohm		= 320,
+	.esd_timeout_ms		= 8000,
+};
+
 static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 	[RX51_SPI_WL1251] = {
 		.modalias		= "wl1251",
@@ -167,10 +182,10 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
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
 
@@ -1086,6 +1101,34 @@ error:
 	 */
 }
 
+static struct gpio rx51_tsc2005_gpios[] __initdata = {
+	{ RX51_TSC2005_IRQ_GPIO,   GPIOF_IN,		"tsc2005 IRQ"	},
+	{ RX51_TSC2005_RESET_GPIO, GPIOF_OUT_INIT_HIGH,	"tsc2005 reset"	},
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
+	omap_mux_init_gpio(RX51_TSC2005_RESET_GPIO, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(RX51_TSC2005_IRQ_GPIO, OMAP_PIN_INPUT_PULLUP);
+
+	r = gpio_request_array(rx51_tsc2005_gpios,
+			       ARRAY_SIZE(rx51_tsc2005_gpios));
+	if (r < 0) {
+		printk(KERN_ERR "tsc2005 board initialization failed\n");
+		tsc2005_pdata.esd_timeout_ms = 0;
+		return;
+	}
+
+	tsc2005_pdata.set_reset = rx51_tsc2005_set_reset;
+}
+
 void __init rx51_peripherals_init(void)
 {
 	rx51_i2c_init();
@@ -1094,6 +1137,7 @@ void __init rx51_peripherals_init(void)
 	board_smc91x_init();
 	rx51_add_gpio_keys();
 	rx51_init_wl1251();
+	rx51_init_tsc2005();
 	rx51_init_si4713();
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));
-- 
1.7.2.3

