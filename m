From: Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH v2 1/2] Trace: PM: promote event 'power_domain_target' to generic power domains.
Date: Mon, 28 Sep 2015 10:44:23 +0200
Message-ID: <1443429864-4177-1-git-send-email-mtitinger+renesas@baylibre.com>
References: <1443187345-14834-2-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1443187345-14834-2-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: khilman@kernel.org, rjw@rjwysocki.net, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>
List-Id: linux-omap@vger.kernel.org

- change arg3 to a state name string: we got the current CPU rom the trace
backend already. This also prepares for multiple/named states in the power
domain, consistent with idle-states. states in the domain may match given
CPU states in this case, we will trace them by their name, and potentially
use arg2 as a link to their index for the cpuidle driver.

- tested with Juno DP

<idle>-0     [000]    42.395510: power_domain_target:  a53_pd index=0 'cluster-sleep-0'
<idle>-0     [000]    42.395528: cpu_idle:             state=4294967295 cpu_id=0
<idle>-0     [000]    42.395668: cpu_idle:             state=2 cpu_id=0

- compiled for Omap2+

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/base/power/domain.c  |  5 +++++
 include/trace/events/power.h | 21 +++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 59ccd92..017c151 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -21,6 +21,8 @@
 #include <linux/export.h>
 #include <linux/sort.h>
 
+#include <trace/events/power.h>
+
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
@@ -328,6 +330,9 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 
  out:
 	genpd->status = GPD_STATE_ACTIVE;
+
+	trace_power_domain_target(genpd->name, genpd->state_idx,
+				genpd->states[genpd->state_idx].name);
 	return 0;
 
  err:
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 284244e..8172d93 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -278,31 +278,32 @@ DEFINE_EVENT(clock, clock_set_rate,
  */
 DECLARE_EVENT_CLASS(power_domain,
 
-	TP_PROTO(const char *name, unsigned int state, unsigned int cpu_id),
+	TP_PROTO(const char *name, unsigned int index, const char *state_name),
 
-	TP_ARGS(name, state, cpu_id),
+	TP_ARGS(name, index, state_name),
 
 	TP_STRUCT__entry(
 		__string(       name,           name            )
-		__field(        u64,            state           )
-		__field(        u64,            cpu_id          )
+		__field(        u64,            index           )
+		__string(       state_name,     state_name      )
 	),
 
 	TP_fast_assign(
 		__assign_str(name, name);
-		__entry->state = state;
-		__entry->cpu_id = cpu_id;
+		__entry->index = index;
+		__assign_str(state_name, state_name);
 ),
 
-	TP_printk("%s state=%lu cpu_id=%lu", __get_str(name),
-		(unsigned long)__entry->state, (unsigned long)__entry->cpu_id)
+	TP_printk("%s index=%lu '%s'", __get_str(name),
+		(unsigned long)__entry->index,
+		__get_str(state_name))
 );
 
 DEFINE_EVENT(power_domain, power_domain_target,
 
-	TP_PROTO(const char *name, unsigned int state, unsigned int cpu_id),
+	TP_PROTO(const char *name, unsigned int index, const char *state_name),
 
-	TP_ARGS(name, state, cpu_id)
+	TP_ARGS(name, index, state_name)
 );
 
 /*
-- 
1.9.1

