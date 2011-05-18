From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH 4/6 v2] OMAP2: cpufreq: use clk_init_cpufreq_table if OPPs not available
Date: Wed, 18 May 2011 02:37:44 -0500
Message-ID: <1305704266-17623-5-git-send-email-nm@ti.com>
References: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:33394 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755009Ab1ERHiA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 03:38:00 -0400
Received: by mail-gw0-f47.google.com with SMTP id 11so519020gwb.20
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:37:59 -0700 (PDT)
In-Reply-To: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

OMAP2 does not use OPP tables at the moment for DVFS. Currently,
we depend on opp table initialization to give us the freq_table,
which makes sense for OMAP3+. for OMAP2, we should be using
clk_init_cpufreq_table - so if the opp based frequency table
initilization fails, fall back to clk_init_cpufreq_table to give
us the table.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 45f1e9e..854f4b3 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -180,7 +180,13 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 		pr_warning("%s: unable to get the mpu device\n", __func__);
 		return -EINVAL;
 	}
-	opp_init_cpufreq_table(mpu_dev, &freq_table);
+
+	/*
+	 * if we dont get cpufreq table using opp, use traditional omap2 lookup
+	 * as a fallback
+	 */
+	if (opp_init_cpufreq_table(mpu_dev, &freq_table))
+		clk_init_cpufreq_table(&freq_table);
 
 	if (freq_table) {
 		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
@@ -188,6 +194,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 			cpufreq_frequency_table_get_attr(freq_table,
 							policy->cpu);
 		} else {
+			clk_exit_cpufreq_table(&freq_table);
 			WARN(true, "%s: fallback to clk_round(freq_table=%d)\n",
 					__func__, result);
 			kfree(freq_table);
-- 
1.7.1

