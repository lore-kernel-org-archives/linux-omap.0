From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v5 19/22] gpio/omap: optimize suspend and resume functions
Date: Thu, 4 Aug 2011 16:34:50 +0530
Message-ID: <1312455893-14922-20-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57064 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab1HDLFS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Aug 2011 07:05:18 -0400
In-Reply-To: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

There is no need to operate on all the banks every time the function is called.
Just operate on the current bank passed by the framework.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |   54 +++++++++++++++++++++------------------------
 1 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e71cfcc..ce93898 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1051,6 +1051,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	platform_set_drvdata(pdev, bank);
+
 	pm_runtime_enable(bank->dev);
 	pm_runtime_irq_safe(bank->dev);
 	if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
@@ -1088,45 +1090,39 @@ err_exit:
 
 static int omap_gpio_suspend(struct device *dev)
 {
-	struct gpio_bank *bank;
-
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *base = bank->base;
-		void __iomem *wake_status;
-		unsigned long flags;
-
-		if (!bank->regs->wkup_status)
-			return 0;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *base = bank->base;
+	void __iomem *wake_status;
+	unsigned long flags;
 
-		wake_status = bank->base + bank->regs->wkup_status;
+	if (!bank->regs->wkup_status || !bank->suspend_wakeup)
+		return 0;
 
-		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		_gpio_rmw(base, bank->regs->wkup_status,
-					bank->suspend_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
-		pm_runtime_put_sync(dev);
-	}
+	wake_status = bank->base + bank->regs->wkup_status;
 
+	spin_lock_irqsave(&bank->lock, flags);
+	bank->saved_wakeup = __raw_readl(wake_status);
+	_gpio_rmw(base, bank->regs->wkup_status, bank->suspend_wakeup, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
+	pm_runtime_put_sync(dev);
 	return 0;
 }
 
 static int omap_gpio_resume(struct device *dev)
 {
-	struct gpio_bank *bank;
-
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *base = bank->base;
-		unsigned long flags;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *base = bank->base;
+	unsigned long flags;
 
-		if (!bank->regs->wkup_status)
-			return 0;
+	if (!bank->regs->wkup_status || !bank->saved_wakeup)
+		return 0;
 
-		pm_runtime_get_sync(dev);
-		spin_lock_irqsave(&bank->lock, flags);
-		_gpio_rmw(base, bank->regs->wkup_status, bank->saved_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	pm_runtime_get_sync(dev);
+	spin_lock_irqsave(&bank->lock, flags);
+	_gpio_rmw(base, bank->regs->wkup_status, bank->saved_wakeup, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
-- 
1.7.0.4

