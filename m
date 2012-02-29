From: Richard Zhao <richard.zhao@linaro.org>
Subject: [PATCH 2/2] cpufreq: OMAP: remove loops_per_jiffy recalculate for smp
Date: Wed, 29 Feb 2012 15:18:15 +0800
Message-ID: <1330499895-12364-3-git-send-email-richard.zhao@linaro.org>
References: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org
Cc: linux@arm.linux.org.uk, davej@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com, davidb@codeaurora.org, arnd@arndb.de, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, Richard Zhao <richard.zhao@linaro.org>
List-Id: linux-omap@vger.kernel.org

arm registered cpufreq transition notifier to recalculate it.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/cpufreq/omap-cpufreq.c |   36 ------------------------------------
 1 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 5d04c57..17da4c4 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -37,16 +37,6 @@
 
 #include <mach/hardware.h>
 
-#ifdef CONFIG_SMP
-struct lpj_info {
-	unsigned long	ref;
-	unsigned int	freq;
-};
-
-static DEFINE_PER_CPU(struct lpj_info, lpj_ref);
-static struct lpj_info global_lpj_ref;
-#endif
-
 static struct cpufreq_frequency_table *freq_table;
 static atomic_t freq_table_users = ATOMIC_INIT(0);
 static struct clk *mpu_clk;
@@ -118,32 +108,6 @@ static int omap_target(struct cpufreq_policy *policy,
 	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
 	freqs.new = omap_getspeed(policy->cpu);
 
-#ifdef CONFIG_SMP
-	/*
-	 * Note that loops_per_jiffy is not updated on SMP systems in
-	 * cpufreq driver. So, update the per-CPU loops_per_jiffy value
-	 * on frequency transition. We need to update all dependent CPUs.
-	 */
-	for_each_cpu(i, policy->cpus) {
-		struct lpj_info *lpj = &per_cpu(lpj_ref, i);
-		if (!lpj->freq) {
-			lpj->ref = per_cpu(cpu_data, i).loops_per_jiffy;
-			lpj->freq = freqs.old;
-		}
-
-		per_cpu(cpu_data, i).loops_per_jiffy =
-			cpufreq_scale(lpj->ref, lpj->freq, freqs.new);
-	}
-
-	/* And don't forget to adjust the global one */
-	if (!global_lpj_ref.freq) {
-		global_lpj_ref.ref = loops_per_jiffy;
-		global_lpj_ref.freq = freqs.old;
-	}
-	loops_per_jiffy = cpufreq_scale(global_lpj_ref.ref, global_lpj_ref.freq,
-					freqs.new);
-#endif
-
 	/* notifiers */
 	for_each_cpu(i, policy->cpus) {
 		freqs.cpu = i;
-- 
1.7.5.4


