From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/28] omap: gpio: fix incorrect matching of IRQ_TYPE_EDGE_BOTH
Date: Fri, 23 Apr 2010 16:11:07 -0700
Message-ID: <20100423231107.31953.72733.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56557 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477Ab0DWXLK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:10 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Since IRQ_TYPE_EDGE_BOTH is defined as (IRQ_TYPE_EDGE_FALLING |
IRQ_TYPE_EDGE_RISING), testing against it with a bitwise AND also matches
both single-edge cases in addition to the intended both edges case. Fix it,
replacing with a more accurate expression.

Created and tested againts linux-2.6.34-rc3.
Applicable to 2.6.33-stable as well.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 76a347b..45a225d 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -798,7 +798,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_INT_EDGE;
 		l = __raw_readl(reg);
-		if (trigger & IRQ_TYPE_EDGE_BOTH)
+		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
 			bank->toggle_mask |= 1 << gpio;
 		if (trigger & IRQ_TYPE_EDGE_RISING)
 			l |= 1 << gpio;
@@ -812,7 +812,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_CONTROL;
 		l = __raw_readl(reg);
-		if (trigger & IRQ_TYPE_EDGE_BOTH)
+		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
 			bank->toggle_mask |= 1 << gpio;
 		if (trigger & IRQ_TYPE_EDGE_RISING)
 			l |= 1 << gpio;
@@ -846,7 +846,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 	case METHOD_GPIO_7XX:
 		reg += OMAP7XX_GPIO_INT_CONTROL;
 		l = __raw_readl(reg);
-		if (trigger & IRQ_TYPE_EDGE_BOTH)
+		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
 			bank->toggle_mask |= 1 << gpio;
 		if (trigger & IRQ_TYPE_EDGE_RISING)
 			l |= 1 << gpio;

