From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/8] ARM: OMAP: Clean-up dmtimer reset code
Date: Tue, 13 Nov 2012 12:13:16 -0600
Message-ID: <1352830403-1706-2-git-send-email-jon-hunter@ti.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40700 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111Ab2KMSNb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 13:13:31 -0500
In-Reply-To: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Only OMAP1 devices use the omap_dm_timer_reset() and so require the
omap_dm_timer_wait_for_reset() and __omap_dm_timer_reset() functions.
Therefore combine these into a single function called omap_dm_timer_reset()
and simplify the code.

The omap_dm_timer_reset() function is now the only place that is using the
omap_dm_timer structure member "sys_stat". Therefore, remove this member and
just use the register offset definition to simplify and clean-up the code. The
TISTAT register is only present on revision 1 timers and so check for this in
the omap_dm_timer_reset() function.

Please note that for OMAP1 devices, the TIOCP_CFG register does not have the
clock-activity field and so when we reset the timer for an OMAP1 device we
only need to configure the idle-mode field in the TIOCP_CFG register.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   50 ++++++++++++++++++-----------
 arch/arm/plat-omap/include/plat/dmtimer.h |   23 -------------
 2 files changed, 31 insertions(+), 42 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 9deeb30..4c28452 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -99,32 +99,39 @@ static void omap_timer_restore_context(struct omap_dm_timer *timer)
 				timer->context.tclr);
 }
 
-static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
+static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
-	int c;
+	u32 l, timeout = 100000;
 
-	if (!timer->sys_stat)
-		return;
+	if (timer->revision != 1)
+		return -EINVAL;
 
-	c = 0;
-	while (!(__raw_readl(timer->sys_stat) & 1)) {
-		c++;
-		if (c > 100000) {
-			printk(KERN_ERR "Timer failed to reset\n");
-			return;
-		}
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
+
+	do {
+		l = __omap_dm_timer_read(timer,
+					 OMAP_TIMER_V1_SYS_STAT_OFFSET, 0);
+	} while (!l && timeout--);
+
+	if (!timeout) {
+		dev_err(&timer->pdev->dev, "Timer failed to reset\n");
+		return -ETIMEDOUT;
 	}
-}
 
-static void omap_dm_timer_reset(struct omap_dm_timer *timer)
-{
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
-	omap_dm_timer_wait_for_reset(timer);
-	__omap_dm_timer_reset(timer, 0, 0);
+	/* Configure timer for smart-idle mode */
+	l = __omap_dm_timer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET, 0);
+	l |= 0x2 << 0x3;
+	__omap_dm_timer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET, l, 0);
+
+	timer->posted = 0;
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
@@ -140,8 +147,13 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 
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
index 05a36e1..c5c890d 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -267,7 +267,6 @@ struct omap_dm_timer {
 	struct clk *fclk;
 
 	void __iomem	*io_base;
-	void __iomem	*sys_stat;	/* TISTAT timer status */
 	void __iomem	*irq_stat;	/* TISR/IRQSTATUS interrupt status */
 	void __iomem	*irq_ena;	/* irq enable */
 	void __iomem	*irq_dis;	/* irq disable, only on v2 ip */
@@ -317,8 +316,6 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
 	tidr = __raw_readl(timer->io_base);
 	if (!(tidr >> 16)) {
 		timer->revision = 1;
-		timer->sys_stat = timer->io_base +
-				OMAP_TIMER_V1_SYS_STAT_OFFSET;
 		timer->irq_stat = timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
 		timer->irq_ena = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
 		timer->irq_dis = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
@@ -326,7 +323,6 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
 		timer->func_base = timer->io_base;
 	} else {
 		timer->revision = 2;
-		timer->sys_stat = NULL;
 		timer->irq_stat = timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
 		timer->irq_ena = timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
 		timer->irq_dis = timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;
@@ -337,25 +333,6 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
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
 /*
  * __omap_dm_timer_enable_posted - enables write posted mode
  * @timer:      pointer to timer instance handle
-- 
1.7.9.5

