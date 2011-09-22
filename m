From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 03/10] cpufreq: OMAP: Enable all CPUs in shared policy mask
Date: Thu, 22 Sep 2011 14:07:21 -0700
Message-ID: <1316725648-26710-4-git-send-email-khilman@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:45762 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753866Ab1IVVHl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 17:07:41 -0400
In-Reply-To: <1316725648-26710-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Todd Poynor <toddpoynor@google.com>

Enable all CPUs in the shared policy in the CPU init callback.
Otherwise, the governor CPUFREQ_GOV_START event is invoked with
a policy that only includes the first CPU, leaving other CPUs
uninitialized by the governor.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index f9b4c4d..5e2f05a 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -151,7 +151,6 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
 	struct device *mpu_dev;
-	static cpumask_var_t cpumask;
 
 	if (cpu_is_omap24xx())
 		mpu_clk = clk_get(NULL, "virt_prcm_set");
@@ -199,8 +198,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	 */
 	if (is_smp()) {
 		policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
-		cpumask_or(cpumask, cpumask_of(policy->cpu), cpumask);
-		cpumask_copy(policy->cpus, cpumask);
+		cpumask_setall(policy->cpus);
 	}
 
 	/* FIXME: what's the actual transition time? */
-- 
1.7.6

