From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 04/13] gpio/omap: remove saved_wakeup field from struct gpio_bank
Date: Wed, 7 Mar 2012 16:45:54 +0530
Message-ID: <1331118963-26364-5-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41130 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756219Ab2CGLQ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Mar 2012 06:16:27 -0500
In-Reply-To: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

There is no more need to have saved_wakeup because bank->context.wake_en
already holds that value. So getting rid of read/write operation associated
with this field.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 14c61e2..3765654 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -54,7 +54,6 @@ struct gpio_bank {
 	void __iomem *base;
 	u16 irq;
 	u16 virtual_irq_start;
-	u32 saved_wakeup;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 	struct gpio_regs context;
@@ -774,7 +773,6 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	bank->saved_wakeup = __raw_readl(mask_reg);
 	__raw_writel(0xffff & ~bank->context.wake_en, mask_reg);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -790,7 +788,7 @@ static int omap_mpuio_resume_noirq(struct device *dev)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	__raw_writel(bank->saved_wakeup, mask_reg);
+	__raw_writel(bank->context.wake_en, mask_reg);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1143,7 +1141,6 @@ static int omap_gpio_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank *bank = platform_get_drvdata(pdev);
 	void __iomem *base = bank->base;
-	void __iomem *wakeup_enable;
 	unsigned long flags;
 
 	if (!bank->mod_usage || !bank->loses_context)
@@ -1152,10 +1149,7 @@ static int omap_gpio_suspend(struct device *dev)
 	if (!bank->regs->wkup_en || !bank->context.wake_en)
 		return 0;
 
-	wakeup_enable = bank->base + bank->regs->wkup_en;
-
 	spin_lock_irqsave(&bank->lock, flags);
-	bank->saved_wakeup = __raw_readl(wakeup_enable);
 	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
 	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -1173,12 +1167,12 @@ static int omap_gpio_resume(struct device *dev)
 	if (!bank->mod_usage || !bank->loses_context)
 		return 0;
 
-	if (!bank->regs->wkup_en || !bank->saved_wakeup)
+	if (!bank->regs->wkup_en || !bank->context.wake_en)
 		return 0;
 
 	spin_lock_irqsave(&bank->lock, flags);
 	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
-	_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
+	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
-- 
1.7.0.4

