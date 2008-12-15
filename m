From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] TPS6235x driver added into the power regulator framework
Date: Mon, 15 Dec 2008 10:59:13 +0000
Message-ID: <20081215105912.GB31145@sirena.org.uk>
References: <1228730882-22328-1-git-send-email-mani.pillai@ti.com> <20081208122240.GG5159@sirena.org.uk> <19F8576C6E063C45BE387C64729E739403ECC737F8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3596 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbYLOK7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 05:59:15 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECC737F8@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Dec 15, 2008 at 10:13:27AM +0530, Pillai, Manikandan wrote:

> Thanks for your comments.Pls find my responses inlined.

For posting on kernel lists you probably want to fix your mail client to
insert quote characters before the mail you're replying to - it makes
your mail much easier to read.  This may mean that you need separate
mail configuration for corporate e-mail.

> > +#if defined(CONFIG_OMAP3EVM_PR785)
> > +	omap_register_i2c_bus(1, 2600, tps_6235x_i2c_board_info,
> > +		ARRAY_SIZE(tps_6235x_i2c_board_info));
> > +#endif
> > +#if defined(CONFIG_TWL4030_CORE)
> >  	omap_register_i2c_bus(1, 2600, omap3evm_i2c_boardinfo,
> >  			ARRAY_SIZE(omap3evm_i2c_boardinfo));
> > +#endif

> Hrm.  If the relevant chips have ID registers it's probably possible to
> detect which is present at run time in which case there should be one
> set of board info.  If they don't and the code needs to be exclusive it
> might be better to express that here.

> [Pillai, Manikandan] It's not possible to have a runtime check for this board
> I can put in a comment here to make it clearer.

You probably want a series of if/elses here or to have a check which
does #error if both are defined.

> > -config TWL4030_CORE
> > -	bool "Texas Instruments TWL4030/TPS659x0 Support"
> > -	depends on I2C=y && GENERIC_HARDIRQS

> This should be left here - there's nothing specific to the board about
> this configuration at all.

> [Pillai, Manikandan] This was one of the comments from Dave to move it
> To arch/arm/mach-omap2. The intention was that two power boards options
>  can be provided for the OMAP3 board. Pls let me know if I have to have
> the PR785 option for power where should I adding it in the Kconfig hierarchy

You've substantially misunderstood Dave's comment here.  You should move
the selection of power boards to the architecture file, not the user
visible configuration options for the chips.

> > +/* Device addresses for PR785 card */
> > +#define	PR785_62352_CORE_ADDR	0x4A
> > +#define	PR785_62353_MPU_ADDR	0x48

> This and all the other PR785 support shouldn't be in this driver, it
> should be in a separate PR785 driver or the board driver.

> [Pillai, Manikandan] OK I will put the PR785 driver as a board driver in
> The arch/arm/mach-omap2/board-omap3evm.c or should I put it as a separate 
> File. I would prefer a separate file.

I'd tend to go with a separate file too, it's probably big enough.
