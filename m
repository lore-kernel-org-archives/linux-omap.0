From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 27/27] PM debug: allow configurable wakeup from suspend on
	OMAP GPtimer
Date: Wed, 14 Oct 2009 14:58:10 -0700
Message-ID: <1255557490-16787-28-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-15-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-16-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-17-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-18-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-19-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-20-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-21-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-22-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-23-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-24-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-25-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-26-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-27-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255557490-16787-27-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Using debugfs, export a configurable wakeup timer to be used to
wakeup system from suspend.

If a non-zero value is written to
/debug/pm_debug/wakeup_timer_seconds, A timer wakeup event will wake
the system and resume after the configured number of seconds.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c |    2 ++
 arch/arm/mach-omap2/pm.h       |    3 +++
 arch/arm/mach-omap2/pm34xx.c   |   21 +++++++++++++++++++++
 arch/arm/mach-omap2/timer-gp.c |    2 ++
 4 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 4e05d29..b45d79d 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -596,6 +596,8 @@ static int __init pm_dbg_init(void)
 				   &enable_off_mode, &pm_dbg_option_fops);
 	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUGO, d,
 				   &sleep_while_idle, &pm_dbg_option_fops);
+	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
+				   &wakeup_timer_seconds, &pm_dbg_option_fops);
 	pm_dbg_init_done = 1;
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index e47508c..c163b77 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -22,6 +22,9 @@ extern void omap3_pm_off_mode_enable(int);
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
+extern u32 wakeup_timer_seconds;
+extern struct omap_dm_timer *gptimer_wakeup;
+
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern int omap2_pm_debug;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 99996fc..209672f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -37,6 +37,7 @@
 #include <mach/dma.h>
 #include <mach/gpmc.h>
 #include <mach/dma.h>
+#include <mach/dmtimer.h>
 
 #include <asm/tlbflush.h>
 
@@ -61,6 +62,7 @@
 
 u32 enable_off_mode;
 u32 sleep_while_idle;
+u32 wakeup_timer_seconds;
 
 struct power_state {
 	struct powerdomain *pwrdm;
@@ -536,6 +538,22 @@ out:
 #ifdef CONFIG_SUSPEND
 static suspend_state_t suspend_state;
 
+static void omap2_pm_wakeup_on_timer(u32 seconds)
+{
+	u32 tick_rate, cycles;
+
+	if (!seconds)
+		return;
+
+	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
+	cycles = tick_rate * seconds;
+	omap_dm_timer_stop(gptimer_wakeup);
+	omap_dm_timer_set_load_start(gptimer_wakeup, 0, 0xffffffff - cycles);
+
+	pr_info("PM: Resume timer in %d secs (%d ticks at %d ticks/sec.)\n",
+		seconds, cycles, tick_rate);
+}
+
 static int omap3_pm_prepare(void)
 {
 	disable_hlt();
@@ -547,6 +565,9 @@ static int omap3_pm_suspend(void)
 	struct power_state *pwrst;
 	int state, ret = 0;
 
+	if (wakeup_timer_seconds)
+		omap2_pm_wakeup_on_timer(wakeup_timer_seconds);
+
 	/* Read current next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node)
 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 95a2176..9c056ff 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -47,6 +47,7 @@ static struct omap_dm_timer *gptimer;
 static struct clock_event_device clockevent_gpt;
 static u8 __initdata gptimer_id = 1;
 static u8 __initdata inited;
+struct omap_dm_timer *gptimer_wakeup;
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
@@ -134,6 +135,7 @@ static void __init omap2_gp_clockevent_init(void)
 
 	gptimer = omap_dm_timer_request_specific(gptimer_id);
 	BUG_ON(gptimer == NULL);
+	gptimer_wakeup = gptimer;
 
 #if defined(CONFIG_OMAP_32K_TIMER)
 	src = OMAP_TIMER_SRC_32_KHZ;
-- 
1.6.4.3
