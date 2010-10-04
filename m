From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 4/4] perf: provide a DEPRECTAED power trace API to user space
Date: Mon,  4 Oct 2010 17:21:01 +0200
Message-ID: <1286205661-24448-5-git-send-email-jean.pihet@newoldbits.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, mathieu.desnoyers@efficios.com, Jean Pihet <jean.pihet@newoldbits.com>, Jean Pihet <j-pihet@ti.com>, Thomas Renninger <trenn@suse.de>
List-Id: linux-omap@vger.kernel.org

Provide a CONFIG_DEPRECATED_POWER_EVENT_TRACING  option in order
to provide backward compatibility with the user space tracing tools.

To be removed as soon as the tools are in sync with the new API.
Note: only the old events are mapped to.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
CC: Thomas Renninger <trenn@suse.de>
---
 include/trace/events/power.h |   98 ++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/Kconfig         |    4 ++
 kernel/trace/power-traces.c  |    4 ++
 3 files changed, 106 insertions(+), 0 deletions(-)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 00bf175..dd00512 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -7,6 +7,103 @@
 #include <linux/ktime.h>
 #include <linux/tracepoint.h>
 
+
+#ifdef CONFIG_DEPRECATED_POWER_EVENT_TRACING
+/*
+ * Keep the old power API for user space tools backward compatibility.
+ * To be removed as soon as the tools are in sync with the new API.
+ *
+ * Note: only the old events are mapped to.
+ *
+ * The mapping is as follows:
+ *  - trace_processor_idle(state != 0, cpu_id) =>
+ *	trace_power_start(POWER_CSTATE, state, cpu_id)
+ *  - trace_processor_idle(state == 0, cpu_id) =>
+ *	trace_power_end(cpu_id)
+ *  - trace_processor_frequency(frequency, cpu_id) =>
+ *	trace_power_frequency(POWER_PSTATE, frequency, cpu_id)
+ *
+ */
+
+/* Define old API events */
+#ifndef _TRACE_POWER_OLD_API_
+#define _TRACE_POWER_OLD_API_
+enum {
+	POWER_NONE = 0,
+	POWER_CSTATE = 1,
+	POWER_PSTATE = 2,
+};
+#endif /* _TRACE_POWER_OLD_API_ */
+
+DECLARE_EVENT_CLASS(power,
+
+	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
+
+	TP_ARGS(type, state, cpu_id),
+
+	TP_STRUCT__entry(
+		__field(	u64,		type		)
+		__field(	u64,		state		)
+		__field(	u64,		cpu_id		)
+	),
+
+	TP_fast_assign(
+		__entry->type = type;
+		__entry->state = state;
+		__entry->cpu_id = cpu_id;
+	),
+
+	TP_printk("type=%lu state=%lu cpu_id=%lu", (unsigned long)__entry->type,
+		(unsigned long)__entry->state, (unsigned long)__entry->cpu_id)
+);
+
+DEFINE_EVENT(power, power_start,
+
+	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
+
+	TP_ARGS(type, state, cpu_id)
+);
+
+DEFINE_EVENT(power, power_frequency,
+
+	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
+
+	TP_ARGS(type, state, cpu_id)
+);
+
+TRACE_EVENT(power_end,
+
+	TP_PROTO(unsigned int cpu_id),
+
+	TP_ARGS(cpu_id),
+
+	TP_STRUCT__entry(
+		__field(	u64,		cpu_id		)
+	),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+	),
+
+	TP_printk("cpu_id=%lu", (unsigned long)__entry->cpu_id)
+);
+
+/* Map new events trace points calls to old ones */
+#define trace_processor_idle(state, cpu_id)				\
+	do {								\
+		if (state != 0)						\
+			trace_power_start(POWER_CSTATE, state, cpu_id);	\
+		else							\
+			trace_power_end(cpu_id);			\
+	} while (0)
+
+#define trace_processor_frequency(frequency, cpu_id)			\
+	do {								\
+		trace_power_frequency(POWER_PSTATE, frequency, cpu_id);	\
+	} while (0)
+
+#else /* CONFIG_DEPRECATED_POWER_EVENT_TRACING */
+
 /*
  * The processor events class is used for cpuidle (processor_idle) and
  *  for cpufreq (processor_frequency)
@@ -44,6 +141,7 @@ DEFINE_EVENT(processor, processor_frequency,
 
 	TP_ARGS(frequency, cpu_id)
 );
+#endif /* CONFIG_DEPRECATED_POWER_EVENT_TRACING */
 
 /*
  * The machine_suspend event is used for system suspend (machine_suspend)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 538501c..dab2bc1 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -64,6 +64,10 @@ config EVENT_TRACING
 	select CONTEXT_SWITCH_TRACER
 	bool
 
+config DEPRECATED_POWER_EVENT_TRACING
+	bool "Use the deprecated power trace API"
+	default n
+
 config CONTEXT_SWITCH_TRACER
 	bool
 
diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index a5555be..3a95670 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -13,4 +13,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/power.h>
 
+#ifdef CONFIG_DEPRECATED_POWER_EVENT_TRACING
+EXPORT_TRACEPOINT_SYMBOL_GPL(power_start);
+#else
 EXPORT_TRACEPOINT_SYMBOL_GPL(processor_idle);
+#endif
-- 
1.7.1

