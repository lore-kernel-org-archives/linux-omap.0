From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: PM branch rebased to 2.6.29... for real this time
Date: Fri, 3 Apr 2009 10:51:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB08687C@dbde02.ent.ti.com>
References: <49D4E28D.50601@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38425 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbZDCFVd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 01:21:33 -0400
In-Reply-To: <49D4E28D.50601@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Kim Kyuwon <chammoru@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Thursday, April 02, 2009 9:37 PM
> To: Kim Kyuwon
> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org; Nayak, Rajendra
> Subject: Re: PM branch rebased to 2.6.29... for real this time
> 
> Yes, this locking problem requires Rajendra's patchset which 
> needs to be 
> updated for the PM branch.

I will send the updated patch set on the latest PM branch maybe later today.

> 
> Kevin
> 
> Kim Kyuwon wrote:
> > Hi Kevin, Sanjeev,
> > 
> > I'm having the same problem.
> > 
> > when clk_set_rate() is invoked in omap_cpu_init() as shown below:
> > 
> > 	clk_set_rate(mpu_clk, policy->cpuinfo.max_freq * 1000);
> > 
> > It acquires the clocks mutex by the next statement.
> > 
> > 	mutex_lock(&clocks_mutex);
> > 
> > But after invoking arch_clock->clk_set_rate() in the middle of
> > clk_set_rate(), clock_set_rate() is invoked again. So 
> deadlock occurs
> > due to mutex_lock() in clock_set_rate().
> > 
> > I think setting the default governor can not help this deadlock.
> > 
> > Regards,
> > Kyuwon
> > 
> > On Thu, Apr 2, 2009 at 3:46 AM, Kevin Hilman
> > <khilman@deeprootsystems.com> wrote:
> >> "Premi, Sanjeev" <premi@ti.com> writes:
> >>
> >> [...]
> >>
> >>>> Sounds to me like CPUfreq is changing frequencies during 
> bootup.  Did
> >>>> you select ondemand as the default CPUfreq governor?
> >>> [sp] Yes. This is what I feel too. Only I was not clear 
> why the process
> >>> gets stuck at WFI. Haven't been able to debug further. So far...
> >>>
> >>>> If so, can you try with performance as the default governor.
> >>> [sp] It was performance governor only.
> >>>
> >>>> If you're already using performance, then u-boot is 
> setting a slower
> >>>> speed and CPUfreq may decide to change it during boot.
> >>> [sp] That is the case.
> >>>
> >> Can you try setting the default governor to userspace so 
> that no DVFS
> >> changes will happen during boot?
> >>
> >> Kevin
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> > 
> > 
> > 
> 
> 
> 