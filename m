From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 1/4] perf: cleanup power events API
Date: Mon,  4 Oct 2010 17:20:58 +0200
Message-ID: <1286205661-24448-2-git-send-email-jean.pihet@newoldbits.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:65441 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962Ab0JDPWT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 11:22:19 -0400
In-Reply-To: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, mathieu.desnoyers@efficios.com, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>

From: Thomas Renninger <trenn@suse.de>

New power trace events:
power:processor_idle
power:processor_frequency
power:machine_suspend

C-state/idle accounting events:
  power:power_start
  power:power_end
are replaced with:
  power:processor_idle

and
  power:power_frequency
is replaced with:
  power:processor_frequency

power:machine_suspend
is newly introduced, a first implementation
comes from the ARM side, but it's easy to add these events
in X86 as well if needed.

the type= field got removed from both, it was never
used and the type is differed by the event type itself.

perf timechart
userspace tool gets adjusted in a separate patch.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Jean Pihet <jean.pihet@newoldbits.com>
CC: Arjan van de Ven <arjan@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>
CC: linux-perf-users@vger.kernel.org
CC: linux-trace-users@vger.kernel.org
CC: linux-pm@lists.linux-foundation.org
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Frank Eigler <fche@redhat.com>
CC: Rafael Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/process.c    |    8 ++---
 arch/x86/kernel/process_32.c |    2 +-
 arch/x86/kernel/process_64.c |    2 +-
 drivers/cpufreq/cpufreq.c    |    2 +-
 drivers/cpuidle/cpuidle.c    |    2 +-
 drivers/idle/intel_idle.c    |    6 ++--
 include/trace/events/power.h |   69 ++++++++++++++++++++++--------------------
 kernel/trace/power-traces.c  |    3 +-
 8 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index e8a5ad1..284df73 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -372,7 +372,7 @@ static inline int hlt_use_halt(void)
 void default_idle(void)
 {
 	if (hlt_use_halt()) {
-		trace_power_start(POWER_CSTATE, 1, smp_processor_id());
+		trace_processor_idle(1, smp_processor_id());
 		current_thread_info()->status &= ~TS_POLLING;
 		/*
 		 * TS_POLLING-cleared state must be visible before we
@@ -442,7 +442,7 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
  */
 void mwait_idle_with_hints(unsigned long ax, unsigned long cx)
 {
-	trace_power_start(POWER_CSTATE, (ax>>4)+1, smp_processor_id());
+	trace_processor_idle((ax>>4)+1, smp_processor_id());
 	if (!need_resched()) {
 		if (cpu_has(&current_cpu_data, X86_FEATURE_CLFLUSH_MONITOR))
 			clflush((void *)&current_thread_info()->flags);
@@ -458,7 +458,7 @@ void mwait_idle_with_hints(unsigned long ax, unsigned long cx)
 static void mwait_idle(void)
 {
 	if (!need_resched()) {
-		trace_power_start(POWER_CSTATE, 1, smp_processor_id());
+		trace_processor_idle(1, smp_processor_id());
 		if (cpu_has(&current_cpu_data, X86_FEATURE_CLFLUSH_MONITOR))
 			clflush((void *)&current_thread_info()->flags);
 
@@ -479,11 +479,9 @@ static void mwait_idle(void)
  */
 static void poll_idle(void)
 {
-	trace_power_start(POWER_CSTATE, 0, smp_processor_id());
 	local_irq_enable();
 	while (!need_resched())
 		cpu_relax();
-	trace_power_end(0);
 }
 
 /*
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 96586c3..8dee35c 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -114,7 +114,7 @@ void cpu_idle(void)
 			pm_idle();
 			start_critical_timings();
 
-			trace_power_end(smp_processor_id());
+			trace_processor_idle(0, smp_processor_id());
 		}
 		tick_nohz_restart_sched_tick();
 		preempt_enable_no_resched();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index b3d7a3a..d30069a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -141,7 +141,7 @@ void cpu_idle(void)
 			pm_idle();
 			start_critical_timings();
 
-			trace_power_end(smp_processor_id());
+			trace_processor_idle(0, smp_processor_id());
 
 			/* In many cases the interrupt that ended idle
 			   has already called exit_idle. But some idle
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 199dcb9..8c0dbe6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -354,7 +354,7 @@ void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
 		dprintk("FREQ: %lu - CPU: %lu", (unsigned long)freqs->new,
 			(unsigned long)freqs->cpu);
-		trace_power_frequency(POWER_PSTATE, freqs->new, freqs->cpu);
+		trace_processor_frequency(freqs->new, freqs->cpu);
 		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 				CPUFREQ_POSTCHANGE, freqs);
 		if (likely(policy) && likely(policy->cpu == freqs->cpu))
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a507108..7ce9065 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -106,7 +106,7 @@ static void cpuidle_idle_call(void)
 	/* give the governor an opportunity to reflect on the outcome */
 	if (cpuidle_curr_governor->reflect)
 		cpuidle_curr_governor->reflect(dev);
-	trace_power_end(smp_processor_id());
+	trace_processor_idle(0, smp_processor_id());
 }
 
 /**
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d0e42e0..fe08983 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -194,9 +194,9 @@ static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state)
 	kt_before = ktime_get_real();
 
 	stop_critical_timings();
-#ifndef MODULE
-	trace_power_start(POWER_CSTATE, (eax >> 4) + 1, cpu);
-#endif
+
+	trace_processor_idle((eax >> 4) + 1, cpu);
+
 	if (!need_resched()) {
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 286784d..00bf175 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -7,71 +7,62 @@
 #include <linux/ktime.h>
 #include <linux/tracepoint.h>
 
-#ifndef _TRACE_POWER_ENUM_
-#define _TRACE_POWER_ENUM_
-enum {
-	POWER_NONE	= 0,
-	POWER_CSTATE	= 1,	/* C-State */
-	POWER_PSTATE	= 2,	/* Fequency change or DVFS */
-	POWER_SSTATE	= 3,	/* Suspend */
-};
-#endif
-
 /*
- * The power events are used for cpuidle & suspend (power_start, power_end)
- *  and for cpufreq (power_frequency)
+ * The processor events class is used for cpuidle (processor_idle) and
+ *  for cpufreq (processor_frequency)
  */
-DECLARE_EVENT_CLASS(power,
+DECLARE_EVENT_CLASS(processor,
 
-	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
+	TP_PROTO(unsigned int state, unsigned int cpu_id),
 
-	TP_ARGS(type, state, cpu_id),
+	TP_ARGS(state, cpu_id),
 
 	TP_STRUCT__entry(
-		__field(	u64,		type		)
 		__field(	u64,		state		)
 		__field(	u64,		cpu_id		)
 	),
 
 	TP_fast_assign(
-		__entry->type = type;
 		__entry->state = state;
 		__entry->cpu_id = cpu_id;
 	),
 
-	TP_printk("type=%lu state=%lu cpu_id=%lu", (unsigned long)__entry->type,
-		(unsigned long)__entry->state, (unsigned long)__entry->cpu_id)
+	TP_printk("state=%lu cpu_id=%lu", (unsigned long)__entry->state,
+		  (unsigned long)__entry->cpu_id)
 );
 
-DEFINE_EVENT(power, power_start,
+DEFINE_EVENT(processor, processor_idle,
 
-	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
+	TP_PROTO(unsigned int state, unsigned int cpu_id),
 
-	TP_ARGS(type, state, cpu_id)
+	TP_ARGS(state, cpu_id)
 );
 
-DEFINE_EVENT(power, power_frequency,
+DEFINE_EVENT(processor, processor_frequency,
 
-	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
+	TP_PROTO(unsigned int frequency, unsigned int cpu_id),
 
-	TP_ARGS(type, state, cpu_id)
+	TP_ARGS(frequency, cpu_id)
 );
 
-TRACE_EVENT(power_end,
+/*
+ * The machine_suspend event is used for system suspend (machine_suspend)
+ */
+TRACE_EVENT(machine_suspend,
 
-	TP_PROTO(unsigned int cpu_id),
+	TP_PROTO(unsigned int state),
 
-	TP_ARGS(cpu_id),
+	TP_ARGS(state),
 
 	TP_STRUCT__entry(
-		__field(	u64,		cpu_id		)
+		__field(	u64,		state		)
 	),
 
 	TP_fast_assign(
-		__entry->cpu_id = cpu_id;
+		__entry->state = state;
 	),
 
-	TP_printk("cpu_id=%lu", (unsigned long)__entry->cpu_id)
+	TP_printk("state=%lu", (unsigned long)__entry->state)
 
 );
 
@@ -97,7 +88,7 @@ DECLARE_EVENT_CLASS(clock,
 		__entry->cpu_id = cpu_id;
 	),
 
-	TP_printk("%s state=%lu cpu_id=%lu", __get_str(name),
+	TP_printk("name=%s state=%lu cpu_id=%lu", __get_str(name),
 		(unsigned long)__entry->state, (unsigned long)__entry->cpu_id)
 );
 
@@ -143,10 +134,15 @@ DECLARE_EVENT_CLASS(power_domain,
 		__entry->cpu_id = cpu_id;
 ),
 
-	TP_printk("%s state=%lu cpu_id=%lu", __get_str(name),
+	TP_printk("name=%s state=%lu cpu_id=%lu", __get_str(name),
 		(unsigned long)__entry->state, (unsigned long)__entry->cpu_id)
 );
 
+/*
+ * The power domain events are used for power domains transitions
+ *  (power_domain_target for target state, power_domain_failed for
+ *  missed target state).
+ */
 DEFINE_EVENT(power_domain, power_domain_target,
 
 	TP_PROTO(const char *name, unsigned int state, unsigned int cpu_id),
@@ -154,6 +150,13 @@ DEFINE_EVENT(power_domain, power_domain_target,
 	TP_ARGS(name, state, cpu_id)
 );
 
+DEFINE_EVENT(power_domain, power_domain_missed,
+
+	TP_PROTO(const char *name, unsigned int state, unsigned int cpu_id),
+
+	TP_ARGS(name, state, cpu_id)
+);
+
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index a22582a..a5555be 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -13,5 +13,4 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/power.h>
 
-EXPORT_TRACEPOINT_SYMBOL_GPL(power_frequency);
-
+EXPORT_TRACEPOINT_SYMBOL_GPL(processor_idle);
-- 
1.7.1

