From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] am35xx-emac: move generic EMAC init to separate file
Date: Tue, 20 Dec 2011 18:38:05 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112201833390.12660@utopia.booyaka.com>
References: <1321490199-24371-1-git-send-email-yanok@emcraft.com> <20111208001503.GV31337@atomide.com> <4EE93564.3010006@emcraft.com> <4EE9C057.6010204@compulab.co.il> <20111215184342.GT32251@atomide.com> <4EEA69C2.4000503@emcraft.com>
 <alpine.DEB.2.00.1112152257150.12660@utopia.booyaka.com> <4EF10CAB.4010503@emcraft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53456 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab1LUBiG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 20:38:06 -0500
In-Reply-To: <4EF10CAB.4010503@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: Tony Lindgren <tony@atomide.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, Ranjith Lohithakshan <ranjithl@ti.com>, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

On Wed, 21 Dec 2011, Ilya Yanok wrote:

> On 16.12.2011 10:13, Paul Walmsley wrote:
> >> Ok, let's wait for Paul's answer and then I'll prepare a separate patch.
> > 
> > Unfortunately the AM3517 TRM (SPRUGR0) here doesn't really have the same 
> > level of clock integration information that the WBU TRMs have, so it's 
> > kind of hard to tell what's going on :-(
> > 
> > Looking at Figure 22-1 "EMAC and MDIO Block Diagram", it appears that what 
> > we call "emac_fck" is really just an optional functional clock for the 
> > MDIO PHY?
> 
> Hm. I have to admit I'm completely lost here.
> CONTROL_IPSS_CLK_CTRL register has bit controlling "Func clock of
> CPGMAC". 

Yeah, I don't think that's correct.  Or rather, it's imprecise.  It might 
be true from a strict integration perspective, but it's misleading.

> But there is no mention of this clock anywhere else in the
> manual. I can't find neither where it comes from nor how it's used.
> According to the current sources it comes from external 50MHz RMII
> clock, do you think this is correct?

I think that part is correct.

> > And it sounds like the AM35xx clock that we call "emac_ick" is actually a 
> > combined interface and functional clock for the EMAC and MDIO IP blocks?  
> > I guess a combined interface/functional clock would make sense, since the 
> > EMAC seems to contain a DMA controller.
> >   
> > Maybe Ranjith can provide some more information; he's cc'ed.
> > 
> > In any case, your changes sound reasonable to me, so a patch to the clock 
> > file sounds good.  I'd suggest both changing the clkdev aliases and 
> > renaming emac_fck - that's a confusing name and I don't think it's in the 
> > TRM as such.
> 
> Actually it's called Func clock in the manual (see
> CONTROL_IPSS_CLK_CTRL). Do you still think we have to rename it?

I guess we have other optional functional clocks with _fck suffixes, so 
it's probably not such a big deal.

> I have another concern: changing clkdev aliases make things work for me
> but now I'm not sure if this change is really correct...

Well, sounds like it's better than what we currently have.


- Paul
