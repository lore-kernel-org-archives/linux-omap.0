From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/4] PERF: Do not export power_frequency, but power_start event
Date: Wed, 27 Oct 2010 01:43:22 +0200
Message-ID: <1288136605-10526-2-git-send-email-trenn@suse.de>
References: <1288136605-10526-1-git-send-email-trenn@suse.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58484 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab0JZXng (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 19:43:36 -0400
In-Reply-To: <1288136605-10526-1-git-send-email-trenn@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arjan@linux.intel.com, jean.pihet@newoldbits.com, mingo@elte.hu, rjw@sisk.pl, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>

power_frequency moved to drivers/cpufreq/cpufreq.c which has
to be compiled in, no need to export it.

intel_idle can a be module though...

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: linux-omap@vger.kernel.org
CC: linux-pm@lists.linux-foundation.org
CC: linux-trace-users@vger.kernel.org
CC: Jean Pihet <jean.pihet@newoldbits.com>
CC: Arjan van de Ven <arjan@linux.intel.com>
CC: Ingo Molnar <mingo@elte.hu>
CC: rjw@sisk.pl
---
 drivers/idle/intel_idle.c   |    2 --
 kernel/trace/power-traces.c |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c37ef64..21ac077 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -201,9 +201,7 @@ static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state)
 	kt_before = ktime_get_real();
 
 	stop_critical_timings();
-#ifndef MODULE
 	trace_power_start(POWER_CSTATE, (eax >> 4) + 1, cpu);
-#endif
 	if (!need_resched()) {
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index a22582a..0e0497d 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -13,5 +13,5 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/power.h>
 
-EXPORT_TRACEPOINT_SYMBOL_GPL(power_frequency);
+EXPORT_TRACEPOINT_SYMBOL_GPL(power_start);
 
-- 
1.6.3

