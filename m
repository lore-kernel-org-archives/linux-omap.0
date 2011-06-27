From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/10] omap2+: Remove gptimer_wakeup for now
Date: Mon, 27 Jun 2011 12:19:07 -0700
Message-ID: <20110627191907.GW23145@atomide.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092341.357.14183.stgit@kaulin> <8762nrch91.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <8762nrch91.fsf@ti.com>
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

* Kevin Hilman <khilman@ti.com> [110627 10:27]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > This removes the support for setting the wake-up timer for debugging.
> >
> > Later on we can reserve gptimer1 for PM code only and have similar
> > functionality.
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> 
> Another minor change to fold into patch: gptimer_wakeup doesn't exist
> anymore, so should probably be removed from dmtimer.h

Thanks, updated patch below. Still with your Reviewed-by
despite causing you more work with the removal of the
interface :)

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 29 Mar 2011 15:54:49 -0700
Subject: [PATCH] omap2+: Remove gptimer_wakeup for now

This removes the support for setting the wake-up timer for debugging.

Later on we can reserve gptimer1 for PM code only and have similar
functionality.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index a5a83b3..c56d1d4 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -31,7 +31,6 @@
 #include <plat/board.h>
 #include "powerdomain.h"
 #include "clockdomain.h"
-#include <plat/dmtimer.h>
 #include <plat/omap-pm.h>
 
 #include "cm2xxx_3xxx.h"
@@ -41,8 +40,6 @@
 int omap2_pm_debug;
 u32 enable_off_mode;
 u32 sleep_while_idle;
-u32 wakeup_timer_seconds;
-u32 wakeup_timer_milliseconds;
 
 #define DUMP_PRM_MOD_REG(mod, reg)    \
 	regs[reg_count].name = #mod "." #reg; \
@@ -162,23 +159,6 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 		printk(KERN_INFO "%-20s: 0x%08x\n", regs[i].name, regs[i].val);
 }
 
-void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
-{
-	u32 tick_rate, cycles;
-
-	if (!seconds && !milliseconds)
-		return;
-
-	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
-	cycles = tick_rate * seconds + tick_rate * milliseconds / 1000;
-	omap_dm_timer_stop(gptimer_wakeup);
-	omap_dm_timer_set_load_start(gptimer_wakeup, 0, 0xffffffff - cycles);
-
-	pr_info("PM: Resume timer in %u.%03u secs"
-		" (%d ticks at %d ticks/sec.)\n",
-		seconds, milliseconds, cycles, tick_rate);
-}
-
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -576,9 +556,6 @@ static int option_set(void *data, u64 val)
 {
 	u32 *option = data;
 
-	if (option == &wakeup_timer_milliseconds && val >= 1000)
-		return -EINVAL;
-
 	*option = val;
 
 	if (option == &enable_off_mode) {
@@ -641,11 +618,6 @@ static int __init pm_dbg_init(void)
 				   &enable_off_mode, &pm_dbg_option_fops);
 	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUSR, d,
 				   &sleep_while_idle, &pm_dbg_option_fops);
-	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUSR, d,
-				   &wakeup_timer_seconds, &pm_dbg_option_fops);
-	(void) debugfs_create_file("wakeup_timer_milliseconds",
-			S_IRUGO | S_IWUSR, d, &wakeup_timer_milliseconds,
-			&pm_dbg_option_fops);
 	pm_dbg_init_done = 1;
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 45bcfce..c3a367e 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -60,19 +60,13 @@ inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
-extern u32 wakeup_timer_seconds;
-extern u32 wakeup_timer_milliseconds;
-extern struct omap_dm_timer *gptimer_wakeup;
-
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
-extern void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds);
 extern int omap2_pm_debug;
 extern u32 enable_off_mode;
 extern u32 sleep_while_idle;
 #else
 #define omap2_pm_dump(mode, resume, us)		do {} while (0);
-#define omap2_pm_wakeup_on_timer(seconds, milliseconds)	do {} while (0);
 #define omap2_pm_debug				0
 #define enable_off_mode 0
 #define sleep_while_idle 0
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c155c9d..4cb636a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -534,10 +534,6 @@ static int omap3_pm_suspend(void)
 	struct power_state *pwrst;
 	int state, ret = 0;
 
-	if (wakeup_timer_seconds || wakeup_timer_milliseconds)
-		omap2_pm_wakeup_on_timer(wakeup_timer_seconds,
-					 wakeup_timer_milliseconds);
-
 	/* Read current next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node)
 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 62c0d5c..578e9df 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -72,11 +72,9 @@
 /* Clockevent code */
 
 static struct omap_dm_timer clkev;
-static struct omap_dm_timer *gptimer;
 static struct clock_event_device clockevent_gpt;
 static u8 __initdata gptimer_id = 1;
 static u8 __initdata inited;
-struct omap_dm_timer *gptimer_wakeup;
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
@@ -218,10 +216,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	timer->reserved = 1;
 
-	gptimer = omap_dm_timer_request_specific(gptimer_id);
-	BUG_ON(gptimer == NULL);
-	gptimer_wakeup = gptimer;
-
 	return res;
 }
 
@@ -235,7 +229,7 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source);
 	BUG_ON(res);
 
-	omap2_gp_timer_irq.dev_id = (void *)gptimer;
+	omap2_gp_timer_irq.dev_id = (void *)&clkev;
 	setup_irq(clkev.irq, &omap2_gp_timer_irq);
 
 	__omap_dm_timer_int_enable(clkev.io_base, OMAP_TIMER_INT_OVERFLOW);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index dd8b3ff..8adcb18 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -59,7 +59,6 @@
  */
 #define OMAP_TIMER_IP_VERSION_1                        0x1
 struct omap_dm_timer;
-extern struct omap_dm_timer *gptimer_wakeup;
 struct clk;
 
 int omap_dm_timer_init(void);
