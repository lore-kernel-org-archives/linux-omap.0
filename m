From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap
 clock framework
Date: Thu, 17 Apr 2008 14:47:29 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0804171422160.8530@utopia.booyaka.com>
References: <alpine.DEB.1.00.0804170952270.3689@utopia.booyaka.com>  <alpine.DEB.1.00.0804171243340.8530@utopia.booyaka.com>  <20080417.215723.241260895.Hiroshi.DOYU@nokia.com>  <200804171214.35936.david-b@pacbell.net>  <alpine.DEB.1.00.0804171319020.8530@utopia.booyaka.com>
 <1208461772.32060.14.camel@mort>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56589 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbYDQUra (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 16:47:30 -0400
In-Reply-To: <1208461772.32060.14.camel@mort>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: David Brownell <david-b@pacbell.net>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

Hello Igor,

On Thu, 17 Apr 2008, Igor Stoppa wrote:

> On Thu, 2008-04-17 at 13:44 -0600, ext Paul Walmsley wrote:
>
> > True, but if we can do a debugfs implementation first, then that seems 
> > like a good way to start, no?  Userspace PM implementations are probably 
> > some months in the future, and we can mandate that debugfs be mounted for 
> > those.
> 
> I can hardly see the benefit of a userspace implementation, considering
> the extra context switch required and the fact the in many cases clocks
> get enabled in response to irqs.

I agree that we shouldn't try to move the clock framework to userspace.

But, determining what OPP to switch to next, based on system load or other 
requirements published by drivers or userspace processes; or determining 
what power state to put powerdomains to -- it would be nice to experiment 
with a userspace governor for those tasks.  It would certainly make 
development and testing easier.

> > In terms of the clock tree, it would be good to allow userspace-driven OPP 
> > changes, analogous to CPUFreq's userspace governor.  [ In general, I agree 
> > that userspace should not be changing driver clocks directly, just like 
> > userspace should not be mucking around in /dev/mem directly :-) ]
> 
> That also sounds akward at best: cpufreq (or similar) is much better
> suited for this sort of activity; userspace governor would be the
> userspace controller you refer to, but it is far from being optimal.
>
> Userspace should limit itself to changing policies.

CPUFreq is good, but it does not manage non-CPU-frequency knobs very well, 
and there are plenty of those on OMAP3.

Is there any reason why we should not allow the option of userspace OPP 
selection/powerdomain control for OMAP?  If people don't want to use it, 
they don't have to :-)


- Paul
