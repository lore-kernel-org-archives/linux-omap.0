From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v13 08/11] OMAP: dmtimer: add timeout to low-level routines
Date: Sat, 16 Apr 2011 21:21:00 +0530
Message-ID: <1302969063-8231-9-git-send-email-tarun.kanti@ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52594 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755969Ab1DPPu0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Apr 2011 11:50:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3GFoNNV009652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 16 Apr 2011 10:50:25 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p3GFoMo7026799
	for <linux-omap@vger.kernel.org>; Sat, 16 Apr 2011 21:20:22 +0530 (IST)
In-Reply-To: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
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
 arch/arm/plat-omap/include/plat/dmtimer.h |   33 ++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 53fd69b..b1c8091 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -37,6 +37,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <plat/common.h>
 
 /* clock sources */
 #define OMAP_TIMER_SRC_SYS_CLK			0x00
@@ -229,6 +230,8 @@ int omap_dm_timers_active(void);
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
+#define MAX_WRITE_PEND_WAIT            10000 /* 10ms timeout delay */
+
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int id;
@@ -254,11 +257,16 @@ void __omap_dm_timer_reset(struct omap_dm_timer *timer, int autoidle,
 static inline u32
 __omap_dm_timer_read(void __iomem *base, u32 reg, int posted, u8 func_offset)
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
+			(reg >> WPSHIFT)), MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON_ONCE(i == MAX_WRITE_PEND_WAIT))
+			pr_err("read timeout.\n");
+	}
 
 	return __raw_readl(base + (reg & 0xff));
 }
@@ -266,11 +274,16 @@ __omap_dm_timer_read(void __iomem *base, u32 reg, int posted, u8 func_offset)
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
+			(reg >> WPSHIFT)), MAX_WRITE_PEND_WAIT, i);
+
+		if (WARN_ON(i == MAX_WRITE_PEND_WAIT))
+			pr_err("write timeout.\n");
+	}
 
 	__raw_writel(val, base + (reg & 0xff));
 }
-- 
1.6.0.4

