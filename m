From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Tue, 19 Feb 2013 11:31:22 -0800
Message-ID: <20130219193122.GJ5724@atomide.com>
References: <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com>
 <20130214224710.GF11362@atomide.com>
 <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com>
 <20130219154511.GU17852@n2100.arm.linux.org.uk>
 <20130219163053.GE5724@atomide.com>
 <20130219182257.GV17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:64348 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933416Ab3BSTb2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 14:31:28 -0500
Content-Disposition: inline
In-Reply-To: <20130219182257.GV17852@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130219 10:26]:
> On Tue, Feb 19, 2013 at 08:30:53AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [130219 07:49]:
> > > If you want such things as pci_enable_device(), then what you're actually
> > > asking for is omap_enable_device() for OMAP devices.  OMAP devices are
> > > already specific enough to OMAP SoCs (god knows, they have really complex
> > > and obscure behaviours that no one else in their right mind would want
> > > to copy) that calling out to omap specific functions would never really
> > > be a problem.
> > 
> > I'd rather avoid adding omap_enable_device() calls to drivers as we really
> > want to keep the drivers generic. But maybe there could be some generic
> > bus_enable_device() function pointer that could be populated by the bus
> > code during init.
> 
> What you're not getting is that pci_enable_device() is a PCI thing which
> is mostly a no-op - and where it isn't a no-op, it's something that must
> be done _before_ PCI resources are used or even reserved (because
> conceptually, this is to do with getting the resources correct.)
> 
> The PCI case is:
> 
> pci_device_probe(pci_dev)
> {
> 	pci_enable_device(pci_dev);
> 
> 	pci_request_regions(pci_dev);
> 
> 	regs = pci_iomap(pci_dev, BAR, size);
> ...
> }
> 
> That's different from what you're wanting on OMAP - what you're wanting
> there is some way to record the platform device has been ioremapped, so
> that you can then fiddle with its idle/reset register from "bus" code.
> 
> If you think about it in light of the above sequence, the "enable device"
> stage *doesn't* suit your needs because that happens before the driver
> has done anything.

Right.. that won't help then. It sounds like the proper place would
be something like pm_runtime_init() as these register manage things
like autoidle etc.
 
> However... if you think you're going to get away with another total
> rewrite of OMAP device support away from hwmod to a new scheme with a
> new load of huge churn, think again.  Remember, churn is evil.  I've
> complained to you about the amount of churn that OMAP manufactures
> in the past.  Linus has complained about it too.  You can't continue
> like this.

I don't think there's any churn needed here if done properly. It's
mostly a question of dropping duplicate data from hwmod that we
already have available in device tree. That means we can shrink the
hwmod data needed.

Regards,

Tony
