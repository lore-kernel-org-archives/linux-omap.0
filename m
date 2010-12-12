From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 2/2] omap3: igepv2: LED gpio-led:green:d1 is active low
Date: Sun, 12 Dec 2010 19:35:38 +0100
Message-ID: <1292178938-9819-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1292178894-9749-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:51183 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab0LLSev (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Dec 2010 13:34:51 -0500
In-Reply-To: <1292178894-9749-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: eballetbo@gmail.com

Make sure the LED is turned off at boot time, and configure the GPIO LED
device as active low.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 20b88c1..41a4b25 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -317,6 +317,7 @@ static struct gpio_led igep2_gpio_leds[] = {
 		.name			= "gpio-led:green:d1",
 		.default_trigger	= "heartbeat",
 		.gpio			= -EINVAL, /* gets replaced */
+		.active_low		= 1,
 	},
 };
 
@@ -394,7 +395,7 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
 #if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
 	if ((gpio_request(gpio+TWL4030_GPIO_MAX+1, "gpio-led:green:d1") == 0)
-	    && (gpio_direction_output(gpio + TWL4030_GPIO_MAX + 1, 0) == 0))
+	    && (gpio_direction_output(gpio + TWL4030_GPIO_MAX + 1, 1) == 0))
 		gpio_export(gpio + TWL4030_GPIO_MAX + 1, 0);
 	else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_GREEN\n");
-- 
1.7.2.2

