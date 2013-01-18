From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 7/8] ARM: OMAP: board-4430sdp: Proper support for TWL6030 PWM LED/Backlight
Date: Fri, 18 Jan 2013 15:31:55 +0100
Message-ID: <1358519516-13165-8-git-send-email-peter.ujfalusi@ti.com>
References: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58630 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756131Ab3AROcL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 09:32:11 -0500
In-Reply-To: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

New PWM drivers are being prepared for twl series which will enable the use
of all PWMs (PWMs and LEDs).
They are implemented as generic PWM drivers to be able to use them for different
purposes.
The current platform code was broken: the leds_pwm driver was not able to pick
up the PWM since the pwm_id was incorrect.

With the other patches we will be able to control the followings:
LCD backlight via pwm-backlight driver
Keypad leds via leds_pwm driver as normal LED
Charging indicator via leds_pwm driver as normal LED

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1cc6696..918b73b 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -24,8 +24,10 @@
 #include <linux/gpio_keys.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/pwm.h>
 #include <linux/leds.h>
 #include <linux/leds_pwm.h>
+#include <linux/pwm_backlight.h>
 #include <linux/platform_data/omap4-keypad.h>
 #include <linux/usb/musb.h>
 
@@ -256,10 +258,20 @@ static struct gpio_led_platform_data sdp4430_led_data = {
 	.num_leds	= ARRAY_SIZE(sdp4430_gpio_leds),
 };
 
+static struct pwm_lookup sdp4430_pwm_lookup[] = {
+	PWM_LOOKUP("twl-pwm", 0, "leds_pwm", "omap4::keypad"),
+	PWM_LOOKUP("twl-pwm", 1, "pwm-backlight", NULL),
+	PWM_LOOKUP("twl-pwmled", 0, "leds_pwm", "omap4:green:chrg"),
+};
+
 static struct led_pwm sdp4430_pwm_leds[] = {
 	{
+		.name		= "omap4::keypad",
+		.max_brightness	= 127,
+		.pwm_period_ns	= 7812500,
+	},
+	{
 		.name		= "omap4:green:chrg",
-		.pwm_id		= 1,
 		.max_brightness	= 255,
 		.pwm_period_ns	= 7812500,
 	},
@@ -278,6 +290,20 @@ static struct platform_device sdp4430_leds_pwm = {
 	},
 };
 
+static struct platform_pwm_backlight_data sdp4430_backlight_data = {
+	.max_brightness = 127,
+	.dft_brightness = 127,
+	.pwm_period_ns = 7812500,
+};
+
+static struct platform_device sdp4430_backlight_pwm = {
+	.name   = "pwm-backlight",
+	.id     = -1,
+	.dev    = {
+		.platform_data = &sdp4430_backlight_data,
+	},
+};
+
 static int omap_prox_activate(struct device *dev)
 {
 	gpio_set_value(OMAP4_SFH7741_ENABLE_GPIO , 1);
@@ -412,6 +438,7 @@ static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
 	&sdp4430_leds_pwm,
+	&sdp4430_backlight_pwm,
 	&sdp4430_vbat,
 	&sdp4430_dmic_codec,
 	&sdp4430_abe_audio,
@@ -707,6 +734,7 @@ static void __init omap_4430sdp_init(void)
 				ARRAY_SIZE(sdp4430_spi_board_info));
 	}
 
+	pwm_add_table(sdp4430_pwm_lookup, ARRAY_SIZE(sdp4430_pwm_lookup));
 	status = omap4_keyboard_init(&sdp4430_keypad_data, &keypad_data);
 	if (status)
 		pr_err("Keypad initialization failed: %d\n", status);
-- 
1.8.1

