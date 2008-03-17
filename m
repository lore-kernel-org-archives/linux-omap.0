From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/14] ARM: OMAP: use edge/level handlers from generic IRQ framework
Date: Mon, 17 Mar 2008 11:42:30 +0200
Message-ID: <1205746958-11242-7-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
 <1205746958-11242-2-git-send-email-tony@atomide.com>
 <1205746958-11242-3-git-send-email-tony@atomide.com>
 <1205746958-11242-4-git-send-email-tony@atomide.com>
 <1205746958-11242-5-git-send-email-tony@atomide.com>
 <1205746958-11242-6-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64382 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbYCQJnd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:33 -0400
In-Reply-To: <1205746958-11242-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>

From: Kevin Hilman <khilman@mvista.com>

Currently, the GPIO interrupt handling is duplicating some of the work
done by the generic IRQ handlers (handle_edge_irq, handle_level_irq)
such as detecting nesting, handling re-triggers etc.  Remove this
duplication and use generic hooks based on IRQ type.

Using generic IRQ handlers ensures correct behavior when using
threaded interrupts introduced by the -rt patch.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |   42 +++++++-----------------------------------
 1 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 4f104e4..1903a34 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -542,10 +542,6 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 	bank->level_mask =
 		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
 		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-	/*
-	 * FIXME: Possibly do 'set_irq_handler(j, handle_level_irq)' if only
-	 * level triggering requested.
-	 */
 }
 #endif
 
@@ -656,6 +652,12 @@ static int gpio_irq_type(unsigned irq, unsigned type)
 		irq_desc[irq].status |= type;
 	}
 	spin_unlock_irqrestore(&bank->lock, flags);
+
+	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
+		__set_irq_handler_unlocked(irq, handle_level_irq);
+	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
+		__set_irq_handler_unlocked(irq, handle_edge_irq);
+
 	return retval;
 }
 
@@ -1050,42 +1052,12 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		gpio_irq = bank->virtual_irq_start;
 		for (; isr != 0; isr >>= 1, gpio_irq++) {
 			struct irq_desc *d;
-			int irq_mask;
+
 			if (!(isr & 1))
 				continue;
 			d = irq_desc + gpio_irq;
-			/* Don't run the handler if it's already running
-			 * or was disabled lazely.
-			 */
-			if (unlikely((d->depth ||
-				      (d->status & IRQ_INPROGRESS)))) {
-				irq_mask = 1 <<
-					(gpio_irq - bank->virtual_irq_start);
-				/* The unmasking will be done by
-				 * enable_irq in case it is disabled or
-				 * after returning from the handler if
-				 * it's already running.
-				 */
-				_enable_gpio_irqbank(bank, irq_mask, 0);
-				if (!d->depth) {
-					/* Level triggered interrupts
-					 * won't ever be reentered
-					 */
-					BUG_ON(level_mask & irq_mask);
-					d->status |= IRQ_PENDING;
-				}
-				continue;
-			}
 
 			desc_handle_irq(gpio_irq, d);
-
-			if (unlikely((d->status & IRQ_PENDING) && !d->depth)) {
-				irq_mask = 1 <<
-					(gpio_irq - bank->virtual_irq_start);
-				d->status &= ~IRQ_PENDING;
-				_enable_gpio_irqbank(bank, irq_mask, 1);
-				retrigger |= irq_mask;
-			}
 		}
 	}
 	/* if bank has any level sensitive GPIO pin interrupt
-- 
1.5.3.6

