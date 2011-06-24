From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 19:39:41 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EF2@dbde02.ent.ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
 <20110624140142.GM9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52154 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859Ab1FXOKj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 10:10:39 -0400
In-Reply-To: <20110624140142.GM9449@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Friday, June 24, 2011 7:32 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix 
> loops_per_jiffy calculation

[snip]...[snip]

> > 
> > +#ifdef CONFIG_SMP
> > +	/* Adjust jiffies before transition */
> > +	for_each_cpu(i, policy->cpus) {
> > +		unsigned long lpj = per_cpu(cpu_data, 
> i).loops_per_jiffy;
> > +
> > +		per_cpu(cpu_data, i).loops_per_jiffy = 
> cpufreq_scale(lpj,
> > +							freqs.old,
> > +							freqs.new);
> > +	}
> > +#endif
> > +
> 
> You didn't listen to what I told you.  It'll be quicker for 
> me to write
> this patch myself if you send me the *original* file.
> 

Russell,

The function adjust_jiffies() is no-op for CONFIG_SMP - but it
is not the case with cpufreq_scale().

So, when CONFIG_SMP is defined, then loops_per_jiffy would be
calculated for both UP and SMP processors.

Did I miss something else?

~sanjeev


[snip]...[snip]
