From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP35x GP TIMER as a wakeup trigger
Date: Mon, 27 Apr 2009 15:17:31 -0700
Message-ID: <87bpqhspvo.fsf@deeprootsystems.com>
References: <1f11a5490904270849j5130384avdbaa8da21bc2b668@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:13557 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbZD0WRe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 18:17:34 -0400
Received: by wa-out-1112.google.com with SMTP id j5so89711wah.21
        for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2009 15:17:34 -0700 (PDT)
In-Reply-To: <1f11a5490904270849j5130384avdbaa8da21bc2b668@mail.gmail.com> (Ashwin Bihari's message of "Mon\, 27 Apr 2009 11\:49\:32 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Ashwin Bihari <abihari@gmail.com> writes:

> I need to implement a timer as a wake up trigger while my custom board
> is in the suspended state. I read in the TRM that all of the GPTIMERs
> have the capability of generating a wake up interrupt. I'm using the
> 2.6.28-rc8 PM Kernel which contains the patch to enable all the
> GPTIMERS as wake up sources.

Try the patch below on the current PM branch.  I use this for
debugging PM code when no other wakeup sources (keypad, UART, etc. are
working.) 

Kevin


>From bf81b7cce8967a425f1aa3d73782c1eb0367ce1a Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Fri, 24 Apr 2009 16:13:47 -0700
Subject: [PATCH] OMAP3: PM: Add feature to wake from suspend on timer

If a non-zero value is written to /sys/power/wakeup_timer_seconds,
A timer wakeup event will wake the system and resume after the
configured number of seconds.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.c       |   15 +++++++++++++--
 arch/arm/mach-omap2/pm.h       |    3 +++
 arch/arm/mach-omap2/pm34xx.c   |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/timer-gp.c |    2 ++
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 50d95cd..dde0af3 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -42,6 +42,7 @@ unsigned short enable_dyn_sleep;
 unsigned short clocks_off_while_idle;
 unsigned short enable_off_mode;
 unsigned short voltage_off_while_idle;
+unsigned short wakeup_timer_seconds;
 atomic_t sleep_block = ATOMIC_INIT(0);
 
 static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
@@ -76,6 +77,9 @@ static struct kobj_attribute vdd2_lock_attr =
 
 #endif
 
+static struct kobj_attribute wakeup_timer_seconds_attr =
+	__ATTR(wakeup_timer_seconds, 0644, idle_show, idle_store);
+
 static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
@@ -87,6 +91,8 @@ static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 		return sprintf(buf, "%hu\n", enable_off_mode);
 	else if (attr == &voltage_off_while_idle_attr)
 		return sprintf(buf, "%hu\n", voltage_off_while_idle);
+	else if (attr == &wakeup_timer_seconds_attr)
+		return sprintf(buf, "%hu\n", wakeup_timer_seconds);
 	else
 		return -EINVAL;
 }
@@ -96,8 +102,7 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	unsigned short value;
 
-	if (sscanf(buf, "%hu", &value) != 1 ||
-	    (value != 0 && value != 1)) {
+	if (sscanf(buf, "%hu", &value) != 1) {
 		printk(KERN_ERR "idle_store: Invalid value\n");
 		return -EINVAL;
 	}
@@ -109,6 +114,8 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 	} else if (attr == &enable_off_mode_attr) {
 		enable_off_mode = value;
 		omap3_pm_off_mode_enable(enable_off_mode);
+	} else if (attr == &wakeup_timer_seconds_attr) {
+		wakeup_timer_seconds = value;
 	} else if (attr == &voltage_off_while_idle_attr) {
 		voltage_off_while_idle = value;
 		if (voltage_off_while_idle)
@@ -255,6 +262,10 @@ static int __init omap_pm_init(void)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
 		return error;
 	}
+	error = sysfs_create_file(power_kobj,
+				  &wakeup_timer_seconds_attr.attr);
+	if (error)
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
 #ifdef CONFIG_OMAP_PM_SRF
 	error = sysfs_create_file(power_kobj,
 				  &vdd1_opp_attr.attr);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 942a990..66effed 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -30,6 +30,9 @@ extern unsigned short voltage_off_while_idle;
 extern atomic_t sleep_block;
 extern void *omap3_secure_ram_storage;
 
+extern unsigned short wakeup_timer_seconds;
+extern struct omap_dm_timer *gptimer_wakeup;
+
 extern void omap2_block_sleep(void);
 extern void omap2_allow_sleep(void);
 #ifdef CONFIG_ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d8795b5..3f41417 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/err.h>
+#include <linux/clk.h>
 
 #include <mach/gpio.h>
 #include <mach/sram.h>
@@ -41,6 +42,8 @@
 #include <mach/dma.h>
 #include <mach/gpmc.h>
 #include <mach/dma.h>
+#include <mach/dmtimer.h>
+
 #include <asm/tlbflush.h>
 
 #include "cm.h"
@@ -552,6 +555,22 @@ out:
 static void (*saved_idle)(void);
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
 	saved_idle = pm_idle;
@@ -564,6 +583,9 @@ static int omap3_pm_suspend(void)
 	struct power_state *pwrst;
 	int state, ret = 0;
 
+	if (wakeup_timer_seconds)
+		omap2_pm_wakeup_on_timer(wakeup_timer_seconds);
+
 	/* Read current next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node)
 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 8351a34..83dd4b1 100644
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
1.6.2.2

