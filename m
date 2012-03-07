From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 03/13] gpio/omap: remove suspend_wakeup field from struct gpio_bank
Date: Wed, 7 Mar 2012 16:45:53 +0530
Message-ID: <1331118963-26364-4-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41120 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120Ab2CGLQS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Mar 2012 06:16:18 -0500
In-Reply-To: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

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
index 895df7f..14c61e2 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -54,7 +54,6 @@ struct gpio_bank {
 	void __iomem *base;
 	u16 irq;
 	u16 virtual_irq_start;
-	u32 suspend_wakeup;
 	u32 saved_wakeup;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
@@ -500,11 +499,11 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 
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
@@ -776,7 +775,7 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->saved_wakeup = __raw_readl(mask_reg);
-	__raw_writel(0xffff & ~bank->suspend_wakeup, mask_reg);
+	__raw_writel(0xffff & ~bank->context.wake_en, mask_reg);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1150,7 +1149,7 @@ static int omap_gpio_suspend(struct device *dev)
 	if (!bank->mod_usage || !bank->loses_context)
 		return 0;
 
-	if (!bank->regs->wkup_en || !bank->suspend_wakeup)
+	if (!bank->regs->wkup_en || !bank->context.wake_en)
 		return 0;
 
 	wakeup_enable = bank->base + bank->regs->wkup_en;
@@ -1158,7 +1157,7 @@ static int omap_gpio_suspend(struct device *dev)
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->saved_wakeup = __raw_readl(wakeup_enable);
 	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
-	_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
+	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
-- 
1.7.0.4

