From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Thu, 14 Feb 2013 11:39:11 -0800
Message-ID: <20130214193911.GD11806@atomide.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:39825 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934858Ab3BNTjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 14:39:13 -0500
Content-Disposition: inline
In-Reply-To: <20130214192719.GB26679@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [130214 11:31]:
> On Thu, Feb 14, 2013 at 10:12:17AM -0800, Tony Lindgren wrote:
> 
> > And only in the case there is no driver, hwmod can parse the address
> > space from DT for the unclaimed hardware in the late_initcall.
> 
> sounds good. But then it means our DTS files should be 100% complete,
> meaning that even for the IPs which we don't have drivers at all, we
> should still provide DTS nodes.

Yes, eventually. It's still better to have only one set of that data
rather than number of supported SoCs times that data.. Parsing it
should not be too bad if it's done one driver at a time during the
driver probe.

> In that case, does it make sense to teach DT about the actual structure
> of OMAP's interconnect ? I mean:
> 
> ocp {
> 	l3@xxxxxxxx {
> 		l4_per@xxxxxxxx {
> 			...
> 		};
> 
> 		l4_wakeup@xxxxxxxx {
> 			...
> 		};
> 
> 		...
> 	};
> };
> 
> That would mean that even interconnect PM could move to a driver under
> drivers/bus/{l3,l4_per,l4_wakeup,..}.c

Yes makes sense to me.
 
> > So the shared inline function should just take the __iomem * and
> > size instead of *drv so both the driver and hwmod code can tinker
> > with the autoidle bit.
> 
> Should hwmod be touching that in the long run ? It _does_ belong in the
> device's address space
> 
> > > Note sure if any of those are acceptable.
> > 
> > Hmm what issues do you see in the above suggestion?
> 
> driver and hwmod accessing SYSC simultaneously for instance. Imagine
> something like:
> 
> hwmod						driver
> ------						-------
> 1. starts device reset
> 2. polls RESET bit with X ms timeout		X' ms later starts reset
> 3. times out since reset restarts		polls RESET bit with X ms timeout
> 4. error!					reset completes
> 
> In such cases, what do we do ? There can be many such cases, don't
> you think ?

I don't think so as hwmod should only touch the sysconfig space
when no driver has claimed it. If hwmod sysconfig tinkering is
only done in late_initcall, I don't think any drivers are probing
at that time? Well there may be some deferred probe related issues
there though, so we need some atomic way at that point to know if
some hardware is being claimed by a driver.

Regards,

Tony 
