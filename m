From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP3 migrating: partition / clock
Date: Mon, 8 Feb 2010 12:13:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002081208380.22923@utopia.booyaka.com>
References: <804f0d21002032306h6a61070bof03bec78a6e4364a@mail.gmail.com>  <alpine.DEB.2.00.1002050051250.26033@utopia.booyaka.com> <804f0d21002080239t2a5e979bxf570a9df06a4ec20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45717 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab0BHTNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 14:13:15 -0500
In-Reply-To: <804f0d21002080239t2a5e979bxf570a9df06a4ec20@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>
Cc: linux-omap@vger.kernel.org

On Mon, 8 Feb 2010, Arno Steffen wrote:

> Thanks Paul for your help.
> 
> Switch on the  "#define DEBUG" in this both files skip almost all
> kernel boot messages before this warning and gives just this: !?!

You probably need to enable CONFIG_DEBUG_LL to see all of the messages.

>  Uncompressing Linux................ done, booting the kernel.
> lock: associated clk usbtll_ick to clkdm core_l4_clkdm
> Clocking rate (Crystal/Core/MPU): 12.0/332/600 MHz
> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/clock34xx.c:773
> omap3_noncore_dpll_set_rate+0x1d4/0x308()
> Modules linked in:
> [<c002a924>] (unwind_backtrace+0x0/0xdc) from [<c004a168>]
> (warn_slowpath_common+0x48/0x60)
> ....
> 
> I expected to get more messages, not less:
> You are right, my board is running at 12 instead of 13MHz, but this
> setting is (or should be) done in uboot.
> I don't know what this new line withb the "lock" means.

The leading "c" was apparently dropped.  You can recursively grep through 
the source tree to locate messages, if you are curious as to where they 
come from.

> On my board there is no USB at all.

If you're not using any of the DPLL5-connected devices (USB, USIM, etc.), 
what happens if you comment out the omap3_clk_lock_dpll5() call in 
clock34xx.c?  This is not a proper fix, of course, but it may help narrow 
down the problem.


- Paul
