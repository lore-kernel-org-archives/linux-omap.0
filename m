From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: SDRC: Comment out SDRC AC timing and MR changes
 in CORE DVFS SRAM code
Date: Wed, 2 Dec 2009 09:22:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912020916431.13408@utopia.booyaka.com>
References: <1254835224-19500-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.0910201918230.22645@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162039B3CF012@dlee02.ent.ti.com> <74583B8642AB8841B30447520659FCA9DDD9D7E9@dnce01.ent.ti.com>
 <13B9B4C6EF24D648824FF11BE8967162039B459718@dlee02.ent.ti.com> <1F18D6510CF0474A8C9500565A7E41A2236DA1C1F3@NOK-EUMSG-02.mgdnok.nokia.com> <alpine.DEB.2.00.0912011832290.13408@utopia.booyaka.com> <4B160552.6050108@ti.com> <20091202155614.GA3699@lixom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52895 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbZLBQWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 11:22:48 -0500
In-Reply-To: <20091202155614.GA3699@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap@vger.kernel.org, Tero.Kristo@nokia.com, r-woodruff2@ti.com, b-cousson@ti.com, rnayak@ti.com, c-sucur@ti.com

Hello Olof, Nishanth,

thanks for the comments,

On Wed, 2 Dec 2009, Olof Johansson wrote:

> On Wed, Dec 02, 2009 at 08:12:34AM +0200, Menon, Nishanth wrote:
> 
> > why not make this a #ifdef instead if we need it some other time, a #if
> > 0 and it's intention might not be readable without doing a git annotate
> > in a few months time..
> 
> Just remove the code. The old implementation is still there in git and
> can be brought back if need be. It's the purpose of having revision
> control in the first place.

I'm leaning towards Nishanth's suggestion and making it a Kconfig option. 
That way, users who know that other system initiators will be inactive at 
CORE DVFS time will be able to use optimal SDRC timings in CORE DVFS.

The other issue with removing it completely is that I'm holding out the 
(admittedly slim) hope that someone else will be enticed into helping out 
with this issue, and so I'd reason that since very few people will look at 
older revisions, removing it will drastically reduce the chances that 
others will help.


- Paul
