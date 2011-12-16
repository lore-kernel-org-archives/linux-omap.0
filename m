From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] am35xx-emac: move generic EMAC init to separate file
Date: Thu, 15 Dec 2011 23:13:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112152257150.12660@utopia.booyaka.com>
References: <1321490199-24371-1-git-send-email-yanok@emcraft.com> <20111208001503.GV31337@atomide.com> <4EE93564.3010006@emcraft.com> <4EE9C057.6010204@compulab.co.il> <20111215184342.GT32251@atomide.com> <4EEA69C2.4000503@emcraft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49217 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab1LPGNK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 01:13:10 -0500
In-Reply-To: <4EEA69C2.4000503@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: Tony Lindgren <tony@atomide.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, Ranjith Lohithakshan <ranjithl@ti.com>, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

(cc'ing Ranjith)

Hi

On Fri, 16 Dec 2011, Ilya Yanok wrote:

> >>>>> +	clk_add_alias(NULL, dev_name(&am35xx_emac_device.dev),
> >>>>> +		      "emac_clk", &am35xx_emac_device.dev);
> >>>>> +	clk_add_alias(NULL, dev_name(&am35xx_mdio_device.dev),
> >>>>> +		      "phy_clk", &am35xx_emac_device.dev);
> >>>>
> >>>> Hmm after moving the code and should be a separate patch, don't
> >>>> we already have these clock aliases in cloc3xxx_data.c?
> >>>
> >>> No, we have
> >>> CLK("davinci_emac", "emac_clk"...) and
> >>> CLK("davinci_emac", "phy_clk"...)
> >>> while drivers want ("davinci_emac", NULL) and ("davinci_mdio", NULL).
> >>>
> >>> Probably we have to fix the clock definitions instead of adding the aliases.
> >>>
> >>> So, should I post this as a separate patch?
> >>
> >> If it comes to that question, Cc Paul...
> > 
> > Yes please do that as a separate patch.
> 
> Ok, let's wait for Paul's answer and then I'll prepare a separate patch.

Unfortunately the AM3517 TRM (SPRUGR0) here doesn't really have the same 
level of clock integration information that the WBU TRMs have, so it's 
kind of hard to tell what's going on :-(

Looking at Figure 22-1 "EMAC and MDIO Block Diagram", it appears that what 
we call "emac_fck" is really just an optional functional clock for the 
MDIO PHY?

And it sounds like the AM35xx clock that we call "emac_ick" is actually a 
combined interface and functional clock for the EMAC and MDIO IP blocks?  
I guess a combined interface/functional clock would make sense, since the 
EMAC seems to contain a DMA controller.
  
Maybe Ranjith can provide some more information; he's cc'ed.

In any case, your changes sound reasonable to me, so a patch to the clock 
file sounds good.  I'd suggest both changing the clkdev aliases and 
renaming emac_fck - that's a confusing name and I don't think it's in the 
TRM as such.


- Paul
