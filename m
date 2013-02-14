From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Thu, 14 Feb 2013 10:12:17 -0800
Message-ID: <20130214181217.GA11806@atomide.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13011 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932479Ab3BNSMV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 13:12:21 -0500
Content-Disposition: inline
In-Reply-To: <20130214175650.GA25891@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [130214 10:00]:
> Hi,
> 
> On Thu, Feb 14, 2013 at 09:12:53AM -0800, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [130214 03:19]:
> > > Currently the omap-serial driver will not
> > > work properly if booted via DT with CPUIDLE
> > > enabled because it depends on function pointers
> > > provided by hwmod to change its own SYSCONFIG
> > > register.
> > > 
> > > Remove that relyance on hwmod by moving SYSCONFIG
> > > handling to driver itself. Note that this also
> > > fixes a possible corner case bug where we could
> > > be putting UART in Force Idle mode if we called
> > > omap_serial_enable_wakeup(up, false) after setting
> > > NOIDLE to the idle mode. This is because hwmod
> > > has no protection against that situation.
> 
> Any comments to these last two sentences ?

Well I think all the driver handling should be done in
the driver since we now have runtime PM.
 
> > I agree the sysconfig stuff should be handled in the drivers.
> > But considering that we need to also reset or idle hardware
> > that may not have a driver loaded, it's best to put the
> > reset/idle function in to the driver specific header as
> > an inline function.
> 
> that is likely to cause quite a few isues, don't you think?
> 
> hwmod depending on driver code to reset particular IPs ? Seems like we
> need a generic device_reset() hook which can be called by platform code,
> no ? Not sure if that would help a lot though.
> 
> > This way the hwmod code can idle or reset the unclaimed
> > hardware in a late_initcall.
> 
> The problem with this:
> 
> my_driver.h:
> 
> static inline void my_driver_reset(struct my_driver *drv)
> {
> 	writel(drv->regs, SYSS, RESET);
> }
> 
> how will hwmod provide drv pointer ? Even if we use void __iomem * it
> would mean that hwmod would have to a) access driver's ioremaped area or
> b) ioremap() the same area again.

Well the ioremapping should only be done in the driver ideally.
Currently we have a mess of both hwmod and driver doing the
ioremapping.

So in the long run, let's assume only the driver ioremaps for
most of the cases where there is a driver available.

And only in the case there is no driver, hwmod can parse the address
space from DT for the unclaimed hardware in the late_initcall.

So the shared inline function should just take the __iomem * and
size instead of *drv so both the driver and hwmod code can tinker
with the autoidle bit.
 
> Note sure if any of those are acceptable.

Hmm what issues do you see in the above suggestion?
 
> > And probably the handling of sysconfig bits should be
> > done using a common header in include/linux/omap-hwmod.h
> > or something so it can be shared between drivers.
> 
> That could be done, though I think the header name could be different.
> Maybe it could match the document which define those registers, let me
> just check if we're allowed to use that publicly :-p

Cool yeah I have no preference where that header should be. Maybe
something bus specific like include/linux/bus/omap-hwmod.h?

Regards,

Tony
