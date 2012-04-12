From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2] ARM: OMAP2+: dmtimer: remove redundant sysconfig context restore
Date: Thu, 12 Apr 2012 15:13:47 +0530
Message-ID: <1334223827-28812-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53587 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756600Ab2DLJnz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Apr 2012 05:43:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com, b-cousson@ti.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Since hwmod framework now manages sysconfig context save/restore
there is no more need to touch this register in driver. Hence,
remove restore of sysconfig register in omap_timer_restore_context.
This was causing incorrect context restore of sysconfig register.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
v2: removed tiocp_cfg from struct timer_regs {}

 arch/arm/plat-omap/dmtimer.c              |    2 --
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 652139c..15e7882 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -82,8 +82,6 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 
 static void omap_timer_restore_context(struct omap_dm_timer *timer)
 {
-	__raw_writel(timer->context.tiocp_cfg,
-			timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
 	if (timer->revision == 1)
 		__raw_writel(timer->context.tistat, timer->sys_stat);
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 9418f00..a4c08d0 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -75,7 +75,6 @@ struct clk;
 
 struct timer_regs {
 	u32 tidr;
-	u32 tiocp_cfg;
 	u32 tistat;
 	u32 tisr;
 	u32 tier;
-- 
1.7.0.4

