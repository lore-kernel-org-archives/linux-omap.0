From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] omap3: igepv2: Don't call gpio_set_value right
	aftergpio_direction_output
Date: Fri, 17 Dec 2010 19:05:33 -0800
Message-ID: <20101218030533.10251.98763.stgit@baageli.muru.com>
References: <20101218030406.10251.73118.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35119 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab0LRDFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 22:05:36 -0500
In-Reply-To: <20101218030406.10251.73118.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

gpio_direction_output() has a value argument, there's no need to call
gpio_set_value() explicitly right after.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 3bee9a1..77e2db7 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -377,24 +377,21 @@ static void __init igep2_leds_init(void)
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
@@ -426,10 +423,9 @@ static int igep2_twl_gpio_setup(struct device *dev,
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

