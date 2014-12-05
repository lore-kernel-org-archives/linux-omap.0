From: Tony Lindgren <tony@atomide.com>
Subject: regression: Clock changes in next-20141205 break at least omap4
Date: Fri, 5 Dec 2014 08:55:39 -0800
Message-ID: <20141205165539.GA30437@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24651 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750934AbaLEQ5p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2014 11:57:45 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Michael Turquette <mturquette@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>

Hi,

Looks like commit 646cafc6aa4d ("clk: Change clk_ops->determine_rate
to return a clk_hw as the best parent") breaks booting at least for
omap4.

Below is the output from omap4-sdp with DEBUG_LL and earlyprintk
enabled.

Regards,

Tony

[    1.670806] clock: dpll_abe_ck failed transition to 'locked'
[    2.966735] clock: dpll_abe_ck failed transition to 'locked'
[    4.262634] clock: dpll_abe_ck failed transition to 'locked'
[    4.268554] ------------[ cut here ]------------
[    4.273406] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:846 clk_disable+0x24/0x30()
[    4.281341] Modules linked in:
[    4.284576] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.18.0-rc7-next-20141205-00004-g24aaa63b #141
[    4.293945] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    4.300231] [<c0015614>] (unwind_backtrace) from [<c0011cdc>] (show_stack+0x10/0x14)
[    4.308288] [<c0011cdc>] (show_stack) from [<c05b7fb8>] (dump_stack+0x80/0x9c)
[    4.315795] [<c05b7fb8>] (dump_stack) from [<c003e4e8>] (warn_slowpath_common+0x78/0xb4)
[    4.324188] [<c003e4e8>] (warn_slowpath_common) from [<c003e540>] (warn_slowpath_null+0x1c/0x24)
[    4.333282] [<c003e540>] (warn_slowpath_null) from [<c04c386c>] (clk_disable+0x24/0x30)
[    4.341583] [<c04c386c>] (clk_disable) from [<c00252a0>] (_disable_clocks+0x18/0x68)
[    4.349609] [<c00252a0>] (_disable_clocks) from [<c0026810>] (_idle+0x15c/0x240)
[    4.357299] [<c0026810>] (_idle) from [<c0844cb8>] (_setup+0x174/0x22c)
[    4.364166] [<c0844cb8>] (_setup) from [<c0026c4c>] (omap_hwmod_for_each+0x30/0x5c)
[    4.372131] [<c0026c4c>] (omap_hwmod_for_each) from [<c08450c4>] (__omap_hwmod_setup_all+0x30/0x40)
[    4.381500] [<c08450c4>] (__omap_hwmod_setup_all) from [<c0008b44>] (do_one_initcall+0x80/0x1d4)
[    4.390594] [<c0008b44>] (do_one_initcall) from [<c0837e9c>] (kernel_init_freeable+0x1f4/0x2cc)
[    4.399627] [<c0837e9c>] (kernel_init_freeable) from [<c05b211c>] (kernel_init+0x8/0xe4)
[    4.408020] [<c05b211c>] (kernel_init) from [<c000ea48>] (ret_from_fork+0x14/0x2c)
[    4.415954] ---[ end trace f968bc068c5b0ccc ]---
[    5.710815] clock: dpll_abe_ck failed transition to 'locked'
[    7.006744] clock: dpll_abe_ck failed transition to 'locked'

