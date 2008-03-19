From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dmtimer posting
Date: Wed, 19 Mar 2008 16:15:06 +0200
Message-ID: <20080319141504.GB14860@atomide.com>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA382@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54362 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756764AbYCSTg5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 15:36:57 -0400
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742903CCA382@dlee13.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Woodruff, Richard <r-woodruff2@ti.com> [080319 04:40]:
> Hi,
> 
> I've fixed the bits Kevin pointed out and ran checkpatch.pl and removed
> the reset of the errors.
> 
> This patch adds the use of write posting for the timer.  Previously,
> every write could lock the requestor for almost 3x32KHz cycles.  This
> now only synchronizes before writes and reads instead of after them and
> it does it on a register per register basis.  Doing it this way there is
> some chance to hide some of the sync latency.  It also removes some
> needless reads when non-posted mode is there.  With out this fix the
> read/writes talk almost 2% CPU load @500MHz just waiting on tick timer
> registers.

Cool. Here's a version that gets rid of the lookup table by encoding the
posted write pending bit into the reg offset. This should be OK, as the
functions are used within dmtimer.c only.

The init of other timers into posted mode is not done yet, so I changed
the timer->posted handling too.

Compile and boot tested only on N810 (2420).

Tony

--VbJkn9YxBvnuCH5J
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-dmtimer-posted-v2.patch"

>From 6f6611eb1558d580c20b5a6e476e7a04bde2b56d Mon Sep 17 00:00:00 2001
From: Richard Woodruff <r-woodruff2@ti.com>
Date: Wed, 19 Mar 2008 16:00:34 +0200
Subject: [PATCH] ARM: OMAP: Use posted mode for dmtimer

This patch adds the use of write posting for the timer.  Previously, every
write could lock the requestor for almost 3x32KHz cycles.  This patch only
synchronizes before writes and reads instead of after them and it does
it on per register basis.  Doing it this way there is some chance to hide
some of the sync latency.  It also removes some needless reads when
non-posted mode is there.  With out this fix the read/writes talk almost
2% CPU load @500MHz just waiting on tick timer registers.

Also define new 34xx only registers.

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -38,34 +38,113 @@
 #include <asm/arch/irqs.h>
 
 /* register offsets */
