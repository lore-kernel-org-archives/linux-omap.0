From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH][pm-wip/cpufreq] OMAP2+: CPUfreq: Remove superfluous check
 in target() for online CPU's.
Date: Mon, 6 Jun 2011 11:56:52 -0500
Message-ID: <BANLkTindbwTeYLt7c25PRO3eDn9E=mg3Dg@mail.gmail.com>
References: <1307103417-22721-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:36197 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752292Ab1FFQ5O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jun 2011 12:57:14 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so3463896bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 09:57:12 -0700 (PDT)
In-Reply-To: <1307103417-22721-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>

On Fri, Jun 3, 2011 at 07:16, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Current OMAP2PLUS CPUfreq tagret() functions returns when all
> the CPU's are not online. This breaks CPUfreq when secondary CPUs
> are offlined on SMP system.
>
> The intention of that check was just avoid CPU frequency change
> during the window when CPU becomes online but it's cpufreq_init is
> not done yet. Otherwise it can lead to notifiers being sent on
> a CPU which is not yet registered to the governor.
>
> But this race conditions is already managed by the CPUfreq
> core driver by updating the available cpumask accordingly.
>
> OMAP CPUFReq driver make use same cpumask for the notifiers
> so the above problem doesn't exist. In my initial implementation
> of the OMAP4 CPUFreq driver, I was using 'for_each_online_cpu()'
> for notifiers which lead me to add that check. Later I fixed
> the notifies but didn't realise that the check has become
> redundant then.
>
> Fix it by removing the superfluous check in target().
>
> Thanks for Nishant Menon <nm@ti.com> for reporting issue
> with hot-plug and Kevin Hilman <khilman@ti.com> for his
> comment on excessive check in target().
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reported-by: Nishanth Menon <nm@ti.com>
> Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Tested-by: Nishanth Menon <nm@ti.com>
Regards,
Nishanth Menon


> ---
> This change is an outcome of discussion on another patch to fix
> the hot-plug issue. For details refer below thread:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50348.html
>
> =A0arch/arm/mach-omap2/omap2plus-cpufreq.c | =A0 =A04 ----
> =A01 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-=
omap2/omap2plus-cpufreq.c
> index 33a91ec..3bf1704 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -81,10 +81,6 @@ static int omap_target(struct cpufreq_policy *poli=
cy,
> =A0 =A0 =A0 =A0int i, ret =3D 0;
> =A0 =A0 =A0 =A0struct cpufreq_freqs freqs;
>
> - =A0 =A0 =A0 /* Changes not allowed until all CPUs are online */
> - =A0 =A0 =A0 if (is_smp() && (num_online_cpus() < NR_CPUS))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> -
> =A0 =A0 =A0 =A0/* Ensure desired rate is within allowed range. =A0Som=
e govenors
> =A0 =A0 =A0 =A0 * (ondemand) will just pass target_freq=3D0 to get th=
e minimum. */
> =A0 =A0 =A0 =A0if (target_freq < policy->min)
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
