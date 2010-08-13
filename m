From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH] OMAP2PLUS: Fix Sparse errors/warnings in mach-omap2
Date: Fri, 13 Aug 2010 16:09:21 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270AE92CD@dbde02.ent.ti.com>
References: <1281687720-5482-1-git-send-email-manjugk@ti.com>
 <4C651189.2080509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34323 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761445Ab0HMKj0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 06:39:26 -0400
In-Reply-To: <4C651189.2080509@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>



> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Friday, August 13, 2010 3:04 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Tony Lindgren
> Subject: Re: [PATCH] OMAP2PLUS: Fix Sparse errors/warnings in 
> mach-omap2
> 
> G, Manjunath Kondaiah had written, on 08/13/2010 03:22 AM, 
> the following:
> > This patch fixes sparse errors/warnings for all the files
> > in mach-omap2 directory.
> > 
> > Build tested for omap3_defconfig and boot tested on OMAP4 
> SDP and beagle
> > board.
> > 
> > sparse warnings which are fixed with this patch:
> > 
> > arch/arm/mach-omap2/control.c:88:6: warning: symbol 
> 'omap3_secure_ram_storage' was not declared. Should it be static?
> > arch/arm/mach-omap2/control.c:195:16: warning: incorrect 
> type in assignment (different address spaces)
> > arch/arm/mach-omap2/control.c:195:16:    expected unsigned 
> int [usertype] *v_addr
> > arch/arm/mach-omap2/control.c:195:16:    got void [noderef] 
> <asn:2>*<noident>
> > arch/arm/mach-omap2/control.c:199:25: warning: incorrect 
> type in argument 1 (different address spaces)
> > arch/arm/mach-omap2/control.c:199:25:    expected void 
> const volatile [noderef] <asn:2>*<noident>
> > arch/arm/mach-omap2/control.c:199:25:    got unsigned int 
> [usertype] *
> > arch/arm/mach-omap2/control.c:320:28: warning: incorrect 
> type in assignment (different address spaces)
> > arch/arm/mach-omap2/control.c:320:28:    expected void 
> *[noderef] <asn:2>scratchpad_address
> > arch/arm/mach-omap2/control.c:320:28:    got void [noderef] 
> <asn:2>*<noident>
> > arch/arm/mach-omap2/control.c:321:9: warning: incorrect 
> type in argument 1 (different address spaces)
> > arch/arm/mach-omap2/control.c:321:9:    expected void 
> volatile [noderef] <asn:2>*<noident>
> > arch/arm/mach-omap2/control.c:321:9:    got void *[noderef] 
> <asn:2>scratchpad_address
> > arch/arm/mach-omap2/control.c:324:9: warning: incorrect 
> type in argument 1 (different address spaces)
> > arch/arm/mach-omap2/control.c:324:9:    expected void 
> volatile [noderef] <asn:2>*<noident>
> > arch/arm/mach-omap2/control.c:324:9:    got void *
> > arch/arm/mach-omap2/control.c:327:9: warning: incorrect 
> type in argument 1 (different address spaces)
> > arch/arm/mach-omap2/control.c:327:9:    expected void 
> volatile [noderef] <asn:2>*<noident>
> > arch/arm/mach-omap2/control.c:327:9:    got void *
> > arch/arm/mach-omap2/control.c:334:9: warning: incorrect 
> type in argument 1 (different address spaces)
> > arch/arm/mach-omap2/control.c:334:9:    expected void 
> volatile [noderef] <asn:2>*<noident>
> > arch/arm/mach-omap2/control.c:334:9:    got void *
> > arch/arm/mach-omap2/control.c:321:9: warning: dereference 
> of noderef expression
> > arch/arm/mach-omap2/control.c:324:9: warning: dereference 
> of noderef expression
> > arch/arm/mach-omap2/control.c:327:9: warning: dereference 
> of noderef expression
> > arch/arm/mach-omap2/control.c:334:9: warning: dereference 
> of noderef expression
> > 
> > arch/arm/mach-omap2/timer-gp.c:50:22: warning: symbol 
> 'gptimer_wakeup' was not declared. Should it be static?
> > arch/arm/mach-omap2/timer-gp.c:115:12: warning: symbol 
> 'omap2_gp_clockevent_set_gptimer' was not declared. Should it 
> be static?
> > arch/arm/mach-omap2/timer-gp.c:240:18: warning: symbol 
> 'omap_timer' was not declared. Should it be static?
> > 
> > arch/arm/mach-omap2/irq.c:50:35: warning: Using plain 
> integer as NULL pointer
> > 
> > arch/arm/mach-omap2/powerdomain.c:993:5: warning: symbol 
> 'pwrdm_set_lowpwrstchange' was not declared. Should it be static?
> > 
> > arch/arm/mach-omap2/mux2430.c:589:29: warning: symbol 
> 'omap2430_pop_ball' was not declared. Should it be static?
> > 
> > arch/arm/mach-omap2/mux34xx.c:934:28: warning: symbol 
> 'omap3_cus_subset' was not declared. Should it be static?
> > arch/arm/mach-omap2/mux34xx.c:1080:29: warning: symbol 
> 'omap3_cus_ball' was not declared. Should it be static?
> > arch/arm/mach-omap2/mux34xx.c:1272:28: warning: symbol 
> 'omap3_cbb_subset' was not declared. Should it be static?
> > arch/arm/mach-omap2/mux34xx.c:1393:29: warning: symbol 
> 'omap3_cbb_ball' was not declared. Should it be static?
> > arch/arm/mach-omap2/mux34xx.c:1603:28: warning: symbol 
> 'omap36xx_cbp_subset' was not declared. Should it be static?
> > arch/arm/mach-omap2/mux34xx.c:1821:29: warning: symbol 
> 'omap36xx_cbp_ball' was not declared. Should it be static?
> > 
> > arch/arm/mach-omap2/pm34xx.c:323:28: warning: incorrect 
> type in assignment (different address spaces)
> > arch/arm/mach-omap2/pm34xx.c:323:28:    expected unsigned 
> int [usertype] *scratchpad_address
> > arch/arm/mach-omap2/pm34xx.c:323:28:    got void [noderef] 
> <asn:2>*<noident>
> > arch/arm/mach-omap2/pm34xx.c:326:26: warning: incorrect 
> type in argument 1 (different address spaces)
> > arch/arm/mach-omap2/pm34xx.c:326:26:    expected void const 
> volatile [noderef] <asn:2>*<noident>
> > arch/arm/mach-omap2/pm34xx.c:326:26:    got unsigned int 
> [usertype] *
> > arch/arm/mach-omap2/pm34xx.c:329:26: warning: incorrect 
> type in argument 1 (different address spaces)
> > arch/arm/mach-omap2/pm34xx.c:329:26:    expected void const 
> volatile [noderef] <asn:2>*<noident>
> > arch/arm/mach-omap2/pm34xx.c:329:26:    got unsigned int 
> [usertype] *
> > arch/arm/mach-omap2/pm34xx.c:334:29: warning: incorrect 
> type in argument 1 (different address spaces)
> > arch/arm/mach-omap2/pm34xx.c:334:29:    expected void const 
> volatile [noderef] <asn:2>*<noident>
> > arch/arm/mach-omap2/pm34xx.c:334:29:    got unsigned int 
> [usertype] *
> > 
> > arch/arm/mach-omap2/pm-debug.c:165:15: warning: symbol 
> 'pm_dbg_dir' was not declared. Should it be static?
> > 
> > arch/arm/mach-omap2/board-flash.c:141:8: warning: symbol 
> 'board_nand_init' was not declared. Should it be static?
> > 
> > arch/arm/mach-omap2/board-omap3evm.c:590:30: warning: 
> symbol 'ads7846_config' was not declared. Should it be static?
> > arch/arm/mach-omap2/board-omap3evm.c:609:23: warning: 
> symbol 'omap3evm_spi_board_info' was not declared. Should it 
> be static?
> > 
> > arch/arm/mach-omap2/board-n8x0.c:416:6: warning: symbol 
> 'n8x0_mmc_slot1_cover_handler' was not declared. Should it be static?
> > arch/arm/mach-omap2/board-n8x0.c:544:13: warning: symbol 
> 'n8x0_mmc_init' was not declared. Should it be static?
> > arch/arm/mach-omap2/board-rx51-sdram.c:46:25: warning: 
> symbol 'rx51_sdrc_params' was not declared. Should it be static?
> > arch/arm/mach-omap2/board-rx51-sdram.c:211:25: warning: 
> symbol 'rx51_get_sdram_timings' was not declared. Should it be static?
> > 
> > arch/arm/mach-omap2/board-rx51-peripherals.c:902:13: 
> warning: symbol 'rx51_peripherals_init' was not declared. 
> Should it be static?
> > arch/arm/mach-omap2/board-rx51-video.c:107:13: warning: 
> symbol 'rx51_video_mem_init' was not declared. Should it be static?
> > arch/arm/mach-omap2/board-zoom-debugboard.c:155:12: 
> warning: symbol 'zoom_debugboard_init' was not declared. 
> Should it be static?
> > arch/arm/mach-omap2/board-zoom-peripherals.c:280:13: 
> warning: symbol 'zoom_peripherals_init' was not declared. 
> Should it be static?
> > 
> > arch/arm/mach-omap2/board-igep0020.c:110:13: warning: 
> symbol 'igep2_flash_init' was not declared. Should it be static?
> > arch/arm/mach-omap2/board-omap3touchbook.c:64:15: warning: 
> symbol 'touchbook_revision' was not declared. Should it be static?
> > 
> > arch/arm/mach-omap2/board-am3517evm.c:109:6: warning: 
> symbol 'am3517_evm_ethernet_init' was not declared. Should it 
> be static?
> > arch/arm/mach-omap2/board-am3517evm.c:350:24: warning: 
> symbol 'am3517_evm_dss_device' was not declared. Should it be static?
> > arch/arm/mach-omap2/board-am3517evm.c:141:17: warning: 
> Initializer entry defined twice
> > arch/arm/mach-omap2/board-am3517evm.c:142:18:   also defined here
> > 
> > Signed-off-by: Manjunatha GK <manjugk@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/board-am3517evm.c          |    5 +--
> >  arch/arm/mach-omap2/board-igep0020.c           |    4 +-
> >  arch/arm/mach-omap2/board-n8x0.c               |   16 +------------
> >  arch/arm/mach-omap2/board-omap3evm.c           |    4 +-
> >  arch/arm/mach-omap2/board-omap3stalker.c       |    2 +-
> >  arch/arm/mach-omap2/board-omap3touchbook.c     |    2 +-
> >  arch/arm/mach-omap2/board-rx51-peripherals.c   |    2 +
> >  arch/arm/mach-omap2/board-rx51-sdram.c         |    2 +-
> >  arch/arm/mach-omap2/board-rx51-video.c         |    2 +
> >  arch/arm/mach-omap2/board-rx51.c               |    2 +
> >  arch/arm/mach-omap2/board-zoom-debugboard.c    |    2 +
> >  arch/arm/mach-omap2/board-zoom-peripherals.c   |    2 +
> >  arch/arm/mach-omap2/control.c                  |    5 ++-
> >  arch/arm/mach-omap2/include/mach/board-flash.h |    2 +
> >  arch/arm/mach-omap2/include/mach/board-rx51.h  |   11 +++++++++
> >  arch/arm/mach-omap2/irq.c                      |    2 +-
> >  arch/arm/mach-omap2/mux2420.c                  |    2 +-
> >  arch/arm/mach-omap2/mux2430.c                  |    2 +-
> >  arch/arm/mach-omap2/mux34xx.c                  |   12 +++++-----
> >  arch/arm/mach-omap2/pm-debug.c                 |    2 +-
> >  arch/arm/mach-omap2/pm34xx.c                   |    2 +-
> >  arch/arm/mach-omap2/powerdomain.c              |   28 
> ------------------------
> >  arch/arm/mach-omap2/prcm.c                     |    2 +-
> >  arch/arm/mach-omap2/timer-gp.c                 |    2 +
> >  arch/arm/plat-omap/include/plat/board.h        |    2 +-
> >  arch/arm/plat-omap/include/plat/dmtimer.h      |    4 ++-
> >  arch/arm/plat-omap/include/plat/sdrc.h         |    1 +
> >  27 files changed, 55 insertions(+), 69 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/include/mach/board-rx51.h
> 
> 
> could we at least split this into each area at least?
> patch 1- fix sparse for static variables
> patch 2 - fix sparse warnings functions that should have been static
> patch 3 - fix specific warnings/errors?
> 
> makes this patch at least readable in some context.. this patch in 
> effect is almost equivalent to -> fix all build warnings on 
> arch/arm/mach-omap2...

Don't you think we will have too many patches once we fix all the sparse 
warnings for omap related code?

In fact, I was thinking to combine all sparse warning fixes in mach-omap2 
and plat-omap directories with single patch. But, decided to separate 
out for mach-omap2 and plat-omap.

Tony, any comments? I am ok to split this patch if it increases readability.

-Manjunath