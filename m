From: Todd Poynor <toddpoynor@google.com>
Subject: [PATCH pm_wip/cpufreq] OMAP2+: cpufreq: Enable all CPUs in shared
 policy mask
Date: Tue, 7 Jun 2011 13:57:52 -0700
Message-ID: <20110607205752.GA11299@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:2025 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757262Ab1FGU6B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 16:58:01 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, Mike Turquette <mturquette@ti.com>, linux-omap@vger.kernel.org

Enable all CPUs in the shared policy in the CPU init callback.
Otherwise, the governor CPUFREQ_GOV_START event is invoked with
a policy that only includes the first CPU, leaving other CPUs
uninitialized by the governor.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 77efcb0..0fe4edb 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -166,7 +166,6 @@ static inline void freq_table_free(void)
 static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
-	static cpumask_var_t cpumask;
 
 	mpu_clk = clk_get(NULL, mpu_clk_name);
 	if (IS_ERR(mpu_clk))
@@ -207,8 +206,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 	 */
 	if (is_smp()) {
 		policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
-		cpumask_or(cpumask, cpumask_of(policy->cpu), cpumask);
-		cpumask_copy(policy->cpus, cpumask);
+		cpumask_setall(policy->cpus);
 	}
 
 	/* FIXME: what's the actual transition time? */
-- 
1.7.3.1

