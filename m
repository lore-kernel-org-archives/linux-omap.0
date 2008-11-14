From: Timo-Pekka Launonen <ext-timo-pekka.launonen@nokia.com>
Subject: [PATCH 1/1] ARM: OMAP3: PM: Add feature to wake from suspend on timer
Date: Fri, 14 Nov 2008 14:00:26 +0200
Message-ID: <1226664026-9275-1-git-send-email-ext-timo-pekka.launonen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48159 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbYKNMAu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 07:00:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

If a non-zero value is written to /sys/power/wakeup_timer_seconds,
A timer wakeup event will wake the system and resume after the
configured number of seconds.

Signed-off-by: Timo-Pekka Launonen <ext-timo-pekka.launonen@nokia.com>
---
 arch/arm/mach-omap2/pm.c       |   16 ++++++++++++++--
 arch/arm/mach-omap2/pm.h       |    3 +++
 arch/arm/mach-omap2/pm34xx.c   |   20 ++++++++++++++++++++
 arch/arm/mach-omap2/timer-gp.c |    2 ++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 4652136..8bb95ef 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -33,6 +33,7 @@
 
 unsigned short enable_dyn_sleep;
 unsigned short clocks_off_while_idle;
+unsigned short wakeup_timer_seconds;
 atomic_t sleep_block = ATOMIC_INIT(0);
 
 static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
@@ -45,6 +46,9 @@ static struct kobj_attribute sleep_while_idle_attr =
 static struct kobj_attribute clocks_off_while_idle_attr =
 	__ATTR(clocks_off_while_idle, 0644, idle_show, idle_store);
 
+static struct kobj_attribute wakeup_timer_seconds_attr =
+	__ATTR(wakeup_timer_seconds, 0644, idle_show, idle_store);
+
 static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
@@ -52,6 +56,8 @@ static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 		return sprintf(buf, "%hu\n", enable_dyn_sleep);
 	else if (attr == &clocks_off_while_idle_attr)
 		return sprintf(buf, "%hu\n", clocks_off_while_idle);
+	else if (attr == &wakeup_timer_seconds_attr)
+		return sprintf(buf, "%hu\n", wakeup_timer_seconds);
 	else
 		return -EINVAL;
 }
@@ -61,8 +67,7 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	unsigned short value;
 
-	if (sscanf(buf, "%hu", &value) != 1 ||
-	    (value != 0 && value != 1)) {
+	if (sscanf(buf, "%hu", &value) != 1) {
 		printk(KERN_ERR "idle_store: Invalid value\n");
 		return -EINVAL;
 	}
@@ -71,6 +76,8 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 		enable_dyn_sleep = value;
 	else if (attr == &clocks_off_while_idle_attr)
 		clocks_off_while_idle = value;
+	else if (attr == &wakeup_timer_seconds_attr)
+		wakeup_timer_seconds = value;
 	else
 		return -EINVAL;
 
@@ -113,6 +120,11 @@ static int __init omap_pm_init(void)
 	if (error)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
 
+	error = sysfs_create_file(power_kobj,
+				  &wakeup_timer_seconds_attr.attr);
+	if (error)
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+
 	return error;
 }
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 68c9278..42b5f08 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -20,6 +20,9 @@ extern unsigned short enable_dyn_sleep;
 extern unsigned short clocks_off_while_idle;
 extern atomic_t sleep_block;
 
+extern unsigned short wakeup_timer_seconds;
+extern struct omap_dm_timer *gptimer_wakeup;
+
 extern void omap2_block_sleep(void);
 extern void omap2_allow_sleep(void);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index da098d2..3cc8e2d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -29,6 +29,7 @@
 #include <mach/pm.h>
 #include <mach/clockdomain.h>
 #include <mach/powerdomain.h>
+#include <mach/dmtimer.h>
 
 #include "cm.h"
 #include "cm-regbits-34xx.h"
@@ -284,6 +285,22 @@ out:
 	local_irq_enable();
 }
 
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
 	saved_idle = pm_idle;
@@ -296,6 +313,9 @@ static int omap3_pm_suspend(void)
 	struct power_state *pwrst;
 	int state, ret = 0;
 
+	if (wakeup_timer_seconds)
+		omap2_pm_wakeup_on_timer(wakeup_timer_seconds);
+
 	/* Read current next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node)
 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 787cfef..24e1b17 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -38,6 +38,7 @@
 
 static struct omap_dm_timer *gptimer;
 static struct clock_event_device clockevent_gpt;
+struct omap_dm_timer *gptimer_wakeup;
 
 static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
 {
@@ -101,6 +102,7 @@ static void __init omap2_gp_clockevent_init(void)
 
 	gptimer = omap_dm_timer_request_specific(CONFIG_OMAP_TICK_GPTIMER);
 	BUG_ON(gptimer == NULL);
+	gptimer_wakeup = gptimer;
 
 #if defined(CONFIG_OMAP_32K_TIMER)
 	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
-- 
1.5.6.5

