From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: clock3xxx_data: change EMAC clocks aliases
Date: Thu, 9 Feb 2012 12:45:57 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202091245210.4469@utopia.booyaka.com>
References: <1324423634-32581-1-git-send-email-yanok@emcraft.com> <4F2F8EE3.1050305@visionsystems.de> <20120209190957.GA30410@h56-17.vpn.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49241 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758458Ab2BITp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 14:45:58 -0500
In-Reply-To: <20120209190957.GA30410@h56-17.vpn.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, Tony Lindgren <tony@atomide.com>, Ilya Yanok <yanok@emcraft.com>, linux-omap@vger.kernel.org, sasha_d@emcraft.com

On Thu, 9 Feb 2012, Matt Porter wrote:

> On Mon, Feb 06, 2012 at 09:27:15AM +0100, Yegor Yefremov wrote:
> > Am 21.12.2011 00:27, schrieb Ilya Yanok:
> > > Rename EMAC clocks to match driver expectations: both davinci_emac and
> > > davinci_mdio drivers call clk_get(dev, NULL) so we have to provide
> > > ("davinci_emac", NULL) and ("davinci_mdio.0", NULL) clocks instead of
> > > ("davinci_emac", "emac_clk") and ("davinci_emac", "phy_clk") resp.
> > > 
> > > CC: Paul Walmsley <paul@pwsan.com>
> > > Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> > > ---
> > >  arch/arm/mach-omap2/clock3xxx_data.c |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Tested-by: Matt Porter <mporter@ti.com>
> 
> Also passing my nightly tests on an AM3517 EVM.

Thanks Matt, Yegor, Ilya; queued for 3.4.


- Paul
