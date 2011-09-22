From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 09/10] cpufreq: OMAP: put clk if cpu_init failed
Date: Thu, 22 Sep 2011 14:07:27 -0700
Message-ID: <1316725648-26710-10-git-send-email-khilman@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1316725648-26710-1-git-send-email-khilman@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

Release the mpu_clk in fail paths.

Reported-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index ce82d50..a66c8b5 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -157,8 +157,10 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
-	if (policy->cpu >= NR_CPUS)
-		return -EINVAL;
+	if (policy->cpu >= NR_CPUS) {
+		result = -EINVAL;
+		goto fail_ck;
+	}
 
 	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
 	result = opp_init_cpufreq_table(mpu_dev, &freq_table);
@@ -166,12 +168,14 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	if (result) {
 		dev_err(mpu_dev, "%s: cpu%d: failed creating freq table[%d]\n",
 				__func__, policy->cpu, result);
-		return result;
+		goto fail_ck;
 	}
 
 	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
 	if (!result)
 		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
+	else
+		goto fail_ck;
 
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
@@ -193,6 +197,10 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 300 * 1000;
 
 	return 0;
+
+fail_ck:
+	clk_put(mpu_clk);
+	return result;
 }
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
-- 
1.7.6

