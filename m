From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: [RFC][PATCH] Add the proximity sensor support for 4430sdp
Date: Sat, 10 Jul 2010 21:27:05 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B36AAFAF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


The proximity sensor is registered as a gpio-key

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   43 +++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9447644..91eba3f 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -20,6 +20,7 @@
 #include <linux/usb/otg.h>
 #include <linux/spi/spi.h>
 #include <linux/i2c/twl.h>
+#include <linux/gpio_keys.h>
 #include <linux/regulator/machine.h>
 #include <linux/leds.h>
 
@@ -40,6 +41,8 @@
 #define ETH_KS8851_IRQ			34
 #define ETH_KS8851_POWER_ON		48
 #define ETH_KS8851_QUART		138
+#define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
+#define OMAP4_SFH7741_ENABLE_GPIO		188
 
 static struct gpio_led sdp4430_gpio_leds[] = {
 	{
@@ -76,11 +79,31 @@ static struct gpio_led sdp4430_gpio_leds[] = {
 	},
 
 };
+static struct gpio_keys_button sdp4430_gpio_keys[] = {
+ {
+		.desc			= "Proximity Sensor",
+		.type			= EV_SW,
+		.code			= SW_FRONT_PROXIMITY,
+		.gpio			= OMAP4_SFH7741_SENSOR_OUTPUT_GPIO,
+		.active_low		= 0,
+	}
+};
 
 static struct gpio_led_platform_data sdp4430_led_data = {
 	.leds	= sdp4430_gpio_leds,
 	.num_leds	= ARRAY_SIZE(sdp4430_gpio_leds),
 };
+static struct gpio_keys_platform_data sdp4430_gpio_keys_data = {
+	.buttons	= sdp4430_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(sdp4430_gpio_keys),
+};
+static struct platform_device sdp4430_gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &sdp4430_gpio_keys_data,
+	},
+};
 
 static struct platform_device sdp4430_leds_gpio = {
 	.name	= "leds-gpio",
@@ -161,6 +184,7 @@ static struct platform_device sdp4430_lcd_device = {
 
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
+	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
 };
 
@@ -426,6 +450,24 @@ static int __init omap4_i2c_init(void)
 	omap_register_i2c_bus(4, 400, NULL, 0);
 	return 0;
 }
+static void omap_sfh7741prox_init(void)
+{
+	int  error;
+
+	error = gpio_request(OMAP4_SFH7741_ENABLE_GPIO, "sfh7741");
+	if (error < 0) {
+		pr_err("failed to request GPIO %d, error %d\n",
+			OMAP4_SFH7741_ENABLE_GPIO, error);
+		return;
+	}
+
+	error = gpio_direction_output(OMAP4_SFH7741_ENABLE_GPIO , 1);
+	if (error < 0) {
+		pr_err("%s: GPIO configuration failed: GPIO %d,\
+			error %d\n",__func__, OMAP4_SFH7741_ENABLE_GPIO, error);
+		gpio_free(OMAP4_SFH7741_ENABLE_GPIO);
+	}
+}
 static void __init omap_4430sdp_init(void)
 {
 	int status;
@@ -448,6 +490,7 @@ static void __init omap_4430sdp_init(void)
 		spi_register_board_info(sdp4430_spi_board_info,
 				ARRAY_SIZE(sdp4430_spi_board_info));
 	}
+	omap_sfh7741prox_init();
 }
 
 static void __init omap_4430sdp_map_io(void)
-- 
1.5.4.7

