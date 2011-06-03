From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] OMAP2+: CPUfreq: Allow the CPU scaling when secondary
 CPUs are offline.
Date: Thu, 2 Jun 2011 21:44:16 -0500
Message-ID: <BANLkTi=LUMdrTzsOXtVwU_aTcecodaJiPg@mail.gmail.com>
References: <1307026270-313-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:33900 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990Ab1FCCoj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 22:44:39 -0400
Received: by wwc33 with SMTP id 33so976424wwc.7
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 19:44:36 -0700 (PDT)
In-Reply-To: <1307026270-313-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, Jun 2, 2011 at 09:51, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Current OMAP2PLUS CPUfreq tagret() functions returns when all
> the CPU's are not online. This will break DVFS when secondary
> CPUs are offlined.
>
> The intention of that check was just avoid CPU frequency change
> during the window when CPU becomes online but it's cpufreq_init is
> not done yet.
is it this requirement a boot requirement or a necessity for
cpufreq_driver.init being called for online cpus? Since we maintain
just a single freq_table... why do we care about multiple cpu_inits?

Anyways, tried testing this and .config with CONFIG_SMP_ON_UP and
USERSPACE. it works with one cpu and does not scale 2 cpus :(

After applying this patch on kevin's cpufreq branch, I added some
prints for logging:
diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c
b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 909bfcb..89856d5 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -83,8 +83,13 @@ static int omap_target(struct cpufreq_policy *policy,
 	struct cpufreq_freqs freqs;

 	/* Changes not allowed until all CPUs are online */
-	if (is_smp() && (cpus_initialized < num_online_cpus()))
+	if (is_smp() && (cpus_initialized < num_online_cpus())) {
+		pr_err("%s: cpu %d not ready to go to %d (inits=%d vs
online=%d)\n", __func__,
+                               policy->cpu, target_freq,
cpus_initialized, num_online_cpus());
 		return ret;
+	}
+	pr_err("%s: cpu %d ready to go to %d (inits=%d vs online=%d)\n", __func__,
+		policy->cpu, target_freq, cpus_initialized, num_online_cpus());

 	/* Ensure desired rate is within allowed range.  Some govenors
 	 * (ondemand) will just pass target_freq=0 to get the minimum. */
@@ -197,6 +202,9 @@ static int __cpuinit omap_cpu_init(struct
cpufreq_policy *policy)
 		cpumask_copy(policy->cpus, cpumask);
 		cpus_initialized++;
 		smp_wmb();
+		pr_err("%s: cpu %d cpus_initialized = %d online=%d\n", __func__,
+			policy->cpu, cpus_initialized, num_online_cpus());
+
 	}

 	/* FIXME: what's the actual transition time? */
@@ -212,6 +220,8 @@ static int omap_cpu_exit(struct cpufreq_policy *policy)
 	if (is_smp()) {
 		cpus_initialized--;
 		smp_wmb();
+		pr_err("%s: cpu %d cpus_initialized = %d online=%d\n", __func__,
+			policy->cpu, cpus_initialized, num_online_cpus());
 	}
 	return 0;
 }

on boot, this is what I see:
[    0.421020] omap_cpu_init: cpu 0 cpus_initialized = 1 online=2
[    0.421264] omap_target: cpu 0 not ready to go to 1008000 (inits=1
vs online=2)
[    0.421630] omap_cpu_init: cpu 1 cpus_initialized = 2 online=2
[    0.421691] omap_cpu_exit: cpu 1 cpus_initialized = 1 online=2
...
snip
...
[    2.044128] omap_target: cpu 0 not ready to go to 1008000 (inits=1
vs online=2)
[    2.051849] omap_target: cpu 0 not ready to go to 1008000 (inits=1
vs online=2)
... snip..
...boots up to busybox shell..
/ # head /sys/devices/system/cpu/cpu1/online /sys/devices/system/cpu/cpu0/online

==> /sys/devices/system/cpu/cpu1/online <==
1

==> /sys/devices/system/cpu/cpu0/online <==
1
/ # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
300000 600000 800000 1008000
/ # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
1008000
/ # echo -n "300000">/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
[  130.257385] omap_target: cpu 0 not ready to go to 300000 (inits=1
vs online=2)
/ # echo -n "0" > /sys/devices/system/cpu/cpu1/online
[  144.749877] CPU1: shutdown
/ # head /sys/devices/system/cpu/cpu1/online /sys/devices/system/cpu/cpu0/online

==> /sys/devices/system/cpu/cpu1/online <==
0

==> /sys/devices/system/cpu/cpu0/online <==
1
/ # echo -n "350000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
[  165.881927] omap_target: cpu 0 ready to go to 350000 (inits=1 vs online=1)
[  165.889526] cpufreq-omap: transition: 1008000 --> 0
/ #
/ # echo -n "1" > /sys/devices/system/cpu/cpu1/online
[  176.469360] CPU1: Booted secondary processor
[  176.469421] CPU1: Unknown IPI message 0x1
[  176.475280] Switched to NOHz mode on CPU #1
[  176.600891] omap_cpu_init: cpu 1 cpus_initialized = 2 online=2
[  176.620178] omap_cpu_exit: cpu 1 cpus_initialized = 1 online=2
[  176.626373] omap_target: cpu 0 not ready to go to 350000 (inits=1
vs online=2)

Regards,
Nishanth Menon
