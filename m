From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v5 12/12] OMAP: dmtimer: add timeout to low-level routines
Date: Tue,  7 Dec 2010 05:14:19 +0530
Message-ID: <1291679059-13419-13-git-send-email-tarun.kanti@ti.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38876 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043Ab0LFMkp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 07:40:45 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB6CefJH002484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 6 Dec 2010 06:40:44 -0600
In-Reply-To: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

The low-level read and write access routines wait on
write-pending register in posted mode to make sure that
previous write is complete on respective registers.
This waiting is done in an infinite while loop. Now it
is being modified to use timeout instead.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   33 +++++++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index d51a459..26e5af1 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -47,6 +47,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/err.h>
 #include <mach/hardware.h>
+#include <plat/common.h>
 #include <plat/dmtimer.h>
 #include <mach/irqs.h>
 
@@ -159,6 +160,8 @@
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
+#define MAX_WRITE_PEND_WAIT		10000 /* 10ms timeout delay */
+
 struct omap_dm_timer {
 	int irq;
 	struct clk *fclk;
@@ -185,14 +188,21 @@ static DEFINE_SPINLOCK(dm_timer_lock);
 static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 {
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+	int i = 0;
+
 	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
 		reg += pdata->func_offset;
 	else if (reg >= OMAP_TIMER_STAT_REG)
 		reg += pdata->intr_offset;
-	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
-			cpu_relax();
+
+	if (timer->posted) {
+		omap_test_timeout(!(readl(timer->io_base +
+			((OMAP_TIMER_WRITE_PEND_REG +
+			pdata->func_offset) & 0xff)) & (reg >> WPSHIFT)),
+			MAX_WRITE_PEND_WAIT, i);
+		WARN_ON(i == MAX_WRITE_PEND_WAIT);
+	}
+
 	return readl(timer->io_base + (reg & 0xff));
 }
 
@@ -210,14 +220,21 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 						u32 value)
 {
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+	int i = 0;
+
 	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
 		reg += pdata->func_offset;
 	else if (reg >= OMAP_TIMER_STAT_REG)
 		reg += pdata->intr_offset;
-	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
-			cpu_relax();
+
+	if (timer->posted) {
+		omap_test_timeout(!(readl(timer->io_base +
+			((OMAP_TIMER_WRITE_PEND_REG +
+			pdata->func_offset) & 0xff)) & (reg >> WPSHIFT)),
+			MAX_WRITE_PEND_WAIT, i);
+		WARN_ON(i == MAX_WRITE_PEND_WAIT);
+	}
+
 	writel(value, timer->io_base + (reg & 0xff));
 }
 
-- 
1.6.0.4

