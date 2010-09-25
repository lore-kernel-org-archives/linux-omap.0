From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/7] omap: 4430sdp board support for proximity sensor
Date: Fri, 24 Sep 2010 17:27:17 -0700
Message-ID: <20100925002717.24551.63605.stgit@baageli.muru.com>
References: <20100925002608.24551.67183.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61500 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0IYA1P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 20:27:15 -0400
In-Reply-To: <20100925002608.24551.67183.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>

From: Shubhrajyoti Datta <shubhrajyoti@ti.com>

omap 4430sdp board support for the  proximity sensor via GPIO keys.
The proximity sensor is connected to GPIO and is registered as a
GPIO key.
- Making the default state of the sensor off at bootup
- The init is called before platform_add_devices

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   61 +++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 5b6a48d..d2b9173 100644
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
@@ -77,11 +80,47 @@ static struct gpio_led sdp4430_gpio_leds[] = {
 
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
@@ -161,6 +200,7 @@ static struct platform_device sdp4430_lcd_device = {
 
 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
+	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
 };
 
@@ -432,11 +472,32 @@ static int __init omap4_i2c_init(void)
 				ARRAY_SIZE(sdp4430_i2c_4_boardinfo));
 	return 0;
 }
+
+static void __init omap_sfh7741prox_init(void)
+{
+	int  error;
+
+	error = gpio_request(OMAP4_SFH7741_ENABLE_GPIO, "sfh7741");
+	if (error < 0) {
+		pr_err("%s:failed to request GPIO %d, error %d\n",
+			__func__, OMAP4_SFH7741_ENABLE_GPIO, error);
+		return;
+	}
+
+	error = gpio_direction_output(OMAP4_SFH7741_ENABLE_GPIO , 0);
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
 
 	omap4_i2c_init();
+	omap_sfh7741prox_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);

