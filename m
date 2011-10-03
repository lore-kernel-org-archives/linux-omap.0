From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please help with the OMAP static mapping mess
Date: Mon, 3 Oct 2011 15:38:24 -0700
Message-ID: <20111003223824.GK6324@atomide.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
 <20111003205658.GJ6324@atomide.com>
 <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43739 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757732Ab1JCWi1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 18:38:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [111003 14:36]:
> On Mon, 3 Oct 2011, Tony Lindgren wrote:
> 
> > * Nicolas Pitre <nico@fluxnic.net> [111003 11:26]:
> 
> > > OK, so let's modify omap4_panda_map_io() just to test this one board and 
> > > reverse the omap44xx_map_common_io() and omap2_set_globals_443x() call 
> > > order.  Now the mappings will be there before ioremap() is called.  But 
> > > that, too, doesn't work and the kernel now complains with:
> > > 
> > > |OMAP revision unknown, please fix!
> > > |Uninitialized omap_chip, please fix!
> > > |Could not detect SRAM size
> > > 
> > > But it looks like omap2_set_globals_tap() still has to be called first!  
> > > Isn't this wonderfully convoluted?
> > 
> > We've already unravelled some of that with the init_early changes.
> > 
> > Earlier having the IO space moving around between 2420/2430/3430
> > meant that we had to map some IO to detect the SoC. Now we have
> > SoC specific initcalls where we assume the SoC category is initialized
> > from board-*.c file (and from DT at some point).
> 
> But the map_io method always has been tied to machine specific 
> descriptors.  That always implied a fixed SoC category, no?  Unless you 
> have a machine which can accommodate multiple different SOCs but that's 
> very uncommon.

Hmm I think we initially tried to use board-generic.c with custom ATAGs
to boot multiple SoCs and that's why we needed SoC detection for map_io.

Now the only variable SoC headache left is that board-omap3beagle.c
is using the same machine_id for 3430 and 3630 beagle which are somewhat
different SoCs, but Luckily not from map_io point of view though. So that
should be fixable with DT when the SoC type will be passed from DT.
 
> > Having the SRAM base address move around with different sizes also
> > requires the SoC detection.. Otherwise we can end up mapping wrong
> > size and end up trying to access secure SRAM that will hang the system.
> > 
> > The way to fix it is to move SRAM init happen much later so we don't
> > have to map it early. I guess now we could use ioremap for SRAM,
> > although we may not want device attributes for the executable code?
> > Got any suggestions here on how we should map SRAM later on?
> 
> You can use a variant of ioremap() such as __arm_ioremap() which let you 
> specify the memory attribute.

OK, I'll take a look at that.
 
> > > Furthermore... there is also a static mapping for physical address 
> > > 0x4e000000 using virtual address 0xff100000 which is already reserved 
> > > for other purposes i.e. the consistent DMA area.  It is not immediately 
> > > obvious where this comes from without being intimate with the OMAP code. 
> > > Can this be fixed as well i.e. moved elsewhere please?
> > 
> > This sounds like a bug somewhere. Which omap are you seeing this on?
> 
> OMAP4430 on a Panda board.
> 
> Here are the static mappings I'm seeing:
> 
> phys = 0x44000000 virt = 0xf8000000 size = 0x100000
> phys = 0x4a000000 virt = 0xfc000000 size = 0x400000
> phys = 0x50000000 virt = 0xf9000000 size = 0x100000
> phys = 0x4c000000 virt = 0xfd100000 size = 0x100000
> phys = 0x4d000000 virt = 0xfe100000 size = 0x100000
> phys = 0x4e000000 virt = 0xff100000 size = 0x100000 <---
> phys = 0x48000000 virt = 0xfa000000 size = 0x400000
> phys = 0x54000000 virt = 0xfe800000 size = 0x800000
> 
> It is also possible that I might have screwed something up on my side.  
> What is located at 0x4e000000?

It seems to be DMM (Dynamic Memory Manager), some more info at:

http://lwn.net/Articles/417790/

Tony
