From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 04/10] cpufreq: OMAP: notify even with bad boot frequency
Date: Thu, 22 Sep 2011 14:07:22 -0700
Message-ID: <1316725648-26710-5-git-send-email-khilman@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1316725648-26710-1-git-send-email-khilman@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Colin Cross <ccross@google.com>

Sometimes, bootloaders starts up with a frequency which is not
in the OPP table. At cpu_init, policy->cur contains the frequency
we pick at boot.  It is possible that system might have fixed
it's boot frequency later on as part of power initialization.
After this condition, the first call to omap_target results in the
following:

omap_getspeed(actual device frequency) != policy->cur(frequency that
cpufreq thinks that the system is at), and it is possible that
freqs.old == freqs.new (because the governor requested a scale down).

We exit without triggering the notifiers in the current code, which
does'nt let code which depends on cpufreq_notify_transition to have
accurate information as to what the system frequency is.

Instead, we do a normal transition if policy->cur is wrong, then,
freqs.old will be the actual cpu frequency, freqs.new will be the
actual new cpu frequency and all required notifiers have the accurate
information.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Colin Cross <ccross@google.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 5e2f05a..724d36c 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -96,7 +96,7 @@ static int omap_target(struct cpufreq_policy *policy,
 	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
 	freqs.cpu = policy->cpu;
 
-	if (freqs.old == freqs.new)
+	if (freqs.old == freqs.new && policy->cur == freqs.new)
 		return ret;
 
 	/* notifiers */
-- 
1.7.6

