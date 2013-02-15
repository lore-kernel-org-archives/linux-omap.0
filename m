From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Fri, 15 Feb 2013 10:16:10 +0000
Message-ID: <20130215101610.GR17852@n2100.arm.linux.org.uk>
References: <1360840554-26901-1-git-send-email-balbi@ti.com> <1360840554-26901-2-git-send-email-balbi@ti.com> <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi> <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43678 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab3BOKQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 05:16:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

On Thu, Feb 14, 2013 at 08:47:53PM +0000, Paul Walmsley wrote:
> Regarding ioremap(), it seems reasonable for drivers to call ioremap(), as 
> long as the implementation of ioremap() can be overridden by the device's 
> bus.  PCI device drivers already do this -- albeit in a PCI-specific way 
> -- with pci_ioremap_bar():

Err no, that's just a helper to assist checking the resource type and
remove all those pesky resource size mistakes - see the commit text:

    PCI: introduce an pci_ioremap(pdev, barnr) function

    A common thing in many PCI drivers is to ioremap() an entire bar.  This
    is a slightly fragile thing right now, needing both an address and a
    size, and many driver writers do.. various things there.

    This patch introduces an pci_ioremap() function taking just a PCI device
    struct and the bar number as arguments, and figures this all out itself,
    in one place.  In addition, we can add various sanity checks to this
    function (the patch already checks to make sure that the bar in question
    really is a MEM bar; few to no drivers do that sort of thing).

    Hopefully with this type of API we get less chance of mistakes in
    drivers with ioremap() operations.

    Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
    Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

> So instead of something bus-specific like that, a better way would be to 
> use something like:
> 
> va = dev->bus->ioremap( ... );
> va = dev->bus->iounmap( ... );

No.  ioremap() is already generic.  We don't need additional layers of
indirection per bus type.
