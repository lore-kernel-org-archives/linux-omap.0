From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv4 13/14] OMAP: dmtimer: remove reset function
Date: Sat, 20 Nov 2010 08:09:37 +0530
Message-ID: <1290220778-22244-14-git-send-email-tarun.kanti@ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-12-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-13-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40059 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755146Ab0KSPgj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 10:36:39 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAJFaZx0024137
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 09:36:38 -0600
In-Reply-To: <1290220778-22244-13-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

reset is handled by hwmod framework and so removing it
from the code.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   42 ++----------------------------------------
 1 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 8950fcd..f9285b1 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -273,54 +273,18 @@ void omap_dm_timer_write_intr_reg(struct omap_dm_timer *timer, u32 reg,
 	writel(value, timer->io_base + (reg & 0xff));
 }
 
-
-static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
-{
-	int c;
-
-	c = 0;
-	while (!(omap_dm_timer_read_reg(timer, OMAP_TIMER_SYS_STAT_REG) & 1)) {
-		c++;
-		if (c > 100000) {
-			printk(KERN_ERR "Timer failed to reset\n");
-			return;
-		}
-	}
-}
-
-static void omap_dm_timer_reset(struct omap_dm_timer *timer)
+static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
-	u32 l;
+	omap_dm_timer_enable(timer);
 
-	if (!cpu_class_is_omap2() || timer->id != 1) {
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
-		omap_dm_timer_wait_for_reset(timer);
-	}
 	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
-	l |= 0x02 << 3;  /* Set to smart-idle mode */
-	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
-
-	/*
-	 * Enable wake-up on OMAP2 CPUs.
-	 */
-	if (cpu_class_is_omap2())
-		l |= 1 << 2;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
-
 	/* Match hardware reset default of posted mode */
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
 			OMAP_TIMER_CTRL_POSTED);
 	timer->posted = 1;
 }
 
-static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
-{
-	omap_dm_timer_enable(timer);
-	omap_dm_timer_reset(timer);
-}
-
 struct omap_dm_timer *omap_dm_timer_request(void)
 {
 	struct omap_dm_timer *timer = NULL, *t;
@@ -372,8 +336,6 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
 
 void omap_dm_timer_free(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_enable(timer);
-	omap_dm_timer_reset(timer);
 	omap_dm_timer_disable(timer);
 
 	WARN_ON(!timer->reserved);
-- 
1.6.0.4

