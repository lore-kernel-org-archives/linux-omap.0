From: Jan Luebbe <jlu@pengutronix.de>
Subject: [RFC PATCH] gpio/omap: fix pm_runtime for IRQ functions
Date: Fri, 18 Jan 2013 18:49:22 +0100
Message-ID: <1358531362-27933-1-git-send-email-jlu@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57727 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab3ARRti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 12:49:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, kernel@pengutronix.de, Jan Luebbe <jlu@pengutronix.de>

Other devices in the device tree can use omap-gpio as an interrupt
controller with something like:
	interrupt-parent = <&gpio1>;
	interrupts = <19 8>;
(in this case with #interrupt-cells = <2> in the gpio node to be able
to configure the IRQ flags in DT)

Currently this triggers an unhandled fault (external abort on non-
linefetch) because the gpio bank has been disabled by runtime pm.
The current driver keeps a reference count in omap_gpio_request
and omap_gpio_free, but these are not called when configuring
an IRQ via device tree. The current code expects that users
always request a gpio before trying to use the IRQ functions.
When using DT, this is no longer the case.

To fix this problem, I changed bank->mod_usage from per pin flags
to a simple refcount and update it from gpio_unmask_irq and
gpio_mask_irq, as well. Depending on the content of bank->mod_usage,
pm_runtime_get_sync and pm_runtime_put are called.

I'm unsure about the code to en-/disable the module clock gate.
Maybe it should be moved to omap_gpio_runtime_{suspend,resume} or
separate helpers?
Another unclear point is whether the pm_runtime_* calls have a too
large overhead for unmask/mask.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 drivers/gpio/gpio-omap.c |   65 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d335af1..51434f3 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -436,10 +436,16 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 		(type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
+	if (!bank->mod_usage)
+		pm_runtime_get_sync(bank->dev);
+
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = _set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), type);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
+	if (!bank->mod_usage)
+		pm_runtime_put(bank->dev);
+
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		__irq_set_handler_locked(d->irq, handle_level_irq);
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
@@ -621,7 +627,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		bank->context.ctrl = ctrl;
 	}
 
-	bank->mod_usage |= 1 << offset;
+	bank->mod_usage++;
 
 	spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -631,19 +637,18 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
-	void __iomem *base = bank->base;
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
 
 	if (bank->regs->wkup_en) {
 		/* Disable wake-up during idle for dynamic tick */
-		_gpio_rmw(base, bank->regs->wkup_en, 1 << offset, 0);
+		_gpio_rmw(bank->base, bank->regs->wkup_en, 1 << offset, 0);
 		bank->context.wake_en =
 			__raw_readl(bank->base + bank->regs->wkup_en);
 	}
 
-	bank->mod_usage &= ~(1 << offset);
+	bank->mod_usage--;
 
 	if (bank->regs->ctrl && !bank->mod_usage) {
 		void __iomem *reg = bank->base + bank->regs->ctrl;
@@ -781,7 +786,35 @@ static void gpio_mask_irq(struct irq_data *d)
 	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_irqenable(bank, gpio, 0);
 	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
+
+	if (bank->regs->wkup_en) {
+		/* Disable wake-up during idle for dynamic tick */
+		_gpio_rmw(bank->base, bank->regs->wkup_en, GPIO_BIT(bank, gpio), 0);
+		bank->context.wake_en =
+			__raw_readl(bank->base + bank->regs->wkup_en);
+	}
+
+	bank->mod_usage--;
+
+	if (bank->regs->ctrl && !bank->mod_usage) {
+		void __iomem *reg = bank->base + bank->regs->ctrl;
+		u32 ctrl;
+
+		ctrl = __raw_readl(reg);
+		/* Module is disabled, clocks are gated */
+		ctrl |= GPIO_MOD_CTRL_BIT;
+		__raw_writel(ctrl, reg);
+		bank->context.ctrl = ctrl;
+	}
+
 	spin_unlock_irqrestore(&bank->lock, flags);
+
+	/*
+	 * If this is the last gpio to be freed in the bank,
+	 * disable the bank module.
+	 */
+	if (!bank->mod_usage)
+		pm_runtime_put(bank->dev);
 }
 
 static void gpio_unmask_irq(struct irq_data *d)
@@ -792,7 +825,31 @@ static void gpio_unmask_irq(struct irq_data *d)
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
+	if (!bank->mod_usage)
+		pm_runtime_get_sync(bank->dev);
+
 	spin_lock_irqsave(&bank->lock, flags);
+
+	if (bank->regs->pinctrl) {
+		void __iomem *reg = bank->base + bank->regs->pinctrl;
+
+		/* Claim the pin for MPU */
+		__raw_writel(__raw_readl(reg) | (GPIO_BIT(bank, gpio)), reg);
+	}
+
+	if (bank->regs->ctrl && !bank->mod_usage) {
+		void __iomem *reg = bank->base + bank->regs->ctrl;
+		u32 ctrl;
+
+		ctrl = __raw_readl(reg);
+		/* Module is enabled, clocks are not gated */
+		ctrl &= ~GPIO_MOD_CTRL_BIT;
+		__raw_writel(ctrl, reg);
+		bank->context.ctrl = ctrl;
+	}
+
+	bank->mod_usage++;
+
 	if (trigger)
 		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
 
-- 
1.7.10.4

