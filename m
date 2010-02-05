From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP3 migrating: partition / clock
Date: Fri, 5 Feb 2010 01:05:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002050051250.26033@utopia.booyaka.com>
References: <804f0d21002032306h6a61070bof03bec78a6e4364a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46772 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab0BEIFE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 03:05:04 -0500
In-Reply-To: <804f0d21002032306h6a61070bof03bec78a6e4364a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arno Steffen <arno.steffen@googlemail.com>
Cc: linux-omap@vger.kernel.org

Hello Arno,

On Thu, 4 Feb 2010, Arno Steffen wrote:

> I am trying to migrate from kernel 28 to 32 on  TI OMA3. Our board is
> derived from EVM board.

...

> Also I do get this warning now while boot:
> 
> Hierarchical RCU implementation.
> NR_IRQS:368
> Clocking rate (Crystal/Core/MPU): 12.0/332/500 MHz

I don't have an 3530 EVM here, but I'd assume this is one difference 
between your board and the EVM, since TI usually seems to 
build boards with 26MHz HF clock (resulting in a 13MHz sys_clk).

> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/clock34xx.c:773
> omap3_noncore_dpll_set_rate+0x280/0x2c4()

The above lines tell you exactly where to find the code that's emitting 
the warning.  In this case, the problem is that the DPLL rate rounding 
code picked DPLL parameters that resulted in an invalid jitter correction 
value (from _omap3_dpll_compute_freqsel()).  The caller is presumably 
omap3_clk_lock_dpll5() in clock34xx.c, which probably got inlined which is 
why it isn't showing up specifically in the backtrace.

I'd first suggest confirming this by changing the '#undef DEBUG' to 
'#define DEBUG' in clock34xx.c and mach-omap2/clock.c, rebuilding, and 
sending along the output.

If the above hypothesis is confirmed, and the problem is not due to some 
other bug in the code, it might be necessary to call 
_omap3_dpll_compute_freqsel() to test the freqsel value in 
_dpll_test_mult(), and reject values that result in an invalid freqsel.


> Modules linked in:
> [<c002a924>] (unwind_backtrace+0x0/0xdc) from [<c0049e74>]
> (warn_slowpath_common+0x48/0x60)
> [<c0049e74>] (warn_slowpath_common+0x48/0x60) from [<c0033d30>]
> (omap3_noncore_dpll_set_rate+0x280/0x2c4)
> [<c0033d30>] (omap3_noncore_dpll_set_rate+0x280/0x2c4) from
> [<c0031674>] (omap2_clk_set_rate+0x20/0x2c)
> [<c0031674>] (omap2_clk_set_rate+0x20/0x2c) from [<c003494c>]
> (clk_set_rate+0x4c/0xb0)
> [<c003494c>] (clk_set_rate+0x4c/0xb0) from [<c000e980>]
> (omap2_clk_init+0x124/0x1a0)
> [<c000e980>] (omap2_clk_init+0x124/0x1a0) from [<c000d6ec>]
> (omap2_init_common_hw+0x4c/0xe0)
> [<c000d6ec>] (omap2_init_common_hw+0x4c/0xe0) from [<c000ead8>]
> (omap3_evm_init_irq+0x28/0x94)
> [<c000ead8>] (omap3_evm_init_irq+0x28/0x94) from [<c000b1b0>]
> (init_IRQ+0x30/0x40)
> [<c000b1b0>] (init_IRQ+0x30/0x40) from [<c0008978>] (start_kernel+0x140/0x29c)
> [<c0008978>] (start_kernel+0x140/0x29c) from [<80008034>] (0x80008034)
> ---[ end trace 1b75b31a2719ed1c ]---
> Reprogramming SDRC clock to 332000000 Hz
> GPMC revision 5.0
> 
> Do you know the reason and how to solve it?
> Thanks & regards
> Arno


- Paul
