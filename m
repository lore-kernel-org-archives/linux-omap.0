From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Mon, 18 Apr 2011 09:48:38 +0300
Message-ID: <20110418064838.GE12272@atomide.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
 <BANLkTikJwFRenjwnws+4J2ep9G0Nv-9aXw@mail.gmail.com>
 <20110416130929.GL4423@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57495 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587Ab1DRGsp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 02:48:45 -0400
Content-Disposition: inline
In-Reply-To: <20110416130929.GL4423@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110416 16:06]:
> On Sat, Apr 16, 2011 at 09:01:26PM +0800, Haojian Zhuang wrote:
> > On Fri, Apr 15, 2011 at 9:06 PM, Russell King - ARM Linux
> > >
> > > This uses the physical address, and unlike Davinci's dma address usage,
> > > it always wants to have the physical address, and will always return
> > > the corresponding physical address when passed that pointer.
> > >
> > > OMAP could probably do with some more work to make the omapfb and other
> > > allocations use the sram allocator, rather than hooking in before the
> > > sram allocator is initialized - and then further cleanups so that we
> > > have an initialization function which just does

I think we can just remove the omapfb SRAM support for now as it should
be optional. That will then leave out that dependency and can be added
back once we have a common framework in place.

Tomi do you see any problems with that?

> > TCM driver can allocate code into SRAM section in link stage. It needs to
> > update link file and virtual memory layout. Is it worth to make SRAM driver
> > support this behavior? The case of using SRAM as memory for instruction
> > is switching frequency or entering/exiting low power mode in PXA silicons.
> 
> This is more or less the same scenario which OMAP is using its SRAM
> for, although that's explicitly SRAM and not TCM.
> 
> I don't think we need position dependent code requiring fixup for
> these applications as such things tend to be fairly easily coded in a
> position independent way.

There should not be any need code requiring fixup in most cases using
parameters passed to the functions should be enough. Usually it's
just register addresses that are different.
 
> Also note that C functions can't be copied because C produces position
> dependent code, and we have no way of extracting the relocation
> dependencies from such code.

C functions should not be needed. The SRAM size is small and typical
usage is a loop waiting for some register to lock. For any larger SRAM
areas NUMA can be used instead.

Regards,

Tony
