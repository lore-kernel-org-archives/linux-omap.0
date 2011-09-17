From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Add support for dmtimer v2 ip (Re: [PATCH v15
 06/12] OMAP: dmtimer: switch-over to platform device driver)
Date: Fri, 16 Sep 2011 18:35:31 -0700
Message-ID: <20110917013531.GB2937@atomide.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
 <1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
 <20110914214533.GA30941@atomide.com>
 <CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
 <20110915165810.GA2284@atomide.com>
 <20110915170548.GB2284@atomide.com>
 <CAC83ZvKGoucZ=xQSa7GEk7Gg8jcFBQE==1a6m4=+nzDRrsw+jw@mail.gmail.com>
 <CAC83ZvKXEb7MTujP4JqhrPeysYxQcLF+BV-J9tpYoRwWGVZ8_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:15646 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751671Ab1IQBff (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 21:35:35 -0400
Content-Disposition: inline
In-Reply-To: <CAC83ZvKXEb7MTujP4JqhrPeysYxQcLF+BV-J9tpYoRwWGVZ8_Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Pedanekar, Hemant" <hemantp@ti.com>

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110916 01:56]:
> [...]
> >>> 1. Modify the inline access functions to take the PEND and others
> >>> =C2=A0 =C2=A0if needed registers as a parameter
> >>>
> >>> 2. Modify mach-omap2/timer.c to initialize the PEND and others
> >>> =C2=A0 =C2=A0in the SoC specific timer_init function
> Just to make my understanding complete, need some clarifications:
> As we would end up modifying almost all inline functions, what naming
> convention should we follow for the parameters?

Well here's what I came up with to deal with the different timer
registers. We can't use the context registers as those are for
the value naturally..

But we can map the interrupt registers separately and then have
the rest start from func_base that is different based on the timer
version. Rebasing the rest of the dmtimer hwmod patches on this
should be fairly easy, mostly just need to pass timer instead of
timer->io_base and use __raw_read/write for the interrupt registers.

Also, I ended up checking the timer revision with if (!(tidr >> 16))
as it seems that those bits are zero for v1 timers? If that works,
then we don't need patch 02/12 for the revision number.

Afzal, care to check if that works for AM335X/TI816X/TI814X?
It tried it briefly with omap4 gptimer3 as the clockevent and
CONFIG_LOCAL_TIMER disabled.

The patch is against the current cleanup branch in linux-omap
tree.

Regards,

Tony


=46rom: Tony Lindgren <tony@atomide.com>
Date: Fri, 16 Sep 2011 15:44:20 -0700
Subject: [PATCH] ARM: OMAP: Add support for dmtimer v2 ip

The registers are slightly different between v1 and v2 ip that
is available in omap4 and later for some timers.

Add support for v2 ip by mapping the interrupt related registers
separately and adding func_base for the functional registers.

