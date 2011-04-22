From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 09/18] OMAP: GPIO: cleanup gpio_irq_handler
Date: Fri, 22 Apr 2011 16:38:23 +0530
Message-ID: <1303470512-19671-10-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38710 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab1DVLFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 07:05:03 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Remove CONFIG_ARCH_OMAP* checks from gpio_irq_handler.

Also correct the multi-line comment style in the
gpio_irq_handler.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |   70 +++++++++++++++++---------------------------
 1 files changed, 27 insertions(+), 43 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 28f58c6..5fe6dbf 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -761,7 +761,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
  */
 static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
-	void __iomem *isr_reg = NULL;
+	u32 isr_val;
 	u32 isr;
 	unsigned int gpio_irq, gpio_index;
 	struct gpio_bank *bank;
@@ -771,58 +771,41 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	bank = irq_get_handler_data(irq);
-#ifdef CONFIG_ARCH_OMAP1
-	if (bank->method == METHOD_MPUIO)
-		isr_reg = bank->base +
-				OMAP_MPUIO_GPIO_INT / bank->stride;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-	if (bank->method == METHOD_GPIO_1510)
-		isr_reg = bank->base + OMAP1510_GPIO_INT_STATUS;
-#endif
-#if defined(CONFIG_ARCH_OMAP16XX)
-	if (bank->method == METHOD_GPIO_1610)
-		isr_reg = bank->base + OMAP1610_GPIO_IRQSTATUS1;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	if (bank->method == METHOD_GPIO_7XX)
-		isr_reg = bank->base + OMAP7XX_GPIO_INT_STATUS;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	if (bank->method == METHOD_GPIO_24XX)
-		isr_reg = bank->base + OMAP24XX_GPIO_IRQSTATUS1;
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
-	if (bank->method == METHOD_GPIO_44XX)
-		isr_reg = bank->base + OMAP4_GPIO_IRQSTATUS0;
-#endif
-
-	if (WARN_ON(!isr_reg))
-		goto exit;
 
 	while(1) {
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
 
+		if (bank->method == METHOD_MPUIO)
+			isr_val = gpio_mpuio_read(bank->base,
+					OMAP_MPUIO_GPIO_INT / bank->stride);
+		else
+			isr_val = gpio_fn.gpio_read(bank->base, IRQSTATUS_REG0);
+
 		enabled = _get_gpio_irqbank_mask(bank);
-		isr_saved = isr = __raw_readl(isr_reg) & enabled;
+		isr = isr_val & enabled;
+		isr_saved = isr;
 
-		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
+		/* Common for all MPUIO banks */
+		if (bank->method == METHOD_MPUIO)
 			isr &= 0x0000ffff;
 
-		if (cpu_class_is_omap2()) {
+		if (bank->method >= METHOD_GPIO_24XX)
 			level_mask = bank->level_mask & enabled;
-		}
 
-		/* clear edge sensitive interrupts before handler(s) are
-		called so that we don't miss any interrupt occurred while
-		executing them */
+		/*
+		 * clear edge sensitive interrupts before handler(s) are
+		 * called so that we don't miss any interrupt occurred
+		 * while executing them
+		 */
 		_enable_gpio_irqbank(bank, isr_saved & ~level_mask, 0);
 		_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
 		_enable_gpio_irqbank(bank, isr_saved & ~level_mask, 1);
 
-		/* if there is only edge sensitive GPIO pin interrupts
-		configured, we could unmask GPIO bank interrupt immediately */
+		/*
+		 * if there is only edge sensitive GPIO pin interrupts
+		 * configured, we could unmask GPIO bank interrupt immediately
+		 */
 		if (!level_mask && !unmasked) {
 			unmasked = 1;
 			desc->irq_data.chip->irq_unmask(&desc->irq_data);
@@ -853,11 +836,12 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			generic_handle_irq(gpio_irq);
 		}
 	}
-	/* if bank has any level sensitive GPIO pin interrupt
-	configured, we must unmask the bank interrupt only after
-	handler(s) are executed in order to avoid spurious bank
-	interrupt */
-exit:
+	/*
+	 * if bank has any level sensitive GPIO pin interrupt
+	 * configured, we must unmask the bank interrupt only after
+	 * handler(s) are executed in order to avoid spurious bank
+	 * interrupt
+	 */
 	if (!unmasked)
 		desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
-- 
1.7.1

