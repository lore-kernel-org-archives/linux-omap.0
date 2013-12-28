From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP display subsystem - does it work?
Date: Sat, 28 Dec 2013 23:30:53 +0000
Message-ID: <20131228233053.GJ32243@n2100.arm.linux.org.uk>
References: <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com> <20131219175644.GE32243@n2100.arm.linux.org.uk> <20131219182252.GP27438@atomide.com> <20131220112700.GF32243@n2100.arm.linux.org.uk> <20131220114837.GH32243@n2100.arm.linux.org.uk> <52B44982.4020501@ti.com> <20131220160432.GZ27438@atomide.com> <20131220165456.GD27438@atomide.com> <20131221005941.GI32243@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54973 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751037Ab3L1XbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 28 Dec 2013 18:31:03 -0500
Content-Disposition: inline
In-Reply-To: <20131221005941.GI32243@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org

On Sat, Dec 21, 2013 at 12:59:41AM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 20, 2013 at 08:55:03AM -0800, Tony Lindgren wrote:
> > Yeah this seems to do the trick for me for the built-in DSS on LDP.
> > 
> > Tony
> > 
> > 8< -----------------------------------
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Fri, 20 Dec 2013 08:53:27 -0800
> > Subject: [PATCH] ARM: OMAP2+: Fix LCD panel backlight regression for LDP legacy booting
> > 
> > Looks like the LCD panel on LDP has been broken quite a while, and
> > recently got fixed. However, there's still an issue where the panel
> > backlight does not come on if the LCD drivers are built into the
> > kernel.
> > 
> > Fix the issue by registering the DPI LCD panel only after the twl4030
> > GPIO has probed.
> > 
> > Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > --- a/arch/arm/mach-omap2/board-ldp.c
> > +++ b/arch/arm/mach-omap2/board-ldp.c
> > @@ -248,7 +248,7 @@ static int ldp_twl_gpio_setup(struct device *dev, unsigned gpio, unsigned ngpio)
> >  	/* Backlight enable GPIO */
> >  	ldp_lcd_pdata.backlight_gpio = gpio + 15;
> >  
> > -	return 0;
> > +	return platform_device_register(&ldp_lcd_device);
> >  }
> >  
> >  static struct twl4030_gpio_platform_data ldp_gpio_data = {
> > @@ -346,7 +346,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
> >  
> >  static struct platform_device *ldp_devices[] __initdata = {
> >  	&ldp_gpio_keys_device,
> > -	&ldp_lcd_device,
> >  };
> >  
> >  #ifdef CONFIG_OMAP_MUX
> 
> I've added it to the test build for tonight (only as an uncommitted
> modification) so we'll see what happens tomorrow morning.

BTW, yes, this does result in the display working again on the LDP.
