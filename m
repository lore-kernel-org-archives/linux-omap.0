From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] clocksource: Allow toggling between runtime and persistent clocksource for idle
Date: Mon,  6 Jul 2015 00:12:05 -0700
Message-ID: <1436166725-18353-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, John Stultz <john.stultz@linaro.org>, Nishanth Menon <nm@ti.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-omap@vger.kernel.org

Some persistent clocksources can be on a slow external bus. For shorter
latencies for RT use, let's allow toggling the clocksource during idle
between a faster non-persistent runtime clocksource and a slower persistent
clocksource.

Cc: Felipe Balbi <balbi@ti.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Anybody got better ideas for something like last_idled_cpu() type check
at the end of this patch?

---
 include/linuxt-email-lkml-omap/clocksource.h |  2 ++
 kernel/time/clocksource.c   | 60 +++++++++++++++++++++++++++++++++++++++++++--
 kernel/time/timekeeping.c   | 13 +++++++++-
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 278dd27..7e5ff99 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -232,6 +232,8 @@ static inline void __clocksource_update_freq_khz(struct clocksource *cs, u32 khz
 
 
 extern int timekeeping_notify(struct clocksource *clock);
+extern int clocksource_pm_enter(void);
+extern void clocksource_pm_exit(void);
 
 extern cycle_t clocksource_mmio_readl_up(struct clocksource *);
 extern cycle_t clocksource_mmio_readl_down(struct clocksource *);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 841b72f..69dc307 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -93,6 +93,8 @@ clocks_calc_mult_shift(u32 *mult, u32 *shift, u32 from, u32 to, u32 maxsec)
 /*[Clocksource internal variables]---------
  * curr_clocksource:
  *	currently selected clocksource.
+ * runtime_clocksource:
+ *	preferred clocksource for runtime, can be local and non-persistent
  * clocksource_list:
  *	linked list with the registered clocksources
  * clocksource_mutex:
@@ -101,6 +103,7 @@ clocks_calc_mult_shift(u32 *mult, u32 *shift, u32 from, u32 to, u32 maxsec)
  *	Name of the user-specified clocksource.
  */
 static struct clocksource *curr_clocksource;
+static struct clocksource *runtime_clocksource;
 static LIST_HEAD(clocksource_list);
 static DEFINE_MUTEX(clocksource_mutex);
 static char override_name[CS_NAME_LEN];
@@ -525,7 +528,8 @@ static inline void clocksource_update_max_deferment(struct clocksource *cs)
 
 #ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
 
-static struct clocksource *clocksource_find_best(bool oneshot, bool skipcur)
+static struct clocksource *clocksource_find_best(bool oneshot, bool persistent,
+						 bool skipcur)
 {
 	struct clocksource *cs;
 
@@ -540,6 +544,8 @@ static struct clocksource *clocksource_find_best(bool oneshot, bool skipcur)
 	list_for_each_entry(cs, &clocksource_list, list) {
 		if (skipcur && cs == curr_clocksource)
 			continue;
+		if (persistent && !(cs->flags & CLOCK_SOURCE_SUSPEND_NONSTOP))
+			continue;
 		if (oneshot && !(cs->flags & CLOCK_SOURCE_VALID_FOR_HRES))
 			continue;
 		return cs;
@@ -553,7 +559,7 @@ static void __clocksource_select(bool skipcur)
 	struct clocksource *best, *cs;
 
 	/* Find the best suitable clocksource */
-	best = clocksource_find_best(oneshot, skipcur);
+	best = clocksource_find_best(oneshot, false, skipcur);
 	if (!best)
 		return;
 
@@ -802,6 +808,56 @@ int clocksource_unregister(struct clocksource *cs)
 }
 EXPORT_SYMBOL(clocksource_unregister);
 
+/**
+ * clocksource_pm_enter - change to a persistent clocksource before idle
+ *
+ * Changes system to use a persistent clocksource for idle. Intended to
+ * be called from CPUidle from the last active CPU.
+ */
+int clocksource_pm_enter(void)
+{
+	bool oneshot = tick_oneshot_mode_active();
+	struct clocksource *best;
+
+	if (WARN_ONCE(!mutex_trylock(&clocksource_mutex),
+		      "Unable to get clocksource_mutex"))
+		return -EINTR;
+
+	best = clocksource_find_best(oneshot, true, false);
+	if (best) {
+		if (curr_clocksource != best &&
+		    !timekeeping_notify(best)) {
+			runtime_clocksource = curr_clocksource;
+			curr_clocksource = best;
+		}
+	}
+	mutex_unlock(&clocksource_mutex);
+
+	return !!best;
+}
+
+/**
+ * clocksource_pm_exit - change to a runtime clocksrouce after idle
+ *
+ * Changes system to use the best clocksource for runtime. Intended to
+ * be called after waking up from CPUidle on the first active CPU.
+ */
+void clocksource_pm_exit(void)
+{
+	if (WARN_ONCE(!mutex_trylock(&clocksource_mutex),
+		      "Unable to get clocksource_mutex"))
+		return;
+
+	if (runtime_clocksource) {
+		if (curr_clocksource != runtime_clocksource &&
+		    !timekeeping_notify(runtime_clocksource)) {
+			curr_clocksource = runtime_clocksource;
+			runtime_clocksource = NULL;
+		}
+	}
+	mutex_unlock(&clocksource_mutex);
+}
+
 #ifdef CONFIG_SYSFS
 /**
  * sysfs_show_current_clocksources - sysfs interface for current clocksource
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index bca3667..0379260 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1086,7 +1086,18 @@ int timekeeping_notify(struct clocksource *clock)
 
 	if (tk->tkr_mono.clock == clock)
 		return 0;
-	stop_machine(change_clocksource, clock, NULL);
+
+	/*
+	 * We may want to toggle between a fast and a persistent
+	 * clocksource from CPUidle on the last active CPU and can't
+	 * use stop_machine at that point.
+	 */
+	if (cpumask_test_cpu(smp_processor_id(), cpu_online_mask) &&
+	    !rcu_is_watching())
+		change_clocksource(clock);
+	else
+		stop_machine(change_clocksource, clock, NULL);
+
 	tick_clock_notify();
 	return tk->tkr_mono.clock == clock ? 0 : -1;
 }
-- 
2.1.4
