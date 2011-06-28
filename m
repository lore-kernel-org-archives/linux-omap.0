From: Colin Cross <ccross@google.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Tue, 28 Jun 2011 15:29:57 -0700
Message-ID: <CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:52599 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab1F1WaC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 18:30:02 -0400
Received: from hpaq5.eem.corp.google.com (hpaq5.eem.corp.google.com [172.25.149.5])
	by smtp-out.google.com with ESMTP id p5SMU0br005830
	for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 15:30:01 -0700
Received: from ywn13 (ywn13.prod.google.com [10.192.14.13])
	by hpaq5.eem.corp.google.com with ESMTP id p5SMTxQI001490
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 15:29:59 -0700
Received: by ywn13 with SMTP id 13so394141ywn.21
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 15:29:58 -0700 (PDT)
In-Reply-To: <1308923618-5333-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

<resending as plain text>

On Fri, Jun 24, 2011 at 6:53 AM, Sanjeev Premi <premi@ti.com> wrote:
>
> Currently, loops_per_jiffy is being calculated twice for
> non-SMP processors.
> =A0- Before calling cpufreq_notify_transition()
> =A0- From within cpufreq_notify_transition()
>
> Double adjustment leads to incorrect value being assigned to
> loops_per_jiffy. This manifests as incorrect BogoMIPS in
> "cat /proc/cpuinfo".
>
> The value of loops_per_jiffy needs to be calculated only
> when CONFIG_SMP is true. It is the core change included
> in this patch.
>
> The patch also leverages the definition of for_each_cpu()
> with and without CONFIG_SMP to consolidate the mechanism
> to call cpufreq_notify_transition().
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
> =A0Changes since v1:
> =A0 * loops_per_jiffy are updated when CONFIG_SMP is true.
> =A0 * leverage definition of for_each_cpu()
>
> =A0Tested on OMAP3EVM with and without CONFIG_SMP.
> =A0Since the log is rather long, will be posting the log in
> =A0a follow-up mail.
>
> =A0arch/arm/mach-omap2/omap2plus-cpufreq.c | =A0 27 +++++++++++++++--=
----------
> =A01 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-=
omap2/omap2plus-cpufreq.c
> index 346519e..0263cae 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -97,12 +97,8 @@ static int omap_target(struct cpufreq_policy *poli=
cy,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> =A0 =A0 =A0 =A0/* Notify transitions */
> - =A0 =A0 =A0 if (is_smp()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_cpu(i, policy->cpus) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freqs.cpu =3D i;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_notify_transiti=
on(&freqs, CPUFREQ_PRECHANGE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 for_each_cpu(i, policy->cpus) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 freqs.cpu =3D i;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpufreq_notify_transition(&freqs, CPUF=
REQ_PRECHANGE);
> =A0 =A0 =A0 =A0}
>
> @@ -114,13 +110,20 @@ static int omap_target(struct cpufreq_policy *p=
olicy,
>
> =A0 =A0 =A0 =A0freqs.new =3D omap_getspeed(policy->cpu);
>
> +#ifdef CONFIG_SMP
> + =A0 =A0 =A0 /* Adjust jiffies before transition */
> + =A0 =A0 =A0 for_each_cpu(i, policy->cpus) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long lpj =3D per_cpu(cpu_data,=
 i).loops_per_jiffy;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(cpu_data, i).loops_per_jiffy =3D=
 cpufreq_scale(lpj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freqs.old,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freqs.new);
Can't this rewrite the loops_per_jiffy for the other CPU while it is
in a udelay?  If it has already calculated the number of loops
necessary, and the CPU frequency increases, it could end up returning
too early from udelay.

There were previous discussions about polling a fixed-frequency timer
for udelay on SMP systems.

> + =A0 =A0 =A0 }
> +#endif
> +
> =A0 =A0 =A0 =A0/* Notify transitions */
> - =A0 =A0 =A0 if (is_smp()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_cpu(i, policy->cpus) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freqs.cpu =3D i;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_notify_transiti=
on(&freqs, CPUFREQ_POSTCHANGE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 for_each_cpu(i, policy->cpus) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 freqs.cpu =3D i;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpufreq_notify_transition(&freqs, CPUF=
REQ_POSTCHANGE);
> =A0 =A0 =A0 =A0}
>
> --
> 1.7.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
