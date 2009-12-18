From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] AM35xx: Add clock support for new modules on AM35xx
Date: Thu, 17 Dec 2009 18:45:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912171844510.12561@utopia.booyaka.com>
References: <1260971823-8532-1-git-send-email-ranjithl@ti.com> <alpine.DEB.2.00.0912171818150.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59809 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbZLRBpr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 20:45:47 -0500
In-Reply-To: <alpine.DEB.2.00.0912171818150.12561@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 17 Dec 2009, Paul Walmsley wrote:

> On Wed, 16 Dec 2009, Ranjith Lohithakshan wrote:
> 
> > This patch adds clock support for the following AM35xx modules
> > 	- Ethernet MAC
> > 	- CAN Controller (HECC)
> > 	- New MUSB OTG Controller with integrated Phy
> > 	- Video Processing Front End (VPFE)
> > 	- Additional UART (UART4)
> > 
> > Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx_data.c  |   93 +++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/cm-regbits-34xx.h |    6 ++
> >  2 files changed, 99 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
> > index 043caed..d7942b3 100644
> > --- a/arch/arm/mach-omap2/clock34xx_data.c
> > +++ b/arch/arm/mach-omap2/clock34xx_data.c
> > @@ -2983,6 +2983,91 @@ static struct clk wdt1_fck = {
> >  	.recalc		= &followparent_recalc,
> >  };
> >  
> > +/* Clocks for AM35XX */
> > +static struct clk emac_ick = {
> > +	.name       = "emac_ick",
> > +	.ops        = &clkops_omap2_dflt,
> 
> Shouldn't this clock use &clkops_omap2_dflt_wait (or rather, some custom 
> version that knows how to read the _ACK bits in IPSS_CLK_CTRL) and test 
> CPGMAC_VBUSP_CLK_EN_ACK?  Same for the other IPSS VBUSP clocks?   (I guess 
> "VBUSP" is a synonym for "interface"?)

Hmmm.  Thinking about this further, I suppose this depends on whether the 
modules are initiators or targets.  Do you know this?


- Paul
