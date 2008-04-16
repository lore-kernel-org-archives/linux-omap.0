From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap2/pm.c build errors
Date: Wed, 16 Apr 2008 14:44:27 -0700
Message-ID: <20080416214427.GP17055@atomide.com>
References: <200804161150.20609.david-b@pacbell.net> <20080416211200.GJ17055@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:53395 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932758AbYDPVo2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 17:44:28 -0400
Content-Disposition: inline
In-Reply-To: <20080416211200.GJ17055@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080416 14:12]:
> * David Brownell <david-b@pacbell.net> [080416 11:51]:
> > arch/arm/mach-omap2/pm.c: In function 'pm_init_serial_console':
> > arch/arm/mach-omap2/pm.c:188: error: expected ';' before 'break'
> > arch/arm/mach-omap2/pm.c:191: error: expected ';' before 'break'
> > arch/arm/mach-omap2/pm.c:193: error: 'PM_WKEN2' undeclared (first use in this function)
> > arch/arm/mach-omap2/pm.c:193: error: (Each undeclared identifier is reported only once
> > arch/arm/mach-omap2/pm.c:193: error: for each function it appears in.)
> > arch/arm/mach-omap2/pm.c:194: error: expected ';' before 'break'
> > 
> > 
> > ... wasn't there a patch for this?  That's with current GIT.
> 
> Hmmm, I don't think so.

Actually, yes, there's a patch from Hiroshi for this, will apply
that one.

> > The "no semicolons after function calls" fix is obvious (and
> > is also a "that patch was never build-tested), but WKEN2 is
> > not quite clear (but see my guess below).
> 
> Heh, this looks easy to miss as it's behind CONFIG_PM_DEBUG :)
> 
> FYI, the PM code will be split to common pm.c and pm24xx.c and
> pm34xx.c most likely. Then all the serial PM debug code will get
> moved to serial driver.
> 
> Care to S-o-b: this patch?
> 
> Tony
> 
> > 
> > 
> > --- a/arch/arm/mach-omap2/pm.c
> > +++ b/arch/arm/mach-omap2/pm.c
> > @@ -184,13 +184,13 @@ static void pm_init_serial_console(void)
> >  	}
> >  	switch (serial_console_uart) {
> >  	case 1:
> > -		prm_set_mod_reg_bits(OMAP24XX_ST_UART1, CORE_MOD, PM_WKEN1)
> > +		prm_set_mod_reg_bits(OMAP24XX_ST_UART1, CORE_MOD, PM_WKEN1);
> >  		break;
> >  	case 2:
> > -		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, CORE_MOD, PM_WKEN1)
> > +		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, CORE_MOD, PM_WKEN1);
> >  		break;
> >  	case 3:
> > -		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD, PM_WKEN2)
> > +		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, CORE_MOD, OMAP24XX_PM_WKEN2);
> >  		break;
> >  	}
> >  }
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
