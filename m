From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP2+: CPUfreq: Allow the CPU scaling when secondary CPUs
 are offline.
Date: Thu, 02 Jun 2011 20:23:57 +0530
Message-ID: <4DE7A405.9030602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41963 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608Ab1FBOyE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 10:54:04 -0400
Received: by yxm8 with SMTP id 8so464073yxm.26
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 07:54:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@ti.com>

Missed Kevin in cc. :(
Sorry about that.

-------- Original Message --------
Subject: [PATCH] OMAP2+: CPUfreq: Allow the CPU scaling when secondary 
CPUs are offline.
Date: Thu, 2 Jun 2011 20:21:10 +0530
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
To: <linux-omap@vger.kernel.org>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>

Current OMAP2PLUS CPUfreq tagret() functions returns when all
the CPU's are not online. This will break DVFS when secondary
CPUs are offlined.

The intention of that check was just avoid CPU frequency change
during the window when CPU becomes online but it's cpufreq_init is
not done yet.

Fix the check accordingly.

Thanks for Nishant Menon <nm@ti.com> for reporting it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reported-by: Nishanth Menon <nm@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
There were some question of making the variable atomic etc
in an internal discussion. After some thinking, I realised
there is no need of that since this is just a counter which
maintains the count for online_cpus = cpufreq_init_cpus.

  arch/arm/mach-omap2/omap2plus-cpufreq.c |    9 ++++++++-
  1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c 
b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 33a91ec..909bfcb 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -44,6 +44,7 @@ static struct cpufreq_frequency_table *freq_table;
  static struct clk *mpu_clk;
  static char *mpu_clk_name;
  static struct device *mpu_dev;
+static int cpus_initialized;

  static int omap_verify_speed(struct cpufreq_policy *policy)
  {
@@ -82,7 +83,7 @@ static int omap_target(struct cpufreq_policy *policy,
  	struct cpufreq_freqs freqs;

  	/* Changes not allowed until all CPUs are online */
-	if (is_smp() && (num_online_cpus() < NR_CPUS))
+	if (is_smp() && (cpus_initialized < num_online_cpus()))
  		return ret;

  	/* Ensure desired rate is within allowed range.  Some govenors
@@ -194,6 +195,8 @@ static int __cpuinit omap_cpu_init(struct 
cpufreq_policy *policy)
  		policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
  		cpumask_or(cpumask, cpumask_of(policy->cpu), cpumask);
  		cpumask_copy(policy->cpus, cpumask);
+		cpus_initialized++;
+		smp_wmb();
  	}

  	/* FIXME: what's the actual transition time? */
@@ -206,6 +209,10 @@ static int omap_cpu_exit(struct cpufreq_policy *policy)
  {
  	clk_exit_cpufreq_table(&freq_table);
  	clk_put(mpu_clk);
+	if (is_smp()) {
+		cpus_initialized--;
+		smp_wmb();
+	}
  	return 0;
  }

-- 
1.6.0.4

