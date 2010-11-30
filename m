From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH] OMAP PM: Optimize cpufreq transition latency
Date: Tue, 30 Nov 2010 13:49:49 -0600
Message-ID: <AANLkTin7QLrwjpwkbrq-5qo+5WH9KmqVmcJh61kbwXYw@mail.gmail.com>
References: <1290692291-25073-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:57098 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754157Ab0K3TuM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 14:50:12 -0500
Received: by mail-wy0-f180.google.com with SMTP id 29so1411321wyb.25
        for <linux-omap@vger.kernel.org>; Tue, 30 Nov 2010 11:50:11 -0800 (PST)
In-Reply-To: <1290692291-25073-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

On Thu, Nov 25, 2010 at 7:38 AM, Vishwanath BS <vishwanath.bs@ti.com> w=
rote:
> Currently cpufreq transition latency value does not really reflect th=
e actual
> OMAP OPP transition delay. This patch has the actual latency value.
> I did profile the DVFS latency on OMAP3430, OMAP3630 and OMAP4 for wo=
rstcase(MPU and Core together) and found that in none of these platform=
s, transiton value
> goes beyong 10ms. Added a buffer of 20ms to avoid too frequent ondema=
nd timer
> expiry.
> With this change, performance of ondemand governor is improved when t=
ested
> using cpufreqbench tool. Without this patch, cpufreq-bench reported o=
ndemand
> performance as 40% of performance governor, and with this patch it's =
around 70%
> (using below procedure).
>
> cpufreq-bench:
> http://lwn.net/Articles/339862/
> http://ftp.riken.go.jp/archives/Linux/suse/people/ckornacker/cpufreq-=
bench/
>
> Command used for performance testing:
> cpufreq-bench -l 50000 -s 100000 -x 50000 -y 100000 -g ondemand -r 5 =
-n 5 -v
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
> =A0arch/arm/plat-omap/cpu-omap.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
> =A0mode change 100644 =3D> 100755 arch/arm/plat-omap/cpu-omap.c
>
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-o=
map.c
> old mode 100644
> new mode 100755
> index c47faf8..d3fc423
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -158,8 +158,8 @@ static int __init omap_cpu_init(struct cpufreq_po=
licy *policy)
> =A0 =A0 =A0 =A0policy->max =3D policy->cpuinfo.max_freq;
> =A0 =A0 =A0 =A0policy->cur =3D omap_getspeed(0);
>
> - =A0 =A0 =A0 /* FIXME: what's the actual transition time? */
> - =A0 =A0 =A0 policy->cpuinfo.transition_latency =3D 300 * 1000;
> + =A0 =A0 =A0 /* Program the actual transition time for worstcase */
> + =A0 =A0 =A0 policy->cpuinfo.transition_latency =3D 30 * 1000;

Vishwa,

This is a frequent periodic timer.  Does a smaller value have any
affect on CPUidle wakeups?

Thanks,
Mike

> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.7.0.4
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
