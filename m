From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH 2/6 v2] OMAP2+: cpufreq: handle invalid cpufreq table
Date: Wed, 18 May 2011 02:37:42 -0500
Message-ID: <1305704266-17623-3-git-send-email-nm@ti.com>
References: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:39859 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754427Ab1ERHh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 03:37:56 -0400
Received: by ywa1 with SMTP id 1so585566ywa.14
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:37:54 -0700 (PDT)
In-Reply-To: <[PM-WIP_CPUFREQ][PATCH 0/5] Cleanups for cpufreq>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Handle the case when cpufreq_frequency_table_cpuinfo fails. freq_table
that we passed failed the internal test of cpufreq generic driver,
so we should'nt be using the freq_table as such. Instead, warn and
fallback to clock functions for validation and operation.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index e38ebb8..6e3666a 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -182,10 +182,18 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 
 	if (freq_table) {
 		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
-		if (!result)
+		if (!result) {
 			cpufreq_frequency_table_get_attr(freq_table,
 							policy->cpu);
-	} else {
+		} else {
+			WARN(true, "%s: fallback to clk_round(freq_table=%d)\n",
+					__func__, result);
+			kfree(freq_table);
+			freq_table = NULL;
+		}
+	}
+
+	if (!freq_table) {
 		policy->cpuinfo.min_freq = clk_round_rate(mpu_clk, 0) / 1000;
 		policy->cpuinfo.max_freq = clk_round_rate(mpu_clk,
 							VERY_HI_RATE) / 1000;
-- 
1.7.1

