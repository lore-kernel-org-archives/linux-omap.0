From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 03/12] gpio/omap: remove suspend_wakeup field from struct gpio_bank
Date: Fri, 16 Mar 2012 19:35:51 +0530
Message-ID: <1331906760-5259-4-git-send-email-tarun.kanti@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49840 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965200Ab2CPOGX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 10:06:23 -0400
In-Reply-To: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Since we already have bank->context.wake_en to keep track
of gpios which are wakeup enabled, there is no need to have
this field any more.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 171f951..3a4f151 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -57,7 +57,6 @@ struct gpio_bank {
 	u16 irq;
 	int irq_base;
 	struct irq_domain *domain;
-	u32 suspend_wakeup;
 	u32 saved_wakeup;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
@@ -505,11 +504,11 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	if (enable)
-		bank->suspend_wakeup |= gpio_bit;
+		bank->context.wake_en |= gpio_bit;
 	else
-		bank->suspend_wakeup &= ~gpio_bit;
+		bank->context.wake_en &= ~gpio_bit;
 
-	__raw_writel(bank->suspend_wakeup, bank->base + bank->regs->wkup_en);
+	__raw_writel(bank->context.wake_en, bank->base + bank->regs->wkup_en);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -779,7 +778,7 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->saved_wakeup = __raw_readl(mask_reg);
-	__raw_writel(0xffff & ~bank->suspend_wakeup, mask_reg);
+	__raw_writel(0xffff & ~bank->context.wake_en, mask_reg);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1160,7 +1159,7 @@ static int omap_gpio_suspend(struct device *dev)
 	if (!bank->mod_usage || !bank->loses_context)
 		return 0;
 
-	if (!bank->regs->wkup_en || !bank->suspend_wakeup)
+	if (!bank->regs->wkup_en || !bank->context.wake_en)
 		return 0;
 
 	wakeup_enable = bank->base + bank->regs->wkup_en;
@@ -1168,7 +1167,7 @@ static int omap_gpio_suspend(struct device *dev)
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->saved_wakeup = __raw_readl(wakeup_enable);
 	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
-	_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
+	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
-- 
1.7.0.4

