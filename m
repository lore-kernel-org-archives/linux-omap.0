From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 19/20] GPIO: OMAP: optimize suspend and resume functions
Date: Fri, 1 Jul 2011 15:17:13 +0530
Message-ID: <1309513634-20971-20-git-send-email-tarun.kanti@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51350 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755995Ab1GAJr4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 05:47:56 -0400
In-Reply-To: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

There is no need to operate on all the banks every time the function is called.
Just operate on the current bank passed by the framework.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |   56 ++++++++++++++++++++++-----------------------
 1 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 66eff1d..e9d2e1e 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1082,6 +1082,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	platform_set_drvdata(pdev, bank);
+
 	pm_runtime_enable(bank->dev);
 	pm_runtime_irq_safe(bank->dev);
 	if (IS_ERR_VALUE(pm_runtime_get_sync(bank->dev) < 0)) {
@@ -1114,26 +1116,24 @@ err_exit:
 
 static int omap_gpio_suspend(struct device *dev)
 {
-	struct gpio_bank *bank;
-
-	pm_runtime_get_sync(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *base = bank->base;
+	void __iomem *wake_status;
+	unsigned long flags;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *base = bank->base;
-		void __iomem *wake_status;
-		unsigned long flags;
+	if (!bank->regs->wkup_status)
+		return 0;
 
-		if (!bank->regs->wkup_status)
-			return 0;
+	wake_status = bank->base + bank->regs->wkup_status;
 
-		wake_status = bank->base + bank->regs->wkup_status;
+	pm_runtime_get_sync(dev);
 
-		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		MOD_REG_BIT(bank->regs->wkup_status, 0xffffffff, 0);
-		MOD_REG_BIT(bank->regs->wkup_status, bank->suspend_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	spin_lock_irqsave(&bank->lock, flags);
+	bank->saved_wakeup = __raw_readl(wake_status);
+	MOD_REG_BIT(bank->regs->wkup_status, 0xffffffff, 0);
+	MOD_REG_BIT(bank->regs->wkup_status, bank->suspend_wakeup, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
 	pm_runtime_put_sync(dev);
 
@@ -1142,22 +1142,20 @@ static int omap_gpio_suspend(struct device *dev)
 
 static int omap_gpio_resume(struct device *dev)
 {
-	struct gpio_bank *bank;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	void __iomem *base = bank->base;
+	unsigned long flags;
 
-	pm_runtime_get_sync(dev);
+	if (!bank->regs->wkup_status)
+		return 0;
 
-	list_for_each_entry(bank, &omap_gpio_list, node) {
-		void __iomem *base = bank->base;
-		unsigned long flags;
-
-		if (!bank->regs->wkup_status)
-			return 0;
+	pm_runtime_get_sync(dev);
 
-		spin_lock_irqsave(&bank->lock, flags);
-		MOD_REG_BIT(bank->regs->wkup_status, 0xffffffff, 0);
-		MOD_REG_BIT(bank->regs->wkup_status, bank->saved_wakeup, 1);
-		spin_unlock_irqrestore(&bank->lock, flags);
-	}
+	spin_lock_irqsave(&bank->lock, flags);
+	MOD_REG_BIT(bank->regs->wkup_status, 0xffffffff, 0);
+	MOD_REG_BIT(bank->regs->wkup_status, bank->saved_wakeup, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
 
 	pm_runtime_put_sync(dev);
 
-- 
1.6.0.4

