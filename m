From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/9] ARM: OMAP: DMTIMER clean-up in preparation for
 device-tree
Date: Wed, 16 May 2012 17:30:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205161727200.2921@utopia.booyaka.com>
References: <1337124914-19921-1-git-send-email-jon-hunter@ti.com> <4FB37356.9040001@ti.com> <4FB40AB5.10302@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41515 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab2EPXao (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 May 2012 19:30:44 -0400
In-Reply-To: <4FB40AB5.10302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

Hello Jon,

On Wed, 16 May 2012, Jon Hunter wrote:

> I have been looking into this and in order to get rid for the above
> function pointer we would need to move at a minimum the following
> functions from omap-mach2/clkt_clksel.c into the platform code.

By platform code, do you mean arch/arm/plat-omap?

> _get_clksel_by_parent()
> _get_div_and_fieldval()
> _write_clksel_reg()
> omap2_init_clksel_parent()
> omap2_clksel_set_parent()
> 
> However, it may be simpler just to move the clkt_clksel.c file
> completely. I have tested the above functions on omap1 and they are
> working well. However, before doing this we would need to get Paul's
> buy-in that this is the right thing to do.
> 
> Paul, do you have any thoughts on this? We were trying to see if we
> could eliminate the dmtimer function pointer for setting the timer clock
> source.

So, just to see if I'm understanding you correctly, you are planning to 
implement clksel clocks in the clock framework for OMAP1, and then use 
clk_set_parent() in the DMTIMER driver ?

If so, then yes, that sounds like the right thing to do.

Eventually both OMAP2+ and OMAP1 will presumably switch to the common 
clock framework, once things settle down a bit and can be tested.

> Also, the only other minor issue I see is that for omap1 devices instead
> of having "sys_ck" as the name the clock name is "armxor_ck". We cannot
> rename armxor_ck as it is used by many peripherals but we could use a
> #define to workaround this or add a dummy clock node.

OMAP1 clockfw uses clkdev just like OMAP2+, so you should be able to 
define as many clock aliases as you want in mach-omap1/clock_data.c.


- Paul
