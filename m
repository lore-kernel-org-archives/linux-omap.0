From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 16:37:23 +0100
Message-ID: <20110415153723.GD4423@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <4DA85B49.60209@vollmann.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35754 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151Ab1DOPhr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 11:37:47 -0400
Content-Disposition: inline
In-Reply-To: <4DA85B49.60209@vollmann.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Detlef Vollmann <dv@vollmann.ch>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 15, 2011 at 04:50:49PM +0200, Detlef Vollmann wrote:
> I'd love to have the mapping inside the create pool, but that might
> not be possible in general.

No, think about it.  What if you need to map the RAM area with some
special attributes - eg, where ioremap() doesn't work.  Eg, OMAP you
need SRAM mapped as normal memory, except for OMAP34xx where it must
be mapped normal memory non-cacheable.

It's best to leave the mapping to the architecture.

>> Another question is whether we should allow multiple SRAM pools or not -
>> this code does allow multiple pools, but so far we only have one pool
>> per SoC.  Overdesign?  Maybe, but it prevents SoCs wanting to duplicate
>> it if they want to partition the SRAM, or have peripheral-local SRAMs.
> Having the option to partition the SRAM is probably useful.
> What I'm missing is sram_pool_add: on AT91SAM9G20 you have two banks
> of SRAM, and you might want to combine them into a single pool.

Do you already combine them into a single pool, or is this a wishlist?
I'm really not interested in sorting out peoples wishlist items in
the process of consolidation.

Second point is that you'll notice that the code converts to a phys
address using this: phys = phys_base + (virt - virt_base).  As soon as
we start allowing multiple regions of SRAM, it becomes impossible to
provide the phys address without a lot more complexity.

>>   arch/arm/common/sram-pool.c                 |   69 +++++++++++++++++++++++++++
>>   arch/arm/include/asm/sram-pool.h            |   20 ++++++++
> Waht is ARM specific about this code?
> Why not put it into lib/ and include/linux, respectively?

Nothing, but this is the first stage of consolidation of this code.
I'm not trying to consolidate the universe down to one implementation
here - that's going to take _far_ too much effort in one go, and from
my previous experiences interacting with other arch maintainers, that's
the way to get precisely nothing done.

In my experience, arch maintainers tend to object to each others patches,
and the net result is no forward progress.  See dma_mmap API as a
brilliant example of that - the lack of which contines to cause problems
for drivers many years after I initially tried (and gave up) trying to
get agreement on that.

So, let's do what we can to consolidate our stuff and if we get some
agreement from other arch maintainers, look towards moving it out.
Moving stuff out once its properly modularized is trivial.
