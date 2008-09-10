From: Paul Walmsley <paul@pwsan.com>
Subject: RE: 3430: can't find mmc debounce clock
Date: Wed, 10 Sep 2008 08:36:49 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809100835560.20446@utopia.booyaka.com>
References: <57314e840809080618x1f0cd0aen74b1a03351dc8ef7@mail.gmail.com> <alpine.DEB.1.00.0809100641010.20446@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE896716203655BDE26@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42339 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbYIJOgv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 10:36:51 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203655BDE26@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Budhee Jamaich <budheej@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 10 Sep 2008, Woodruff, Richard wrote:

> 
> > > I read that the mmc has 3 clocks: fixed functional clock (MMCi_FCLK),
> > > interface clock (MMCi_ICLK) and debounce clock (MMCi_32).
> > >
> > > But, when I look in clock34xx.h, I can only see two of those - there
> > > is the "mmchs_fck" and "mmchs_ick". There is no struct clk for the
> > > debounce clock. Only when I look in older kernels I can see also the
> > > "mmchsdb2_fck".
> > >
> > > So where is the debounce clock struct ? (I want to 'get' and 'enable'
> > it...)
> >
> > The debounce clocks are controlled by gpio[1-6]_fck.  Perhaps we should
> > rename them, but that's what the current tree uses.
> 
> With out looking, that's a bit confusing to me.  Perhaps it's a porting wonder...

Ugh, sorry, the above is wrong.  Richard's solution below is right.

> 2430 did have a separate MMC denounce clock which is controllable at the PRCM level.  This is the name you mention above (2430 name).  I don't think 3430 provides the same control.  A 32K clock is fed into the MMC block, but it is probably controlled locally in MMC block not through clock API at PRCM level.
> 
> Maybe you just need an ifdef or is_cpu_ call.


- Paul
