From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [RESEND PATCH 2/4] ARM: OMAP: dmtimer: raw read and write endian fix
Date: Tue, 15 Apr 2014 20:37:47 +0300
Message-ID: <1397583469-14457-3-git-send-email-taras.kondratiuk@linaro.org>
References: <1397583469-14457-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:61206 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbaDORiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2014 13:38:04 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so8145374eek.9
        for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2014 10:38:03 -0700 (PDT)
In-Reply-To: <1397583469-14457-1-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Victor Kamensky <victor.kamensky@linaro.org>, Taras Kondratiuk <taras.kondratiuk@linaro.org>

From: Victor Kamensky <victor.kamensky@linaro.org>

All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
Need to use endian neutral functions to read/write h/w registers.
I.e instead of __raw_read[lw] and __raw_write[lw] functions code
need to use read[lw]_relaxed and write[lw]_relaxed functions.
If the first simply reads/writes register, the second will byteswap
it if host operates in BE mode.

Changes are trivial sed like replacement of __raw_xxx functions
with xxx_relaxed variant.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 arch/arm/plat-omap/dmtimer.c              |    8 ++++----
 arch/arm/plat-omap/include/plat/dmtimer.h |   16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 869254c..db10169 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -103,7 +103,7 @@ static void omap_timer_restore_context(struct omap_dm_timer *timer)
 				timer->context.tmar);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
 				timer->context.tsicr);
-	__raw_writel(timer->context.tier, timer->irq_ena);
+	writel_relaxed(timer->context.tier, timer->irq_ena);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG,
 				timer->context.tclr);
 }
@@ -699,9 +699,9 @@ int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 	omap_dm_timer_enable(timer);
 
 	if (timer->revision == 1)
-		l = __raw_readl(timer->irq_ena) & ~mask;
+		l = readl_relaxed(timer->irq_ena) & ~mask;
 
-	__raw_writel(l, timer->irq_dis);
+	writel_relaxed(l, timer->irq_dis);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 
@@ -722,7 +722,7 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 		return 0;
 	}
 
-	l = __raw_readl(timer->irq_stat);
+	l = readl_relaxed(timer->irq_stat);
 
 	return l;
 }
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 2861b15..dd79f30 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -280,20 +280,20 @@ static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
 						int posted)
 {
 	if (posted)
-		while (__raw_readl(timer->pend) & (reg >> WPSHIFT))
+		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
 			cpu_relax();
 
-	return __raw_readl(timer->func_base + (reg & 0xff));
+	return readl_relaxed(timer->func_base + (reg & 0xff));
 }
 
 static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
 					u32 reg, u32 val, int posted)
 {
 	if (posted)
-		while (__raw_readl(timer->pend) & (reg >> WPSHIFT))
+		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
 			cpu_relax();
 
-	__raw_writel(val, timer->func_base + (reg & 0xff));
+	writel_relaxed(val, timer->func_base + (reg & 0xff));
 }
 
 static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
@@ -301,7 +301,7 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
 	u32 tidr;
 
 	/* Assume v1 ip if bits [31:16] are zero */
-	tidr = __raw_readl(timer->io_base);
+	tidr = readl_relaxed(timer->io_base);
 	if (!(tidr >> 16)) {
 		timer->revision = 1;
 		timer->irq_stat = timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
@@ -385,7 +385,7 @@ static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
 	}
 
 	/* Ack possibly pending interrupt */
-	__raw_writel(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
+	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
 }
 
 static inline void __omap_dm_timer_load_start(struct omap_dm_timer *timer,
@@ -399,7 +399,7 @@ static inline void __omap_dm_timer_load_start(struct omap_dm_timer *timer,
 static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
 						unsigned int value)
 {
-	__raw_writel(value, timer->irq_ena);
+	writel_relaxed(value, timer->irq_ena);
 	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
 }
 
@@ -412,7 +412,7 @@ __omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
 static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
 						unsigned int value)
 {
-	__raw_writel(value, timer->irq_stat);
+	writel_relaxed(value, timer->irq_stat);
 }
 
 #endif /* __ASM_ARCH_DMTIMER_H */
-- 
1.7.9.5

