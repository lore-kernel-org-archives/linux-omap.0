From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH 14/26] ARM: OMAP3: clock: Add 3xxx data using common struct clk
Date: Thu, 8 Nov 2012 13:52:50 -0800
Message-ID: <20121108215250.17381.71505@nucleus>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
 <1352337181-29427-15-git-send-email-mturquette@ti.com>
 <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37694 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160Ab2KHVxL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 16:53:11 -0500
In-Reply-To: <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Quoting Paul Walmsley (2012-11-08 10:08:16)
> On Wed, 7 Nov 2012, Mike Turquette wrote:
> 
> > From: Rajendra Nayak <rnayak@ti.com>
> > 
> > The patch is the output from a python script which converts
> > from the old OMAP clk format to COMMON clk format using a
> > JSON parser in between which was developed by Paul Walmsley.
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > [paul@pwsan.com: AM3517/05: dropped bogus hsotgusb "ick" and "fck"
> >  clkdev aliases; added hsotgusb_fck alias; added emac_ick and emac_fck
> >  aliases; replace omap2_init_clksel_parent() with
> >  omap2_clksel_find_parent_index(); reflow macros and parent name
> >  lists; add clkdm_name argument to DEFINE_STRUCT_CLK_HW_OMAP macros]
> > Signed-off-by: Mike Turquette <mturquette@ti.com>
> 
> Am seeing warnings during the disable-unused-clocks phase of the boot
> on the OMAP3 test boards here.  Log is included at the bottom of this
> E-mail, with some debugging added for extra context.  The problem
> appears to be that the clock code is disabling clocks that are active
> in the hardware, but for which the clockdomain use count is 0, since
> they've never been enabled.
> 

Right.  The old omap2_disabled_unused_clocks code used to call
omap2_clk_enable before calling omap2_clk_disable.  That approach is
sort of "cooking the books" and the generic implementation in
drivers/clk/clk.c simply disables the clocks (without first enabling),
which is why these WARNs are new.

> Ideally there would be some way for the core CCF code to indicate to the 
> underlying clock hardware implementation that the disable-unused-clock 
> process is a 'force disable'.  The OMAP clock hardware implementation code 
> could then also put the clockdomain to sleep (and skip the warning) in 
> such a circumstance.
> 

I'm looking at a few different ways to do that now.

Regards,
Mike

> 
> - Paul
> 
> [    2.685943] disabling sys_clkout1: ec = 0
> [    2.690277] disabling wdt1_ick: ec = 0
> [    2.694366] disabling cam_mclk: ec = 0
> [    2.698333] ------------[ cut here ]------------
> [    2.703216] WARNING: at arch/arm/mach-omap2/clockdomain.c:961 _clkdm_clk_hwmod_disable+0xc4/0xd8()
> [    2.712646] Modules linked in:
> [    2.715911] [<c001c38c>] (unwind_backtrace+0x0/0xf0) from [<c0043cd8>] (warn_slowpath_common+0x4c/0x64)
> [    2.725799] [<c0043cd8>] (warn_slowpath_common+0x4c/0x64) from [<c0043d0c>] (warn_slowpath_null+0x1c/0x24)
> [    2.735961] [<c0043d0c>] (warn_slowpath_null+0x1c/0x24) from [<c003705c>] (_clkdm_clk_hwmod_disable+0xc4/0xd8)
> [    2.746520] [<c003705c>] (_clkdm_clk_hwmod_disable+0xc4/0xd8) from [<c0437bd0>] (clk_disable_unused_subtree+0xb0/0xbc)
> [    2.757781] [<c0437bd0>] (clk_disable_unused_subtree+0xb0/0xbc) from [<c0437b40>] (clk_disable_unused_subtree+0x20/0xbc)
> [    2.769226] ---[ end trace ebefd5468131571a ]---
> [    2.774261] disabling mspro_fck: ec = 0
> [    2.778320] disabling ssi_ssr_fck_3430es2: ec = 0
> [    2.783355] disabling pka_ick: ec = 0
> [    2.787231] disabling sad2d_ick: ec = 0
> [    2.791259] ------------[ cut here ]------------
> [    2.796142] WARNING: at arch/arm/mach-omap2/clockdomain.c:961 _clkdm_clk_hwmod_disable+0xc4/0xd8()
> [    2.805572] Modules linked in:
> [    2.808807] [<c001c38c>] (unwind_backtrace+0x0/0xf0) from [<c0043cd8>] (warn_slowpath_common+0x4c/0x64)
> [    2.818695] [<c0043cd8>] (warn_slowpath_common+0x4c/0x64) from [<c0043d0c>] (warn_slowpath_null+0x1c/0x24)
> [    2.828857] [<c0043d0c>] (warn_slowpath_null+0x1c/0x24) from [<c003705c>] (_clkdm_clk_hwmod_disable+0xc4/0xd8)
> [    2.839416] [<c003705c>] (_clkdm_clk_hwmod_disable+0xc4/0xd8) from [<c0437bd0>] (clk_disable_unused_subtree+0xb0/0xbc)
> [    2.850677] [<c0437bd0>] (clk_disable_unused_subtree+0xb0/0xbc) from [<c0437b40>] (clk_disable_unused_subtree+0x20/0xbc)
> [    2.862121] ---[ end trace ebefd5468131571b ]---
> [    2.867065] disabling wdt3_ick: ec = 0
> [    2.871032] disabling des1_ick: ec = 0
> [    2.875030] disabling sha11_ick: ec = 0
> [    2.879089] disabling rng_ick: ec = 0
> [    2.882995] disabling aes1_ick: ec = 0
> [    2.886932] disabling ssi_ick_3430es2: ec = 0
> [    2.891601] disabling mspro_ick: ec = 0
> [    2.895660] disabling des2_ick: ec = 0
> [    2.899658] disabling sha12_ick: ec = 0
> [    2.903686] disabling aes2_ick: ec = 0
> [    2.907684] disabling icr_ick: ec = 0
> [    2.911621] disabling wdt3_fck: ec = 0
