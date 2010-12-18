From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] omap3: igepv2: LED gpio-led:green:d1 is active low
Date: Fri, 17 Dec 2010 19:05:36 -0800
Message-ID: <20101218030536.10251.87298.stgit@baageli.muru.com>
References: <20101218030406.10251.73118.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24127 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab0LRDFj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 22:05:39 -0500
In-Reply-To: <20101218030406.10251.73118.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Make sure the LED is turned off at boot time, and configure the GPIO LED
device as active low.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-igep0020.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 77e2db7..c5bd537 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -352,6 +352,7 @@ static struct gpio_led igep2_gpio_leds[] = {
 		.name			= "gpio-led:green:d1",
 		.default_trigger	= "heartbeat",
 		.gpio			= -EINVAL, /* gets replaced */
+		.active_low		= 1,
 	},
 };
 
@@ -423,7 +424,7 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
 #if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
 	if ((gpio_request(gpio+TWL4030_GPIO_MAX+1, "gpio-led:green:d1") == 0)
-	    && (gpio_direction_output(gpio + TWL4030_GPIO_MAX + 1, 0) == 0))
+	    && (gpio_direction_output(gpio + TWL4030_GPIO_MAX + 1, 1) == 0))
 		gpio_export(gpio + TWL4030_GPIO_MAX + 1, 0);
 	else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_GREEN\n");

