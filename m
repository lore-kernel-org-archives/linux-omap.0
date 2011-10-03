From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please help with the OMAP static mapping mess
Date: Mon, 3 Oct 2011 13:56:58 -0700
Message-ID: <20111003205658.GJ6324@atomide.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18426 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756961Ab1JCU5B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 16:57:01 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [111003 11:26]:
> 
> The problem is that those ioremap() calls are performed _*before*_ the 
> memory is fully set up yet, and also even before the corresponding 
> static mappings are even in place!  So not only is the ioremap code 
> unoperational at this point, but a generic way to trap ioremap() calls 
> in order to toss a static mapping back won't even work here because 
> iotable_init() was not even called yet.
> 
> The current code get away with it because OMAP is providing its own 
> __arch_ioremap() which does the interception and provide a virtual 
> address from hardcoded but yet to exist mappings.  But the goal of 
> global kernel maintenance is to _remove_ such SOC-specific special cases 
> and move such a perfectly valid optimization into core code where it can 
> be applied uniformly to all.  So the OMAP __arch_ioremap() is going 
> away, meaning that static mappings have to be in place before ioremap() 
> calls can return something minimally usable.

Sure this would be nice to fix, see below.
 
> OK, so let's modify omap4_panda_map_io() just to test this one board and 
> reverse the omap44xx_map_common_io() and omap2_set_globals_443x() call 
> order.  Now the mappings will be there before ioremap() is called.  But 
> that, too, doesn't work and the kernel now complains with:
> 
> |OMAP revision unknown, please fix!
> |Uninitialized omap_chip, please fix!
> |Could not detect SRAM size
> 
> But it looks like omap2_set_globals_tap() still has to be called first!  
> Isn't this wonderfully convoluted?

We've already unravelled some of that with the init_early changes.

Earlier having the IO space moving around between 2420/2430/3430
meant that we had to map some IO to detect the SoC. Now we have
SoC specific initcalls where we assume the SoC category is initialized
from board-*.c file (and from DT at some point).

Having the SRAM base address move around with different sizes also
requires the SoC detection.. Otherwise we can end up mapping wrong
size and end up trying to access secure SRAM that will hang the system.

The way to fix it is to move SRAM init happen much later so we don't
have to map it early. I guess now we could use ioremap for SRAM,
although we may not want device attributes for the executable code?
Got any suggestions here on how we should map SRAM later on?
 
> Also the repeated local_flush_tlb_all()/flush_cache_all() calls found in 
> the OMAP mdesc->map_io code paths (one in _omap2_map_common_io(), 
> another in omap_map_sram(), just to pick those as examples) is a sure 
> sign that too much is being done via this call and layering violations 
> are present.

This should go away too if we can avoid SoC detection early and
map SRAM later. I guess the only issue remaining with that is what we
should use for mapping SRAM later on.
 
> So could someone in the OMAP camp fix this nonsense ASAP please?
> Of course, yesterday would be best.

Heh. Were working on it. So far it's been moving things to get initialized
later, separate sys_timer code from dmtimer driver features, initialize
only the hwmods needed for sys_timer early, SoC specific initcalls to
clear the SoC detection out of the early init path and so on.
 
> Furthermore... there is also a static mapping for physical address 
> 0x4e000000 using virtual address 0xff100000 which is already reserved 
> for other purposes i.e. the consistent DMA area.  It is not immediately 
> obvious where this comes from without being intimate with the OMAP code. 
> Can this be fixed as well i.e. moved elsewhere please?

This sounds like a bug somewhere. Which omap are you seeing this on?

Regards,

Tony
