From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 3/4] perf: add calls to suspend trace point
Date: Mon,  4 Oct 2010 17:21:00 +0200
Message-ID: <1286205661-24448-4-git-send-email-jean.pihet@newoldbits.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, mathieu.desnoyers@efficios.com, Jean Pihet <jean.pihet@newoldbits.com>, Jean Pihet <j-pihet@ti.com>, Thomas Renninger <trenn@suse.de>
List-Id: linux-omap@vger.kernel.org

Uses the machine_suspend trace point, from the
generic kernel suspend_enter function.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
CC: Thomas Renninger <trenn@suse.de>
---
 kernel/power/suspend.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 7335952..10cad5c 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <trace/events/power.h>
 
 #include "power.h"
 
@@ -164,7 +165,9 @@ static int suspend_enter(suspend_state_t state)
 	error = sysdev_suspend(PMSG_SUSPEND);
 	if (!error) {
 		if (!suspend_test(TEST_CORE) && pm_check_wakeup_events()) {
+			trace_machine_suspend(state);
 			error = suspend_ops->enter(state);
+			trace_machine_suspend(0);
 			events_check_enabled = false;
 		}
 		sysdev_resume();
-- 
1.7.1

