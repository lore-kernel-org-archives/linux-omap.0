From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 14:57:46 -0500 (EST)
Message-ID: <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
 <20130221182724.GA14329@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:21407 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab3BUT5s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 14:57:48 -0500
In-reply-to: <20130221182724.GA14329@obsidianresearch.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, 21 Feb 2013, Jason Gunthorpe wrote:

> On Thu, Feb 21, 2013 at 12:25:21PM -0500, Nicolas Pitre wrote:
> 
> > So let's stop kidding ourselves and be coherent please: either we move 
> > device specifics away from the kernel, or we keep them together.  In 
> > other words, the DT should ideally come preinstalled with the bootloader 
> > on a given board/device for distros to not even have to care about it, 
> > or we put that data back inside the kernel and dispense ourselves from 
> > all the added DT overhead entirely.  But an hybrid mixed solution like 
> > FIT is IMHO the worst of both worlds and sending a wrong message.
> 
> Just to thread jack a bit here..
> 
> We've been using DT on production embedded stuff sice about 2.6.20ish
> on PPC and now ARM. We treat the dtb as a kernel version specific
> file, much like an initrd and ensure that the kernel only ever boots
> with its proper dtb. This is based on experience that the dtbs change
> depending on the state of the drivers in the kernel, what gets
> mainlined and when, etc.

For embedded appliance product you may do as you wish.  Nobody will 
interfere in the way you develop and support your own products (as long 
as you honor the applicable licenses of course).

But here we're discussing ARM Linux distributions having to deal with 
different hardware devices.  It simply doesn't make sense to bundle 
every hardware specific data with the kernel in that context.

> Embedding this stuff into the bootloader is *not* desirable for my
> embedded scenarios. We don't use FIT (or uboot) but we do the same
> thing: a single image is constructed with the proper dtb, kernel and
> initrd, and that is what the bootloader boots.

No one is advocating to embed the DT stuff in the bootloader.  The DTB 
may be buggy and/or incomplete and being able to update it safely i.e. 
independently from the bootloader is necessary.

> Why? This is an embedded appliance product. We need to be able to
> deliver firmware upgrades that *work*. We can't brick the board
> because the bootloader and kernel get out of sync. The boot loader has
> to be *simple*, it has to boot every past, present and future kernel
> or we start taking risks that a firmware flash will end up bricking
> it.
> 
> People making dev boards and distros for them certainly have different
> requirements, but we've decided that the single image approach is the
> best for appliance style products.

Absolutely.  And in your case, DT is not bringing any benefit over the 
previous situation where everything was compiled into the kernel.  I 
suspect you're not using the multi-platform support either which is one 
of the major endeavor on ARM right now.


Nicolas
