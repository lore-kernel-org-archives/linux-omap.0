From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Please help with the OMAP static mapping mess
Date: Mon, 03 Oct 2011 18:09:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
 <20111003205658.GJ6324@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:24187 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab1JCWJ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 18:09:58 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LSI004N6G6TUG20@VL-VM-MR001.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Mon, 03 Oct 2011 18:08:53 -0400 (EDT)
In-reply-to: <20111003205658.GJ6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 3 Oct 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [111003 11:26]:
> > 
> > The problem is that those ioremap() calls are performed _*before*_ the 
> > memory is fully set up yet, and also even before the corresponding 
> > static mappings are even in place!  So not only is the ioremap code 
> > unoperational at this point, but a generic way to trap ioremap() calls 
> > in order to toss a static mapping back won't even work here because 
> > iotable_init() was not even called yet.
> > 
> > The current code get away with it because OMAP is providing its own 
> > __arch_ioremap() which does the interception and provide a virtual 
> > address from hardcoded but yet to exist mappings.  But the goal of 
> > global kernel maintenance is to _remove_ such SOC-specific special cases 
> > and move such a perfectly valid optimization into core code where it can 
> > be applied uniformly to all.  So the OMAP __arch_ioremap() is going 
> > away, meaning that static mappings have to be in place before ioremap() 
> > calls can return something minimally usable.
> 
> Sure this would be nice to fix, see below.

Great!

> > OK, so let's modify omap4_panda_map_io() just to test this one board and 
> > reverse the omap44xx_map_common_io() and omap2_set_globals_443x() call 
> > order.  Now the mappings will be there before ioremap() is called.  But 
> > that, too, doesn't work and the kernel now complains with:
> > 
> > |OMAP revision unknown, please fix!
> > |Uninitialized omap_chip, please fix!
> > |Could not detect SRAM size
> > 
> > But it looks like omap2_set_globals_tap() still has to be called first!  
> > Isn't this wonderfully convoluted?
> 
> We've already unravelled some of that with the init_early changes.
> 
> Earlier having the IO space moving around between 2420/2430/3430
> meant that we had to map some IO to detect the SoC. Now we have
> SoC specific initcalls where we assume the SoC category is initialized
> from board-*.c file (and from DT at some point).

But the map_io method always has been tied to machine specific 
descriptors.  That always implied a fixed SoC category, no?  Unless you 
have a machine which can accommodate multiple different SOCs but that's 
very uncommon.

> Having the SRAM base address move around with different sizes also
> requires the SoC detection.. Otherwise we can end up mapping wrong
> size and end up trying to access secure SRAM that will hang the system.
> 
> The way to fix it is to move SRAM init happen much later so we don't
> have to map it early. I guess now we could use ioremap for SRAM,
> although we may not want device attributes for the executable code?
> Got any suggestions here on how we should map SRAM later on?

You can use a variant of ioremap() such as __arm_ioremap() which let you 
specify the memory attribute.

> > So could someone in the OMAP camp fix this nonsense ASAP please?
> > Of course, yesterday would be best.
> 
> Heh. Were working on it. So far it's been moving things to get initialized
> later, separate sys_timer code from dmtimer driver features, initialize
> only the hwmods needed for sys_timer early, SoC specific initcalls to
> clear the SoC detection out of the early init path and so on.

Wonderful!

> > Furthermore... there is also a static mapping for physical address 
> > 0x4e000000 using virtual address 0xff100000 which is already reserved 
> > for other purposes i.e. the consistent DMA area.  It is not immediately 
> > obvious where this comes from without being intimate with the OMAP code. 
> > Can this be fixed as well i.e. moved elsewhere please?
> 
> This sounds like a bug somewhere. Which omap are you seeing this on?

OMAP4430 on a Panda board.

Here are the static mappings I'm seeing:

phys = 0x44000000 virt = 0xf8000000 size = 0x100000
phys = 0x4a000000 virt = 0xfc000000 size = 0x400000
phys = 0x50000000 virt = 0xf9000000 size = 0x100000
phys = 0x4c000000 virt = 0xfd100000 size = 0x100000
phys = 0x4d000000 virt = 0xfe100000 size = 0x100000
phys = 0x4e000000 virt = 0xff100000 size = 0x100000 <---
phys = 0x48000000 virt = 0xfa000000 size = 0x400000
phys = 0x54000000 virt = 0xfe800000 size = 0x800000

It is also possible that I might have screwed something up on my side.  
What is located at 0x4e000000?


Nicolas
