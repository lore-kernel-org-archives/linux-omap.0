From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: [PATCH] [RFC] dmtimer library is very inefficient today
Date: Fri, 14 Mar 2008 19:24:34 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903C4A2ED@dlee13.ent.ti.com>
References: <ae36f8040803061301y6e0823a8pbdf0b6f0b47e5639@mail.gmail.com> <3B6D69C3A9EBCA4BA5DA60D91302742903AFC880@dlee13.ent.ti.com> <20080307071454.GC7635@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36771 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbYCOAYo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2008 20:24:44 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080307071454.GC7635@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi,
  
> Yeah, I agree. We should be able to optimize at least the GPT0 writes
> into just few instructions as it's done for every timer interrupt.
> >
> > One side note is the code only enables the wake up function for
GPT1.
> > This seems wrong also.  You almost always want all devices which
should
> > be able to generate an interrupt to generate a wake up event.  If
you
> > don't do this you might wait for the dynamic tick interval before
> > recognizing an event when you are in interconnect clock stop.  You
do
> > have to clear status else you will miss chip retention, but this is
well
> > worth the trivial extra work in power savings.
> 
> Sure, that makes sense. Got any patches around?

Here is a patch to look at it.  Seems to work for me.  It adds the use
of posting for the timer.  Previously, every write could lock the
requestor for almost 3x32KHz cycles.  This now only synchronizes before
writes and reads instead of after them and it does it on a register per
register basis.  Doing it this way there is some chance to hide some of
the sync latency.  It also removes some needless reads when non-posted
mode is there.

The code probably would be a little smaller if a wpost[256] were used.
Probably the structure comes in on the cache line read so it is not like
its adding so much with the ARM running in the hundreds of MHz range. 

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 302ad8d..c635180 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -67,6 +67,41 @@
 #define OMAP_TIMER_CTRL_AR		(1 << 1)	/* auto-reload
enable */
 #define OMAP_TIMER_CTRL_ST		(1 << 0)	/* start timer
*/
 
+/* Write posting bit shift table
+ * - Values are register shift for TWPS status bits
+ * - Use of this avoids 32KHz Synchronization penalties. The cost is
almost 
+ *   a 3x32KHz stall.  This is compared to a 166MHz posted access.
+ * - A value of '15' is a shift which always returns 0
+ *   for registers which are not postable
+ *
+ * Note: Faster code can be generated if a larger array is used.
+ */
+#define PROW	6
+#define PCOL	4
+#define WPINDEX(off)	(wpost[off >> 4][(off & 0xf) >> 2])
+
+#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_OMAP2)
+static unsigned char wpost[PROW][PCOL] = {
+			/* 0, 4, 8, c */
+/* 00 */	{15, 15, 15, 15},
+/* 10 */	{15, 15, 15, 15},
+/* 20 */	{15,  0,  1,  2},
+/* 30 */	{ 3, 15,  4, 15},
+/* 40 */	{15, 15, 15, 15},
+/* 50 */	{15, 15, 15, 15},
+};
+#else /* OMAP3 */
+static unsigned char wpost[PROW][PCOL] = {
+			/* 0, 4, 8, c */
+/* 00 */	{15, 15, 15, 15},
+/* 10 */	{15, 15, 15, 15},
+/* 20 */	{15,  0,  1,  2},
+/* 30 */	{ 3, 15,  4, 15},
+/* 40 */	{15, 15,  5, 06},
+/* 50 */	{ 7,  8,  9, 15},
+};
+#endif
+
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int irq;
@@ -76,6 +111,7 @@ struct omap_dm_timer {
 	void __iomem *io_base;
 	unsigned reserved:1;
 	unsigned enabled:1;
+	unsigned posted:1;
 };
 
 #ifdef CONFIG_ARCH_OMAP1
@@ -181,16 +217,23 @@ static struct clk **dm_source_clocks;
 
 static spinlock_t dm_timer_lock;
 
-static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer,
int reg)
+u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, int reg)
 {
+	/* A read of a non completed write will be a read error */
+	if(timer->posted) 
+		while (readl(timer->io_base + OMAP_TIMER_WRITE_PEND_REG)
& 
+			   (1 << WPINDEX(reg)));
 	return readl(timer->io_base + reg);
 }
 
-static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, int
reg, u32 value)
+static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, int
reg, 
+
u32 value)
 {
+	/* A write on a register which has a pending write will be
thrown away */
+	if(timer->posted) 
+		while (readl(timer->io_base + OMAP_TIMER_WRITE_PEND_REG)
& 
+			   (1 << WPINDEX(reg)));
 	writel(value, timer->io_base + reg);
-	while (omap_dm_timer_read_reg(timer, OMAP_TIMER_WRITE_PEND_REG))
-		;
 }
 
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
@@ -217,15 +260,16 @@ static void omap_dm_timer_reset(struct
omap_dm_timer *timer)
 	}
 	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 
-	/* Set to smart-idle mode */
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
-	l |= 0x02 << 3;
+	l |= 0x02 << 3;  /* Set to smart-idle mode */
+	l |= 0x2 << 8;   /* Set clock activity to preserve f-clock on
idle */
 
-	if (cpu_class_is_omap2() && timer == &dm_timers[0]) {
-		/* Enable wake-up only for GPT1 on OMAP2 CPUs*/
+	if (cpu_class_is_omap2() && (timer == &dm_timers[0])) {
+		/* Enable wake-up only for GPT1 on OMAP2 CPUs */
+		/* FIXME: All should have this enabled and have PRCM
status clear*/
 		l |= 1 << 2;
-		/* Non-posted mode */
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
0);
+		/* Ensure posted mode */
+		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
(1 << 2));
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
 }
@@ -434,6 +478,8 @@ void omap_dm_timer_set_load(struct omap_dm_timer
*timer, int autoreload,
 		l &= ~OMAP_TIMER_CTRL_AR;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
+	/* ? hw-bug ttgr overtaking tldr*/
+	while(readl(timer->io_base + OMAP_TIMER_WRITE_PEND_REG));
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 }
 
@@ -568,6 +614,7 @@ int __init omap_dm_timer_init(void)
 	for (i = 0; i < dm_timer_count; i++) {
 		timer = &dm_timers[i];
 		timer->io_base = (void __iomem
*)io_p2v(timer->phys_base);
+		timer->posted = 1;  /* post by default */
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 		if (cpu_class_is_omap2()) {
 			char clk_name[16];