Also disable dmtimer driver features on omap4 for now as
those need the hwmod conversion series to deal with enabling
the timers properly in omap_dm_timer_init.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index cf1de7d..21d34fb 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -78,7 +78,7 @@ static irqreturn_t omap2_gp_timer_interrupt(int irq, =
void *dev_id)
 {
 	struct clock_event_device *evt =3D &clockevent_gpt;
=20
-	__omap_dm_timer_write_status(clkev.io_base, OMAP_TIMER_INT_OVERFLOW);
+	__omap_dm_timer_write_status(&clkev, OMAP_TIMER_INT_OVERFLOW);
=20
 	evt->event_handler(evt);
 	return IRQ_HANDLED;
@@ -93,7 +93,7 @@ static struct irqaction omap2_gp_timer_irq =3D {
 static int omap2_gp_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
 {
-	__omap_dm_timer_load_start(clkev.io_base, OMAP_TIMER_CTRL_ST,
+	__omap_dm_timer_load_start(&clkev, OMAP_TIMER_CTRL_ST,
 						0xffffffff - cycles, 1);
=20
 	return 0;
@@ -104,16 +104,16 @@ static void omap2_gp_timer_set_mode(enum clock_ev=
ent_mode mode,
 {
 	u32 period;
=20
-	__omap_dm_timer_stop(clkev.io_base, 1, clkev.rate);
+	__omap_dm_timer_stop(&clkev, 1, clkev.rate);
=20
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		period =3D clkev.rate / HZ;
 		period -=3D 1;
 		/* Looks like we need to first set the load value separately */
-		__omap_dm_timer_write(clkev.io_base, OMAP_TIMER_LOAD_REG,
+		__omap_dm_timer_write(&clkev, OMAP_TIMER_LOAD_REG,
 					0xffffffff - period, 1);
-		__omap_dm_timer_load_start(clkev.io_base,
+		__omap_dm_timer_load_start(&clkev,
 					OMAP_TIMER_CTRL_AR | OMAP_TIMER_CTRL_ST,
 						0xffffffff - period, 1);
 		break;
@@ -172,6 +172,7 @@ static int __init omap_dm_timer_init_one(struct oma=
p_dm_timer *timer,
 	}
=20
 	omap_hwmod_enable(oh);
+	__omap_dm_timer_init_regs(timer);
=20
 	sys_timer_reserved |=3D (1 << (gptimer_id - 1));
=20
@@ -189,7 +190,7 @@ static int __init omap_dm_timer_init_one(struct oma=
p_dm_timer *timer,
 			clk_put(src);
 		}
 	}
-	__omap_dm_timer_reset(timer->io_base, 1, 1);
+	__omap_dm_timer_reset(timer, 1, 1);
 	timer->posted =3D 1;
=20
 	timer->rate =3D clk_get_rate(timer->fclk);
@@ -210,7 +211,7 @@ static void __init omap2_gp_clockevent_init(int gpt=
imer_id,
 	omap2_gp_timer_irq.dev_id =3D (void *)&clkev;
 	setup_irq(clkev.irq, &omap2_gp_timer_irq);
=20
-	__omap_dm_timer_int_enable(clkev.io_base, OMAP_TIMER_INT_OVERFLOW);
+	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
=20
 	clockevent_gpt.mult =3D div_sc(clkev.rate, NSEC_PER_SEC,
 				     clockevent_gpt.shift);
@@ -251,7 +252,7 @@ static struct omap_dm_timer clksrc;
 static DEFINE_CLOCK_DATA(cd);
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
-	return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_base, 1);
+	return (cycle_t)__omap_dm_timer_read_counter(&clksrc, 1);
 }
=20
 static struct clocksource clocksource_gpt =3D {
@@ -266,7 +267,7 @@ static void notrace dmtimer_update_sched_clock(void=
)
 {
 	u32 cyc;
=20
-	cyc =3D __omap_dm_timer_read_counter(clksrc.io_base, 1);
+	cyc =3D __omap_dm_timer_read_counter(&clksrc, 1);
=20
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
@@ -276,7 +277,7 @@ unsigned long long notrace sched_clock(void)
 	u32 cyc =3D 0;
=20
 	if (clksrc.reserved)
-		cyc =3D __omap_dm_timer_read_counter(clksrc.io_base, 1);
+		cyc =3D __omap_dm_timer_read_counter(&clksrc, 1);
=20
 	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
 }
@@ -293,7 +294,7 @@ static void __init omap2_gp_clocksource_init(int gp=
timer_id,
 	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
 		gptimer_id, clksrc.rate);
=20
-	__omap_dm_timer_load_start(clksrc.io_base,
+	__omap_dm_timer_load_start(&clksrc,
 			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
 	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, clksrc.rate);
=20
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.=
c
index 75a847d..e23b7cf 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -170,7 +170,8 @@ static spinlock_t dm_timer_lock;
  */
 static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, =
u32 reg)
 {
-	return __omap_dm_timer_read(timer->io_base, reg, timer->posted);
+	WARN_ON((reg & 0xff) < _OMAP_TIMER_WAKEUP_EN_OFFSET);
+	return __omap_dm_timer_read(timer, reg, timer->posted);
 }
=20
 /*
@@ -182,15 +183,19 @@ static inline u32 omap_dm_timer_read_reg(struct o=
map_dm_timer *timer, u32 reg)
 static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 r=
eg,
 						u32 value)
 {
-	__omap_dm_timer_write(timer->io_base, reg, value, timer->posted);
+	WARN_ON((reg & 0xff) < _OMAP_TIMER_WAKEUP_EN_OFFSET);
+	__omap_dm_timer_write(timer, reg, value, timer->posted);
 }
=20
 static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 {
 	int c;
=20
+	if (!timer->sys_stat)
+		return;
+
 	c =3D 0;
-	while (!(omap_dm_timer_read_reg(timer, OMAP_TIMER_SYS_STAT_REG) & 1))=
 {
+	while (!(__raw_readl(timer->sys_stat) & 1)) {
 		c++;
 		if (c > 100000) {
 			printk(KERN_ERR "Timer failed to reset\n");
@@ -219,7 +224,7 @@ static void omap_dm_timer_reset(struct omap_dm_time=
r *timer)
 	if (cpu_class_is_omap2())
 		wakeup =3D 1;
=20
-	__omap_dm_timer_reset(timer->io_base, autoidle, wakeup);
+	__omap_dm_timer_reset(timer, autoidle, wakeup);
 	timer->posted =3D 1;
 }
=20
@@ -401,7 +406,7 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer=
)
 	rate =3D clk_get_rate(timer->fclk);
 #endif
=20
-	__omap_dm_timer_stop(timer->io_base, timer->posted, rate);
+	__omap_dm_timer_stop(timer, timer->posted, rate);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
=20
@@ -466,7 +471,7 @@ void omap_dm_timer_set_load_start(struct omap_dm_ti=
mer *timer, int autoreload,
 	}
 	l |=3D OMAP_TIMER_CTRL_ST;
=20
-	__omap_dm_timer_load_start(timer->io_base, l, load, timer->posted);
+	__omap_dm_timer_load_start(timer, l, load, timer->posted);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
=20
@@ -519,7 +524,7 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
 void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 				  unsigned int value)
 {
-	__omap_dm_timer_int_enable(timer->io_base, value);
+	__omap_dm_timer_int_enable(timer, value);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
=20
@@ -527,7 +532,7 @@ unsigned int omap_dm_timer_read_status(struct omap_=
dm_timer *timer)
 {
 	unsigned int l;
=20
-	l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_STAT_REG);
+	l =3D __raw_readl(timer->irq_stat);
=20
 	return l;
 }
@@ -535,13 +540,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
=20
 void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned =
int value)
 {
-	__omap_dm_timer_write_status(timer->io_base, value);
+	__omap_dm_timer_write_status(timer, value);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
=20
 unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	return __omap_dm_timer_read_counter(timer->io_base, timer->posted);
+	return __omap_dm_timer_read_counter(timer, timer->posted);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
=20
@@ -601,6 +606,9 @@ static int __init omap_dm_timer_init(void)
 		dm_timer_count =3D omap4_dm_timer_count;
 		dm_source_names =3D omap4_dm_source_names;
 		dm_source_clocks =3D omap4_dm_source_clocks;
+
+		pr_err("dmtimers disabled for omap4 until hwmod conversion\n");
+		return -ENODEV;
 	}
=20
 	if (cpu_class_is_omap2())
@@ -630,8 +638,12 @@ static int __init omap_dm_timer_init(void)
 		if (sys_timer_reserved & (1  << i)) {
 			timer->reserved =3D 1;
 			timer->posted =3D 1;
+			continue;
 		}
 #endif
+		omap_dm_timer_enable(timer);
+		__omap_dm_timer_init_regs(timer);
+		omap_dm_timer_disable(timer);
 	}
=20
 	return 0;
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-=
omap/include/plat/dmtimer.h
index eb5d16c..a11d0c0 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -98,12 +98,30 @@ int omap_dm_timers_active(void);
  * used by dmtimer.c and sys_timer related code.
  */
=20
-/* register offsets */
-#define _OMAP_TIMER_ID_OFFSET		0x00
-#define _OMAP_TIMER_OCP_CFG_OFFSET	0x10
-#define _OMAP_TIMER_SYS_STAT_OFFSET	0x14
-#define _OMAP_TIMER_STAT_OFFSET		0x18
-#define _OMAP_TIMER_INT_EN_OFFSET	0x1c
+/*
+ * The interrupt registers are different between v1 and v2 ip.
+ * These registers are offsets from timer->iobase.
+ */
+#define OMAP_TIMER_ID_OFFSET		0x00
+#define OMAP_TIMER_OCP_CFG_OFFSET	0x10
+
+#define OMAP_TIMER_V1_SYS_STAT_OFFSET	0x14
+#define OMAP_TIMER_V1_STAT_OFFSET	0x18
+#define OMAP_TIMER_V1_INT_EN_OFFSET	0x1c
+
+#define OMAP_TIMER_V2_IRQSTATUS_RAW	0x24
+#define OMAP_TIMER_V2_IRQSTATUS		0x28
+#define OMAP_TIMER_V2_IRQENABLE_SET	0x2c
+#define OMAP_TIMER_V2_IRQENABLE_CLR	0x30
+
+/*
+ * The functional registers have a different base on v1 and v2 ip.
+ * These registers are offsets from timer->func_base. The func_base
+ * is samae as io_base for v1 and io_base + 0x14 for v2 ip.
+ *
+ */
+#define OMAP_TIMER_V2_FUNC_OFFSET		0x14
+
 #define _OMAP_TIMER_WAKEUP_EN_OFFSET	0x20
 #define _OMAP_TIMER_CTRL_OFFSET		0x24
 #define		OMAP_TIMER_CTRL_GPOCFG		(1 << 14)
@@ -147,21 +165,6 @@ int omap_dm_timers_active(void);
 /* register offsets with the write pending bit encoded */
 #define	WPSHIFT					16
=20
-#define OMAP_TIMER_ID_REG			(_OMAP_TIMER_ID_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_OCP_CFG_REG			(_OMAP_TIMER_OCP_CFG_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_SYS_STAT_REG			(_OMAP_TIMER_SYS_STAT_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_STAT_REG			(_OMAP_TIMER_STAT_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_INT_EN_REG			(_OMAP_TIMER_INT_EN_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
 #define OMAP_TIMER_WAKEUP_EN_REG		(_OMAP_TIMER_WAKEUP_EN_OFFSET \
 							| (WP_NONE << WPSHIFT))
=20
@@ -213,7 +216,14 @@ struct omap_dm_timer {
 #ifdef CONFIG_ARCH_OMAP2PLUS
 	struct clk *iclk, *fclk;
 #endif
-	void __iomem *io_base;
+	void __iomem	*io_base;
+	void __iomem	*sys_stat;	/* TISTAT timer status */
+	void __iomem	*irq_stat;	/* TISR/IRQSTATUS interrupt status */
+	void __iomem	*irq_ena;	/* irq enable */
+	void __iomem	*irq_dis;	/* irq disable, only on v2 ip */
+	void __iomem	*pend;		/* write pending */
+	void __iomem	*func_base;	/* function register base */
+
 	unsigned long rate;
 	unsigned reserved:1;
 	unsigned enabled:1;
@@ -223,35 +233,57 @@ struct omap_dm_timer {
 extern u32 sys_timer_reserved;
 void omap_dm_timer_prepare(struct omap_dm_timer *timer);
=20
-static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,
+static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u3=
2 reg,
 						int posted)
 {
 	if (posted)
-		while (__raw_readl(base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
+		while (__raw_readl(timer->pend) & (reg >> WPSHIFT))
 			cpu_relax();
=20
-	return __raw_readl(base + (reg & 0xff));
+	return __raw_readl(timer->func_base + (reg & 0xff));
 }
=20
-static inline void __omap_dm_timer_write(void __iomem *base, u32 reg, =
u32 val,
-						int posted)
+static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
+					u32 reg, u32 val, int posted)
 {
 	if (posted)
-		while (__raw_readl(base + (OMAP_TIMER_WRITE_PEND_REG & 0xff))
-				& (reg >> WPSHIFT))
+		while (__raw_readl(timer->pend) & (reg >> WPSHIFT))
 			cpu_relax();
=20
-	__raw_writel(val, base + (reg & 0xff));
+	__raw_writel(val, timer->func_base + (reg & 0xff));
+}
+
+static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *tim=
er)
+{
+	u32 tidr;
+
+	/* Assume v1 ip if bits [31:16] are zero */
+	tidr =3D __raw_readl(timer->io_base);
+	if (!(tidr >> 16)) {
+		timer->sys_stat =3D timer->io_base + OMAP_TIMER_V1_SYS_STAT_OFFSET;
+		timer->irq_stat =3D timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
+		timer->irq_ena =3D timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->irq_dis =3D 0;
+		timer->pend =3D timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
+		timer->func_base =3D timer->io_base;
+	} else {
+		timer->sys_stat =3D 0;
+		timer->irq_stat =3D timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
+		timer->irq_ena =3D timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
+		timer->irq_dis =3D timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;
+		timer->pend =3D timer->io_base +
+			_OMAP_TIMER_WRITE_PEND_OFFSET + OMAP_TIMER_V2_FUNC_OFFSET;
+		timer->func_base =3D timer->io_base + OMAP_TIMER_V2_FUNC_OFFSET;
+	}
 }
=20
 /* Assumes the source clock has been set by caller */
-static inline void __omap_dm_timer_reset(void __iomem *base, int autoi=
dle,
-						int wakeup)
+static inline void __omap_dm_timer_reset(struct omap_dm_timer *timer,
+					int autoidle, int wakeup)
 {
 	u32 l;
=20
-	l =3D __omap_dm_timer_read(base, OMAP_TIMER_OCP_CFG_REG, 0);
+	l =3D __raw_readl(timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
 	l |=3D 0x02 << 3;  /* Set to smart-idle mode */
 	l |=3D 0x2 << 8;   /* Set clock activity to perserve f-clock on idle =
*/
=20
@@ -261,10 +293,10 @@ static inline void __omap_dm_timer_reset(void __i=
omem *base, int autoidle,
 	if (wakeup)
 		l |=3D 1 << 2;
=20
-	__omap_dm_timer_write(base, OMAP_TIMER_OCP_CFG_REG, l, 0);
+	__raw_writel(l, timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
=20
 	/* Match hardware reset default of posted mode */
-	__omap_dm_timer_write(base, OMAP_TIMER_IF_CTRL_REG,
+	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
 					OMAP_TIMER_CTRL_POSTED, 0);
 }
=20
@@ -286,18 +318,18 @@ static inline int __omap_dm_timer_set_source(stru=
ct clk *timer_fck,
 	return ret;
 }
=20
-static inline void __omap_dm_timer_stop(void __iomem *base, int posted=
,
-						unsigned long rate)
+static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
+					int posted, unsigned long rate)
 {
 	u32 l;
=20
-	l =3D __omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG, posted);
+	l =3D __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
 	if (l & OMAP_TIMER_CTRL_ST) {
 		l &=3D ~0x1;
-		__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG, l, posted);
+		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
 #ifdef CONFIG_ARCH_OMAP2PLUS
 		/* Readback to make sure write has completed */
-		__omap_dm_timer_read(base, OMAP_TIMER_CTRL_REG, posted);
+		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
 		/*
 		 * Wait for functional clock period x 3.5 to make sure that
 		 * timer is stopped
@@ -307,34 +339,34 @@ static inline void __omap_dm_timer_stop(void __io=
mem *base, int posted,
 	}
=20
 	/* Ack possibly pending interrupt */
-	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG,
-					OMAP_TIMER_INT_OVERFLOW, 0);
+	__raw_writel(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
 }
=20
-static inline void __omap_dm_timer_load_start(void __iomem *base, u32 =
ctrl,
-						unsigned int load, int posted)
+static inline void __omap_dm_timer_load_start(struct omap_dm_timer *ti=
mer,
+						u32 ctrl, unsigned int load,
+						int posted)
 {
-	__omap_dm_timer_write(base, OMAP_TIMER_COUNTER_REG, load, posted);
-	__omap_dm_timer_write(base, OMAP_TIMER_CTRL_REG, ctrl, posted);
+	__omap_dm_timer_write(timer, OMAP_TIMER_COUNTER_REG, load, posted);
+	__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, ctrl, posted);
 }
=20
-static inline void __omap_dm_timer_int_enable(void __iomem *base,
+static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *ti=
mer,
 						unsigned int value)
 {
-	__omap_dm_timer_write(base, OMAP_TIMER_INT_EN_REG, value, 0);
-	__omap_dm_timer_write(base, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
+	__raw_writel(value, timer->irq_ena);
+	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
 }
=20
-static inline unsigned int __omap_dm_timer_read_counter(void __iomem *=
base,
-							int posted)
+static inline unsigned int
+__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
 {
-	return __omap_dm_timer_read(base, OMAP_TIMER_COUNTER_REG, posted);
+	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
 }
=20
-static inline void __omap_dm_timer_write_status(void __iomem *base,
+static inline void __omap_dm_timer_write_status(struct omap_dm_timer *=
timer,
 						unsigned int value)
 {
-	__omap_dm_timer_write(base, OMAP_TIMER_STAT_REG, value, 0);
+	__raw_writel(value, timer->irq_stat);
 }
=20
 #endif /* __ASM_ARCH_DMTIMER_H */
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
