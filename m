From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH] ARM: OMAP: dmtimer: fix missing content/correction in low-power mode support
Date: Tue, 8 Nov 2011 11:30:26 +0530
Message-ID: <1320732026-6783-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52775 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234Ab1KHGAo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Nov 2011 01:00:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Since omap_dm_timer_write_reg/__omap_dm_timer_write is now modified
to use timer->func_base OCP_CFG should not use this wrapper anymore.
Instead use __raw_writel() directly and use timer->io_base instead
to write to OCP_CFG.

The timer->sys_stat is valid only if timer->revision is 1. In the
context restore function make this correction.

Save the contexts and loss count when timer is stopped.
Also, disable the clock. Else, clock usecount would become imbalanced.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
Baseline: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Branch: master
Linux 3.2-rc1

 arch/arm/plat-omap/dmtimer.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index af3b92b..f042c82 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -80,9 +80,9 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 
 static void omap_timer_restore_context(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_OFFSET,
-				timer->context.tiocp_cfg);
-	if (timer->revision > 1)
+	__raw_writel(timer->context.tiocp_cfg,
+			timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
+	if (timer->revision == 1)
 		__raw_writel(timer->context.tistat, timer->sys_stat);
 
 	__raw_writel(timer->context.tisr, timer->irq_stat);
@@ -357,6 +357,21 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
 
 	__omap_dm_timer_stop(timer, timer->posted, rate);
 
+	if (timer->loses_context) {
+		if (timer->get_context_loss_count)
+			timer->ctx_loss_count =
+			timer->get_context_loss_count(&timer->pdev->dev);
+	}
+
+	/*
+	 * Since the register values are computed and written within
+	 * __omap_dm_timer_stop, we need to use read to retrieve the
+	 * context.
+	 */
+	timer->context.tclr =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	timer->context.tisr = __raw_readl(timer->irq_stat);
+	omap_dm_timer_disable(timer);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
-- 
1.7.0.4

