From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH 2/3] omap4: Add platform changes for PWM LED
Date: Thu, 2 Dec 2010 12:59:33 +0530 (IST)
Message-ID: <54269.10.24.255.17.1291274973.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58288 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902Ab0LBH3f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 02:29:35 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB27TY0e025567
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 2 Dec 2010 01:29:34 -0600
Received: from dbdmail.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id oB27TWmX010563
	for <linux-omap@vger.kernel.org>; Thu, 2 Dec 2010 01:29:33 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From b90e733faa2fcbe4241dcce01c7722e77c91705f Mon Sep 17 00:00:00 2001
From: Hemanth V <hemanthv@ti.com>
Date: Wed, 1 Dec 2010 17:51:10 +0530
Subject: [PATCH] omap4: Add platform changes for PWM LED

Register TWL6030 PWM, which is used as charging LED

Signed-off-by: Hemanth V <hemanthv@ti.com>
---
TWL6030 PWM driver is part of mainline kernel

 arch/arm/mach-omap2/board-4430sdp.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index d8ef903..ea56c30 100644
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
-- 
1.5.4.3



