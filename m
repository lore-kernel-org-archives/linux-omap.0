From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Tue, 19 Oct 2010 13:36:10 +0200
Message-ID: <1287488171-25303-3-git-send-email-trenn@suse.de>
References: <1287488171-25303-1-git-send-email-trenn@suse.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45540 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758456Ab0JSLgN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 07:36:13 -0400
In-Reply-To: <1287488171-25303-1-git-send-email-trenn@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: trenn@suse.de
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>

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
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
CC: Frank Eigler <fche@redhat.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: linux-omap@vger.kernel.org
CC: rjw@sisk.pl
CC: linux-pm@lists.linux-foundation.org
CC: linux-trace-users@vger.kernel.org
CC: Jean Pihet <jean.pihet@newoldbits.com>
CC: Pierre Tardy <tardyp@gmail.com>
CC: Frederic Weisbecker <fweisbec@gmail.com>
CC: Tejun Heo <tj@kernel.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Arjan van de Ven <arjan@linux.intel.com>
CC: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/process.c    |    5 ++-
 arch/x86/kernel/process_64.c |    1 +
 drivers/cpufreq/cpufreq.c    |    1 +
 drivers/cpuidle/cpuidle.c    |    1 +
 drivers/idle/intel_idle.c    |    1 +
 include/trace/events/power.h |   80 +++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/Kconfig         |   14 +++++++
 kernel/trace/power-traces.c  |    3 ++
 8 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 57d1868..b6b1578 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -374,6 +374,7 @@ void default_idle(void)
 {
 	if (hlt_use_halt()) {
 		trace_power_start(POWER_CSTATE, 1, smp_processor_id());
+		trace_processor_idle(1, smp_processor_id());
 		current_thread_info()->status &= ~TS_POLLING;
 		/*
 		 * TS_POLLING-cleared state must be visible before we
@@ -444,6 +445,7 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
 void mwait_idle_with_hints(unsigned long ax, unsigned long cx)
 {
 	trace_power_start(POWER_CSTATE, (ax>>4)+1, smp_processor_id());
+	trace_processor_idle((ax>>4)+1, smp_processor_id());
 	if (!need_resched()) {
 		if (cpu_has(&current_cpu_data, X86_FEATURE_CLFLUSH_MONITOR))
 			clflush((void *)&current_thread_info()->flags);
@@ -460,6 +462,7 @@ static void mwait_idle(void)
 {
 	if (!need_resched()) {
 		trace_power_start(POWER_CSTATE, 1, smp_processor_id());
+		trace_processor_idle(1, smp_processor_id());
 		if (cpu_has(&current_cpu_data, X86_FEATURE_CLFLUSH_MONITOR))
 			clflush((void *)&current_thread_info()->flags);
 
@@ -480,11 +483,9 @@ static void mwait_idle(void)
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
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3d9ea53..2c3254c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -142,6 +142,7 @@ void cpu_idle(void)
 			start_critical_timings();
 
 			trace_power_end(smp_processor_id());
+			trace_processor_idle(0, smp_processor_id());
 
 			/* In many cases the interrupt that ended idle
 			   has already called exit_idle. But some idle
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 199dcb9..33bdc41 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -355,6 +355,7 @@ void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
 		dprintk("FREQ: %lu - CPU: %lu", (unsigned long)freqs->new,
 			(unsigned long)freqs->cpu);
 		trace_power_frequency(POWER_PSTATE, freqs->new, freqs->cpu);
+		trace_processor_frequency(freqs->new, freqs->cpu);
 		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 				CPUFREQ_POSTCHANGE, freqs);
 		if (likely(policy) && likely(policy->cpu == freqs->cpu))
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a507108..f79de04 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -107,6 +107,7 @@ static void cpuidle_idle_call(void)
 	if (cpuidle_curr_governor->reflect)
 		cpuidle_curr_governor->reflect(dev);
 	trace_power_end(smp_processor_id());
+	trace_processor_idle(0, smp_processor_id());
 }
 
 /**
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 21ac077..c78e496 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -202,6 +202,7 @@ static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state)
 
 	stop_critical_timings();
 	trace_power_start(POWER_CSTATE, (eax >> 4) + 1, cpu);
+	trace_processor_idle((eax >> 4) + 1, smp_processor_id());
 	if (!need_resched()) {
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 35a2a6e..d5cecd9 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -7,6 +7,60 @@
 #include <linux/ktime.h>
 #include <linux/tracepoint.h>
 
+DECLARE_EVENT_CLASS(processor,
+
+	TP_PROTO(unsigned int state, unsigned int cpu_id),
+
+	TP_ARGS(state, cpu_id),
+
+	TP_STRUCT__entry(
+		__field(	u64,		state		)
+		__field(	u64,		cpu_id		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->cpu_id = cpu_id;
+	),
+
+	TP_printk("state=%lu cpu_id=%lu", (unsigned long)__entry->state,
+		  (unsigned long)__entry->cpu_id)
+);
+
+DEFINE_EVENT(processor, processor_idle,
+
+	TP_PROTO(unsigned int state, unsigned int cpu_id),
+
+	     TP_ARGS(state, cpu_id)
+);
+
+DEFINE_EVENT(processor, processor_frequency,
+
+	TP_PROTO(unsigned int frequency, unsigned int cpu_id),
+
+	TP_ARGS(frequency, cpu_id)
+);
+
+TRACE_EVENT(machine_suspend,
+
+	TP_PROTO(unsigned int state),
+
+	TP_ARGS(state),
+
+	TP_STRUCT__entry(
+		__field(	u64,		state		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+	),
+
+	TP_printk("state=%lu", (unsigned long)__entry->state)
+
+);
+
+#ifdef CONFIG_EVENT_POWER_TRACING_DEPRECATED
+
 #ifndef _TRACE_POWER_ENUM_
 #define _TRACE_POWER_ENUM_
 enum {
@@ -69,8 +123,32 @@ TRACE_EVENT(power_end,
 	TP_printk("cpu_id=%lu", (unsigned long)__entry->cpu_id)
 
 );
-
+#endif /* CONFIG_EVENT_POWER_TRACING_DEPRECATED */
 #endif /* _TRACE_POWER_H */
 
+/* Deprecated dummy functions must be protected against multi-declartion */
+#ifndef EVENT_POWER_TRACING_DEPRECATED_PART_H
+#define EVENT_POWER_TRACING_DEPRECATED_PART_H
+
+#ifndef CONFIG_EVENT_POWER_TRACING_DEPRECATED
+
+#ifndef _TRACE_POWER_ENUM_
+#define _TRACE_POWER_ENUM_
+enum {
+	POWER_NONE = 0,
+	POWER_CSTATE = 1,
+	POWER_PSTATE = 2,
+};
+#endif
+
+static inline void trace_power_start(u64 type, u64 state, u64 cpuid) {};
+static inline void trace_power_end(u64 cpuid) {};
+static inline void trace_power_frequency(u64 type, u64 state, u64 cpuid) {};
+#endif /* CONFIG_EVENT_POWER_TRACING_DEPRECATED */
+
+#endif /* EVENT_POWER_TRACING_DEPRECATED_PART_H */
+
+
+
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 538501c..0b5c841 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -64,6 +64,20 @@ config EVENT_TRACING
 	select CONTEXT_SWITCH_TRACER
 	bool
 
+config EVENT_POWER_TRACING_DEPRECATED
+	depends on EVENT_TRACING
+	bool
+	help
+	  Provides old power event types:
+	  C-state/idle accounting events:
+	  power:power_start
+	  power:power_end
+	  and old cpufreq accounting event:
+	  power:power_frequency
+	  This is for userspace compatibility
+	  and will vanish after 5 kernel iterations,
+	  namely 2.6.41.
+
 config CONTEXT_SWITCH_TRACER
 	bool
 
diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index 0e0497d..6b6da42 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -13,5 +13,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/power.h>
 
+#ifdef EVENT_POWER_TRACING_DEPRECATED
 EXPORT_TRACEPOINT_SYMBOL_GPL(power_start);
+#endif
+EXPORT_TRACEPOINT_SYMBOL_GPL(processor_idle);
 
-- 
1.6.0.2

