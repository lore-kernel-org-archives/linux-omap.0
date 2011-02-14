From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS support
Date: Mon, 14 Feb 2011 18:19:49 +0530
Message-ID: <0a4ab0bfef880f12edb62915a3592104@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com><1295618465-15234-9-git-send-email-vishwanath.bs@ti.com>
 <AANLkTinKFYHLSZBMxukb7dT6tenozmVHBm6JR4FCSbak@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37795 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753902Ab1BNMtm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 07:49:42 -0500
Received: by mail-fx0-f48.google.com with SMTP id 2so5563315fxm.7
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 04:49:41 -0800 (PST)
In-Reply-To: <AANLkTinKFYHLSZBMxukb7dT6tenozmVHBm6JR4FCSbak@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gery Kahn <geryk@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

> -----Original Message-----
> From: Kahn, Gery [mailto:geryk@ti.com]
> Sent: Monday, February 14, 2011 3:04 PM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; patches@linaro.org; Santosh Shilimkar
> Subject: Re: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS
> support
>
> Dear Vishwanath,
>
> On Fri, Jan 21, 2011 at 16:01, Vishwanath BS <vishwanath.bs@ti.com>
> wrote:
> > Changes in the omap cpufreq driver for DVFS support.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> > =A0arch/arm/plat-omap/cpu-omap.c | =A0 35
> ++++++++++++++++++++++++++++++++---
> > =A01 files changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-
> omap/cpu-omap.c
> > index 1c1b80b..d965220 100644
> > --- a/arch/arm/plat-omap/cpu-omap.c
> > +++ b/arch/arm/plat-omap/cpu-omap.c
> > @@ -30,10 +30,12 @@
> > =A0#include <mach/hardware.h>
> > =A0#include <plat/clock.h>
> > =A0#include <asm/system.h>
> > +#include <asm/cpu.h>
> >
> > =A0#if defined(CONFIG_ARCH_OMAP3) &&
> !defined(CONFIG_OMAP_PM_NONE)
> > =A0#include <plat/omap-pm.h>
> > =A0#include <plat/common.h>
> > +#include <plat/dvfs.h>
> > =A0#endif
> >
> > =A0#define VERY_HI_RATE =A0 900000000
> > @@ -85,11 +87,11 @@ static int omap_target(struct cpufreq_policy
> *policy,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int target_fre=
q,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int relation)
> > =A0{
> > -#ifdef CONFIG_ARCH_OMAP1
> > =A0 =A0 =A0 =A0struct cpufreq_freqs freqs;
> > -#endif
> > =A0#if defined(CONFIG_ARCH_OMAP3) &&
> !defined(CONFIG_OMAP_PM_NONE)
> > =A0 =A0 =A0 =A0unsigned long freq;
> > + =A0 =A0 =A0 int i;
> > + =A0 =A0 =A0 struct cpufreq_freqs freqs_notify;
> > =A0 =A0 =A0 =A0struct device *mpu_dev =3D omap2_get_mpuss_device();
> > =A0#endif
> > =A0 =A0 =A0 =A0int ret =3D 0;
> > @@ -116,9 +118,36 @@ static int omap_target(struct cpufreq_policy
> *policy,
> > =A0 =A0 =A0 =A0ret =3D clk_set_rate(mpu_clk, freqs.new * 1000);
> > =A0 =A0 =A0 =A0cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE=
);
> > =A0#elif defined(CONFIG_ARCH_OMAP3) &&
> !defined(CONFIG_OMAP_PM_NONE)
> > + =A0 =A0 =A0 freqs.old =3D omap_getspeed(policy->cpu);;
> > + =A0 =A0 =A0 freqs_notify.new =3D clk_round_rate(mpu_clk, target_f=
req *
> 1000) / 1000;
> > + =A0 =A0 =A0 freqs.cpu =3D policy->cpu;
> > +
> > + =A0 =A0 =A0 if (freqs.old =3D=3D freqs.new)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> > +
> > + =A0 =A0 =A0 /* pre notifiers */
> > + =A0 =A0 =A0 for_each_cpu(i, policy->cpus) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 freqs.cpu =3D i;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_notify_transition(&freqs, CPU=
=46REQ_PRECHANGE);
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /* scale the frequency */
> > =A0 =A0 =A0 =A0freq =3D target_freq * 1000;
> > =A0 =A0 =A0 =A0if (opp_find_freq_ceil(mpu_dev, &freq))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_pm_cpu_set_freq(freq);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_device_scale(mpu_dev, mpu_dev, f=
req);
> > +
> > + =A0 =A0 =A0 /* Update loops per jiffy */
> > + =A0 =A0 =A0 freqs.new =3D omap_getspeed(policy->cpu);
> > + =A0 =A0 =A0 for_each_cpu(i, policy->cpus)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(cpu_data, i).loops_per_jiffy =
=3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_scale(per_cpu(cpu_data, i).lo=
ops_per_jiffy,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 freqs=
=2Eold, freqs.new);
> > +
> > + =A0 =A0 =A0 /* post notifiers */
> > + =A0 =A0 =A0 for_each_cpu(i, policy->cpus) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 freqs.cpu =3D i;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_notify_transition(&freqs,
> CPUFREQ_POSTCHANGE);
> > + =A0 =A0 =A0 }
> > =A0#endif
> > =A0 =A0 =A0 =A0return ret;
> > =A0}
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
>
> I took those patches and applied to my .38-rc4 with help from Nishant=
h
> Menon.
>
> There is problem appeared during compilation:
>
> arch/arm/plat-omap/cpu-omap.c:142: error: 'struct cpuinfo_arm' has no
> member named 'loops_per_jiffy'
>
> My kernel is for Zoom3 board (OMAP3630-GP rev 2, CPU-OPP2 L3-
> 200MHz)
> Looking at the source, arch/arm/include/asm/cpu.h
> loops_per_jiffy is under CONFIG_SMP and since the omap2plus_defconfig
> builds for OMAP4 as well by default, I am guessing this bug was not
> immediately visible...
>
> Is there solution for the issue?
Yes this is an issue if CONFIG_SMP is disabled. We probably will need t=
o
put this code under #ifdef CONFIG_SMP till lpj is handled for SMP in
generic cpufreq code itself .

Vishwa
>
> Regards,
> Gery
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
