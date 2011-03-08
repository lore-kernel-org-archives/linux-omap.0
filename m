From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v12 8/9] OMAP: dmtimer: add timeout to low-level routines
Date: Wed,  9 Mar 2011 05:15:47 +0530
Message-ID: <1299627948-20040-9-git-send-email-tarun.kanti@ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51430 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756423Ab1CHXnb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 18:43:31 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p28NhS9r025338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 17:43:30 -0600
In-Reply-To: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

The low-level read and write access routines wait on write-pending register
in posted mode to make sure that previous write is complete on respective
registers. This waiting is done in an infinite while loop. Now it is being
modified to use timeout instead.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   35 +++++++++++++++++++++++++++--------
 1 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index fe258a2..aea0b5d 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -44,6 +44,7 @@
 #include <linux/platform_device.h>
 
 #include <plat/dmtimer.h>
+#include <plat/common.h>
 
 /* register offsets */
 #define _OMAP_TIMER_ID_OFFSET		0x00
@@ -161,6 +162,8 @@
 #define VERSION2_TIMER_WAKEUP_EN_REG_OFFSET     0x14
 #define VERSION2_TIMER_STAT_REG_OFFSET          0x10
 
+#define MAX_WRITE_PEND_WAIT		10000 /* 10ms timeout delay */
+
 static LIST_HEAD(omap_timer_list);
 static DEFINE_SPINLOCK(dm_timer_lock);
 
@@ -175,15 +178,23 @@ static DEFINE_SPINLOCK(dm_timer_lock);
  */
 static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 {
+	int i = 0;
+
 	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
 		reg += timer->func_offset;
 	else if (reg >= OMAP_TIMER_STAT_REG)
 		reg += timer->intr_offset;
 
-	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
-			cpu_relax();
+	if (timer->posted) {
+		omap_test_timeout(!(readl(timer->io_base +
+			((OMAP_TIMER_WRITE_PEND_REG +
+			timer->func_offset) & 0xff)) & (reg >> WPSHIFT)),
+			MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON_ONCE(i == MAX_WRITE_PEND_WAIT))
+			dev_err(&timer->pdev->dev, "read timeout.\n");
+	}
+
 	return readl(timer->io_base + (reg & 0xff));
 }
 
@@ -200,15 +211,23 @@ static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 						u32 value)
 {
+	int i = 0;
+
 	if (reg >= OMAP_TIMER_WAKEUP_EN_REG)
 		reg += timer->func_offset;
 	else if (reg >= OMAP_TIMER_STAT_REG)
 		reg += timer->intr_offset;
 
-	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
-			cpu_relax();
+	if (timer->posted) {
+		omap_test_timeout(!(readl(timer->io_base +
+			((OMAP_TIMER_WRITE_PEND_REG +
+			timer->func_offset) & 0xff)) & (reg >> WPSHIFT)),
+			MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON(i == MAX_WRITE_PEND_WAIT))
+			dev_err(&timer->pdev->dev, "write timeout.\n");
+	}
+
 	writel(value, timer->io_base + (reg & 0xff));
 }
 
-- 
1.6.0.4

