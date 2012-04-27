From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 3/8] gpio/omap: remove suspend_wakeup field from struct gpio_bank
Date: Fri, 27 Apr 2012 19:43:33 +0530
Message-ID: <1335536018-16004-4-git-send-email-tarun.kanti@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50696 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759691Ab2D0ONz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 10:13:55 -0400
In-Reply-To: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

Since we already have bank->context.wake_en to keep track
of gpios which are wakeup enabled, there is no need to have
this field any more.

Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 1751f89..7b00256 100644
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
@@ -514,11 +513,11 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 
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
@@ -788,7 +787,7 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->saved_wakeup = __raw_readl(mask_reg);
-	__raw_writel(0xffff & ~bank->suspend_wakeup, mask_reg);
+	__raw_writel(0xffff & ~bank->context.wake_en, mask_reg);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1165,7 +1164,7 @@ static int omap_gpio_suspend(struct device *dev)
 	if (!bank->mod_usage || !bank->loses_context)
 		return 0;
 
-	if (!bank->regs->wkup_en || !bank->suspend_wakeup)
+	if (!bank->regs->wkup_en || !bank->context.wake_en)
 		return 0;
 
 	wakeup_enable = bank->base + bank->regs->wkup_en;
@@ -1173,7 +1172,7 @@ static int omap_gpio_suspend(struct device *dev)
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->saved_wakeup = __raw_readl(wakeup_enable);
 	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
-	_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
+	_gpio_rmw(base, bank->regs->wkup_en, bank->context.wake_en, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
-- 
1.7.0.4

