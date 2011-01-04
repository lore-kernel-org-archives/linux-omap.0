From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/4] arm: omap: gpio: don't access irq_desc array directly
Date: Tue,  4 Jan 2011 14:02:54 +0200
Message-ID: <1294142577-28772-2-git-send-email-balbi@ti.com>
References: <1294142577-28772-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:49645 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100Ab1ADMDH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 07:03:07 -0500
Received: by mail-yi0-f53.google.com with SMTP id 17so4845616yib.26
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 04:03:06 -0800 (PST)
In-Reply-To: <1294142577-28772-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>

Instead of accessing the irq_desc array directly
we can use irq_to_desc(irq). That will allow us to,
if wanted, select SPARSE_IRQ and irq_descs will be
added to a radix tree, instead of a array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/gpio.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c05c653..c351758 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -905,8 +905,10 @@ static int gpio_irq_type(unsigned irq, unsigned type)
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = _set_gpio_triggering(bank, get_gpio_index(gpio), type);
 	if (retval == 0) {
-		irq_desc[irq].status &= ~IRQ_TYPE_SENSE_MASK;
-		irq_desc[irq].status |= type;
+		struct irq_desc *d = irq_to_desc(irq);
+
+		d->status &= ~IRQ_TYPE_SENSE_MASK;
+		d->status |= type;
 	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -1925,7 +1927,9 @@ static int __init _omap_gpio_init(void)
 
 		for (j = bank->virtual_irq_start;
 		     j < bank->virtual_irq_start + gpio_count; j++) {
-			lockdep_set_class(&irq_desc[j].lock, &gpio_lock_class);
+			struct irq_desc *d = irq_to_desc(j);
+
+			lockdep_set_class(&d->lock, &gpio_lock_class);
 			set_irq_chip_data(j, bank);
 			if (bank_is_mpuio(bank))
 				set_irq_chip(j, &mpuio_irq_chip);
-- 
1.7.3.4.598.g85356

