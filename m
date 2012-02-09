From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH] OMAP3: clock3xxx_data: change EMAC clocks aliases
Date: Thu, 9 Feb 2012 14:09:59 -0500
Message-ID: <20120209190957.GA30410@h56-17.vpn.ti.com>
References: <1324423634-32581-1-git-send-email-yanok@emcraft.com>
 <4F2F8EE3.1050305@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35811 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754136Ab2BITKS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Feb 2012 14:10:18 -0500
Content-Disposition: inline
In-Reply-To: <4F2F8EE3.1050305@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: Tony Lindgren <tony@atomide.com>, Ilya Yanok <yanok@emcraft.com>, linux-omap@vger.kernel.org, sasha_d@emcraft.com, Paul Walmsley <paul@pwsan.com>

On Mon, Feb 06, 2012 at 09:27:15AM +0100, Yegor Yefremov wrote:
> Am 21.12.2011 00:27, schrieb Ilya Yanok:
> > Rename EMAC clocks to match driver expectations: both davinci_emac and
> > davinci_mdio drivers call clk_get(dev, NULL) so we have to provide
> > ("davinci_emac", NULL) and ("davinci_mdio.0", NULL) clocks instead of
> > ("davinci_emac", "emac_clk") and ("davinci_emac", "phy_clk") resp.
> > 
> > CC: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> > ---
> >  arch/arm/mach-omap2/clock3xxx_data.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> > index d75e5f6..1a60661 100644
> > --- a/arch/arm/mach-omap2/clock3xxx_data.c
> > +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> > @@ -3465,8 +3465,8 @@ static struct omap_clk omap3xxx_clks[] = {
> >  	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
> >  	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
> >  	CLK(NULL,	"pclk_ck",	&pclk_ck,	CK_AM35XX),
> > -	CLK("davinci_emac",	"emac_clk",	&emac_ick,	CK_AM35XX),
> > -	CLK("davinci_emac",	"phy_clk",	&emac_fck,	CK_AM35XX),
> > +	CLK("davinci_emac",	NULL,	&emac_ick,	CK_AM35XX),
> > +	CLK("davinci_mdio.0",	NULL,	&emac_fck,	CK_AM35XX),
> >  	CLK("vpfe-capture",	"master",	&vpfe_ick,	CK_AM35XX),
> >  	CLK("vpfe-capture",	"slave",	&vpfe_fck,	CK_AM35XX),
> >  	CLK("musb-am35x",	"ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),
> 
> Tested-by: Yegor Yefremov <yegorslists@googlemail.com>

Tested-by: Matt Porter <mporter@ti.com>

Also passing my nightly tests on an AM3517 EVM.

-Matt
