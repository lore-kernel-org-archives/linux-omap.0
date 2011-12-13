From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v9 17/31] gpio/omap: optimize suspend and resume functions
Date: Wed, 14 Dec 2011 01:50:19 +0530
Message-ID: <1323807633-23713-18-git-send-email-tarun.kanti@ti.com>
References: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45739 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912Ab1LMUVG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 15:21:06 -0500
In-Reply-To: <1323807633-23713-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

There is no need to operate on all the banks every time the function is called.
Just operate on the current bank passed by the framework.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   54 ++++++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e5dd3bb..174aa06 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1055,6 +1055,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	platform_set_drvdata(pdev, bank);
+
 	pm_runtime_enable(bank->dev);
 	pm_runtime_irq_safe(bank->dev);
 	pm_runtime_get_sync(bank->dev);
@@ -1082,44 +1084,46 @@ err_exit:
 
 static int omap_gpio_suspend(struct device *dev)
 {
-	struct gpio_bank *bank;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *base = bank->base;
+	void __iomem *wakeup_enable;
+	unsigned long flags;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *base = bank->base;
-		void __iomem *wake_status;
-		unsigned long flags;
+	if (!bank->mod_usage || !bank->loses_context)
+		return 0;
 
-		if (!bank->regs->wkup_en)
-			return 0;
+	if (!bank->regs->wkup_en || !bank->suspend_wakeup)
+		return 0;
 
-		wake_status = bank->base + bank->regs->wkup_en;
+	wakeup_enable = bank->base + bank->regs->wkup_en;
 
-		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
-		_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	spin_lock_irqsave(&bank->lock, flags);
+	bank->saved_wakeup = __raw_readl(wakeup_enable);
+	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
+	_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
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
 
-		spin_lock_irqsave(&bank->lock, flags);
-		_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
-		_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	spin_lock_irqsave(&bank->lock, flags);
+	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
+	_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
-- 
1.7.0.4

