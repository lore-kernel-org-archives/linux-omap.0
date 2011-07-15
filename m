From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v14 REPOST 08/12] OMAP: dmtimer: add timeout to low-level routines
Date: Fri, 15 Jul 2011 17:34:57 +0530
Message-ID: <1310731501-13078-9-git-send-email-tarun.kanti@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103Ab1GOMFa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 08:05:30 -0400
In-Reply-To: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

The low-level read and write access routines wait on write-pending register
in posted mode to make sure that previous write is complete on respective
registers. This waiting is done in an infinite while loop. Now it is being
modified to use timeout instead.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/include/plat/dmtimer.h |   34 ++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 53d5da6..6e34094 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -36,6 +36,8 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 
+#include <plat/common.h>
+
 #ifndef __ASM_ARCH_DMTIMER_H
 #define __ASM_ARCH_DMTIMER_H
 
@@ -230,6 +232,8 @@ int omap_dm_timers_active(void);
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
+#define MAX_WRITE_PEND_WAIT            10000 /* 10ms timeout delay */
+
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int id;
@@ -251,11 +255,16 @@ void omap_dm_timer_prepare(struct omap_dm_timer *timer);
 static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,
 						int posted, u8 func_offset)
 {
-	if (posted)
-		while (__raw_readl(base +
-			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff))
-				& (reg >> WPSHIFT))
-			cpu_relax();
+	int i = 0;
+
+	if (posted) {
+		omap_test_timeout(!(__raw_readl(base +
+			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff)) &
+				(reg >> WPSHIFT)), MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON_ONCE(i == MAX_WRITE_PEND_WAIT))
+			pr_err("read timeout.\n");
+	}
 
 	return __raw_readl(base + (reg & 0xff));
 }
@@ -263,11 +272,16 @@ static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,
 static inline void __omap_dm_timer_write(void __iomem *base, u32 reg, u32 val,
 						int posted, u8 func_offset)
 {
-	if (posted)
-		while (__raw_readl(base +
-			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff))
-				& (reg >> WPSHIFT))
-			cpu_relax();
+	int i = 0;
+
+	if (posted) {
+		omap_test_timeout(!(__raw_readl(base +
+			((OMAP_TIMER_WRITE_PEND_REG + func_offset) & 0xff)) &
+				(reg >> WPSHIFT)), MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON(i == MAX_WRITE_PEND_WAIT))
+			pr_err("write timeout.\n");
+	}
 
 	__raw_writel(val, base + (reg & 0xff));
 }
-- 
1.6.0.4

