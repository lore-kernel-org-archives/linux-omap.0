From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: AM33xx: Add missing reset status info to
 GFX hwmod
Date: Mon, 20 May 2013 05:50:29 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC8E77E@DBDE04.ent.ti.com>
References: <1367693284-7870-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EC8C092@DBDE04.ent.ti.com>
 <20130517172451.GY5600@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37160 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab3ETFvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 May 2013 01:51:22 -0400
In-Reply-To: <20130517172451.GY5600@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, May 17, 2013 10:55 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Paul Walmsley
> Subject: Re: [PATCH] ARM: OMAP2+: AM33xx: Add missing reset status info
> to GFX hwmod
> 
> * Hiremath, Vaibhav <hvaibhav@ti.com> [130517 04:13]:
> >
> > > -----Original Message-----
> > > From: Hiremath, Vaibhav
> > > Sent: Sunday, May 05, 2013 12:18 AM
> > > To: linux-omap@vger.kernel.org
> > > Cc: tony@atomide.com; linux-arm-kernel@lists.infradead.org;
> Hiremath,
> > > Vaibhav; Paul Walmsley
> > > Subject: [PATCH] ARM: OMAP2+: AM33xx: Add missing reset status info
> to
> > > GFX hwmod
> > >
> > > GFX has a reset status register (PRM_GFX.RM_GFX_RSTST),
> > > so update the GFX hwmod data with .rstst_off and .st_shift
> > > information.
> > >
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > ---
> > >  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    3 ++-
> > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > > b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > > index d1cf3ab..38c7b04 100644
> > > --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > > +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > > @@ -329,7 +329,7 @@ static struct omap_hwmod_class
> > > am33xx_gfx_hwmod_class = {
> > >  };
> > >
> > >  static struct omap_hwmod_rst_info am33xx_gfx_resets[] = {
> > > -	{ .name = "gfx", .rst_shift = 0 },
> > > +	{ .name = "gfx", .rst_shift = 0, .st_shift = 0},
> > >  };
> > >
> > >  static struct omap_hwmod_irq_info am33xx_gfx_irqs[] = {
> > > @@ -347,6 +347,7 @@ static struct omap_hwmod am33xx_gfx_hwmod = {
> > >  		.omap4	= {
> > >  			.clkctrl_offs	= AM33XX_CM_GFX_GFX_CLKCTRL_OFFSET,
> > >  			.rstctrl_offs	= AM33XX_RM_GFX_RSTCTRL_OFFSET,
> > > +			.rstst_offs	= AM33XX_RM_GFX_RSTST_OFFSET,
> > >  			.modulemode	= MODULEMODE_SWCTRL,
> > >  		},
> > >  	},
> > > --
> >
> > Tony and Paul,
> >
> > Any Update on this one as well?
> 
> Is this needed for v3.10 as a fix? If so, it should describe the
> regression or error.
> 

Certainly this is fix, but no impact on kernel boot.
I will describe it more in the description and send next version shortly.

Thanks,
Vaibhav

