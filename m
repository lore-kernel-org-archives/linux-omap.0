From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
Date: Fri, 27 Apr 2012 19:43:38 +0530
Message-ID: <1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50697 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759972Ab2D0ONy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 10:13:54 -0400
In-Reply-To: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

We do checking for bank->enabled_non_wakeup_gpios in order
to skip redundant operations. Somehow, the check got missed
while doing the cleanup series.

Just to make sure that we do context restore correctly in
*_runtime_resume(), the bank->workaround_enabled check is
moved after context restore. Otherwise, it would prevent
context restore when bank->enabled_non_wakeup_gpios is 0.

Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d238f84..59a4af1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1160,6 +1160,9 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 
 	spin_lock_irqsave(&bank->lock, flags);
 
+	if (!bank->enabled_non_wakeup_gpios)
+		goto update_gpio_context_count;
+
 	/*
 	 * Only edges can generate a wakeup event to the PRCM.
 	 *
@@ -1235,11 +1238,6 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	__raw_writel(bank->context.risingdetect,
 		     bank->base + bank->regs->risingdetect);
 
-	if (!bank->workaround_enabled) {
-		spin_unlock_irqrestore(&bank->lock, flags);
-		return 0;
-	}
-
 	if (bank->get_context_loss_count) {
 		context_lost_cnt_after =
 			bank->get_context_loss_count(bank->dev);
@@ -1252,6 +1250,11 @@ static int omap_gpio_runtime_resume(struct device *dev)
 		}
 	}
 
+	if (!bank->workaround_enabled) {
+		spin_unlock_irqrestore(&bank->lock, flags);
+		return 0;
+	}
+
 	__raw_writel(bank->context.fallingdetect,
 			bank->base + bank->regs->fallingdetect);
 	__raw_writel(bank->context.risingdetect,
-- 
1.7.0.4

