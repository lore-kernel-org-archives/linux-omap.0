From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 3/5] gpio/omap: optimise interrupt service routine
Date: Thu, 4 Apr 2013 15:16:14 -0500
Message-ID: <1365106576-31816-4-git-send-email-jon-hunter@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40487 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764497Ab3DDUQi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 16:16:38 -0400
In-Reply-To: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Felipe Balbi <balbi@ti.com>

The OMAP GPIO interrupt service routine is checking each bit in the
GPIO interrupt status register to see which bits are set. It is not
efficient to check every bit especially if only a few bits are set.
Therefore, instead of checking every bit use the __ffs() function,
which returns the location of the first set bit, to find all the set
bits.

This optimisation was suggested-by and developed in collaboration
with Felipe Balbi.

Cc: Felipe Balbi <balbi@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/gpio/gpio-omap.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 5af7acd..685e850 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -689,7 +689,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	void __iomem *isr_reg = NULL;
 	u32 isr;
-	unsigned int i;
+	unsigned int bit;
 	struct gpio_bank *bank;
 	int unmasked = 0;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -730,9 +730,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		if (!isr)
 			break;
 
-		for (i = 0; isr != 0; isr >>= 1, i++) {
-			if (!(isr & 1))
-				continue;
+		while (isr) {
+			bit = __ffs(isr);
+			isr &= ~(1 << bit);
 
 			/*
 			 * Some chips can't respond to both rising and falling
@@ -741,10 +741,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			 * to respond to the IRQ for the opposite direction.
 			 * This will be indicated in the bank toggle_mask.
 			 */
-			if (bank->toggle_mask & (1 << i))
-				_toggle_gpio_edge_triggering(bank, i);
+			if (bank->toggle_mask & (1 << bit))
+				_toggle_gpio_edge_triggering(bank, bit);
 
-			generic_handle_irq(irq_find_mapping(bank->domain, i));
+			generic_handle_irq(irq_find_mapping(bank->domain, bit));
 		}
 	}
 	/* if bank has any level sensitive GPIO pin interrupt
-- 
1.7.10.4

