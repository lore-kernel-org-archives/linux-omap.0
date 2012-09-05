From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 07/10] ARM: OMAP: Clean-up dmtimer reset code
Date: Wed, 5 Sep 2012 14:04:29 -0500
Message-ID: <1346871872-24413-8-git-send-email-jon-hunter@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32783 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759005Ab2IETEw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 15:04:52 -0400
In-Reply-To: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Only OMAP1 devices use the omap_dm_timer_reset() and so require the
omap_dm_timer_wait_for_reset() and __omap_dm_timer_reset() functions.
Therefore combine these into a single function called omap_dm_timer_reset()
and simplify the code.

Please note that for OMAP1 devices, the TIOCP_CFG register does not have the
clock-activity field and so when we reset the timer for an OMAP1 device we
only need to configure the idle-mode field in the TIOCP_CFG register.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   40 +++++++++++++++++------------
 arch/arm/plat-omap/include/plat/dmtimer.h |   19 --------------
 2 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 623c1f3..1eb7353 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -43,6 +43,7 @@
 
 #include <plat/dmtimer.h>
 #include <plat/omap-pm.h>
+#include <plat/omap_hwmod.h>
 
 #include <mach/hardware.h>
 
@@ -103,32 +104,34 @@ static void omap_timer_restore_context(struct omap_dm_timer *timer)
 				timer->context.tclr);
 }
 
-static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
+static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
-	int c;
+	u32 l, timeout = 0;
 
 	if (!timer->sys_stat)
-		return;
+		return -EINVAL;
+
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 
-	c = 0;
 	while (!(__raw_readl(timer->sys_stat) & 1)) {
-		c++;
-		if (c > 100000) {
-			printk(KERN_ERR "Timer failed to reset\n");
-			return;
+		if (timeout++ > 100000) {
+			dev_err(&timer->pdev->dev, "Timer failed to reset\n");
+			return -ETIMEDOUT;
 		}
 	}
-}
 
-static void omap_dm_timer_reset(struct omap_dm_timer *timer)
-{
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
-	omap_dm_timer_wait_for_reset(timer);
-	__omap_dm_timer_reset(timer, 0, 0);
+	/* Configure timer for smart-idle mode */
+	l = __raw_readl(timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
+	l |= __ffs(HWMOD_IDLEMODE_SMART) << SYSC_TYPE1_SIDLEMODE_SHIFT;
+	__raw_writel(l, timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
+
+	return 0;
 }
 
 int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
+	int rc;
+
 	/*
 	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
 	 * do not call clk_get() for these devices.
@@ -144,8 +147,13 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 
 	omap_dm_timer_enable(timer);
 
-	if (timer->capability & OMAP_TIMER_NEEDS_RESET)
-		omap_dm_timer_reset(timer);
+	if (timer->capability & OMAP_TIMER_NEEDS_RESET) {
+		rc = omap_dm_timer_reset(timer);
+		if (rc) {
+			omap_dm_timer_disable(timer);
+			return rc;
+		}
+	}
 
 	__omap_dm_timer_enable_posted(timer);
 	omap_dm_timer_disable(timer);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index fa9d04b..6488a19 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -331,25 +331,6 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
 	}
 }
 
-/* Assumes the source clock has been set by caller */
-static inline void __omap_dm_timer_reset(struct omap_dm_timer *timer,
-					int autoidle, int wakeup)
-{
-	u32 l;
-
-	l = __raw_readl(timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
-	l |= 0x02 << 3;  /* Set to smart-idle mode */
-	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
-
-	if (autoidle)
-		l |= 0x1 << 0;
-
-	if (wakeup)
-		l |= 1 << 2;
-
-	__raw_writel(l, timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
-}
-
 static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
 {
 	if (timer->posted)
-- 
1.7.9.5

