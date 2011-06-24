From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 2/2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 16:05:42 +0530
Message-ID: <1308911742-27394-3-git-send-email-premi@ti.com>
References: <1308911742-27394-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50703 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660Ab1FXKgB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 06:36:01 -0400
In-Reply-To: <1308911742-27394-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

Currently, loops_per_jiffy is being calculated before calling
cpufreq_notify_transition().

However, generic cpufreq driver adjusts the jiffies as well.
Double adjustment leads to incorrect value being assigned to
loops_per_jiffy.

This manifests as incorrect BogoMIPS in "cat /proc/cpuinfo'

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index ce9d534..346519e 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -114,29 +114,13 @@ static int omap_target(struct cpufreq_policy *policy,
 
 	freqs.new = omap_getspeed(policy->cpu);
 
-	/*
-	 * In the generic cpufreq driver jiffies are updated only for
-	 * non-SMP cases. Ensure that jiffies are bing updated for both
-	 * SMP systems and UP systems built with CONFIG_SMP enabled.
-	 */
+	/* Notify transitions */
 	if (is_smp()) {
-#ifdef CONFIG_SMP
-		for_each_cpu(i, policy->cpus)
-			per_cpu(cpu_data, i).loops_per_jiffy =
-				cpufreq_scale(per_cpu(cpu_data, i).loops_per_jiffy,
-						freqs.old,
-						freqs.new);
-#endif
-		/* Notify transitions */
 		for_each_cpu(i, policy->cpus) {
 			freqs.cpu = i;
 			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 		}
 	} else {
-		loops_per_jiffy = cpufreq_scale(loops_per_jiffy,
-					freqs.old, freqs.new);
-
-		/* Notify transitions */
 		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 	}
 
-- 
1.7.2.2

