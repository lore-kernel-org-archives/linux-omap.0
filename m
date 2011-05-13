From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-CPUFREQ][PATCH 5/5] OMAP2+: cpufreq: use cpufreq_frequency_table_target
Date: Fri, 13 May 2011 14:07:26 -0700
Message-ID: <1305320846-16147-6-git-send-email-nm@ti.com>
References: <1305320846-16147-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41475 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759155Ab1EMVH5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 17:07:57 -0400
Received: by mail-gw0-f51.google.com with SMTP id 17so1019569gwj.10
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 14:07:56 -0700 (PDT)
In-Reply-To: <1305320846-16147-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Use cpufreq_frequency_table_target for finding the proper target
instead of seeing if the frequency requested is divisible alone.
if we have a frequency table, we should restrict ourselves to
selecting the "approved" frequencies alone and only in the case
where the frequency table is not available should we attempt at
closest roundable clock frequency.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   34 +++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 854f4b3..688c5bc 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -77,24 +77,38 @@ static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-	int i, ret = 0;
+	unsigned int i;
+	int ret = 0;
 	struct cpufreq_freqs freqs;
 
 	/* Changes not allowed until all CPUs are online */
 	if (is_smp() && (num_online_cpus() < NR_CPUS))
 		return ret;
 
-	/*
-	 * Ensure desired rate is within allowed range.  Some govenors
-	 * (ondemand) will just pass target_freq=0 to get the minimum.
-	 */
-	if (target_freq < policy->min)
-		target_freq = policy->min;
-	if (target_freq > policy->max)
-		target_freq = policy->max;
+	if (freq_table) {
+		cpufreq_frequency_table_target(policy, freq_table, target_freq,
+			relation, &i);
+		freqs.new = freq_table[i].frequency;
+	} else {
+		/*
+		 * Ensure desired rate is within allowed range. Some govenors
+		 * (ondemand) will just pass target_freq=0 to get the minimum.
+		 */
+		if (target_freq < policy->min)
+			target_freq = policy->min;
+		if (target_freq > policy->max)
+			target_freq = policy->max;
+
+		freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
+	}
+	if (!freqs.new) {
+		for_each_cpu(i, policy->cpus)
+			pr_err("%s:cpu%d no match for freq %d\n", __func__,
+				i, target_freq);
+		return -EINVAL;
+	}
 
 	freqs.old = omap_getspeed(policy->cpu);
-	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
 	freqs.cpu = policy->cpu;
 
 	if (freqs.old == freqs.new)
-- 
1.7.1

