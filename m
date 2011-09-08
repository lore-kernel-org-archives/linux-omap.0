From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v15 08/12] OMAP: dmtimer: add timeout to low-level routines
Date: Fri, 9 Sep 2011 02:38:14 +0530
Message-ID: <1315516098-29761-9-git-send-email-tarun.kanti@ti.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The low-level read and write access routines wait on write-pending register
in posted mode to make sure that previous write is complete on respective
registers. This waiting is done in an infinite while loop. Now it is being
modified to use timeout instead.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/plat-omap/include/plat/dmtimer.h |   35 ++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 5368140..41723f4 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -37,6 +37,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
+#include <plat/common.h>
+
 #ifndef __ASM_ARCH_DMTIMER_H
 #define __ASM_ARCH_DMTIMER_H
 
@@ -231,6 +233,9 @@ int omap_dm_timers_active(void);
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
+/* 10ms timeout delay */
+#define MAX_WRITE_PEND_WAIT            10000
+
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int id;
@@ -252,11 +257,16 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer);
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
@@ -264,11 +274,16 @@ static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,
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
1.7.0.4
