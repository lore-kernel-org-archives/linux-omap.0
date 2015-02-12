From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] gpio: omap: use raw locks for locking
Date: Thu, 12 Feb 2015 17:10:36 +0100
Message-ID: <1423757436-18986-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56928 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383AbbBLQKy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2015 11:10:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This patch converts gpio_bank.lock from a spin_lock into a
raw_spin_lock. The call path to access this lock is always under a
raw_spin_lock, for instance
- __setup_irq() holds &desc->lock with irq off
  + __irq_set_trigger()
   + omap_gpio_irq_type()

- handle_level_irq() (runs with irqs off therefore raw locks)
  + mask_ack_irq()
   + omap_gpio_mask_irq()

This fixes the obvious backtrace on -RT. However I noticed two cases
where it looks wrong and this is not limited to -RT:
- omap_gpio_irq_type() is called with IRQ off and has an conditional
  call to pm_runtime_get_sync() which may sleep. Either it may happen or
  it may not happen but pm_runtime_get_sync() should not be called in an
  atomic section.

- omap_gpio_debounce() is holding the lock with IRQs off.
  + omap2_set_gpio_debounce()
   + clk_prepare_enable()
    + clk_prepare() this one might sleep.
  The number of users of gpiod_set_debounce() / gpio_set_debounce()
  looks low but still this is not good.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/gpio/gpio-omap.c | 78 ++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f476ae2eb0b3..27e835f4c39d 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -57,7 +57,7 @@ struct gpio_bank {
 	u32 saved_datain;
 	u32 level_mask;
 	u32 toggle_mask;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct gpio_chip chip;
 	struct clk *dbck;
 	u32 mod_usage;
@@ -515,15 +515,15 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 		(type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	offset = GPIO_INDEX(bank, gpio);
 	retval = omap_set_gpio_triggering(bank, offset, type);
 	omap_gpio_init_irq(bank, gpio, offset);
 	if (!omap_gpio_is_input(bank, BIT(offset))) {
-		spin_unlock_irqrestore(&bank->lock, flags);
+		raw_spin_unlock_irqrestore(&bank->lock, flags);
 		return -EINVAL;
 	}
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
 		__irq_set_handler_locked(d->irq, handle_level_irq);
@@ -641,14 +641,14 @@ static int omap_set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	if (enable)
 		bank->context.wake_en |= gpio_bit;
 	else
 		bank->context.wake_en &= ~gpio_bit;
 
 	writel_relaxed(bank->context.wake_en, bank->base + bank->regs->wkup_en);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -683,7 +683,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	if (!BANK_USED(bank))
 		pm_runtime_get_sync(bank->dev);
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	/* Set trigger to none. You need to enable the desired trigger with
 	 * request_irq() or set_irq_type(). Only do this if the IRQ line has
 	 * not already been requested.
@@ -693,7 +693,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		omap_enable_gpio_module(bank, offset);
 	}
 	bank->mod_usage |= BIT(offset);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -703,11 +703,11 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	bank->mod_usage &= ~(BIT(offset));
 	omap_disable_gpio_module(bank, offset);
 	omap_reset_gpio(bank, bank->chip.base + offset);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
 	 * If this is the last gpio to be freed in the bank,
@@ -810,9 +810,9 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 	if (!BANK_USED(bank))
 		pm_runtime_get_sync(bank->dev);
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap_gpio_init_irq(bank, gpio, offset);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 	omap_gpio_unmask_irq(d);
 
 	return 0;
@@ -825,12 +825,12 @@ static void omap_gpio_irq_shutdown(struct irq_data *d)
 	unsigned long flags;
 	unsigned offset = GPIO_INDEX(bank, gpio);
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	gpiochip_unlock_as_irq(&bank->chip, offset);
 	bank->irq_usage &= ~(BIT(offset));
 	omap_disable_gpio_module(bank, offset);
 	omap_reset_gpio(bank, gpio);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
 	 * If this is the last IRQ to be freed in the bank,
@@ -854,10 +854,10 @@ static void omap_gpio_mask_irq(struct irq_data *d)
 	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
 	unsigned long flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap_set_gpio_irqenable(bank, gpio, 0);
 	omap_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static void omap_gpio_unmask_irq(struct irq_data *d)
@@ -868,7 +868,7 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	if (trigger)
 		omap_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
 
@@ -880,7 +880,7 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	}
 
 	omap_set_gpio_irqenable(bank, gpio, 1);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 /*---------------------------------------------------------------------*/
@@ -893,9 +893,9 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	writel_relaxed(0xffff & ~bank->context.wake_en, mask_reg);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -908,9 +908,9 @@ static int omap_mpuio_resume_noirq(struct device *dev)
 					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	writel_relaxed(bank->context.wake_en, mask_reg);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -956,9 +956,9 @@ static int omap_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 
 	bank = container_of(chip, struct gpio_bank, chip);
 	reg = bank->base + bank->regs->direction;
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	dir = !!(readl_relaxed(reg) & BIT(offset));
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 	return dir;
 }
 
@@ -968,9 +968,9 @@ static int omap_gpio_input(struct gpio_chip *chip, unsigned offset)
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap_set_gpio_direction(bank, offset, 1);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 	return 0;
 }
 
@@ -994,10 +994,10 @@ static int omap_gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	bank->set_dataout(bank, offset, value);
 	omap_set_gpio_direction(bank, offset, 0);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 	return 0;
 }
 
@@ -1009,9 +1009,9 @@ static int omap_gpio_debounce(struct gpio_chip *chip, unsigned offset,
 
 	bank = container_of(chip, struct gpio_bank, chip);
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap2_set_gpio_debounce(bank, offset, debounce);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -1022,9 +1022,9 @@ static void omap_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	bank->set_dataout(bank, offset, value);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 /*---------------------------------------------------------------------*/
@@ -1250,7 +1250,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	else
 		bank->set_dataout = omap_set_gpio_dataout_mask;
 
-	spin_lock_init(&bank->lock);
+	raw_spin_lock_init(&bank->lock);
 
 	/* Static mapping, never released */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1297,7 +1297,7 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 	unsigned long flags;
 	u32 wake_low, wake_hi;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 
 	/*
 	 * Only edges can generate a wakeup event to the PRCM.
@@ -1350,7 +1350,7 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 				bank->get_context_loss_count(bank->dev);
 
 	omap_gpio_dbck_disable(bank);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
@@ -1365,7 +1365,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	unsigned long flags;
 	int c;
 
-	spin_lock_irqsave(&bank->lock, flags);
+	raw_spin_lock_irqsave(&bank->lock, flags);
 
 	/*
 	 * On the first resume during the probe, the context has not
@@ -1401,14 +1401,14 @@ static int omap_gpio_runtime_resume(struct device *dev)
 			if (c != bank->context_loss_count) {
 				omap_gpio_restore_context(bank);
 			} else {
-				spin_unlock_irqrestore(&bank->lock, flags);
+				raw_spin_unlock_irqrestore(&bank->lock, flags);
 				return 0;
 			}
 		}
 	}
 
 	if (!bank->workaround_enabled) {
-		spin_unlock_irqrestore(&bank->lock, flags);
+		raw_spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 	}
 
@@ -1463,7 +1463,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	}
 
 	bank->workaround_enabled = false;
-	spin_unlock_irqrestore(&bank->lock, flags);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
-- 
2.1.4

