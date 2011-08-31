From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v6 18/25] gpio/omap: optimize suspend and resume functions
Date: Wed, 31 Aug 2011 19:12:34 +0530
Message-ID: <1314798161-19523-19-git-send-email-tarun.kanti@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34806 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079Ab1HaNni (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2011 09:43:38 -0400
In-Reply-To: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

There is no need to operate on all the banks every time the function is called.
Just operate on the current bank passed by the framework.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |   53 +++++++++++++++++++++------------------------
 1 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f36931a..a267a30 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1047,6 +1047,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	platform_set_drvdata(pdev, bank);
+
 	pm_runtime_enable(bank->dev);
 	pm_runtime_irq_safe(bank->dev);
 	if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
@@ -1082,44 +1084,39 @@ err_exit:
 
 static int omap_gpio_suspend(struct device *dev)
 {
-	struct gpio_bank *bank;
-
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *base = bank->base;
-		void __iomem *wake_status;
-		unsigned long flags;
-
-		if (!bank->regs->wkup_en)
-			return 0;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *base = bank->base;
+	void __iomem *wake_status;
+	unsigned long flags;
 
-		wake_status = bank->base + bank->regs->wkup_en;
+	if (!bank->regs->wkup_en || !bank->suspend_wakeup)
+		return 0;
 
-		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		MOD_REG_BIT(bank->regs->wkup_en, bank->suspend_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
-		pm_runtime_put_sync(dev);
-	}
+	wake_status = bank->base + bank->regs->wkup_en;
 
+	spin_lock_irqsave(&bank->lock, flags);
+	bank->saved_wakeup = __raw_readl(wake_status);
+	MOD_REG_BIT(bank->regs->wkup_en, bank->suspend_wakeup, 1);
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
 
-		if (!bank->regs->wkup_en)
-			return 0;
+	if (!bank->regs->wkup_en || !bank->saved_wakeup)
+		return 0;
 
-		pm_runtime_get_sync(dev);
-		spin_lock_irqsave(&bank->lock, flags);
-		MOD_REG_BIT(bank->regs->wkup_en, bank->saved_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	pm_runtime_get_sync(dev);
+	spin_lock_irqsave(&bank->lock, flags);
+	MOD_REG_BIT(bank->regs->wkup_en, bank->saved_wakeup, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
-- 
1.7.0.4

