From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Fri, 15 Feb 2013 10:26:09 +0000
Message-ID: <20130215102609.GS17852@n2100.arm.linux.org.uk>
References: <1360840554-26901-1-git-send-email-balbi@ti.com> <1360840554-26901-2-git-send-email-balbi@ti.com> <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi> <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com> <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43692 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935665Ab3BOK0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 05:26:17 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

On Thu, Feb 14, 2013 at 09:40:29PM +0000, Paul Walmsley wrote:
> Hi,
> 
> On Thu, 14 Feb 2013, Paul Walmsley wrote:
> 
> > So instead of something bus-specific like that, a better way would be to 
> > use something like:
> > 
> > va = dev->bus->ioremap( ... );
> > va = dev->bus->iounmap( ... );
> 
> Something like this is what I was thinking.  Obviously there would be more
> patches needed, for the various arches, etc.; and I'm not convinced that
> the function pointer init is done at the right time yet. Comments welcome.

Not only does this break the "ioremap caller" stuff, allowing the caller
of ioremap() to be recorded, I believe this to be a total abonimation.

> This might also be useful as a generic replacement for pci_ioremap_bar().

No it isn't.  Read the comments about why pci_ioremap_bar() was introduced
in its original commit.  It's there to reduce the number of common errors
with mapping a PCI bar, so it takes the PCI device and the BAR index.

It has a totally different interface to standard ioremap().  It can't be
twisted into the standard ioremap() interface in any shape or form.

> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index ce328c7..303dba0 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -17,6 +17,7 @@
>  #include <linux/fs.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
> +#include <linux/platform_device.h>
>  
>  #include <asm/cp15.h>
>  #include <asm/cputype.h>
> @@ -28,6 +29,7 @@
>  #include <asm/highmem.h>
>  #include <asm/system_info.h>
>  #include <asm/traps.h>
> +#include <asm/io.h>

How many more bloody times do I have to tell people about using asm/io.h
directly?  You've been around for _long_ enough that you well know this
by now.  There is no excuse for this kind of thing other than shere
laziness or down-right sloppyness on your part.

If I make a big enough thing about it, hopefully people will become scared
to post their un-self-reviewed patches and instead start taking a little
more care in future.
