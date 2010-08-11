From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/4] initial support for LogicPD's OMAP3 SOM andTORPEDO
	development kits
Date: Wed, 11 Aug 2010 20:57:55 +0200
Message-ID: <20100811185755.GA3527@merkur.ravnborg.org>
References: <20100811175450.GA17425@merkur.ravnborg.org> <77A0A4DB5BF2A44283E5522C27234AC6021C82D5@EDPRSRV011.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <77A0A4DB5BF2A44283E5522C27234AC6021C82D5@EDPRSRV011.logicpd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi Jacob.

Quick feedback!

You should teach your mailer better manners so it is
visible what you quote and what you answer.


> 
> > +static void __init omap3logic_init_irq(void)
> > +{
> > +	omap_board_config = omap3logic_config;
> > +	omap_board_config_size = ARRAY_SIZE(omap3logic_config);
> > +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> > +				mt46h32m32lf6_sdrc_params);
> > +	omap_init_irq();
> > +#ifdef CONFIG_OMAP_32K_TIMER
> > +	omap2_gp_clockevent_set_gptimer(12);
> > +#endif
> 
> Fix this on the called site. There is zero reason
> to sprinkle all user of omap2_gp_clockevent_set_gptimer()
> with ifdef/endif.
> 
> Will fix

I noticed other users of omap2_gp_clockevent_set_gptimer()
does the same ifdef/endif.
You should take care of them when you have a proper way to do so.
Obviously in another patch.

	Sam
