From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH v2] omap: 4430sdp board support for the the GPIO keys
Date: Fri, 20 Aug 2010 15:54:27 +0530
Message-ID: <1282299867-24201-1-git-send-email-shubhrajyoti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60989 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0HTKYb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 06:24:31 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7KAOSJb003681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Aug 2010 05:24:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

omap 4430sdp board support for the GPIO keys.
The proximity sensor is connected to GPIO and is registered as a
GPIO key.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   64 +++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 9447644..699620d 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -20,6 +20,7 @@
 #include <linux/usb/otg.h>
 #include <linux/spi/spi.h>
 #include <linux/i2c/twl.h>
+#include <linux/gpio_keys.h>
 #include <linux/regulator/machine.h>
 #include <linux/leds.h>
 
@@ -40,6 +41,11 @@
 #define ETH_KS8851_IRQ			34
 #define ETH_KS8851_POWER_ON		48
 #define ETH_KS8851_QUART		138
+#define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
+#define OMAP4_SFH7741_ENABLE_GPIO		188
+
+static int omap_prox_activate(struct device *dev);
+static void omap_prox_deactivate(struct device *dev);
 
 static struct gpio_led sdp4430_gpio_leds[] = {
 	{
@@ -77,11 +83,36 @@ static struct gpio_led sdp4430_gpio_leds[] = {
 
 };
 
+static struct gpio_keys_button sdp4430_gpio_keys[] = {
+	{
+		.desc			= "Proximity Sensor",
+		.type			= EV_SW,
+		.code			= SW_FRONT_PROXIMITY,
+		.gpio			= OMAP4_SFH7741_SENSOR_OUTPUT_GPIO,
+		.active_low		= 0,
+	}
+};
+
 static struct gpio_led_platform_data sdp4430_led_data = {
 	.leds	= sdp4430_gpio_leds,
 	.num_leds	= ARRAY_SIZE(sdp4430_gpio_leds),
 };
 
+static struct gpio_keys_platform_data sdp4430_gpio_keys_data = {
+	.buttons	= sdp4430_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(sdp4430_gpio_keys),
+	.enable		= omap_prox_activate,
+	.disable	= omap_prox_deactivate,
+};
+
+static struct platform_device sdp4430_gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &sdp4430_gpio_keys_data,
+	},
+};
+
 static struct platform_device sdp4430_leds_gpio = {
 	.name	= "leds-gpio",
 	.id	= -1,
@@ -161,6 +192,7 @@ static struct platform_device sdp4430_lcd_device = {
 
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
+	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
 };
 
@@ -426,6 +458,37 @@ static int __init omap4_i2c_init(void)
 	omap_register_i2c_bus(4, 400, NULL, 0);
 	return 0;
 }
+
+static int omap_prox_activate(struct device *dev)
+{
+	gpio_set_value(OMAP4_SFH7741_ENABLE_GPIO , 1);
+	return 0;
+}
+
+static void omap_prox_deactivate(struct device *dev)
+{
+	gpio_set_value(OMAP4_SFH7741_ENABLE_GPIO , 0);
+}
+
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
+		pr_err("%s: GPIO configuration failed: GPIO %d,error %d\n",
+			 __func__, OMAP4_SFH7741_ENABLE_GPIO, error);
+		gpio_free(OMAP4_SFH7741_ENABLE_GPIO);
+	}
+}
+
 static void __init omap_4430sdp_init(void)
 {
 	int status;
@@ -448,6 +511,7 @@ static void __init omap_4430sdp_init(void)
 		spi_register_board_info(sdp4430_spi_board_info,
 				ARRAY_SIZE(sdp4430_spi_board_info));
 	}
+	omap_sfh7741prox_init();
 }
 
 static void __init omap_4430sdp_map_io(void)
-- 
1.7.0.4