-#define OMAP_TIMER_ID_REG		0x00
-#define OMAP_TIMER_OCP_CFG_REG		0x10
-#define OMAP_TIMER_SYS_STAT_REG		0x14
-#define OMAP_TIMER_STAT_REG		0x18
-#define OMAP_TIMER_INT_EN_REG		0x1c
-#define OMAP_TIMER_WAKEUP_EN_REG	0x20
-#define OMAP_TIMER_CTRL_REG		0x24
-#define OMAP_TIMER_COUNTER_REG		0x28
-#define OMAP_TIMER_LOAD_REG		0x2c
-#define OMAP_TIMER_TRIGGER_REG		0x30
-#define OMAP_TIMER_WRITE_PEND_REG	0x34
-#define OMAP_TIMER_MATCH_REG		0x38
-#define OMAP_TIMER_CAPTURE_REG		0x3c
-#define OMAP_TIMER_IF_CTRL_REG		0x40
-
-/* timer control reg bits */
-#define OMAP_TIMER_CTRL_GPOCFG		(1 << 14)
-#define OMAP_TIMER_CTRL_CAPTMODE	(1 << 13)
-#define OMAP_TIMER_CTRL_PT		(1 << 12)
-#define OMAP_TIMER_CTRL_TCM_LOWTOHIGH	(0x1 << 8)
-#define OMAP_TIMER_CTRL_TCM_HIGHTOLOW	(0x2 << 8)
-#define OMAP_TIMER_CTRL_TCM_BOTHEDGES	(0x3 << 8)
-#define OMAP_TIMER_CTRL_SCPWM		(1 << 7)
-#define OMAP_TIMER_CTRL_CE		(1 << 6)	/* compare enable */
-#define OMAP_TIMER_CTRL_PRE		(1 << 5)	/* prescaler enable */
-#define OMAP_TIMER_CTRL_PTV_SHIFT	2		/* how much to shift the prescaler value */
-#define OMAP_TIMER_CTRL_AR		(1 << 1)	/* auto-reload enable */
-#define OMAP_TIMER_CTRL_ST		(1 << 0)	/* start timer */
+#define _OMAP_TIMER_ID_OFFSET		0x00
+#define _OMAP_TIMER_OCP_CFG_OFFSET	0x10
+#define _OMAP_TIMER_SYS_STAT_OFFSET	0x14
+#define _OMAP_TIMER_STAT_OFFSET		0x18
+#define _OMAP_TIMER_INT_EN_OFFSET	0x1c
+#define _OMAP_TIMER_WAKEUP_EN_OFFSET	0x20
+#define _OMAP_TIMER_CTRL_OFFSET		0x24
+#define _OMAP_TIMER_COUNTER_OFFSET	0x28
+#define _OMAP_TIMER_LOAD_OFFSET		0x2c
+#define _OMAP_TIMER_TRIGGER_OFFSET	0x30
+#define _OMAP_TIMER_WRITE_PEND_OFFSET	0x34
+#define		WP_NONE			0	/* no write pending bit */
+#define		WP_TCLR			(1 << 0)
+#define		WP_TCRR			(1 << 1)
+#define		WP_TLDR			(1 << 2)
+#define		WP_TTGR			(1 << 3)
+#define		WP_TMAR			(1 << 4)
+#define		WP_TPIR			(1 << 5)
+#define		WP_TNIR			(1 << 6)
+#define		WP_TCVR			(1 << 7)
+#define		WP_TOCR			(1 << 8)
+#define		WP_TOWR			(1 << 9)
+#define _OMAP_TIMER_MATCH_OFFSET	0x38
+#define _OMAP_TIMER_CAPTURE_OFFSET	0x3c
+#define _OMAP_TIMER_IF_CTRL_OFFSET	0x40
+#define		OMAP_TIMER_CTRL_GPOCFG		(1 << 14)
+#define		OMAP_TIMER_CTRL_CAPTMODE	(1 << 13)
+#define		OMAP_TIMER_CTRL_PT		(1 << 12)
+#define		OMAP_TIMER_CTRL_TCM_LOWTOHIGH	(0x1 << 8)
+#define		OMAP_TIMER_CTRL_TCM_HIGHTOLOW	(0x2 << 8)
+#define		OMAP_TIMER_CTRL_TCM_BOTHEDGES	(0x3 << 8)
+#define		OMAP_TIMER_CTRL_SCPWM		(1 << 7)
+#define		OMAP_TIMER_CTRL_CE		(1 << 6) /* compare enable */
+#define		OMAP_TIMER_CTRL_PRE		(1 << 5) /* prescaler enable */
+#define		OMAP_TIMER_CTRL_PTV_SHIFT	2 /* prescaler value shift */
+#define		OMAP_TIMER_CTRL_POSTED		(1 << 2)
+#define		OMAP_TIMER_CTRL_AR		(1 << 1) /* auto-reload enable */
+#define		OMAP_TIMER_CTRL_ST		(1 << 0) /* start timer */
+#define _OMAP_TIMER_CAPTURE2_OFFSET		0x44	/* TCAR2, 34xx only */
+#define _OMAP_TIMER_TICK_POS_OFFSET		0x48	/* TPIR, 34xx only */
+#define _OMAP_TIMER_TICK_NEG_OFFSET		0x4c	/* TNIR, 34xx only */
+#define _OMAP_TIMER_TICK_COUNT_OFFSET		0x50	/* TCVR, 34xx only */
+#define _OMAP_TIMER_TICK_INT_MASK_SET_OFFSET	0x54	/* TOCR, 34xx only */
+#define _OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET	0x58	/* TOWR, 34xx only */
+
+/* register offsets with the write pending bit encoded */
+#define	WPSHIFT					8
+
+#define OMAP_TIMER_ID_REG			(_OMAP_TIMER_ID_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_OCP_CFG_REG			(_OMAP_TIMER_OCP_CFG_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_SYS_STAT_REG			(_OMAP_TIMER_SYS_STAT_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_STAT_REG			(_OMAP_TIMER_STAT_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_INT_EN_REG			(_OMAP_TIMER_INT_EN_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_WAKEUP_EN_REG		(_OMAP_TIMER_WAKEUP_EN_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_CTRL_REG			(_OMAP_TIMER_CTRL_OFFSET \
+							| (WP_TCLR << WPSHIFT))
+
+#define OMAP_TIMER_COUNTER_REG			(_OMAP_TIMER_COUNTER_OFFSET \
+							| (WP_TCRR << WPSHIFT))
+
+#define OMAP_TIMER_LOAD_REG			(_OMAP_TIMER_LOAD_OFFSET \
+							| (WP_TLDR << WPSHIFT))
+
+#define OMAP_TIMER_TRIGGER_REG			(_OMAP_TIMER_TRIGGER_OFFSET \
+							| (WP_TTGR << WPSHIFT))
+
+#define OMAP_TIMER_WRITE_PEND_REG		(_OMAP_TIMER_WRITE_PEND_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_MATCH_REG			(_OMAP_TIMER_MATCH_OFFSET \
+							| (WP_TMAR << WPSHIFT))
+
+#define OMAP_TIMER_CAPTURE_REG			(_OMAP_TIMER_CAPTURE_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_IF_CTRL_REG			(_OMAP_TIMER_IF_CTRL_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_CAPTURE2_REG			(_OMAP_TIMER_CAPTURE2_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_TICK_POS_REG			(_OMAP_TIMER_TICK_POS_OFFSET \
+							| (WP_TPIR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_NEG_REG			(_OMAP_TIMER_TICK_NEG_OFFSET \
+							| (WP_TNIR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_COUNT_REG		(_OMAP_TIMER_TICK_COUNT_OFFSET \
+							| (WP_TCVR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_INT_MASK_SET_REG				\
+		(_OMAP_TIMER_TICK_INT_MASK_SET_OFFSET | (WP_TOCR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
+		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
 struct omap_dm_timer {
 	unsigned long phys_base;
@@ -76,6 +155,7 @@ struct omap_dm_timer {
 	void __iomem *io_base;
 	unsigned reserved:1;
 	unsigned enabled:1;
+	unsigned posted:1;
 };
 
 #ifdef CONFIG_ARCH_OMAP1
@@ -181,16 +261,34 @@ static struct clk **dm_source_clocks;
 
 static spinlock_t dm_timer_lock;
 
-static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, int reg)
+/*
+ * Reads timer registers in posted and non-posted mode. The posted mode bit
+ * is encoded in reg. Note that in posted mode write pending bit must be
+ * checked. Otherwise a read of a non completed write will produce an error.
+ */
+static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
 {
-	return readl(timer->io_base + reg);
+	if (timer->posted)
+		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
+				& (reg >> WPSHIFT))
+			;
+	return readl(timer->io_base + (reg & 0xff));
 }
 
-static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, int reg, u32 value)
+/*
+ * Writes timer registers in posted and non-posted mode. The posted mode bit
+ * is encoded in reg. Note that in posted mode the write pending bit must be
+ * checked. Otherwise a write on a register which has a pending write will be
+ * lost.
+ */
+static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
+						u32 value)
 {
-	writel(value, timer->io_base + reg);
-	while (omap_dm_timer_read_reg(timer, OMAP_TIMER_WRITE_PEND_REG))
-		;
+	if (timer->posted)
+		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
+				& (reg >> WPSHIFT))
+			;
+	writel(value, timer->io_base + (reg & 0xff));
 }
 
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
@@ -217,15 +315,21 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 	}
 	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
-	/* Set to smart-idle mode */
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
-	l |= 0x02 << 3;
-
-	if (cpu_class_is_omap2() && timer == &dm_timers[0]) {
-		/* Enable wake-up only for GPT1 on OMAP2 CPUs*/
+	l |= 0x02 << 3;  /* Set to smart-idle mode */
+	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
+
+	/*
+	 * Enable wake-up only for GPT1 on OMAP2 CPUs.
+	 * FIXME: All timers should have wake-up enabled and clear
+	 * PRCM status. Posted mode should be set by default.
+	 */
+	if (cpu_class_is_omap2() && (timer == &dm_timers[0])) {
 		l |= 1 << 2;
-		/* Non-posted mode */
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0);
+		/* Ensure posted mode */
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
+							OMAP_TIMER_CTRL_POSTED);
+		timer->posted = 1;
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
 }
@@ -434,6 +538,10 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 		l &= ~OMAP_TIMER_CTRL_AR;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
+
+	/* REVISIT: hw feature, ttgr overtaking tldr? */
+	while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG & 0xff)));
+
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 }
 
@@ -568,6 +676,7 @@ int __init omap_dm_timer_init(void)
 	for (i = 0; i < dm_timer_count; i++) {
 		timer = &dm_timers[i];
 		timer->io_base = (void __iomem *)io_p2v(timer->phys_base);
+		/* REVISIT: Set posted mode by default */
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		if (cpu_class_is_omap2()) {
 			char clk_name[16];


--VbJkn9YxBvnuCH5J--
