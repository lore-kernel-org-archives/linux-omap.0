From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] OMAP3EVM: Made backlight GPIO default state to off
Date: Thu, 1 Apr 2010 03:23:21 -0700
Message-ID: <20100401102321.GN31200@atomide.com>
References: <hvaibhav@ti.com>
 <1269263470-13814-1-git-send-email-hvaibhav@ti.com>
 <19F8576C6E063C45BE387C64729E7394044DEBF3A5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52876 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab0DAKVb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 06:21:31 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DEBF3A5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [100330 01:07]:
> 
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Monday, March 22, 2010 6:41 PM
> > To: linux-omap@vger.kernel.org
> > Cc: tomi.valkeinen@nokia.com; tony@atomide.com; Hiremath, Vaibhav
> > Subject: [PATCH 1/2] OMAP3EVM: Made backlight GPIO default state to off
> > 
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > 
> > If you choose default output to DVI, the LCD backlight still
> > gets powered, since panel->disable function never gets called for LCD.
> > 
> > So, during init put backlight GPIO to off state and the driverr
> > code will decide which output to enable explicitly.
> > 
> [Hiremath, Vaibhav] Tony,
> 
> Do you see any issues with this patch? I think we can merge this patch series.

Looks like a valid fix to me.

Tony
 
> Thanks,
> Vaibhav
> 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> > omap2/board-omap3evm.c
> > index 74bbdcb..f2a52c3 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -420,7 +420,10 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
> > 
> >  	/* TWL4030_GPIO_MAX + 0 == ledA, LCD Backlight control */
> >  	gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
> > -	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> > +	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
> > +		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
> > +	else
> > +		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> > 
> >  	/* gpio + 7 == DVI Enable */
> >  	gpio_request(gpio + 7, "EN_DVI");
> > --
> > 1.6.2.4
> 
