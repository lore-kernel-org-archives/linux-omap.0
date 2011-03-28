From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/10] omap: Make a subset of dmtimer functions into inline
	functions
Date: Mon, 28 Mar 2011 15:21:37 -0700
Message-ID: <20110328222137.4046.32363.stgit@baageli.muru.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20618 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab1C1WVj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 18:21:39 -0400
In-Reply-To: <20110328221501.4046.41079.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This will allow us to share the code between system timer and
dmtimer device driver code without having to initialize all
dmtimers early. It will also make the timer_set_next_event
more efficient as the inline functions will optimize the code
better in this case.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c              |   90 ++++++++++++++++-------------
 arch/arm/plat-omap/include/plat/dmtimer.h |   53 +++++++++++++++++
 2 files changed, 102 insertions(+), 41 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index dfdc3b2..ff9b732 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -170,11 +170,7 @@ static spinlock_t dm_timer_lock;
  */
 static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 {
-	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
-			cpu_relax();
-	return readl(timer->io_base + (reg & 0xff));
+	return __omap_dm_timer_read(timer->io_base, reg, timer->posted);
 }
 
 /*
@@ -186,11 +182,7 @@ static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
 						u32 value)
 {
-	if (timer->posted)
-		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
-			cpu_relax();
-	writel(value, timer->io_base + (reg & 0xff));
+	__omap_dm_timer_write(timer->io_base, reg, value, timer->posted);
 }
 
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
@@ -207,38 +199,54 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 	}
 }
 
-static void omap_dm_timer_reset(struct omap_dm_timer *timer)
+/* Assumes the source clock has been set by caller */
+void __omap_dm_timer_reset(struct omap_dm_timer *timer, int autoidle,
+				int wakeup)
 {
 	u32 l;
 
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
+	l |= 0x02 << 3;  /* Set to smart-idle mode */
+	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
+
+	if (autoidle)
+		l |= 0x1 << 0;
+
+	if (wakeup)
+		l |= 1 << 2;
+
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
+
+	/* Match hardware reset default of posted mode */
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
+			OMAP_TIMER_CTRL_POSTED);
+	timer->posted = 1;
+}
+
+static void omap_dm_timer_reset(struct omap_dm_timer *timer)
+{
+	int autoidle = 0, wakeup = 0;
+
 	if (!cpu_class_is_omap2() || timer != &dm_timers[0]) {
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 		omap_dm_timer_wait_for_reset(timer);
 	}
 	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
-	l |= 0x02 << 3;  /* Set to smart-idle mode */
-	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
-
 	/* Enable autoidle on OMAP2 / OMAP3 */
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		l |= 0x1 << 0;
+		autoidle = 1;
 
 	/*
 	 * Enable wake-up on OMAP2 CPUs.
 	 */
 	if (cpu_class_is_omap2())
-		l |= 1 << 2;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
+		wakeup = 1;
 
-	/* Match hardware reset default of posted mode */
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
-			OMAP_TIMER_CTRL_POSTED);
-	timer->posted = 1;
+	__omap_dm_timer_reset(timer, autoidle, wakeup);
 }
 
-static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
+void omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
 	omap_dm_timer_enable(timer);
 	omap_dm_timer_reset(timer);
@@ -449,16 +457,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
 #else
 
-int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
+int __omap_dm_timer_set_source(struct clk *timer_fck, struct clk *parent)
 {
-	int ret = -EINVAL;
-
-	if (source < 0 || source >= 3)
-		return -EINVAL;
+	int ret;
 
-	clk_disable(timer->fclk);
-	ret = clk_set_parent(timer->fclk, dm_source_clocks[source]);
-	clk_enable(timer->fclk);
+	clk_disable(timer_fck);
+	ret = clk_set_parent(timer_fck, parent);
+	clk_enable(timer_fck);
 
 	/*
 	 * When the functional clock disappears, too quick writes seem
@@ -468,6 +473,15 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 
 	return ret;
 }
+
+int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
+{
+	if (source < 0 || source >= 3)
+		return -EINVAL;
+
+	return __omap_dm_timer_set_source(timer->fclk,
+						dm_source_clocks[source]);
+}
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
 #endif
@@ -504,8 +518,7 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
 	}
 	l |= OMAP_TIMER_CTRL_ST;
 
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, load);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	__omap_dm_timer_load_start(timer->io_base, l, load, timer->posted);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
 
@@ -558,8 +571,7 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
 {
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_INT_EN_REG, value);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, value);
+	__omap_dm_timer_int_enable(timer->io_base, value);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 
@@ -575,17 +587,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
 
 void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG, value);
+	__omap_dm_timer_write_status(timer->io_base, value);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
 
 unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	unsigned int l;
-
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_COUNTER_REG);
-
-	return l;
+	return __omap_dm_timer_read_counter(timer->io_base, timer->posted);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 66c4b34..21ad28c 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -218,4 +218,57 @@ struct omap_dm_timer {
 	unsigned posted:1;
 };
 
+void __omap_dm_timer_reset(struct omap_dm_timer *timer, int autoidle,
+				int wakeup);
+void omap_dm_timer_prepare(struct omap_dm_timer *timer);
+int __omap_dm_timer_set_source(struct clk *timer_fck, struct clk *parent);
+void __omap_dm_timer_stop(void __iomem *base, int posted, unsigned long rate);
+
+static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg, int posted)
+{
+	if (posted)
+		while (__raw_readl(base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
+				& (reg >> WPSHIFT))
+			cpu_relax();
+
+	return __raw_readl(base + (reg & 0xff));
+}
+
+static inline void __omap_dm_timer_write(void __iomem *base, u32 reg, u32 val,
+						int posted)
+{
+	if (posted)
+		while (__raw_readl(base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
+				& (reg >> WPSHIFT))
+			cpu_relax();
+
+	__raw_writel(val, base + (reg & 0xff));
+}
+
+static inline void __omap_dm_timer_load_start(void __iomem *base, u32 ctrl,
+						unsigned int load, int posted)
+{
+	__omap_dm_timer_write(base, OMAP_TIMER_COUNTER_REG, load, posted);
+	__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG, ctrl, posted);
+}
+
+static inline void __omap_dm_timer_int_enable(void __iomem *base,
+						unsigned int value)
+{
+	__omap_dm_timer_write(base, OMAP_TIMER_INT_EN_REG, value, 0);
+	__omap_dm_timer_write(base, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
+}
+
+static inline unsigned int __omap_dm_timer_read_counter(void __iomem *base,
+							int posted)
+{
+	return __omap_dm_timer_read(base, OMAP_TIMER_COUNTER_REG, posted);
+}
+
+static inline void __omap_dm_timer_write_status(void __iomem *base,
+						unsigned int value)
+{
+	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG, value, 0);
+}
+
 #endif /* __ASM_ARCH_DMTIMER_H */

