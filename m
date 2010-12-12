From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 1/2] omap3: igepv2: Don't call gpio_set_value right after gpio_direction_output
Date: Sun, 12 Dec 2010 19:35:37 +0100
Message-ID: <1292178938-9819-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1292178894-9749-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:51181 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab0LLSeu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Dec 2010 13:34:50 -0500
In-Reply-To: <1292178894-9749-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: eballetbo@gmail.com

gpio_direction_output() has a value argument, there's no need to call
gpio_set_value() explicitly right after.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 5e035a5..20b88c1 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -342,24 +342,21 @@ static void __init igep2_leds_init(void)
 static inline void igep2_leds_init(void)
 {
 	if ((gpio_request(IGEP2_GPIO_LED0_RED, "gpio-led:red:d0") == 0) &&
-	    (gpio_direction_output(IGEP2_GPIO_LED0_RED, 1) == 0)) {
+	    (gpio_direction_output(IGEP2_GPIO_LED0_RED, 0) == 0))
 		gpio_export(IGEP2_GPIO_LED0_RED, 0);
-		gpio_set_value(IGEP2_GPIO_LED0_RED, 0);
-	} else
+	else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED0_RED\n");
 
 	if ((gpio_request(IGEP2_GPIO_LED0_GREEN, "gpio-led:green:d0") == 0) &&
-	    (gpio_direction_output(IGEP2_GPIO_LED0_GREEN, 1) == 0)) {
+	    (gpio_direction_output(IGEP2_GPIO_LED0_GREEN, 0) == 0))
 		gpio_export(IGEP2_GPIO_LED0_GREEN, 0);
-		gpio_set_value(IGEP2_GPIO_LED0_GREEN, 0);
-	} else
+	else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED0_GREEN\n");
 
 	if ((gpio_request(IGEP2_GPIO_LED1_RED, "gpio-led:red:d1") == 0) &&
-	    (gpio_direction_output(IGEP2_GPIO_LED1_RED, 1) == 0)) {
+	    (gpio_direction_output(IGEP2_GPIO_LED1_RED, 0) == 0))
 		gpio_export(IGEP2_GPIO_LED1_RED, 0);
-		gpio_set_value(IGEP2_GPIO_LED1_RED, 0);
-	} else
+	else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_RED\n");
 
 }
@@ -397,10 +394,9 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
 #if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
 	if ((gpio_request(gpio+TWL4030_GPIO_MAX+1, "gpio-led:green:d1") == 0)
-	    && (gpio_direction_output(gpio + TWL4030_GPIO_MAX + 1, 1) == 0)) {
+	    && (gpio_direction_output(gpio + TWL4030_GPIO_MAX + 1, 0) == 0))
 		gpio_export(gpio + TWL4030_GPIO_MAX + 1, 0);
-		gpio_set_value(gpio + TWL4030_GPIO_MAX + 1, 0);
-	} else
+	else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_GREEN\n");
 #else
 	igep2_gpio_leds[3].gpio = gpio + TWL4030_GPIO_MAX + 1;
-- 
1.7.2.2

