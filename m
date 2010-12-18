From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] omap4: Add platform changes for PWM LED
Date: Fri, 17 Dec 2010 19:05:41 -0800
Message-ID: <20101218030541.10251.37326.stgit@baageli.muru.com>
References: <20101218030406.10251.73118.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48096 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab0LRDFo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 22:05:44 -0500
In-Reply-To: <20101218030406.10251.73118.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Hemanth V <hemanthv@ti.com>, linux-omap@vger.kernel.org

From: Hemanth V <hemanthv@ti.com>

Register TWL6030 PWM, which is used as charging LED

Signed-off-by: Hemanth V <hemanthv@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 66f8943..33b1f73 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -23,6 +23,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/regulator/machine.h>
 #include <linux/leds.h>
+#include <linux/leds_pwm.h>
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -97,6 +98,28 @@ static struct gpio_led_platform_data sdp4430_led_data = {
 	.num_leds	= ARRAY_SIZE(sdp4430_gpio_leds),
 };
 
+static struct led_pwm sdp4430_pwm_leds[] = {
+	{
+		.name		= "omap4:green:chrg",
+		.pwm_id		= 1,
+		.max_brightness	= 255,
+		.pwm_period_ns	= 7812500,
+	},
+};
+
+static struct led_pwm_platform_data sdp4430_pwm_data = {
+	.num_leds	= ARRAY_SIZE(sdp4430_pwm_leds),
+	.leds		= sdp4430_pwm_leds,
+};
+
+static struct platform_device sdp4430_leds_pwm = {
+	.name	= "leds_pwm",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &sdp4430_pwm_data,
+	},
+};
+
 static int omap_prox_activate(struct device *dev)
 {
 	gpio_set_value(OMAP4_SFH7741_ENABLE_GPIO , 1);
@@ -204,6 +227,7 @@ static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
 	&sdp4430_gpio_keys_device,
 	&sdp4430_leds_gpio,
+	&sdp4430_leds_pwm,
 };
 
 static struct omap_lcd_config sdp4430_lcd_config __initdata = {

