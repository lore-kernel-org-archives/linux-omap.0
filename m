From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2 1/9] gpio/omap: remove saved_fallingdetect, saved_risingdetect fields
Date: Thu, 1 Mar 2012 04:14:21 +0530
Message-ID: <1330555469-21260-2-git-send-email-tarun.kanti@ti.com>
References: <1330555469-21260-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32786 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276Ab2B2Won (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 17:44:43 -0500
In-Reply-To: <1330555469-21260-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Since we already have context.fallingdetect and context.risingdetect
there is no more need to have these additional fields. Also, getting
rid of extra reads associated with them.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 752ae9b..c9369d2 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -60,8 +60,6 @@ struct gpio_bank {
 	u32 enabled_non_wakeup_gpios;
 	struct gpio_regs context;
 	u32 saved_datain;
-	u32 saved_fallingdetect;
-	u32 saved_risingdetect;
 	u32 level_mask;
 	u32 toggle_mask;
 	spinlock_t lock;
@@ -1234,11 +1232,9 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 
 	bank->saved_datain = __raw_readl(bank->base +
 						bank->regs->datain);
-	l1 = __raw_readl(bank->base + bank->regs->fallingdetect);
-	l2 = __raw_readl(bank->base + bank->regs->risingdetect);
+	l1 = bank->context.fallingdetect;
+	l2 = bank->context.risingdetect;
 
-	bank->saved_fallingdetect = l1;
-	bank->saved_risingdetect = l2;
 	l1 &= ~bank->enabled_non_wakeup_gpios;
 	l2 &= ~bank->enabled_non_wakeup_gpios;
 
@@ -1297,9 +1293,9 @@ static int omap_gpio_runtime_resume(struct device *dev)
 		}
 	}
 
-	__raw_writel(bank->saved_fallingdetect,
+	__raw_writel(bank->context.fallingdetect,
 			bank->base + bank->regs->fallingdetect);
-	__raw_writel(bank->saved_risingdetect,
+	__raw_writel(bank->context.risingdetect,
 			bank->base + bank->regs->risingdetect);
 	l = __raw_readl(bank->base + bank->regs->datain);
 
@@ -1316,14 +1312,15 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	 * No need to generate IRQs for the rising edge for gpio IRQs
 	 * configured with falling edge only; and vice versa.
 	 */
-	gen0 = l & bank->saved_fallingdetect;
+	gen0 = l & bank->context.fallingdetect;
 	gen0 &= bank->saved_datain;
 
-	gen1 = l & bank->saved_risingdetect;
+	gen1 = l & bank->context.risingdetect;
 	gen1 &= ~(bank->saved_datain);
 
 	/* FIXME: Consider GPIO IRQs with level detections properly! */
-	gen = l & (~(bank->saved_fallingdetect) & ~(bank->saved_risingdetect));
+	gen = l & (~(bank->context.fallingdetect) &
+					 ~(bank->context.risingdetect));
 	/* Consider all GPIO IRQs needed to be updated */
 	gen |= gen0 | gen1;
 
-- 
1.7.0.4

