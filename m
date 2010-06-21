From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: wait on IDLEST after enabling USBTLL fclk
Date: Mon, 21 Jun 2010 15:45:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006211540100.1550@utopia.booyaka.com>
References: <1273127288-21590-1-git-send-email-gadiyar@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032358E85A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51422 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758314Ab0FUVpb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 17:45:31 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032358E85A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Sat, 19 Jun 2010, Gadiyar, Anand wrote:

> Gadiyar, Anand wrote:
> > We need to wait on the IDLEST bit after the clocks are enabled
> > before attempting to access any register.
> > 
> > Currently, the USBTLL i-clock ops uses the clkops_omap2_dflt_wait,
> > while the USBTLL f-clock ops uses clkops_omap2_dflt. If the
> > i-clock is enabled first, the clkops_omap2_dflt_wait is
> > short-circuited as the companion f-clock is not enabled.
> > This can cause a data abort if the IDLEST has not transitioned,
> > and we try to access a USBTLL register.
> > 
> > Since the USBTLL i-clock and f-clock could be enabled in any order,
> > this is a bug. Fix it by changing the clkops for the f-clock.
> > 
> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

It looks fine to me.  I will queue it for a -rc branch. 

> Ping?

Generally it is helpful if you have a patch for a subsystem that I 
maintain, to cc me directly.


- Paul

> 
> 
> > ---
> > 
> >  arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-omap-2.6/arch/arm/mach-omap2/clock3xxx_data.c
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/clock3xxx_data.c
> > +++ linux-omap-2.6/arch/arm/mach-omap2/clock3xxx_data.c
> > @@ -1484,7 +1484,7 @@ static struct clk ts_fck = {
> >  
> >  static struct clk usbtll_fck = {
> >  	.name		= "usbtll_fck",
> > -	.ops		= &clkops_omap2_dflt,
> > +	.ops		= &clkops_omap2_dflt_wait,
> >  	.parent		= &dpll5_m2_ck,
> >  	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
> >  	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
> > --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
