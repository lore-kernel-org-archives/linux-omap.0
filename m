From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 5/8] gpio/omap: remove retrigger variable in gpio_irq_handler
Date: Fri, 27 Apr 2012 19:43:35 +0530
Message-ID: <1335536018-16004-6-git-send-email-tarun.kanti@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50703 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760163Ab2D0ON6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 10:13:58 -0400
In-Reply-To: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

commit 672e302e3c (ARM: OMAP: use edge/level handlers from generic IRQ
framework) removed retrigger support in favor of using generic IRQ
framework.  This patch cleans up some unused remnants of that removal.

Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index cb9f6d9..7533564 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -636,7 +636,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u32 isr;
 	unsigned int gpio_irq, gpio_index;
 	struct gpio_bank *bank;
-	u32 retrigger = 0;
 	int unmasked = 0;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
@@ -673,8 +672,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			chained_irq_exit(chip, desc);
 		}
 
-		isr |= retrigger;
-		retrigger = 0;
 		if (!isr)
 			break;
 
-- 
1.7.0.4

