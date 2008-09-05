From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: Fix Nokia N8x0 second I2C bus device
	registration
Date: Fri, 5 Sep 2008 09:11:50 -0700
Message-ID: <20080905161149.GB24202@atomide.com>
References: <1220274304-23744-1-git-send-email-jarkko.nikula@nokia.com> <20080901191130.GA8837@kos.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57387 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbYIEQL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 12:11:59 -0400
Content-Disposition: inline
In-Reply-To: <20080901191130.GA8837@kos.to>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

* Riku Voipio <riku.voipio@iki.fi> [080901 12:12]:
> On Mon, Sep 01, 2008 at 04:05:04PM +0300, Jarkko Nikula wrote:
> > - TSL2563 and LP5521 are found only in N810
> > - Fix one typo
> 
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> 
> Acked-by: Riku voipio <riku.voipio@iki.fi>

Pushing today.

Tony

> 
> > ---
> >  arch/arm/mach-omap2/board-n800.c |   14 +++++++-------
> >  1 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
> > index 95cc84a..1df9f3d 100644
> > --- a/arch/arm/mach-omap2/board-n800.c
> > +++ b/arch/arm/mach-omap2/board-n800.c
> > @@ -649,12 +649,6 @@ static struct i2c_board_info __initdata_or_module n8x0_i2c_board_info_2[] = {
> >  		.platform_data = &n800_tcm825x_platform_data,
> >  #endif
> >  	},
> > -	{
> > -		I2C_BOARD_INFO("tsl2563", 0x29),
> > -	},
> > -	{
> > -		I2C_BOARD_INFO("lp5521", 0x32),
> > -	},
> >  };
> >  
> >  
> > @@ -670,6 +664,12 @@ static struct i2c_board_info __initdata_or_module n810_i2c_board_info_2[] = {
> >  		.irq		= OMAP_GPIO_IRQ(109),
> >  		.platform_data	= &lm8323_pdata,
> >  	},
> > +	{
> > +		I2C_BOARD_INFO("tsl2563", 0x29),
> > +	},
> > +	{
> > +		I2C_BOARD_INFO("lp5521", 0x32),
> > +	},
> >  };
> >  
> >  void __init nokia_n800_common_init(void)
> > @@ -694,7 +694,7 @@ void __init nokia_n800_common_init(void)
> >  	omap_register_i2c_bus(1, 400, n800_i2c_board_info_1,
> >  			      ARRAY_SIZE(n800_i2c_board_info_1));
> >  	omap_register_i2c_bus(2, 400, n8x0_i2c_board_info_2,
> > -			      ARRAY_SIZE(n800_i2c_board_info_2));
> > +			      ARRAY_SIZE(n8x0_i2c_board_info_2));
> >  	if (machine_is_nokia_n800())
> >  		i2c_register_board_info(2, n800_i2c_board_info_2,
> >  			ARRAY_SIZE(n800_i2c_board_info_2));
> > -- 
> > 1.5.6.3
> 
> -- 
> "rm -rf" only sounds scary if you don't have backups
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
