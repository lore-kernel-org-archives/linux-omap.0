From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 09/13] gpio/omap: remove suspend/resume callbacks
Date: Wed, 7 Mar 2012 16:45:59 +0530
Message-ID: <1331118963-26364-10-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33549 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120Ab2CGLQP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Mar 2012 06:16:15 -0500
In-Reply-To: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Both omap_gpio_suspend() and omap_gpio_resume() does programming
of wakeup_en register.
_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);

This is redundant in omap_gpio_suspend() because wakeup_en
register automatically gets initialized in _set_gpio_wakeup()
and set_gpio_trigger() while being called either from
chip.irq_set_wake() or chip.irq_set_type().

This is redundant in omap_gpio_resume() because wakeup_en
register is programmed in omap_gpio_restore_context() called
which is called from runtime resume callback.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |   47 ----------------------------------------------
 1 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 186ce92..8b4a7ba 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1132,50 +1132,6 @@ err_exit:
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
-#if defined(CONFIG_PM_SLEEP)
-static int omap_gpio_suspend(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank *bank = platform_get_drvdata(pdev);
-	void __iomem *base = bank->base;
-	unsigned long flags;
-
-	if (!bank->mod_usage || !bank->loses_context)
-		return 0;
-
-	if (!bank->regs->wkup_en || !bank->context.wake_en)
-		return 0;
-
-	spin_lock_irqsave(&bank->lock, flags);
-	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
-	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
-	spin_unlock_irqrestore(&bank->lock, flags);
-
-	return 0;
-}
-
-static int omap_gpio_resume(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank *bank = platform_get_drvdata(pdev);
-	void __iomem *base = bank->base;
-	unsigned long flags;
-
-	if (!bank->mod_usage || !bank->loses_context)
-		return 0;
-
-	if (!bank->regs->wkup_en || !bank->context.wake_en)
-		return 0;
-
-	spin_lock_irqsave(&bank->lock, flags);
-	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
-	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
-	spin_unlock_irqrestore(&bank->lock, flags);
-
-	return 0;
-}
-#endif /* CONFIG_PM_SLEEP */
-
 #if defined(CONFIG_PM_RUNTIME)
 static void omap_gpio_restore_context(struct gpio_bank *bank);
 
@@ -1407,14 +1363,11 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 }
 #endif /* CONFIG_PM_RUNTIME */
 #else
-#define omap_gpio_suspend NULL
-#define omap_gpio_resume NULL
 #define omap_gpio_runtime_suspend NULL
 #define omap_gpio_runtime_resume NULL
 #endif
 
 static const struct dev_pm_ops gpio_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(omap_gpio_suspend, omap_gpio_resume)
 	SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_resume,
 									NULL)
 };
-- 
1.7.0.4

