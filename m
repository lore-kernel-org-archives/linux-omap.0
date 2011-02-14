From: "Kahn, Gery" <geryk@ti.com>
Subject: Re: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS support
Date: Mon, 14 Feb 2011 11:34:22 +0200
Message-ID: <AANLkTinKFYHLSZBMxukb7dT6tenozmVHBm6JR4FCSbak@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-9-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:49580 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752268Ab1BNJeX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 04:34:23 -0500
Received: by mail-vx0-f177.google.com with SMTP id 2so2720609vxd.22
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 01:34:23 -0800 (PST)
In-Reply-To: <1295618465-15234-9-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Dear Vishwanath,

On Fri, Jan 21, 2011 at 16:01, Vishwanath BS <vishwanath.bs@ti.com> wro=
te:
> Changes in the omap cpufreq driver for DVFS support.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> =C2=A0arch/arm/plat-omap/cpu-omap.c | =C2=A0 35 +++++++++++++++++++++=
+++++++++++---
> =C2=A01 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-o=
map.c
> index 1c1b80b..d965220 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -30,10 +30,12 @@
> =C2=A0#include <mach/hardware.h>
> =C2=A0#include <plat/clock.h>
> =C2=A0#include <asm/system.h>
> +#include <asm/cpu.h>
>
> =C2=A0#if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
> =C2=A0#include <plat/omap-pm.h>
> =C2=A0#include <plat/common.h>
> +#include <plat/dvfs.h>
> =C2=A0#endif
>
> =C2=A0#define VERY_HI_RATE =C2=A0 900000000
> @@ -85,11 +87,11 @@ static int omap_target(struct cpufreq_policy *pol=
icy,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 unsigned int target_freq,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 unsigned int relation)
> =C2=A0{
> -#ifdef CONFIG_ARCH_OMAP1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cpufreq_freqs freqs;
> -#endif
> =C2=A0#if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long freq;
> + =C2=A0 =C2=A0 =C2=A0 int i;
> + =C2=A0 =C2=A0 =C2=A0 struct cpufreq_freqs freqs_notify;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *mpu_dev =3D omap2_get_mpuss=
_device();
> =C2=A0#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;
> @@ -116,9 +118,36 @@ static int omap_target(struct cpufreq_policy *po=
licy,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_set_rate(mpu_clk, freqs.new * =
1000);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cpufreq_notify_transition(&freqs, CPUFREQ_=
POSTCHANGE);
> =C2=A0#elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NON=
E)
> + =C2=A0 =C2=A0 =C2=A0 freqs.old =3D omap_getspeed(policy->cpu);;
> + =C2=A0 =C2=A0 =C2=A0 freqs_notify.new =3D clk_round_rate(mpu_clk, t=
arget_freq * 1000) / 1000;
> + =C2=A0 =C2=A0 =C2=A0 freqs.cpu =3D policy->cpu;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (freqs.old =3D=3D freqs.new)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* pre notifiers */
> + =C2=A0 =C2=A0 =C2=A0 for_each_cpu(i, policy->cpus) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 freqs.cpu =3D i;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpufreq_notify_tra=
nsition(&freqs, CPUFREQ_PRECHANGE);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* scale the frequency */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0freq =3D target_freq * 1000;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opp_find_freq_ceil(mpu_dev, &freq))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_pm_cpu_set_fr=
eq(freq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_device_scale(=
mpu_dev, mpu_dev, freq);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Update loops per jiffy */
> + =C2=A0 =C2=A0 =C2=A0 freqs.new =3D omap_getspeed(policy->cpu);
> + =C2=A0 =C2=A0 =C2=A0 for_each_cpu(i, policy->cpus)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 per_cpu(cpu_data, =
i).loops_per_jiffy =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpufreq_scale(per_=
cpu(cpu_data, i).loops_per_jiffy,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 freqs.old, freqs.new);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* post notifiers */
> + =C2=A0 =C2=A0 =C2=A0 for_each_cpu(i, policy->cpus) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 freqs.cpu =3D i;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpufreq_notify_tra=
nsition(&freqs, CPUFREQ_POSTCHANGE);
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

I took those patches and applied to my .38-rc4 with help from Nishanth =
Menon.

There is problem appeared during compilation:

arch/arm/plat-omap/cpu-omap.c:142: error: 'struct cpuinfo_arm' has no
member named 'loops_per_jiffy'

My kernel is for Zoom3 board (OMAP3630-GP rev 2, CPU-OPP2 L3-200MHz)
Looking at the source, arch/arm/include/asm/cpu.h
loops_per_jiffy is under CONFIG_SMP and since the omap2plus_defconfig
builds for OMAP4 as well by default, I am guessing this bug was not
immediately visible...

Is there solution for the issue?

Regards,
Gery
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
