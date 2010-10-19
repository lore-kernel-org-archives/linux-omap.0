From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/3] PERF(userspace): Adjust perf timechart to the new power events
Date: Tue, 19 Oct 2010 13:36:11 +0200
Message-ID: <1287488171-25303-4-git-send-email-trenn@suse.de>
References: <1287488171-25303-1-git-send-email-trenn@suse.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45522 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758432Ab0JSLgN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 07:36:13 -0400
In-Reply-To: <1287488171-25303-1-git-send-email-trenn@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: trenn@suse.de
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>

The transition was rather smooth, only part I had to fiddle
some time was the check whether a tracepoint/event is
supported by the running kernel.

builtin-timechart must only pass -e power:xy events which
are supported by the running kernel.
For this I added the tiny helper function:
int is_valid_tracepoint(const char *event_string)
to parse-events.[hc]
which could be more generic as an interface and support
hardware/software/... events, not only tracepoints, but someone
else could extend that if needed...

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
 tools/perf/builtin-timechart.c |   87 ++++++++++++++++++++++++++++++++-------
 tools/perf/util/parse-events.c |   43 +++++++++++++++++++-
 tools/perf/util/parse-events.h |    1 +
 3 files changed, 114 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 9bcc38f..1304c27 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -32,6 +32,8 @@
 #include "util/session.h"
 #include "util/svghelper.h"
 
+#define SUPPORT_OLD_POWER_EVENTS 1
+
 static char		const *input_name = "perf.data";
 static char		const *output_name = "output.svg";
 
@@ -298,12 +300,25 @@ struct trace_entry {
 	int			lock_depth;
 };
 
