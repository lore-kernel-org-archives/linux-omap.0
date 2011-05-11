From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v2 2/2] OMAP2PLUS: cpufreq: Add SMP support to cater OMAP4430
Date: Tue, 10 May 2011 19:41:32 -0500
Message-ID: <BANLkTinSPpmepfJNC=2SSPF5KzsHcKXGEw@mail.gmail.com>
References: <1300102729-17276-1-git-send-email-santosh.shilimkar@ti.com> <1300102729-17276-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:39377 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751519Ab1EKAlz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 20:41:55 -0400
Received: by wyb28 with SMTP id 28so8606wyb.36
        for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 17:41:52 -0700 (PDT)
In-Reply-To: <1300102729-17276-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, Vishwanath BS <vishwanath.bs@ti.com>, "Herman, Saquib" <saquib@ti.com>, "Revanna, Amarnath" <amarnath@ti.com>

On Mon, Mar 14, 2011 at 06:38, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On OMAP SMP configuartion, both processors share the voltage
> and clock. So both CPUs needs to be scaled together and hence
> needs software co-ordination.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> cc: Vishwanath BS <vishwanath.bs@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap2plus-cpufreq.c | =A0 73 +++++++++++++++++=
+++++++++-----
> =A01 files changed, 62 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-=
omap2/omap2plus-cpufreq.c

[...]
> =A0 =A0 =A0 =A0rate =3D clk_get_rate(mpu_clk) / 1000;
> @@ -74,9 +76,13 @@ static int omap_target(struct cpufreq_policy *poli=
cy,
[...]

> - =A0 =A0 =A0 cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +#ifdef CONFIG_SMP
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Note that loops_per_jiffy is not updated on SMP sy=
stems in
> + =A0 =A0 =A0 =A0* cpufreq driver. So, update the per-CPU loops_per_j=
iffy value
> + =A0 =A0 =A0 =A0* on frequency transition. We need to update all dep=
endent CPUs.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for_each_cpu(i, policy->cpus)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(cpu_data, i).loops_per_jiffy =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_scale(per_cpu(c=
pu_data, i).loops_per_jiffy,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 freqs.old, freqs.new);
We have an issue here - arch/arm/lib/delay.S uses the generic
loops_per_jiffy which is not updated when smp (OMAP4) is active, as a
result loops_per_jiffy contains the value which was updated. with a
trace added as follows:
diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c
b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 0105c8d..8bad854 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -137,10 +137,14 @@ set_freq:
         * cpufreq driver. So, update the per-CPU loops_per_jiffy value
         * on frequency transition. We need to update all dependent CPU=
s.
         */
-       for_each_cpu(i, policy->cpus)
+       for_each_cpu(i, policy->cpus) {
                per_cpu(cpu_data, i).loops_per_jiffy =3D
                        cpufreq_scale(per_cpu(cpu_data, i).loops_per_ji=
ffy,
                                        freqs.old, freqs.new);
+               pr_err("%s: loops_per_jiffy=3D%lu cpu%d.loops_per_jiffy=
=3D%d\n",
+                               __func__, loops_per_jiffy, i,
+                               per_cpu(cpu_data, i).loops_per_jiffy);
+       }
 #endif

Testing:600000 freq
[   30.319885] omap_target: loops_per_jiffy=3D7643136 cpu0.loops_per_ji=
ffy=3D4666514
[   30.327758] omap_target: loops_per_jiffy=3D7643136 cpu1.loops_per_ji=
ffy=3D4549484
testing:800000
[   31.419616] omap_target: loops_per_jiffy=3D7643136 cpu0.loops_per_ji=
ffy=3D6222018
[   31.427612] omap_target: loops_per_jiffy=3D7643136 cpu1.loops_per_ji=
ffy=3D6065978
testing:1008000
[   32.532012] omap_target: loops_per_jiffy=3D7643136 cpu0.loops_per_ji=
ffy=3D7839742
[   32.540252] omap_target: loops_per_jiffy=3D7643136 cpu1.loops_per_ji=
ffy=3D7643132

Luckily my bootloader was booting up at 1GHz, but for folks booting at
OPP100, well.. at 1GHz, the mdelays and udelays are going to be wrong
badly.

With a quick patch as follows (by Amarnath/Saquib), the output is:
testing:600000
[   27.499603] omap_target: loops_per_jiffy=3D4666514 cpu0.loops_per_ji=
ffy=3D4666514
[   27.507507] omap_target: loops_per_jiffy=3D4666514 cpu1.loops_per_ji=
ffy=3D4549484
testing:800000
[   28.617553] omap_target: loops_per_jiffy=3D6222018 cpu0.loops_per_ji=
ffy=3D6222018
[   28.625518] omap_target: loops_per_jiffy=3D6222018 cpu1.loops_per_ji=
ffy=3D6065978
testing:1008000
[   29.724578] omap_target: loops_per_jiffy=3D7839742 cpu0.loops_per_ji=
ffy=3D7839742
[   29.732818] omap_target: loops_per_jiffy=3D7839742 cpu1.loops_per_ji=
ffy=3D7643132

patch:
diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c
b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 0105c8d..58a968d 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -80,6 +80,7 @@ static int omap_target(struct cpufreq_policy *policy,
        int i, ret =3D 0;
        struct cpufreq_freqs freqs;
        struct device *mpu_dev =3D omap2_get_mpuss_device();
+       unsigned int jiffy_loop_cpu =3D 0;

        /* Changes not allowed until all CPUs are online */
        if (is_smp() && (num_online_cpus() < NR_CPUS))
@@ -137,10 +138,14 @@ set_freq:
         * cpufreq driver. So, update the per-CPU loops_per_jiffy value
         * on frequency transition. We need to update all dependent CPU=
s.
         */
-       for_each_cpu(i, policy->cpus)
+       for_each_cpu(i, policy->cpus) {
                per_cpu(cpu_data, i).loops_per_jiffy =3D
                        cpufreq_scale(per_cpu(cpu_data, i).loops_per_ji=
ffy,
                                        freqs.old, freqs.new);
+               if (per_cpu(cpu_data, i).loops_per_jiffy > jiffy_loop_c=
pu)
+                       jiffy_loop_cpu =3D per_cpu(cpu_data, i).loops_p=
er_jiffy;
+       }
+       loops_per_jiffy =3D jiffy_loop_cpu;
 #endif

        /* notifiers */

Question: what would be the best solution for this? is a solution
isolated to OMAP good enough?

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
