From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 19:23:38 +0530
Message-ID: <1308923618-5333-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51228 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab1FXNx5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 09:53:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

Currently, loops_per_jiffy is being calculated twice for
non-SMP processors.
 - Before calling cpufreq_notify_transition()
 - From within cpufreq_notify_transition()

Double adjustment leads to incorrect value being assigned to
loops_per_jiffy. This manifests as incorrect BogoMIPS in
"cat /proc/cpuinfo".

The value of loops_per_jiffy needs to be calculated only
when CONFIG_SMP is true. It is the core change included
in this patch.

The patch also leverages the definition of for_each_cpu()
with and without CONFIG_SMP to consolidate the mechanism
to call cpufreq_notify_transition().

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 Changes since v1:
   * loops_per_jiffy are updated when CONFIG_SMP is true.
   * leverage definition of for_each_cpu()

 Tested on OMAP3EVM with and without CONFIG_SMP.
 Since the log is rather long, will be posting the log in
 a follow-up mail.

 arch/arm/mach-omap2/omap2plus-cpufreq.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 346519e..0263cae 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -97,12 +97,8 @@ static int omap_target(struct cpufreq_policy *policy,
 		return ret;

 	/* Notify transitions */
-	if (is_smp()) {
-		for_each_cpu(i, policy->cpus) {
-			freqs.cpu = i;
-			cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-		}
-	} else {
+	for_each_cpu(i, policy->cpus) {
+		freqs.cpu = i;
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 	}

@@ -114,13 +110,20 @@ static int omap_target(struct cpufreq_policy *policy,

 	freqs.new = omap_getspeed(policy->cpu);

+#ifdef CONFIG_SMP
+	/* Adjust jiffies before transition */
+	for_each_cpu(i, policy->cpus) {
+		unsigned long lpj = per_cpu(cpu_data, i).loops_per_jiffy;
+
+		per_cpu(cpu_data, i).loops_per_jiffy = cpufreq_scale(lpj,
+							freqs.old,
+							freqs.new);
+	}
+#endif
+
 	/* Notify transitions */
-	if (is_smp()) {
-		for_each_cpu(i, policy->cpus) {
-			freqs.cpu = i;
-			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-		}
-	} else {
+	for_each_cpu(i, policy->cpus) {
+		freqs.cpu = i;
 		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 	}

--
1.7.2.2

