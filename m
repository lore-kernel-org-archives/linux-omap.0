From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/10] omap2+: Reserve clocksource and timesource and
	initialize dmtimer later
Date: Mon, 27 Jun 2011 03:44:28 -0700
Message-ID: <20110627104428.GK23145@atomide.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092343.357.60445.stgit@kaulin> <87ei2ka2u6.fsf@ti.com>
	<20110627075101.GE23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110627075101.GE23145@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [110627 00:46]:
> * Kevin Hilman <khilman@ti.com> [110623 10:08]:
> > Tony Lindgren <tony@atomide.com> writes:
> > 
> > > There's no need to initialize the dmtimer framework early.
> > > Just mark the clocksource and timesource as reserved, and
> > > initialize dmtimer with an arch_initcall.
> > >
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > 
> > Also, when you are able to fully get rid of omap_dm_timer_init(), you
> > can probably remove it from dmtimer.h and make it static in dmtimer.c
> 
> Good catch. That can be made static now.

Here's an updated version of this patch.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 29 Mar 2011 15:54:49 -0700
Subject: [PATCH] omap2+: Reserve clocksource and timesource and initialize dmtimer later

There's no need to initialize the dmtimer framework early.
Just mark the clocksource and timesource as reserved, and
initialize dmtimer with an arch_initcall.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 13d7b8f..96604a5 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -183,10 +183,6 @@ static __init void omap_init_32k_timer(void)
 bool __init omap_32k_timer_init(void)
 {
 	omap_init_clocksource_32k();
-
-#ifdef CONFIG_OMAP_DM_TIMER
-	omap_dm_timer_init();
-#endif
 	omap_init_32k_timer();
 
 	return true;
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 578e9df..cf2ec85 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -69,6 +69,8 @@
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
 
+u32 sys_timer_reserved;
+
 /* Clockevent code */
 
 static struct omap_dm_timer clkev;
@@ -195,6 +197,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	omap_hwmod_enable(oh);
 
+	sys_timer_reserved |= (1 << (gptimer_id - 1));
+
 	if (gptimer_id != 12) {
 		struct clk *src;
 
@@ -321,7 +325,6 @@ static void __init omap2_gp_clocksource_init(void)
 #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src)			\
 static void __init omap##name##_timer_init(void)			\
 {									\
-	omap_dm_timer_init();						\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src);		\
 	omap2_gp_clocksource_init();					\
 }
@@ -350,7 +353,6 @@ static void __init omap4_timer_init(void)
 	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
 	BUG_ON(!twd_base);
 #endif
-	omap_dm_timer_init();
 	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
 	omap2_gp_clocksource_init();
 }
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 7c5cb4e..8dfb818 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -572,7 +572,7 @@ int omap_dm_timers_active(void)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 
-int __init omap_dm_timer_init(void)
+static int __init omap_dm_timer_init(void)
 {
 	struct omap_dm_timer *timer;
 	int i, map_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
@@ -625,8 +625,16 @@ int __init omap_dm_timer_init(void)
 			sprintf(clk_name, "gpt%d_fck", i + 1);
 			timer->fclk = clk_get(NULL, clk_name);
 		}
+
+		/* One or two timers may be set up early for sys_timer */
+		if (sys_timer_reserved & (1  << i)) {
+			timer->reserved = 1;
+			timer->posted = 1;
+		}
 #endif
 	}
 
 	return 0;
 }
+
+arch_initcall(omap_dm_timer_init);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index dd8b3ff..40d7936 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -62,8 +62,6 @@ struct omap_dm_timer;
 extern struct omap_dm_timer *gptimer_wakeup;
 struct clk;
 
-int omap_dm_timer_init(void);
-
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
 void omap_dm_timer_free(struct omap_dm_timer *timer);
@@ -222,6 +220,7 @@ struct omap_dm_timer {
 	unsigned posted:1;
 };
 
+extern u32 sys_timer_reserved;
 void omap_dm_timer_prepare(struct omap_dm_timer *timer);
 
 static inline u32 __omap_dm_timer_read(void __iomem *base, u32 reg,