-struct power_entry {
+#if defined(SUPPORT_OLD_POWER_EVENTS)
+struct power_entry_old {
 	struct trace_entry te;
 	u64	type;
 	u64	value;
 	u64	cpu_id;
 };
+#endif
+
+struct power_processor_entry {
+	struct trace_entry te;
+	u64	state;
+	u64	cpu_id;
+};
+
+struct power_suspend_entry {
+	struct trace_entry te;
+	u64	state;
+};
 
 #define TASK_COMM_LEN 16
 struct wakeup_entry {
@@ -489,29 +504,46 @@ static int process_sample_event(event_t *event, struct perf_session *session)
 	te = (void *)data.raw_data;
 	if (session->sample_type & PERF_SAMPLE_RAW && data.raw_size > 0) {
 		char *event_str;
-		struct power_entry *pe;
-
-		pe = (void *)te;
+#if defined(SUPPORT_OLD_POWER_EVENTS)
+		struct power_entry_old *peo;
+		peo = (void *)te;
+#endif
 
 		event_str = perf_header__find_event(te->type);
 
 		if (!event_str)
 			return 0;
 
-		if (strcmp(event_str, "power:power_start") == 0)
-			c_state_start(pe->cpu_id, data.time, pe->value);
-
-		if (strcmp(event_str, "power:power_end") == 0)
-			c_state_end(pe->cpu_id, data.time);
+		if (strcmp(event_str, "power:processor_idle") == 0) {
+			struct power_processor_entry *ppe = (void *)te;
+			if (ppe->state == 0)
+				c_state_end(ppe->cpu_id, data.time);
+			else
+				c_state_start(ppe->cpu_id, data.time,
+					      ppe->state);
+		}
 
-		if (strcmp(event_str, "power:power_frequency") == 0)
-			p_state_change(pe->cpu_id, data.time, pe->value);
+		else if (strcmp(event_str, "power:processor_frequency") == 0) {
+			struct power_processor_entry *ppe = (void *)te;
+			p_state_change(ppe->cpu_id, data.time, ppe->state);
+		}
 
-		if (strcmp(event_str, "sched:sched_wakeup") == 0)
+		else if (strcmp(event_str, "sched:sched_wakeup") == 0)
 			sched_wakeup(data.cpu, data.time, data.pid, te);
 
-		if (strcmp(event_str, "sched:sched_switch") == 0)
+		else if (strcmp(event_str, "sched:sched_switch") == 0)
 			sched_switch(data.cpu, data.time, te);
+
+#if defined(SUPPORT_OLD_POWER_EVENTS)
+		else if (strcmp(event_str, "power:power_start") == 0)
+			c_state_start(peo->cpu_id, data.time, peo->value);
+
+		else if (strcmp(event_str, "power:power_end") == 0)
+			c_state_end(peo->cpu_id, data.time);
+
+		else if (strcmp(event_str, "power:power_frequency") == 0)
+			p_state_change(peo->cpu_id, data.time, peo->value);
+#endif
 	}
 	return 0;
 }
@@ -968,7 +1000,8 @@ static const char * const timechart_usage[] = {
 	NULL
 };
 
-static const char *record_args[] = {
+#if defined(SUPPORT_OLD_POWER_EVENTS)
+static const char *record_old_args[] = {
 	"record",
 	"-a",
 	"-R",
@@ -980,16 +1013,38 @@ static const char *record_args[] = {
 	"-e", "sched:sched_wakeup",
 	"-e", "sched:sched_switch",
 };
+#endif
+
+static const char *record_new_args[] = {
+	"record",
+	"-a",
+	"-R",
+	"-f",
+	"-c", "1",
+	"-e", "power:processor_frequency",
+	"-e", "power:processor_idle",
+	"-e", "sched:sched_wakeup",
+	"-e", "sched:sched_switch",
+};
 
 static int __cmd_record(int argc, const char **argv)
 {
 	unsigned int rec_argc, i, j;
 	const char **rec_argv;
+	const char **record_args = record_new_args;
+	unsigned int record_elems = ARRAY_SIZE(record_new_args);
 
-	rec_argc = ARRAY_SIZE(record_args) + argc - 1;
+#if defined(SUPPORT_OLD_POWER_EVENTS)
+	if (is_valid_tracepoint("power:power_start")) {
+		record_args = record_old_args;
+		record_elems = ARRAY_SIZE(record_old_args);
+	}
+#endif
+	
+	rec_argc = record_elems + argc - 1;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 
-	for (i = 0; i < ARRAY_SIZE(record_args); i++)
+	for (i = 0; i < record_elems; i++)
 		rec_argv[i] = strdup(record_args[i]);
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4af5bd5..d706dcb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -824,7 +824,7 @@ int parse_events(const struct option *opt __used, const char *str, int unset __u
 		if (ret != EVT_HANDLED_ALL) {
 			attrs[nr_counters] = attr;
 			nr_counters++;
-		}
+	}
 
 		if (*str == 0)
 			break;
@@ -906,6 +906,47 @@ static void print_tracepoint_events(void)
 }
 
 /*
+ * Check whether event is in <debugfs_mount_point>/tracing/events
+ */
+
+int is_valid_tracepoint(const char *event_string)
+{
+	DIR *sys_dir, *evt_dir;
+	struct dirent *sys_next, *evt_next, sys_dirent, evt_dirent;
+	char evt_path[MAXPATHLEN];
+	char dir_path[MAXPATHLEN];
+
+	if (debugfs_valid_mountpoint(debugfs_path))
+		return 0;
+
+	sys_dir = opendir(debugfs_path);
+	if (!sys_dir)
+		return 0;
+
+	for_each_subsystem(sys_dir, sys_dirent, sys_next) {
+
+		snprintf(dir_path, MAXPATHLEN, "%s/%s", debugfs_path,
+			 sys_dirent.d_name);
+		evt_dir = opendir(dir_path);
+		if (!evt_dir)
+			continue;
+
+		for_each_event(sys_dirent, evt_dir, evt_dirent, evt_next) {
+			snprintf(evt_path, MAXPATHLEN, "%s:%s",
+				 sys_dirent.d_name, evt_dirent.d_name);
+			if (!strcmp(evt_path, event_string)) {
+				closedir(evt_dir);
+				closedir(sys_dir);
+				return 1;
+			}
+		}
+		closedir(evt_dir);
+	}
+	closedir(sys_dir);
+	return 0;
+}
+
+/*
  * Print the help text for the event symbols:
  */
 void print_events(void)
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index fc4ab3f..7ab4685 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -29,6 +29,7 @@ extern int parse_filter(const struct option *opt, const char *str, int unset);
 #define EVENTS_HELP_MAX (128*1024)
 
 extern void print_events(void);
+extern int is_valid_tracepoint(const char *event_string);
 
 extern char debugfs_path[];
 extern int valid_debugfs_mount(const char *debugfs);
-- 
1.6.0.2

