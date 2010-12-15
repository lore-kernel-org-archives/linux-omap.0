From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v6 11/12] OMAP: dmtimer: add timeout to low-level routines
Date: Wed, 15 Dec 2010 09:35:09 +0530
Message-ID: <1292385910-5234-12-git-send-email-tarun.kanti@ti.com>
References: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37484 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364Ab0LNRBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 12:01:45 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBEH1gm5008832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 11:01:44 -0600
In-Reply-To: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
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
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index e4849b7..4ef25de 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -41,6 +41,7 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/err.h>
+#include <plat/common.h>
 #include <plat/dmtimer.h>
 
 /* register offsets */
@@ -152,6 +153,7 @@
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
+#define MAX_WRITE_PEND_WAIT		10000 /* 10ms timeout delay */
 
 static LIST_HEAD(omap_timer_list);
 static DEFINE_SPINLOCK(dm_timer_lock);
@@ -168,16 +170,23 @@ static DEFINE_SPINLOCK(dm_timer_lock);
 static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 {
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+	int i = 0;
 
 	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
 		reg += pdata->func_offset;
 	else if (reg >= OMAP_TIMER_STAT_REG)
 		reg += pdata->intr_offset;
 
-	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
-			cpu_relax();
+	if (timer->posted) {
+		omap_test_timeout(!(readl(timer->io_base +
+			((OMAP_TIMER_WRITE_PEND_REG +
+			pdata->func_offset) & 0xff)) & (reg >> WPSHIFT)),
+			MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON_ONCE(i == MAX_WRITE_PEND_WAIT))
+			pr_err(": read timeout\n");
+	}
+
 	return readl(timer->io_base + (reg & 0xff));
 }
 
@@ -195,16 +204,23 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 						u32 value)
 {
 	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+	int i = 0;
 
 	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
 		reg += pdata->func_offset;
 	else if (reg >= OMAP_TIMER_STAT_REG)
 		reg += pdata->intr_offset;
 
-	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
-			cpu_relax();
+	if (timer->posted) {
+		omap_test_timeout(!(readl(timer->io_base +
+			((OMAP_TIMER_WRITE_PEND_REG +
+			pdata->func_offset) & 0xff)) & (reg >> WPSHIFT)),
+			MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON(i == MAX_WRITE_PEND_WAIT))
+			pr_err(": write timeout\n");
+	}
+
 	writel(value, timer->io_base + (reg & 0xff));
 }
 
-- 
1.6.0.4

