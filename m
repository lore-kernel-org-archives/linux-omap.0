From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 9/9] OMAP: GPIO: convert MPUIO IRQ over to generic irq_chip
Date: Thu, 21 Apr 2011 13:35:27 -0700
Message-ID: <1303418127-4310-10-git-send-email-khilman@ti.com>
References: <1303418127-4310-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:40910 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754390Ab1DUUds (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 16:33:48 -0400
Received: by pzk10 with SMTP id 10so62900pzk.21
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 13:33:47 -0700 (PDT)
In-Reply-To: <1303418127-4310-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/gpio.c |   74 ++++++++++++++++++--------------------------
 1 files changed, 30 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 8d80bf0..57530c0 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -922,45 +922,8 @@ static struct irq_chip gpio_irq_chip = {
 
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
@@ -1035,8 +998,6 @@ static inline void mpuio_init(void) {}
 
 #else
 
-extern struct irq_chip mpuio_irq_chip;
-
 #define bank_is_mpuio(bank)	0
 static inline void mpuio_init(void) {}
 
@@ -1236,6 +1197,30 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
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
+	irq_setup_generic_chip(gc, IRQ_MSK(num),
+				IRQ_NOREQUEST | IRQ_NOPROBE, 0);
+}
+
 static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 {
 	int j;
@@ -1273,12 +1258,13 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 		     j < bank->virtual_irq_start + bank->width; j++) {
 		irq_set_lockdep_class(j, &gpio_lock_class);
 		irq_set_chip_data(j, bank);
-		if (bank_is_mpuio(bank))
-			irq_set_chip(j, &mpuio_irq_chip);
-		else
+		if (bank_is_mpuio(bank)) {
+			omap_mpuio_alloc_gc(bank->base, j, bank->width);
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
1.7.4

