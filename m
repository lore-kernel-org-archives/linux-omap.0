From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 5/8] ARM: OMAP5: hwmod: Add ocp2scp3 and sata hwmods
Date: Thu, 13 Mar 2014 21:44:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1403132123070.25824@utopia.booyaka.com>
References: <1394187308-19622-1-git-send-email-rogerq@ti.com> <1394187308-19622-6-git-send-email-rogerq@ti.com> <20140312174703.GD1996@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140312174703.GD1996-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 12 Mar 2014, Tony Lindgren wrote:

> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [140307 02:18]:
> > From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> > 
> > Create hwmods for ocp2scp3 and sata modules.
> 
> Paul, does this look OK to you?

I didn't go over every entry with a magnifying glass, but did take a 
quick look at the sysc_offs and the clkdms - the basics look OK.

Acked-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>


- Paul

> 
> Regards,
> 
> Tony
>  
> > [Roger Q] Clean up.
> > 
> > CC: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> > CC: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> > CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 73 ++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> > 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> > index e297d62..227a69f 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> > @@ -1726,6 +1726,77 @@ static struct omap_hwmod omap54xx_wd_timer2_hwmod = {
> >  	},
> >  };
> >  
> > +/*
> > + * 'ocp2scp' class
> > + * bridge to transform ocp interface protocol to scp (serial control port)
> > + * protocol
> > + */
> > +/* ocp2scp3 */
> > +static struct omap_hwmod omap54xx_ocp2scp3_hwmod;
> > +/* l4_cfg -> ocp2scp3 */
> > +static struct omap_hwmod_ocp_if omap54xx_l4_cfg__ocp2scp3 = {
> > +	.master		= &omap54xx_l4_cfg_hwmod,
> > +	.slave		= &omap54xx_ocp2scp3_hwmod,
> > +	.clk		= "l4_root_clk_div",
> > +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +
> > +static struct omap_hwmod omap54xx_ocp2scp3_hwmod = {
> > +	.name		= "ocp2scp3",
> > +	.class		= &omap54xx_ocp2scp_hwmod_class,
> > +	.clkdm_name	= "l3init_clkdm",
> > +	.prcm = {
> > +		.omap4 = {
> > +			.clkctrl_offs = OMAP54XX_CM_L3INIT_OCP2SCP3_CLKCTRL_OFFSET,
> > +			.context_offs = OMAP54XX_RM_L3INIT_OCP2SCP3_CONTEXT_OFFSET,
> > +			.modulemode   = MODULEMODE_HWCTRL,
> > +		},
> > +	},
> > +};
> > +
> > +/*
> > + * 'sata' class
> > + * sata:  serial ata interface  gen2 compliant   ( 1 rx/ 1 tx)
> > + */
> > +
> > +static struct omap_hwmod_class_sysconfig omap54xx_sata_sysc = {
> > +	.sysc_offs	= 0x0000,
> > +	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
> > +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> > +			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
> > +			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
> > +	.sysc_fields	= &omap_hwmod_sysc_type2,
> > +};
> > +
> > +static struct omap_hwmod_class omap54xx_sata_hwmod_class = {
> > +	.name	= "sata",
> > +	.sysc	= &omap54xx_sata_sysc,
> > +};
> > +
> > +/* sata */
> > +static struct omap_hwmod omap54xx_sata_hwmod = {
> > +	.name		= "sata",
> > +	.class		= &omap54xx_sata_hwmod_class,
> > +	.clkdm_name	= "l3init_clkdm",
> > +	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
> > +	.main_clk	= "func_48m_fclk",
> > +	.mpu_rt_idx	= 1,
> > +	.prcm = {
> > +		.omap4 = {
> > +			.clkctrl_offs = OMAP54XX_CM_L3INIT_SATA_CLKCTRL_OFFSET,
> > +			.context_offs = OMAP54XX_RM_L3INIT_SATA_CONTEXT_OFFSET,
> > +			.modulemode   = MODULEMODE_SWCTRL,
> > +		},
> > +	},
> > +};
> > +
> > +/* l4_cfg -> sata */
> > +static struct omap_hwmod_ocp_if omap54xx_l4_cfg__sata = {
> > +	.master		= &omap54xx_l4_cfg_hwmod,
> > +	.slave		= &omap54xx_sata_hwmod,
> > +	.clk		= "l3_iclk_div",
> > +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> >  
> >  /*
> >   * Interfaces
> > @@ -2399,6 +2470,8 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
> >  	&omap54xx_l4_cfg__usb_tll_hs,
> >  	&omap54xx_l4_cfg__usb_otg_ss,
> >  	&omap54xx_l4_wkup__wd_timer2,
> > +	&omap54xx_l4_cfg__ocp2scp3,
> > +	&omap54xx_l4_cfg__sata,
> >  	NULL,
> >  };
> >  
> > -- 
> > 1.8.3.2
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
