From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v7 REPOST 18/24] gpio/omap: optimize suspend and resume functions
Date: Tue, 27 Sep 2011 05:44:14 +0530
Message-ID: <1317082460-31706-19-git-send-email-tarun.kanti@ti.com>
References: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43694 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267Ab1I0AOv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 20:14:51 -0400
In-Reply-To: <1317082460-31706-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

There is no need to operate on all the banks every time the function is called.
Just operate on the current bank passed by the framework.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   55 ++++++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index b5be8b8..b9ccf9e 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1044,6 +1044,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	platform_set_drvdata(pdev, bank);
+
 	pm_runtime_enable(bank->dev);
 	pm_runtime_irq_safe(bank->dev);
 	pm_runtime_get_sync(bank->dev);
@@ -1071,44 +1073,45 @@ err_exit:
 
 static int omap_gpio_suspend(struct device *dev)
 {
-	struct gpio_bank *bank;
-
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *base = bank->base;
-		void __iomem *wake_status;
-		unsigned long flags;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *base = bank->base;
+	void __iomem *wake_status;
+	unsigned long flags;
 
-		if (!bank->regs->wkup_en)
-			return 0;
+	if (!bank->mod_usage || !bank->loses_context)
+		return 0;
 
-		wake_status = bank->base + bank->regs->wkup_en;
+	if (!bank->regs->wkup_en || !bank->suspend_wakeup)
+		return 0;
 
-		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
-		pm_runtime_put_sync(dev);
-	}
+	wake_status = bank->base + bank->regs->wkup_en;
 
+	spin_lock_irqsave(&bank->lock, flags);
+	bank->saved_wakeup = __raw_readl(wake_status);
+	_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
+	pm_runtime_put_sync(dev);
 	return 0;
 }
 
 static int omap_gpio_resume(struct device *dev)
 {
-	struct gpio_bank *bank;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *base = bank->base;
+	unsigned long flags;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *base = bank->base;
-		unsigned long flags;
+	if (!bank->mod_usage || !bank->loses_context)
+		return 0;
 
-		if (!bank->regs->wkup_en)
-			return 0;
+	if (!bank->regs->wkup_en || !bank->saved_wakeup)
+		return 0;
 
-		pm_runtime_get_sync(dev);
-		spin_lock_irqsave(&bank->lock, flags);
-		_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	pm_runtime_get_sync(dev);
+	spin_lock_irqsave(&bank->lock, flags);
+	_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
-- 
1.7.0.4

