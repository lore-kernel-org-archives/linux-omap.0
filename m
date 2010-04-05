From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] omap: gpio: fix incorrect matching of IRQ_TYPE_EDGE_BOTH
Date: Mon, 5 Apr 2010 13:38:06 +0200
Message-ID: <201004051338.07160.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:44725 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487Ab0DELm5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Apr 2010 07:42:57 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <greg@kroah.com>

Since IRQ_TYPE_EDGE_BOTH is defined as (IRQ_TYPE_EDGE_FALLING | 
IRQ_TYPE_EDGE_RISING), testing against it with a bitwise AND also matches 
both single-edge cases in addition to the intended both edges case. Fix it, 
replacing with a more accurate expression.

Created and tested againts linux-2.6.34-rc3.
Applicable to 2.6.33-stable as well.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
--- git/arch/arm/plat-omap/gpio.c.orig	2010-04-01 17:54:17.000000000 +0200
+++ git/arch/arm/plat-omap/gpio.c	2010-04-04 02:34:44.000000000 +0200
@@ -798,7 +798,7 @@ static int _set_gpio_triggering(struct g
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_INT_EDGE;
 		l = __raw_readl(reg);
-		if (trigger & IRQ_TYPE_EDGE_BOTH)
+		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
 			bank->toggle_mask |= 1 << gpio;
 		if (trigger & IRQ_TYPE_EDGE_RISING)
 			l |= 1 << gpio;
@@ -812,7 +812,7 @@ static int _set_gpio_triggering(struct g
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_CONTROL;
 		l = __raw_readl(reg);
-		if (trigger & IRQ_TYPE_EDGE_BOTH)
+		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
 			bank->toggle_mask |= 1 << gpio;
 		if (trigger & IRQ_TYPE_EDGE_RISING)
 			l |= 1 << gpio;
@@ -846,7 +846,7 @@ static int _set_gpio_triggering(struct g
 	case METHOD_GPIO_7XX:
 		reg += OMAP7XX_GPIO_INT_CONTROL;
 		l = __raw_readl(reg);
-		if (trigger & IRQ_TYPE_EDGE_BOTH)
+		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
 			bank->toggle_mask |= 1 << gpio;
 		if (trigger & IRQ_TYPE_EDGE_RISING)
 			l |= 1 << gpio;
