From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: AM33xx: Add missing reset status info to
 GFX hwmod
Date: Fri, 17 May 2013 10:24:52 -0700
Message-ID: <20130517172451.GY5600@atomide.com>
References: <1367693284-7870-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EC8C092@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50855 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351Ab3EQRYy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 13:24:54 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC8C092@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [130517 04:13]:
> 
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Sunday, May 05, 2013 12:18 AM
> > To: linux-omap@vger.kernel.org
> > Cc: tony@atomide.com; linux-arm-kernel@lists.infradead.org; Hiremath,
> > Vaibhav; Paul Walmsley
> > Subject: [PATCH] ARM: OMAP2+: AM33xx: Add missing reset status info to
> > GFX hwmod
> > 
> > GFX has a reset status register (PRM_GFX.RM_GFX_RSTST),
> > so update the GFX hwmod data with .rstst_off and .st_shift
> > information.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > index d1cf3ab..38c7b04 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > @@ -329,7 +329,7 @@ static struct omap_hwmod_class
> > am33xx_gfx_hwmod_class = {
> >  };
> > 
> >  static struct omap_hwmod_rst_info am33xx_gfx_resets[] = {
> > -	{ .name = "gfx", .rst_shift = 0 },
> > +	{ .name = "gfx", .rst_shift = 0, .st_shift = 0},
> >  };
> > 
> >  static struct omap_hwmod_irq_info am33xx_gfx_irqs[] = {
> > @@ -347,6 +347,7 @@ static struct omap_hwmod am33xx_gfx_hwmod = {
> >  		.omap4	= {
> >  			.clkctrl_offs	= AM33XX_CM_GFX_GFX_CLKCTRL_OFFSET,
> >  			.rstctrl_offs	= AM33XX_RM_GFX_RSTCTRL_OFFSET,
> > +			.rstst_offs	= AM33XX_RM_GFX_RSTST_OFFSET,
> >  			.modulemode	= MODULEMODE_SWCTRL,
> >  		},
> >  	},
> > --
> 
> Tony and Paul,
> 
> Any Update on this one as well?

Is this needed for v3.10 as a fix? If so, it should describe the
regression or error.

Regards,

Tony
