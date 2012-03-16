From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 04/12] gpio/omap: remove saved_wakeup field from struct gpio_bank
Date: Fri, 16 Mar 2012 19:35:52 +0530
Message-ID: <1331906760-5259-5-git-send-email-tarun.kanti@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49823 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349Ab2CPOGN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 10:06:13 -0400
In-Reply-To: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

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
index 3a4f151..3b91ade 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -57,7 +57,6 @@ struct gpio_bank {
 	u16 irq;
 	int irq_base;
 	struct irq_domain *domain;
-	u32 saved_wakeup;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 	struct gpio_regs context;
@@ -777,7 +776,6 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	bank->saved_wakeup = __raw_readl(mask_reg);
 	__raw_writel(0xffff & ~bank->context.wake_en, mask_reg);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -793,7 +791,7 @@ static int omap_mpuio_resume_noirq(struct device *dev)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	__raw_writel(bank->saved_wakeup, mask_reg);
+	__raw_writel(bank->context.wake_en, mask_reg);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1153,7 +1151,6 @@ static int omap_gpio_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank *bank = platform_get_drvdata(pdev);
 	void __iomem *base = bank->base;
-	void __iomem *wakeup_enable;
 	unsigned long flags;
 
 	if (!bank->mod_usage || !bank->loses_context)
@@ -1162,10 +1159,7 @@ static int omap_gpio_suspend(struct device *dev)
 	if (!bank->regs->wkup_en || !bank->context.wake_en)
 		return 0;
 
-	wakeup_enable = bank->base + bank->regs->wkup_en;
-
 	spin_lock_irqsave(&bank->lock, flags);
-	bank->saved_wakeup = __raw_readl(wakeup_enable);
 	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
 	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -1183,12 +1177,12 @@ static int omap_gpio_resume(struct device *dev)
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

