From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Thu, 18 Dec 2014 08:41:23 -0800
Message-ID: <20141218164122.GH23854@atomide.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13006 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbaLRQoR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2014 11:44:17 -0500
Content-Disposition: inline
In-Reply-To: <20141217172333.GE23854@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joel Fernandes <joelf@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Nishanth Menon <nm@ti.com>

* Tony Lindgren <tony@atomide.com> [141217 09:28]:
> 
> And then there are these too in the current mainline that are
> clock related:
> 
> omap4xxx_dt_clk_init: failed to configure ABE DPLL!
> ...
> clock: dpll_abe_ck failed transition to 'locked'
> clock: dpll_abe_ck failed transition to 'locked'
> clock: dpll_abe_ck failed transition to 'locked'
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:851 clk_disable+0x24/0x30()
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.18.0-09274-g53c5279 #699
> Hardware name: Generic OMAP4 (Flattened Device Tree)
> [<c00154b4>] (unwind_backtrace) from [<c0011b7c>] (show_stack+0x10/0x14)
> [<c0011b7c>] (show_stack) from [<c05d5068>] (dump_stack+0x80/0x9c)
> [<c05d5068>] (dump_stack) from [<c003e104>] (warn_slowpath_common+0x78/0xb4)
> [<c003e104>] (warn_slowpath_common) from [<c003e15c>] (warn_slowpath_null+ 0x1c/0x24)
> [<c003e15c>] (warn_slowpath_null) from [<c04dfc1c>] (clk_disable+0x24/0x30)
> [<c04dfc1c>] (clk_disable) from [<c0024ea0>] (_disable_clocks+0x18/0x68)
> [<c0024ea0>] (_disable_clocks) from [<c0026410>] (_idle+0x15c/0x240)
> [<c0026410>] (_idle) from [<c086fc48>] (_setup+0x174/0x22c)
> [<c086fc48>] (_setup) from [<c002684c>] (omap_hwmod_for_each+0x30/0x5c)
> [<c002684c>] (omap_hwmod_for_each) from [<c0870054>] (__omap_hwmod_setup_all+0x30/0x40)
> [<c0870054>] (__omap_hwmod_setup_all) from [<c00089e4>] (do_one_initcall+0x80/0x1d8)
> [<c00089e4>] (do_one_initcall) from [<c0862ea4>] (kernel_init_freeable+0x1f4/0x2cc)
> [<c0862ea4>] (kernel_init_freeable) from [<c05cf184>] (kernel_init+0x8/0xe4)
> [<c05cf184>] (kernel_init) from [<c000e8e8>] (ret_from_fork+0x14/0x2c)
> ---[ end trace f0d1b75165d8ef11 ]---
> clock: dpll_abe_ck failed transition to 'locked'
> clock: dpll_abe_ck failed transition to 'locked'
> ...
> 
> Tero & Tomi, can you please look into these clock issues above?

FYI, looks like merging Mike's pending clk-next to current mainline
somehow fixes the clock issues above. It seems the audio changes
depended on changes in clk-next?

Regards,

Tony
