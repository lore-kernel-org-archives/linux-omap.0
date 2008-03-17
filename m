From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/14] ARM: OMAP: Clear level-triggered GPIO interrupts in unmask hook
Date: Mon, 17 Mar 2008 11:42:29 +0200
Message-ID: <1205746958-11242-6-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
 <1205746958-11242-2-git-send-email-tony@atomide.com>
 <1205746958-11242-3-git-send-email-tony@atomide.com>
 <1205746958-11242-4-git-send-email-tony@atomide.com>
 <1205746958-11242-5-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62334 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbYCQJna (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:30 -0400
In-Reply-To: <1205746958-11242-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>

From: Kevin Hilman <khilman@mvista.com>

The clearing was moved to the unmask hook because it is known to run
after the interrupt handler has actually run.  Before this patch, if
interrupts are threaded, the clearing/unmasking of level triggered
interrupts would be done before the threaded handler actually ran.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 56889fd..4f104e4 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -148,6 +148,7 @@ struct gpio_bank {
 	u32 saved_fallingdetect;
 	u32 saved_risingdetect;
 #endif
+	u32 level_mask;
 	spinlock_t lock;
 	struct gpio_chip chip;
 };
@@ -538,6 +539,9 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
 	}
 
+	bank->level_mask =
+		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
+		__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 	/*
 	 * FIXME: Possibly do 'set_irq_handler(j, handle_level_irq)' if only
 	 * level triggering requested.
@@ -1021,12 +1025,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			isr &= 0x0000ffff;
 
 		if (cpu_class_is_omap2()) {
-			level_mask =
-				__raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0) |
-				__raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
-			level_mask &= enabled;
+			level_mask = bank->level_mask & enabled;
 		}
 
 		/* clear edge sensitive interrupts before handler(s) are
@@ -1088,14 +1087,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 				retrigger |= irq_mask;
 			}
 		}
-
-		if (cpu_class_is_omap2()) {
-			/* clear level sensitive interrupts after handler(s) */
-			_enable_gpio_irqbank(bank, isr_saved & level_mask, 0);
-			_clear_gpio_irqbank(bank, isr_saved & level_mask);
-			_enable_gpio_irqbank(bank, isr_saved & level_mask, 1);
-		}
-
 	}
 	/* if bank has any level sensitive GPIO pin interrupt
 	configured, we must unmask the bank interrupt only after
@@ -1134,6 +1125,14 @@ static void gpio_unmask_irq(unsigned int irq)
 {
 	unsigned int gpio = irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = get_irq_chip_data(irq);
+	unsigned int irq_mask = 1 << get_gpio_index(gpio);
+
+	/* For level-triggered GPIOs, the clearing must be done after
+	 * the HW source is cleared, thus after the handler has run */
+	if (bank->level_mask & irq_mask) {
+		_set_gpio_irqenable(bank, gpio, 0);
+		_clear_gpio_irqstatus(bank, gpio);
+	}
 
 	_set_gpio_irqenable(bank, gpio, 1);
 }
-- 
1.5.3.6

