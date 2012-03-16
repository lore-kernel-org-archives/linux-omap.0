From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v4 11/12] gpio/omap: fix incorrect context restore logic in omap_gpio_runtime_*
Date: Fri, 16 Mar 2012 19:35:59 +0530
Message-ID: <1331906760-5259-12-git-send-email-tarun.kanti@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48754 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965208Ab2CPOGX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 10:06:23 -0400
In-Reply-To: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

In omap_gpio_runtime_suspend/resume() the context save/restore should
be independent of bank->enabled_non_wakeup_gpios. This was preventing
context restore of GPIO lines which are not wakeup enabled.

Reported-by: Govindraj Raja <govindraj.raja@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 072a841..c5aff7c 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1187,9 +1187,6 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
 	 * generated.  See OMAP2420 Errata item 1.101.
 	 */
-	if (!(bank->enabled_non_wakeup_gpios))
-		goto update_gpio_context_count;
-
 	bank->saved_datain = __raw_readl(bank->base +
 						bank->regs->datain);
 	l1 = bank->context.fallingdetect;
@@ -1236,7 +1233,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	__raw_writel(bank->context.risingdetect,
 		     bank->base + bank->regs->risingdetect);
 
-	if (!bank->enabled_non_wakeup_gpios || !bank->workaround_enabled) {
+	if (!bank->workaround_enabled) {
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 	}
-- 
1.7.0.4

