From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/10] omap2+: Use dmtimer macros for clocksource
Date: Mon, 27 Jun 2011 03:48:16 -0700
Message-ID: <20110627104815.GL23145@atomide.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092345.357.11154.stgit@kaulin> <87iprwa2xx.fsf@ti.com>
	<20110627075429.GF23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110627075429.GF23145@atomide.com>
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

* Tony Lindgren <tony@atomide.com> [110627 00:50]:
> * Kevin Hilman <khilman@ti.com> [110623 10:06]:
> > Tony Lindgren <tony@atomide.com> writes:
> > > +
> > > +	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
> > 
> > This function makes calls into "real" driver, but is called from
> > sys_timer.init so happens before driver is initialized.
> 
> That one is the static omap2+ specific function that can be passed
> to the dmtimer device driver as a function pointer in the later
> patches. 
>  
> > > +	omap_dm_timer_set_load_start(&clksrc, 1, 0);
> > 
> > Here's another call into the real driver.  I think you need
> > __omap_dm_timer_set_load_start() here.
> 
> Thanks, that's correct. Will fix that one.

Here's this one updated. Looks like I still have your Reviewed-by
lines from the last time this series got posted. Can you please check
if those are still valid?

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 29 Mar 2011 15:54:49 -0700
Subject: [PATCH] omap2+: Use dmtimer macros for clocksource

Use dmtimer macros for clocksource. As with the clockevent,
this allows us to initialize the rest of dmtimer code later on.

Note that eventually we will be initializing the timesource
from init_early so sched_clock will work properly for
CONFIG_PRINTK_TIME.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index cf2ec85..2b8cb70 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -262,20 +262,22 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
  * sync counter.  See clocksource setup in plat-omap/counter_32k.c
  */
 
-static void __init omap2_gp_clocksource_init(void)
+static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
 {
 	omap_init_clocksource_32k();
 }
 
 #else
+
+static struct omap_dm_timer clksrc;
+
 /*
  * clocksource
  */
 static DEFINE_CLOCK_DATA(cd);
-static struct omap_dm_timer *gpt_clocksource;
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
-	return (cycle_t)omap_dm_timer_read_counter(gpt_clocksource);
+	return (cycle_t)__omap_dm_timer_read_counter(clksrc.io_base, 1);
 }
 
 static struct clocksource clocksource_gpt = {
@@ -290,43 +292,48 @@ static void notrace dmtimer_update_sched_clock(void)
 {
 	u32 cyc;
 
-	cyc = omap_dm_timer_read_counter(gpt_clocksource);
+	cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
 
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
-/* Setup free-running counter for clocksource */
-static void __init omap2_gp_clocksource_init(void)
+unsigned long long notrace sched_clock(void)
 {
-	static struct omap_dm_timer *gpt;
-	u32 tick_rate;
-	static char err1[] __initdata = KERN_ERR
-		"%s: failed to request dm-timer\n";
-	static char err2[] __initdata = KERN_ERR
-		"%s: can't register clocksource!\n";
+	u32 cyc = 0;
 
-	gpt = omap_dm_timer_request();
-	if (!gpt)
-		printk(err1, clocksource_gpt.name);
-	gpt_clocksource = gpt;
+	if (clksrc.reserved)
+		cyc = __omap_dm_timer_read_counter(clksrc.io_base, 1);
 
-	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
-	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
+
+/* Setup free-running counter for clocksource */
+static void __init omap2_gp_clocksource_init(int gptimer_id,
+						const char *fck_source)
+{
+	int res;
+
+	res = omap_dm_timer_init_one(&clksrc, gptimer_id, fck_source);
+	BUG_ON(res);
 
-	omap_dm_timer_set_load_start(gpt, 1, 0);
+	pr_info("OMAP clocksource: GPTIMER%d at %lu Hz\n",
+		gptimer_id, clksrc.rate);
 
-	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, tick_rate);
+	__omap_dm_timer_load_start(clksrc.io_base, OMAP_TIMER_CTRL_ST, 0, 1);
+	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, clksrc.rate);
 
-	if (clocksource_register_hz(&clocksource_gpt, tick_rate))
-		printk(err2, clocksource_gpt.name);
+	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
+		pr_err("Could not register clocksource %s\n",
+			clocksource_gpt.name);
 }
 #endif
 
-#define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src)			\
+#define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
+				clksrc_nr, clksrc_src)			\
 static void __init omap##name##_timer_init(void)			\
 {									\
 	omap2_gp_clockevent_init((clkev_nr), clkev_src);		\
-	omap2_gp_clocksource_init();					\
+	omap2_gp_clocksource_init((clksrc_nr), clksrc_src);		\
 }
 
 #define OMAP_SYS_TIMER(name)						\
@@ -335,14 +342,15 @@ struct sys_timer omap##name##_timer = {					\
 };
 
 #ifdef CONFIG_ARCH_OMAP2
-OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE)
+OMAP_SYS_TIMER_INIT(2, 1, OMAP2_CLKEV_SOURCE, 2, OMAP2_MPU_SOURCE)
 OMAP_SYS_TIMER(2)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE)
+OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
 OMAP_SYS_TIMER(3)
-OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE)
+OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
+			2, OMAP3_MPU_SOURCE)
 OMAP_SYS_TIMER(3_secure)
 #endif
 
@@ -354,7 +362,7 @@ static void __init omap4_timer_init(void)
 	BUG_ON(!twd_base);
 #endif
 	omap2_gp_clockevent_init(1, OMAP4_CLKEV_SOURCE);
-	omap2_gp_clocksource_init();
+	omap2_gp_clocksource_init(2, OMAP4_MPU_SOURCE);
 }
 OMAP_SYS_TIMER(4)
 #endif
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index f7fed60..c13bc3d 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -126,7 +126,7 @@ static inline unsigned long long notrace _omap_32k_sched_clock(void)
 	return cyc_to_fixed_sched_clock(&cd, cyc, (u32)~0, SC_MULT, SC_SHIFT);
 }
 
-#ifndef CONFIG_OMAP_MPU_TIMER
+#if defined(CONFIG_OMAP_32K_TIMER) && !defined(CONFIG_OMAP_MPU_TIMER)
 unsigned long long notrace sched_clock(void)
 {
 	return _omap_32k_sched_clock();
