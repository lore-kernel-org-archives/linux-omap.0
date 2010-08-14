From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv2 8/13] dmtimer: OMAP: multi-platform register access support
Date: Sat, 14 Aug 2010 21:06:19 +0530
Message-ID: <1281800179-15085-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45237 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100Ab0HNEhE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Aug 2010 00:37:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch uses the new register structures and mappings in functions
in order to access register offsets thereby supporting multi-platform
environment.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |   51 ++++++++++++++++++++++++++++++++----------
 1 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 14a20e0..24ca283 100755
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -154,6 +154,7 @@ struct omap_dm_timer {
 	unsigned long fclk_rate;
 	int irq;
 	void __iomem *io_base;
+	u32	*regs;
 	unsigned reserved:1;
 	unsigned enabled:1;
 	unsigned posted:1;
@@ -174,13 +175,14 @@ static DEFINE_SPINLOCK(dm_timer_lock);
  * pending bit must be checked. Otherwise a read of a non completed write
  * will produce an error.
  **/
-static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
+static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, int reg)
 {
 	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
+		while (readl(timer->io_base + \
+			((timer->regs[OMAP_TIMER_WRITE_PEND_REG]) & 0xff))
+				& (timer->regs[reg] >> WPSHIFT))
 			cpu_relax();
-	return readl(timer->io_base + (reg & 0xff));
+	return readl(timer->io_base + (timer->regs[reg] & 0xff));
 }
 
 /**
@@ -193,25 +195,38 @@ static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
  * pending bit must be checked. Otherwise a write on a register which has a
  * pending write will be lost.
  **/
-static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
+static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, int reg,
 						u32 value)
 {
 	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
+		while (readl(timer->io_base + \
+			((timer->regs[OMAP_TIMER_WRITE_PEND_REG]) & 0xff))
+				& (timer->regs[reg] >> WPSHIFT))
 			cpu_relax();
-	writel(value, timer->io_base + (reg & 0xff));
+	writel(value, timer->io_base + (timer->regs[reg] & 0xff));
 }
 
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 {
 	int c;
+	u32 reg;
+	int reset_is_active;
+	struct omap_dmtimer_platform_data *pdata = \
+					timer->pdev->dev.platform_data;
+
+	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
+		reg = OMAP_TIMER_OCP_CFG_REG;
+		reset_is_active = 1;
+	} else {
+		reg = OMAP_TIMER_SYS_STAT_REG;
+		reset_is_active = 0;
+	}
 
 	c = 0;
-	while (!(omap_dm_timer_read_reg(timer, OMAP_TIMER_SYS_STAT_REG) & 1)) {
+	while (omap_dm_timer_read_reg(timer, reg) == reset_is_active) {
 		c++;
 		if (c > 100000) {
-			printk(KERN_ERR "Timer failed to reset\n");
+			printk(KERN_ERR "%s:Timer failed to reset\n", __func__);
 			return;
 		}
 	}
@@ -500,10 +515,17 @@ void omap_dm_timer_set_int_disable(struct omap_dm_timer *timer,
 					unsigned int value)
 {
 	u32 l;
+	struct omap_dmtimer_platform_data *pdata = \
+					timer->pdev->dev.platform_data;
 
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG);
-	l &= ~value;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_INT_EN_REG, l);
+	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2) {
+		l |= value;
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_INT_CLR_REG, value);
+	} else {
+		l &= ~value;
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_INT_EN_REG, l);
+	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_disable);
@@ -624,6 +646,11 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_release_ioregion;
 	}
+	if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_2)
+		timer->regs = (u32 *) omap4_reg_map;
+	else
+		timer->regs = (u32 *) reg_map;
+
 	timer->io_base = ioremap(mem->start, resource_size(mem));
 	if (!timer->io_base) {
 		dev_err(&pdev->dev, "%s: ioremap failed\n", __func__);
-- 
1.6.0.4

