From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 12/14] ARM: OMAP: Add dmtimer interrupt disable function
Date: Wed, 7 Nov 2012 13:01:28 -0600
Message-ID: <1352314890-22224-13-git-send-email-jon-hunter@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36397 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284Ab2KGTBy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 14:01:54 -0500
In-Reply-To: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
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

This change is required for OMAP4+ devices. For OMAP4, all timers apart from 1,
2 and 10 need this function and for OMAP5 all timers need this function.
Please note that the interrupt disable function has been written so that it
can be used by all OMAP devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c              |   31 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dmtimer.h |    3 ++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index e7bf0d1..508a38e 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -715,6 +715,37 @@ int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
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
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
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
index af145a9..14190e8 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -137,6 +137,7 @@ int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on, int toggle, i
 int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler);
 
 int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer, unsigned int value);
+int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask);
 
 unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer);
 int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value);
@@ -322,7 +323,7 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
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

