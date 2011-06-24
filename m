From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 11:48:24 -0700
Message-ID: <4E04DBF8.1050401@ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>	<20110624140142.GM9449@n2100.arm.linux.org.uk>	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2EF2@dbde02.ent.ti.com>	<20110624141402.GN9449@n2100.arm.linux.org.uk> <20110624151201.GO9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:54845 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754041Ab1FXSs3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 14:48:29 -0400
Received: by mail-gx0-f181.google.com with SMTP id 9so1874829gxk.40
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 11:48:28 -0700 (PDT)
In-Reply-To: <20110624151201.GO9449@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>

Russell,

On 6/24/2011 8:12 AM, Russell King - ARM Linux wrote:
> Right, thanks for the file.  Here's the patch.
>

[.....]

> Notice how we adjust _both_ the per-cpu loops_per_jiffy, and that we
> adjust them with reference to the initial values.
>
> If you adjust lpj with reference to the last, then you _will_ build up
> a progressively bigger and bigger error in the value over time.
>
Thanks Russell for the change. This change should fix the global
lpj for UP machine as well when build with SMP_ON_UP.

Can you have a look at below complete change which should
make the BOGOMIPS happy on all OMAP2PLUS machines. Generated
against Kevin's cpufreq branch.

url = 
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git 
pm-wip/cpufreq.

Just compile tested with UP and SMP OMAP builds. After your
review, I can give a test.

Regards
Santosh

 From 9a6154c0f68e39c4d1fbc4ef3fef5ce577ba87d4 Mon Sep 17 00:00:00 2001
From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Fri, 24 Jun 2011 10:51:17 -0700
Subject: [PATCH] OMAP2+: CPUfreq: update lpj with refernce value to 
avoid progressive error.

Adjust _both_ the per-cpu loops_per_jiffy and global lpj. Calibrate them
with with reference to the initial values to avoid a progressively
bigger and bigger error in the value over time.

While at this also re-use the notifiers for UP/SMP since on
UP machine or UP_ON_SMP policy->cpus mask would contain only
the one CPU.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[santosh.shilimkar@ti.com: rebased against omap cpufreq upstream branch]
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>
---
  arch/arm/mach-omap2/omap2plus-cpufreq.c |   48 
+++++++++++++++++-------------
  1 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c 
b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 1f3b2e1..434698e 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -38,6 +38,16 @@

  #include <mach/hardware.h>

+#ifdef CONFIG_SMP
+struct lpj_info {
+	unsigned long	ref;
+	unsigned int	freq;
+};
+
+static DEFINE_PER_CPU(struct lpj_info, lpj_ref);
+static struct lpj_info global_lpj_ref;
+#endif
+
  static struct cpufreq_frequency_table *freq_table;
  static atomic_t freq_table_users = ATOMIC_INIT(0);
  static struct clk *mpu_clk;
@@ -96,11 +106,6 @@ static int omap_target(struct cpufreq_policy *policy,
  	if (freqs.old == freqs.new && policy->cur == freqs.new)
  		return ret;

-	if (!is_smp()) {
-		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-		goto set_freq;
-	}
-
  	/* notifiers */
  	for_each_cpu(i, policy->cpus) {
  		freqs.cpu = i;
@@ -114,19 +119,7 @@ set_freq:

  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);

-	/*
-	 * Generic CPUFREQ driver jiffy update is under !SMP. So jiffies
-	 * won't get updated when UP machine cpufreq build with
-	 * CONFIG_SMP enabled. Below code is added only to manage that
-	 * scenario
-	 */
  	freqs.new = omap_getspeed(policy->cpu);
-	if (!is_smp()) {
-		loops_per_jiffy =
-			 cpufreq_scale(loops_per_jiffy, freqs.old, freqs.new);
-		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-		goto skip_lpj;
-	}

  #ifdef CONFIG_SMP
  	/*
@@ -134,10 +127,24 @@ set_freq:
  	 * cpufreq driver. So, update the per-CPU loops_per_jiffy value
  	 * on frequency transition. We need to update all dependent CPUs.
  	 */
-	for_each_cpu(i, policy->cpus)
+	for_each_cpu(i, policy->cpus) {
+		struct lpj_info *lpj = &per_cpu(lpj_ref, i);
+		if (!lpj->freq) {
+			lpj->ref = per_cpu(cpu_data, i).loops_per_jiffy;
+			lpj->freq = freqs.old;
+		}
+
  		per_cpu(cpu_data, i).loops_per_jiffy =
-			cpufreq_scale(per_cpu(cpu_data, i).loops_per_jiffy,
-					freqs.old, freqs.new);
+			cpufreq_scale(lpj->ref, lpj->freq, freqs.new);
+	}
+
+	/* And don't forget to adjust the global one */
+	if (!global_lpj_ref.freq) {
+		global_lpj_ref.ref = loops_per_jiffy;
+		global_lpj_ref.freq = freqs.old;
+	}
+	loops_per_jiffy = cpufreq_scale(global_lpj_ref.ref, global_lpj_ref.freq,
+					freqs.new);
  #endif

  	/* notifiers */
@@ -146,7 +153,6 @@ set_freq:
  		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
  	}

-skip_lpj:
  	return ret;
  }

-- 
1.7.4.1









