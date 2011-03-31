From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] omap: rx51: Platform support for lp5523 led chip
Date: Thu, 31 Mar 2011 15:17:57 +0300
Message-ID: <1301573877-26010-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:53731 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab1CaMSP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 08:18:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mathias.nyman@nokia.com, linux-arm-kernel@lists.infradead.org

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   81 ++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index bbcb677..488916d 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -38,6 +38,7 @@
 #include <sound/tpa6130a2-plat.h>
 #include <media/radio-si4713.h>
 #include <media/si4713.h>
+#include <linux/leds-lp5523.h>
 
 #include <../drivers/staging/iio/light/tsl2563.h>
 
@@ -51,6 +52,7 @@
 #define RX51_WL1251_IRQ_GPIO		42
 #define RX51_FMTX_RESET_GPIO		163
 #define RX51_FMTX_IRQ			53
+#define RX51_LP5523_CHIP_EN_GPIO	41
 
 /* list all spi devices here */
 enum {
@@ -67,6 +69,79 @@ static struct tsl2563_platform_data rx51_tsl2563_platform_data = {
 };
 #endif
 
+#if defined(CONFIG_LEDS_LP5523) || defined(CONFIG_LEDS_LP5523_MODULE)
+static struct lp5523_led_config rx51_lp5523_led_config[] = {
+	{
+		.chan_nr	= 0,
+		.led_current	= 50,
+	}, {
+		.chan_nr	= 1,
+		.led_current	= 50,
+	}, {
+		.chan_nr	= 2,
+		.led_current	= 50,
+	}, {
+		.chan_nr	= 3,
+		.led_current	= 50,
+	}, {
+		.chan_nr	= 4,
+		.led_current	= 50,
+	}, {
+		.chan_nr	= 5,
+		.led_current	= 50,
+	}, {
+		.chan_nr	= 6,
+		.led_current	= 50,
+	}, {
+		.chan_nr	= 7,
+		.led_current	= 50,
+	}, {
+		.chan_nr	= 8,
+		.led_current	= 50,
+	}
+};
+
+static int rx51_lp5523_setup(void)
+{
+	int err;
+
+	err = gpio_request(RX51_LP5523_CHIP_EN_GPIO, "lp5523_enable");
+	if (err < 0) {
+		pr_err("Unable to get lp5523_enable GPIO\n");
+		return err;
+	}
+
+	err = gpio_direction_output(RX51_LP5523_CHIP_EN_GPIO, 1);
+	if (err < 0) {
+		pr_err("Failed to change direction for %d GPIO\n",
+				RX51_LP5523_CHIP_EN_GPIO);
+	}
+	return err;
+}
+
+static void rx51_lp5523_release(void)
+{
+	gpio_free(RX51_LP5523_CHIP_EN_GPIO);
+}
+
+static void rx51_lp5523_enable(bool state)
+{
+	if (state)
+		gpio_set_value(RX51_LP5523_CHIP_EN_GPIO, 1);
+	else
+		gpio_set_value(RX51_LP5523_CHIP_EN_GPIO, 0);
+}
+
+static struct lp5523_platform_data rx51_lp5523_platform_data = {
+	.led_config		= rx51_lp5523_led_config,
+	.num_channels		= ARRAY_SIZE(rx51_lp5523_led_config),
+	.clock_mode		= LP5523_CLOCK_AUTO,
+	.setup_resources	= rx51_lp5523_setup,
+	.release_resources 	= rx51_lp5523_release,
+	.enable			= rx51_lp5523_enable,
+};
+#endif
+
 static struct omap2_mcspi_device_config wl1251_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,
@@ -816,6 +891,12 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
 		.platform_data = &rx51_tsl2563_platform_data,
 	},
 #endif
+#if defined(CONFIG_LEDS_LP5523) || defined(CONFIG_LEDS_LP5523_MODULE)
+	{
+		I2C_BOARD_INFO("lp5523", 0x32),
+		.platform_data  = &rx51_lp5523_platform_data,
+	},
+#endif
 	{
 		I2C_BOARD_INFO("tpa6130a2", 0x60),
 		.platform_data = &rx51_tpa6130a2_data,
-- 
1.7.1

