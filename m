From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Tue, 19 Feb 2013 08:38:20 -0800
Message-ID: <20130219163820.GF5724@atomide.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130214222247.GE11362@atomide.com>
 <alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14734 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758438Ab3BSQiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 11:38:24 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Paul Walmsley <paul@pwsan.com> [130219 07:30]:
> Hi,
> 
> On Thu, 14 Feb 2013, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [130214 12:51]:
> > > On Thu, 14 Feb 2013, Tony Lindgren wrote:
> > > 
> > > > I don't think so as hwmod should only touch the sysconfig space
> > > > when no driver has claimed it.
> > > 
> > > hwmod does need to touch the SYSCONFIG register during pm_runtime suspend 
> > > and resume operations, and during device enable and disable operations.  
> > > Here's the relevant code:
> > > 
> > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2157
> > > 
> > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2195
> > 
> > But that's triggered by runtime PM from the device driver, right?
> 
> Yes - for devices with drivers, it will hopefully be called by the 
> driver.
> 
> > I think it's fine for hwmod to do that as requested by the device
> > driver via runtime PM since hwmod is the bus glue making the drivers arch
> > independent.
> > 
> > I think the only piece we're missing for that is for driver to run
> > something like pm_runtime_init() that initializes the address space
> > to hwmod. 
> 
> In the current design, we might be able to do this during the driver's 
> first call to pm_runtime_get*().  I think that's the first point that we 
> can hook into the PM runtime code.

Sounds doable and generic for now.
 
> Once the hwmod code is moved out to be a bus, I'm hoping we can do this 
> through the driver making a dev->bus->enable_device() call - similar to 
> the way PCI drivers call pci_enable_device(), but not bus-specific.  That 
> should remove our current dependency on CONFIG_PM_RUNTIME for OMAP devices 
> to work correctly :-(
> 
> > Just to recap what we've discussed earlier, the reasons why we want
> > reset and idle functions should be in the driver specific header are:
> > 
> > 1. There's often driver specific logic needed in addition to the
> >    syconfig tinkering in the reset/idle functions.
> 
> It's been a while since I last tabulated this.  But my recollection was 
> that some kind of IP block-specific reset code is needed for about 7% to 
> 10% of the OMAP IP blocks.

Yes it's not too many, but the issue there is the driver specific code
that's duplicated in both places. And sounds like the solution to that
is to make driver specific reset code a static inline function in the
driver header as discussed earlier so bus code can call it when there's
no driver loaded.
 
> One thing that's unclear to me for the DT case is how we'll bind the 
> driver-specific parts of the reset code to the device, particularly in the 
> case where there's no driver present.  It should be possible to place an 
> initcall in the driver-specific header, but that seems like a hack.  Any 
> thoughts on this?

I think we can just initialize the driver-specific reset functions
in hwmod code and those can just call the driver specific inline functions
as needed in the driver specific header files.
 
> > 2. We need to be able to reset and idle some hardware even if the
> >    driver is not compiled in.
> 
> Yep.

Regards,

Tony
