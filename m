From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS support
Date: Wed, 13 Apr 2011 10:57:54 -0700
Message-ID: <a3214a9323e70490664dfa3ec52fc926@mail.gmail.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com><1295618465-15234-9-git-send-email-vishwanath.bs@ti.com>
 <20110413171320.5226cd86.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50954 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755436Ab1DMR5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 13:57:52 -0400
Received: by mail-vx0-f171.google.com with SMTP id 40so1042527vxc.16
        for <linux-omap@vger.kernel.org>; Wed, 13 Apr 2011 10:57:50 -0700 (PDT)
In-Reply-To: <20110413171320.5226cd86.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

> -----Original Message-----
> From: Jarkko Nikula [mailto:jhnikula@gmail.com]
> Sent: Wednesday, April 13, 2011 7:13 AM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; patches@linaro.org; Santosh
> Shilimkar
> Subject: Re: [PATCH 08/13] OMAP3: cpufreq driver changes for DVFS
> support
>
> Hi
>
> A few comments below in case this is still under development as I
> was
> playing a bit with this version on omap3.
There is an updated version of omap cpufreq patches where this issue is
fixed.
https://patchwork.kernel.org/patch/632781/

Regards
Vishwa

>
> On Fri, 21 Jan 2011 19:31:00 +0530
> Vishwanath BS <vishwanath.bs@ti.com> wrote:
>
> > Changes in the omap cpufreq driver for DVFS support.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/plat-omap/cpu-omap.c |   35
> ++++++++++++++++++++++++++++++++---
> >  1 files changed, 32 insertions(+), 3 deletions(-)
> >
> ...
> > @@ -85,11 +87,11 @@ static int omap_target(struct cpufreq_policy
> *policy,
> >  		       unsigned int target_freq,
> >  		       unsigned int relation)
> >  {
> > -#ifdef CONFIG_ARCH_OMAP1
> >  	struct cpufreq_freqs freqs;
> > -#endif
> >  #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
> >  	unsigned long freq;
> > +	int i;
> > +	struct cpufreq_freqs freqs_notify;
> >  	struct device *mpu_dev = omap2_get_mpuss_device();
> >  #endif
> >  	int ret = 0;
> > @@ -116,9 +118,36 @@ static int omap_target(struct cpufreq_policy
> *policy,
> >  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
> >  	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> >  #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
> > +	freqs.old = omap_getspeed(policy->cpu);;
> > +	freqs_notify.new = clk_round_rate(mpu_clk, target_freq * 1000)
> / 1000;
> > +	freqs.cpu = policy->cpu;
> > +
> > +	if (freqs.old == freqs.new)
> > +		return ret;
> > +
>
> Here freqs.new is uninitialized which very likely means that code
> falls
> always through, sets the correct target frequency though, but can
> populate the wrong frequency through the cpufreq_notify_transition
> when
> running the pre notifiers below.
>
> I think the code above meant
>
> freqs_notify.new = clk_round_rate(mpu_clk, target_freq * 1000) /
> 1000;
> ->
> freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
>
> as the freqs_notify is otherwise unused?
>
> However, that doesn't work as the clk_round_rate returns the current
> rate for mpu_clk on omap3 and "freqs.old == freqs.new" is always
> true.
> Looks like there is no round_rate function for arm_fck.
>
> I replaced that with "freqs.new = target_freq;" but this means there
> will be unnecessary fall throughs if the real frequency (eg 124800
> kHz)
> will differ from opp table frequency (eg 125000 kHz) and no real
> changes are happening e.g. with on-demand governor.
>
> > +	/* pre notifiers */
> > +	for_each_cpu(i, policy->cpus) {
> > +		freqs.cpu = i;
> > +		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> > +	}
>
> --
> Jarkko
