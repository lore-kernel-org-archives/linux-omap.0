From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 09/10] ARM: OMAP: Add dmtimer interrupt disable function
Date: Wed, 5 Sep 2012 14:04:31 -0500
Message-ID: <1346871872-24413-10-git-send-email-jon-hunter@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32789 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759005Ab2IETE4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 15:04:56 -0400
In-Reply-To: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The OMAP dmtimer driver does not currently have a function to disable the
timer interrupts. For some timer instances the timer interrupt enable
function can be used to disable the interrupts because the same interrupt
enable register is used to disable interrupts. However, some timer instances
have separate interrupt enable/disable registers and so this will not work.
Therefore, add a dedicated function to disable interrupts.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   31 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dmtimer.h |    3 ++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 541adbb..3b548dc 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -612,6 +612,37 @@ int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
 
+/**
+ * omap_dm_timer_set_int_disable - disable timer interrupts
+ * @timer:	pointer to timer handle
+ * @mask:	bit mask of interrupts to be disabled
+ *
+ * Disables the specified timer interrupts for a timer.
+ */
+int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
+{
+	u32 l = mask;
+
+	if (unlikely(!timer))
+		return -EINVAL;
+
+	omap_dm_timer_enable(timer);
+
+	if (timer->revision == 1)
+		l = __raw_readl(timer->irq_ena) & ~mask;
+
+	__raw_writel(l, timer->irq_dis);
+	l = __omap_dm_timer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
+	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
+
+	/* Save the context */
+	timer->context.tier &= ~mask;
+	timer->context.twer &= ~mask;
+	omap_dm_timer_disable(timer);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_disable);
+
 unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
 	unsigned int l;
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index b3150a3..820f0ce 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -130,6 +130,7 @@ int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on, int toggle, i
 int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler);
 
 int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer, unsigned int value);
+int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask);
 
 unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer);
 int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value);
@@ -314,7 +315,7 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
 				OMAP_TIMER_V1_SYS_STAT_OFFSET;
 		timer->irq_stat = timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
 		timer->irq_ena = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
-		timer->irq_dis = NULL;
+		timer->irq_dis = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
 		timer->pend = timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
 		timer->func_base = timer->io_base;
 	} else {
-- 
1.7.9.5

