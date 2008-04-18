From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap
	clock framework
Date: Fri, 18 Apr 2008 10:08:03 +0300
Message-ID: <1208502483.9933.15.camel@mort>
References: <alpine.DEB.1.00.0804170952270.3689@utopia.booyaka.com>
	 <alpine.DEB.1.00.0804171243340.8530@utopia.booyaka.com>
	 <20080417.215723.241260895.Hiroshi.DOYU@nokia.com>
	 <200804171214.35936.david-b@pacbell.net>
	 <alpine.DEB.1.00.0804171319020.8530@utopia.booyaka.com>
	 <1208461772.32060.14.camel@mort>
	 <alpine.DEB.1.00.0804171422160.8530@utopia.booyaka.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45869 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbYDRKQ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 06:16:26 -0400
In-Reply-To: <alpine.DEB.1.00.0804171422160.8530@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: David Brownell <david-b@pacbell.net>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

Hi Paul,
On Thu, 2008-04-17 at 14:47 -0600, ext Paul Walmsley wrote:
> Hello Igor,
> 
> On Thu, 17 Apr 2008, Igor Stoppa wrote:
> 
> > On Thu, 2008-04-17 at 13:44 -0600, ext Paul Walmsley wrote:
> >
> > > True, but if we can do a debugfs implementation first, then that seems 
> > > like a good way to start, no?  Userspace PM implementations are probably 
> > > some months in the future, and we can mandate that debugfs be mounted for 
> > > those.
> > 
> > I can hardly see the benefit of a userspace implementation, considering
> > the extra context switch required and the fact the in many cases clocks
> > get enabled in response to irqs.
> 
> I agree that we shouldn't try to move the clock framework to userspace.
> 
> But, determining what OPP to switch to next, based on system load or other 
> requirements published by drivers or userspace processes; or determining 
> what power state to put powerdomains to -- it would be nice to experiment 
> with a userspace governor for those tasks.  It would certainly make 
> development and testing easier.

yes, it can be used to play with it in its infancy state, when one is
still not looking for performance/stability stress testing.

Afterward it simply doesn't fit the bill of leveraging the HW response
time. Notice also that with QoS information coming from different
sources, mostly low level ones, this will generate lots of cache
trashing.

> > > In terms of the clock tree, it would be good to allow userspace-driven OPP 
> > > changes, analogous to CPUFreq's userspace governor.  [ In general, I agree 
> > > that userspace should not be changing driver clocks directly, just like 
> > > userspace should not be mucking around in /dev/mem directly :-) ]
> > 
> > That also sounds akward at best: cpufreq (or similar) is much better
> > suited for this sort of activity; userspace governor would be the
> > userspace controller you refer to, but it is far from being optimal.
> >
> > Userspace should limit itself to changing policies.
> 
> CPUFreq is good, but it does not manage non-CPU-frequency knobs very well, 
> and there are plenty of those on OMAP3.

But CPUFreq can be expanded. Call it systemfreq or whatever can be more
appealing from an advertising point of view.

For omap HW anything different from ondemand doesn't make much sense.
Maybe performance, would be another viable option, in certain cases.

> Is there any reason why we should not allow the option of userspace OPP 
> selection/powerdomain control for OMAP?  If people don't want to use it, 
> they don't have to :-)


No, of course freedom is good. But it shouldn't be freedom of knowingly
adopt suboptimal solutions just for the sake of diversity.

An approach that doesn't involve requiring userspace components can be
used also for more "embedded" systems where there might be no
traditional userspace.

A similar case would be in replacing CPUIdle with user space based
decision, which is likely far from being optimal.

-- 
Cheers, Igor

---

Igor Stoppa
Next Generation Software
Nokia Devices R&D - Helsinki
