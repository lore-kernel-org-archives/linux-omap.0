From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 10/14] GPIO: OMAP: convert MPUIO IRQ over to generic irq_chip
Date: Fri, 20 May 2011 17:14:53 +0200
Message-ID: <1305904497-26013-11-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45951 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933413Ab1ETPPi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:38 -0400
Received: by wyb28 with SMTP id 28so3404851wyb.8
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:35 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

MPUIO banks have their own dedicated IRQ chip interface, separate from
the "normal" GPIO banks.   Convert the MPUIO IRQ chip over to using
the new generic IRQ chip interface.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio_omap.c |   74 ++++++++++++++++++---------------------------
 1 files changed, 30 insertions(+), 44 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 6bb3785..d84cc95 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -875,45 +875,8 @@ static struct irq_chip gpio_irq_chip = {
 
 #ifdef CONFIG_ARCH_OMAP1
 
-/* MPUIO uses the always-on 32k clock */
-
-static void mpuio_ack_irq(struct irq_data *d)
-{
-	/* The ISR is reset automatically, so do nothing here. */
-}
-
-static void mpuio_mask_irq(struct irq_data *d)
-{
-	unsigned int gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
-	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-
-	_set_gpio_irqenable(bank, gpio, 0);
-}
-
-static void mpuio_unmask_irq(struct irq_data *d)
-{
-	unsigned int gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
-	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-
-	_set_gpio_irqenable(bank, gpio, 1);
-}
-
-static struct irq_chip mpuio_irq_chip = {
-	.name		= "MPUIO",
-	.irq_ack	= mpuio_ack_irq,
-	.irq_mask	= mpuio_mask_irq,
-	.irq_unmask	= mpuio_unmask_irq,
-	.irq_set_type	= gpio_irq_type,
-#ifdef CONFIG_ARCH_OMAP16XX
-	/* REVISIT: assuming only 16xx supports MPUIO wake events */
-	.irq_set_wake	= gpio_wake_enable,
-#endif
-};
-
-
 #define bank_is_mpuio(bank)	((bank)->method == METHOD_MPUIO)
 
-
 #ifdef CONFIG_ARCH_OMAP16XX
 
 #include <linux/platform_device.h>
@@ -988,8 +951,6 @@ static inline void mpuio_init(void) {}
 
 #else
 
-extern struct irq_chip mpuio_irq_chip;
-
 #define bank_is_mpuio(bank)	0
 static inline void mpuio_init(void) {}
 
@@ -1189,6 +1150,30 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 	}
 }
 
+static __init void
+omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
+		    unsigned int num)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+
+	gc = irq_alloc_generic_chip("MPUIO", 1, irq_start, bank->base,
+				    handle_simple_irq);
+	ct = gc->chip_types;
+
+	/* NOTE: No ack required, reading IRQ status clears it. */
+	ct->chip.irq_mask = irq_gc_mask_set_bit;
+	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
+	ct->chip.irq_set_type = gpio_irq_type;
+	/* REVISIT: assuming only 16xx supports MPUIO wake events */
+	if (cpu_is_omap16xx())
+		ct->chip.irq_set_wake = gpio_wake_enable,
+
+	ct->regs.mask = OMAP_MPUIO_GPIO_INT / bank->stride;
+	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
+			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
+}
+
 static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 {
 	int j;
@@ -1226,12 +1211,13 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 		     j < bank->virtual_irq_start + bank->width; j++) {
 		irq_set_lockdep_class(j, &gpio_lock_class);
 		irq_set_chip_data(j, bank);
-		if (bank_is_mpuio(bank))
-			irq_set_chip(j, &mpuio_irq_chip);
-		else
+		if (bank_is_mpuio(bank)) {
+			omap_mpuio_alloc_gc(bank, j, bank->width);
+		} else {
 			irq_set_chip(j, &gpio_irq_chip);
-		irq_set_handler(j, handle_simple_irq);
-		set_irq_flags(j, IRQF_VALID);
+			irq_set_handler(j, handle_simple_irq);
+			set_irq_flags(j, IRQF_VALID);
+		}
 	}
 	irq_set_chained_handler(bank->irq, gpio_irq_handler);
 	irq_set_handler_data(bank->irq, bank);
-- 
1.7.3.4

