From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/3] omap: cpufreq: Split omap1 and omap2plus cpufreq drivers.
Date: Fri, 25 Feb 2011 12:52:36 +0530
Message-ID: <249b719993fd0ebc4f09de6c21d5750f@mail.gmail.com>
References: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com>
 <1298614239-32196-3-git-send-email-santosh.shilimkar@ti.com> <a5de4c2875426c022dd85547c8aff31b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57158 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754361Ab1BYHWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 02:22:39 -0500
Received: by mail-qw0-f46.google.com with SMTP id 7so1299178qwd.5
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 23:22:38 -0800 (PST)
In-Reply-To: <a5de4c2875426c022dd85547c8aff31b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>

> -----Original Message-----
> From: Vishwanath Sripathy [mailto:vishwanath.bs@ti.com]
> Sent: Friday, February 25, 2011 12:47 PM
> To: Santosh Shilimkar; linux-omap@vger.kernel.org
> Cc: Kevin Hilman
> Subject: RE: [PATCH 2/3] omap: cpufreq: Split omap1 and omap2plus
> cpufreq drivers.
>
[....]

> > @@ -101,33 +84,44 @@ static int omap_target(struct cpufreq_policy
> > *policy,
> >  	if (target_freq > policy->max)
> >  		target_freq = policy->max;
> >
> > -#ifdef CONFIG_ARCH_OMAP1
> >  	freqs.old = omap_getspeed(0);
> >  	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) /
> 1000;
> >  	freqs.cpu = 0;
> >
> >  	if (freqs.old == freqs.new)
> >  		return ret;
> > +
> >  	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> > +
> >  #ifdef CONFIG_CPU_FREQ_DEBUG
> > -	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
> > -	       freqs.old, freqs.new);
> > +	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old,
> > freqs.new);
> >  #endif
> > +
> >  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
> > +	if (ret)
> > +		return ret;
> Do you want to return here w/o calling post notifiers and
> readjusting the
> jiffies? Cpufreq updates lpj as part of PRECHANGE notifier when
> frequency
> is scaled up. So in that case returning here will end of having
> wrong lpj I suppose.
You are right. A notifier with old freq is needed here.

Regards,
Santosh
