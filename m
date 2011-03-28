From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/10] omap2+: Remove gptimer_wakekup for now
Date: Mon, 28 Mar 2011 15:21:43 -0700
Message-ID: <20110328222142.4046.4677.stgit@baageli.muru.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20661 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab1C1WVo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 18:21:44 -0400
In-Reply-To: <20110328221501.4046.41079.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This removes the support for setting the wake-up timer for debugging.

Later on we can reserve gptimer1 for PM code only and have similar
functionality.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm-debug.c |   27 ---------------------------
 arch/arm/mach-omap2/pm.h       |    6 ------
 arch/arm/mach-omap2/pm34xx.c   |    4 ----
 arch/arm/mach-omap2/timer-gp.c |    8 +-------
 4 files changed, 1 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index a5a83b3..6e19f10 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -41,8 +41,6 @@
 int omap2_pm_debug;
 u32 enable_off_mode;
 u32 sleep_while_idle;
-u32 wakeup_timer_seconds;
-u32 wakeup_timer_milliseconds;
 
 #define DUMP_PRM_MOD_REG(mod, reg)    \
 	regs[reg_count].name = #mod "." #reg; \
@@ -162,23 +160,6 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
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
@@ -576,9 +557,6 @@ static int option_set(void *data, u64 val)
 {
 	u32 *option = data;
 
-	if (option == &wakeup_timer_milliseconds && val >= 1000)
-		return -EINVAL;
-
 	*option = val;
 
 	if (option == &enable_off_mode) {
@@ -641,11 +619,6 @@ static int __init pm_dbg_init(void)
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
index 797bfd1..fb26e71 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -55,19 +55,13 @@ inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
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
index 0c5e3a4..ff2fb0e 100644
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
index c21e99f..4b071fb 100644
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
@@ -192,10 +190,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	omap_hwmod_enable(oh);
 
-	gptimer = omap_dm_timer_request_specific(gptimer_id);
-	BUG_ON(gptimer == NULL);
-	gptimer_wakeup = gptimer;
-
 	if (gptimer_id != 12) {
 		struct clk *src;
 
@@ -229,7 +223,7 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 	res = omap_dm_timer_init_one(&clkev, gptimer_id, fck_source);
 	BUG_ON(res);
 
-	omap2_gp_timer_irq.dev_id = (void *)gptimer;
+	omap2_gp_timer_irq.dev_id = (void *)&clkev;
 	setup_irq(clkev.irq, &omap2_gp_timer_irq);
 
 	__omap_dm_timer_int_enable(clkev.io_base, OMAP_TIMER_INT_OVERFLOW);

