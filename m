From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Fri, 31 Oct 2008 09:35:03 -0700
Message-ID: <20081031163503.GF13227@atomide.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <200810302012.35317.david-b@pacbell.net> <20081031033936.GC13227@atomide.com> <200810302341.24275.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52341 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbYJaQfJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 12:35:09 -0400
Content-Disposition: inline
In-Reply-To: <200810302341.24275.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081030 23:41]:
> On Thursday 30 October 2008, Tony Lindgren wrote:
> > * David Brownell <david-b@pacbell.net> [081030 20:12]:
> > >
> > > Related:  shouldn't hsmmc_init() accept a set of params, maybe even a struct,
> > > describing how each controller is wired?
> > > 
> > > 	- which controller (1, 2, 3)
> > > 	- how many data wires are used (1, 4, 8)
> > > 	- supported voltages (mask)
> > > 	- card detect gpio (or negative) ... assume gpio_to_irq(gpio) works
> > > 	- write protect gpio (or negative)
> > > 	- callback for updating the voltages
> > > 
> > > That would support more complete functionality ... and get away from
> > > the current hard-wiring of most of those parameters.
> > 
> > Yeah I don't know what the right solution is.. I was thinking about
> > passing the struct omap_mmc_platform_data to hsmmc_init, but then
> > again hsmmc.c does not know anything about the custom configurations
> > and the power functions. So right now hsmmc.c would only call
> > omap2_init_mmc() with the custom struct omap_mmc_platform_data.
> 
> Part of it is that "hsmmc.c" is really twl4030-specific glue,
> but it's misnamed as being more generic.
> 
> Glue to other kinds of interface should call omap2_init_mmc()
> directly ... the issue here is that the twl-specific stuff isn't
> quite generic enough yet.

OK, good point. Let's rename it to twl4030-hsmmc.c or something like
that.

> > Maybe we should just let the boards with non-standarad wiring additionally
> > initialize the other mmc controllers from board-*.c by calling
> > omap2_init_mmc()?
> 
> How about this instead:  boards pass an __initdata struct in, not a
> mask, and it's used to set up the current omap_mmc_platform_data.
> Struct should handle common TWL wiring options; maybe:
> 
> 	struct twl4030_hsmmc_info {
> 		u8	mmc;		/* controller 1/2/3 */
> 		u8	wires;		/* 1/4/8 wires */
> 		u8	twl_reg;	/* vmmc1/vmmc2 */
> 		bool	cd_debounce;	/* in case cd isn't on twl4030 */
> 		int	gpio_cd;	/* or -EINVAL */
> 		int	gpio_wp;	/* or -EINVAL */
> 	};
> 
> So for example Beagle would only set up MMC-1, 8-wires, VMMC1,
> debounced TWL GPIO-0 for CD, and some OMAP GPIO for WP ... while
> Overo would do the same with 4-wires and a different GPIO, then
> call hsmmc_init() again with a second struct for MMC-2, 4-wires,
> VMMC2, no CD, no WP.
> 
> That should be a simple tweak on top of what you've just sent,

Sounds good to me. The twl4030 voltages may require further
options, but that can be added later.

Tony
