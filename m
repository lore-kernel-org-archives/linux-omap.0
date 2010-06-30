From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH 1/2] OMAP4:  Add GPIO LED support
Date: Wed, 30 Jun 2010 19:34:38 +0530 (IST)
Message-ID: <17163.10.24.255.18.1277906678.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60414 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817Ab0F3OEj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jun 2010 10:04:39 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5UE4dlH015958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 30 Jun 2010 09:04:39 -0500
Received: from dbdmail.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o5UE4aAu019989
	for <linux-omap@vger.kernel.org>; Wed, 30 Jun 2010 09:04:38 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From c17be0bcb4c92df5b5aabdad9034ff7ef427f618 Mon Sep 17 00:00:00 2001
From: Hemanth V <hemanthv@ti.com>
Date: Wed, 30 Jun 2010 18:03:09 +0530
Subject: [PATCH] OMAP4: Add GPIO LED support

This patch adds support for GPIO LEDs present on OMAP4
SDP and Blaze boards. This basically adds platform data
required by leds-gpio driver

Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   50 +++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 4bb2c5d..b213032 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
+#include <linux/leds.h>

 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -40,6 +41,54 @@
 #define ETH_KS8851_POWER_ON		48
 #define ETH_KS8851_QUART		138

+static struct gpio_led sdp4430_gpio_leds[] = {
+	{
+		.name	= "omap4:green:debug0",
+		.gpio	= 61,
+	},
+	{
+		.name	= "omap4:green:debug1",
+		.gpio	= 30,
+	},
+	{
+		.name	= "omap4:green:debug2",
+		.gpio	= 7,
+	},
+	{
+		.name	= "omap4:green:debug3",
+		.gpio	= 8,
+	},
+	{
+		.name	= "omap4:green:debug4",
+		.gpio	= 50,
+	},
+	{
+		.name	= "omap4:blue:user",
+		.gpio	= 169,
+	},
+	{
+		.name	= "omap4:red:user",
+		.gpio	= 170,
+	},
+	{
+		.name	= "omap4:green:user",
+		.gpio	= 139,
+	},
+
+};
+
+static struct gpio_led_platform_data sdp4430_led_data = {
+	.leds	= sdp4430_gpio_leds,
+	.num_leds	= ARRAY_SIZE(sdp4430_gpio_leds),
+};
+
+static struct platform_device sdp4430_leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &sdp4430_led_data,
+	},
+};
 static struct spi_board_info sdp4430_spi_board_info[] __initdata = {
 	{
 		.modalias               = "ks8851",
@@ -112,6 +161,7 @@ static struct platform_device sdp4430_lcd_device = {

 static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_lcd_device,
+	&sdp4430_leds_gpio,
 };

 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
-- 
1.5.6.3



