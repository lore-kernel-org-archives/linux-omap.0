From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 8/8] ARM: OMAP: omap3beagle: Use the pwm_leds driver to control the PMU_STAT led
Date: Fri, 18 Jan 2013 15:31:56 +0100
Message-ID: <1358519516-13165-9-git-send-email-peter.ujfalusi@ti.com>
References: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60401 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756133Ab3AROcM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 09:32:12 -0500
In-Reply-To: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

With the PWM backed driver the PMU_STAT led's brighness can be controlled.
This needs the new drivers for the TWL PWM/LED to work.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c | 39 ++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 909e7fa..2a6e8ad 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -20,6 +20,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/leds.h>
+#include <linux/pwm.h>
+#include <linux/leds_pwm.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
@@ -55,6 +57,32 @@
 
 #define	NAND_CS	0
 
+static struct pwm_lookup pwm_lookup[] = {
+	/* LEDB -> PMU_STAT */
+	PWM_LOOKUP("twl-pwmled", 1, "leds_pwm", "beagleboard::pmu_stat"),
+};
+
+static struct led_pwm pwm_leds[] = {
+	{
+		.name		= "beagleboard::pmu_stat",
+		.max_brightness	= 127,
+		.pwm_period_ns	= 7812500,
+	},
+};
+
+static struct led_pwm_platform_data pwm_data = {
+	.num_leds	= ARRAY_SIZE(pwm_leds),
+	.leds		= pwm_leds,
+};
+
+static struct platform_device leds_pwm = {
+	.name	= "leds_pwm",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &pwm_data,
+	},
+};
+
 /*
  * OMAP3 Beagle revision
  * Run time detection of Beagle revision is done by reading GPIO.
@@ -292,9 +320,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	gpio_request_one(gpio + TWL4030_GPIO_MAX, beagle_config.usb_pwr_level,
 			"nEN_USB_PWR");
 
-	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
-	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
-
 	return 0;
 }
 
@@ -376,11 +401,6 @@ static struct gpio_led gpio_leds[] = {
 		.default_trigger	= "mmc0",
 		.gpio			= 149,
 	},
-	{
-		.name			= "beagleboard::pmu_stat",
-		.gpio			= -EINVAL,	/* gets replaced */
-		.active_low		= true,
-	},
 };
 
 static struct gpio_led_platform_data gpio_led_info = {
@@ -428,6 +448,7 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
 	&madc_hwmon,
+	&leds_pwm,
 };
 
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
@@ -532,6 +553,8 @@ static void __init omap3_beagle_init(void)
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
+
+	pwm_add_table(pwm_lookup, ARRAY_SIZE(pwm_lookup));
 }
 
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
-- 
1.8.1

