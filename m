From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Tue, 19 Feb 2013 18:22:57 +0000
Message-ID: <20130219182257.GV17852@n2100.arm.linux.org.uk>
References: <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi> <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com> <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com> <20130214224710.GF11362@atomide.com> <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com> <20130219154511.GU17852@n2100.arm.linux.org.uk> <20130219163053.GE5724@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46542 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933369Ab3BSSXH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 13:23:07 -0500
Content-Disposition: inline
In-Reply-To: <20130219163053.GE5724@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

On Tue, Feb 19, 2013 at 08:30:53AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [130219 07:49]:
> > If you want such things as pci_enable_device(), then what you're actually
> > asking for is omap_enable_device() for OMAP devices.  OMAP devices are
> > already specific enough to OMAP SoCs (god knows, they have really complex
> > and obscure behaviours that no one else in their right mind would want
> > to copy) that calling out to omap specific functions would never really
> > be a problem.
> 
> I'd rather avoid adding omap_enable_device() calls to drivers as we really
> want to keep the drivers generic. But maybe there could be some generic
> bus_enable_device() function pointer that could be populated by the bus
> code during init.

What you're not getting is that pci_enable_device() is a PCI thing which
is mostly a no-op - and where it isn't a no-op, it's something that must
be done _before_ PCI resources are used or even reserved (because
conceptually, this is to do with getting the resources correct.)

The PCI case is:

pci_device_probe(pci_dev)
{
	pci_enable_device(pci_dev);

	pci_request_regions(pci_dev);

	regs = pci_iomap(pci_dev, BAR, size);
...
}

That's different from what you're wanting on OMAP - what you're wanting
there is some way to record the platform device has been ioremapped, so
that you can then fiddle with its idle/reset register from "bus" code.

If you think about it in light of the above sequence, the "enable device"
stage *doesn't* suit your needs because that happens before the driver
has done anything.

However... if you think you're going to get away with another total
rewrite of OMAP device support away from hwmod to a new scheme with a
new load of huge churn, think again.  Remember, churn is evil.  I've
complained to you about the amount of churn that OMAP manufactures
in the past.  Linus has complained about it too.  You can't continue
like this.
