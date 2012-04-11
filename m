From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH] ARM: OMAP2+: remove redundant sysconfig context restore
Date: Wed, 11 Apr 2012 14:04:16 +0530
Message-ID: <1334133256-20475-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51996 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab2DKIe0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 04:34:26 -0400
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
 arch/arm/plat-omap/dmtimer.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

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
 
-- 
1.7.0.4

