From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Tue, 19 Feb 2013 15:45:11 +0000
Message-ID: <20130219154511.GU17852@n2100.arm.linux.org.uk>
References: <1360840554-26901-2-git-send-email-balbi@ti.com> <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi> <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com> <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com> <20130214224710.GF11362@atomide.com> <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46417 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758355Ab3BSPpW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 10:45:22 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

On Tue, Feb 19, 2013 at 03:30:01PM +0000, Paul Walmsley wrote:
> Hi,
> 
> On Thu, 14 Feb 2013, Tony Lindgren wrote:
> 
> > The other option could be to allow custom ioremap function pointers 
> > based on address range in __arm_ioremap_pfn_caller() the same way as
> > the SoC specific static mappings are allowed. That would require adding
> > a function pointer to struct map_desc.
> > 
> > Maybe that would do the trick?
> 
> That sounds fine to me too.
> 
> To me it makes sense to eventually handle the I/O mappings automatically 
> from data in the DT -- hence the association with a bus device, which 
> should be present in DT data.

No.  I really don't get why OMAP thinks it's soo special that it needs
to go around adding lots and lots of new abstractions all over the
place.

Indirect ioremap() through a function pointer so you can overload it with
OMAP specific crap?  No way.  Function pointers in map_desc - what the hell
for?

You must be totally mad if you think that's a way forward, I really don't
see how you think this kind of crap would be remotely acceptable.

Ok, so you have this problem that you need hwmod to touch a register which
is also contained within the device resources as well.  That's fine.  You
can do it one of two ways:

1. Call out from the driver at the appropriate points (which seems to be
   _after_ you've ioremapped it) to access the register.

2. Find the resource, temporarily map the register, access it, and then
   unmap it.

No requirement what so ever to override ioremap().  AT ALL.  So stop this
madness now.

As for a function pointer in struct map_desc.  You're bonkers, the lot of
you.  map_desc is a structure describing the boot time static mappings
which gets discarded.  Nothing keeps any references around to it, and it
is used at a time when *NOTHING ELSE* should be going on in the kernel
other than building those static mappings.  Not even any arch code poking
about at devices.  Or anything like that.  Because if you think that's
acceptable, then we'll need to flush the cache and TLB after each and
every map_desc entry is touched - which brings a whole load of new pain
and slowness to the kernel boot.

So please, stop this idiotic madness now.

If you want such things as pci_enable_device(), then what you're actually
asking for is omap_enable_device() for OMAP devices.  OMAP devices are
already specific enough to OMAP SoCs (god knows, they have really complex
and obscure behaviours that no one else in their right mind would want
to copy) that calling out to omap specific functions would never really
be a problem.

No need for any of this crazy dev->bus shit either.
