From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Thu, 10 May 2012 12:02:43 -0700
Message-ID: <20120510190243.GM21851@atomide.com>
References: <1335442669-13474-1-git-send-email-ivan.djelic@parrot.com>
 <20120509002927.GF5088@atomide.com>
 <20120509081047.GC17333@parrot.com>
 <20120509153141.GI5088@atomide.com>
 <1336655257.2625.8.camel@sauron.fi.intel.com>
 <20120510151725.GA11107@parrot.com>
 <1336665138.2243.1.camel@brekeke>
 <20120510174527.GA11275@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55885 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab2EJTCq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 15:02:46 -0400
Content-Disposition: inline
In-Reply-To: <20120510174527.GA11275@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, "afzal@ti.com" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

* Ivan Djelic <ivan.djelic@parrot.com> [120510 10:49]:
> On Thu, May 10, 2012 at 04:52:18PM +0100, Artem Bityutskiy wrote:
> > On Thu, 2012-05-10 at 17:17 +0200, Ivan Djelic wrote:
> > > But in order to do so, I need the changes that Afzal has submitted
> > > (in particular [3]). Those changes (and as a consequence, my new patch)
> > > won't hit 3.5.
> > > 
> > > So, when Afzal's patches are pushed, I'll submit a new, single MTD patch.
> > 
> > But this is not going to happen this merge window as I understood, may
> > be not even the next one. We need to make UBIFS happy sooner than that,
> > I think. So may be we go forward with your original patch?
> 
> I'm OK with this too, as the patches are ready and tested.
> The MTD patch is [2], it depends on [1] which has been pushed, then dropped by Tony.
> Do you need me to repost [2] ?
> 
> Tony, sorry to backpedal on this: would you re-push patch [1], if indeed Afzal's patches
> are not going to be merged soon ? In the meantime, I can prepare a patch on top of Afzal's to
> have a smooth transition w.r.t BCH support. What do you think ?

Yes this is OK with me as this removes the blocker for UBIFS work.

For arch/arm/mach-omap2/gpmc.c, I have the following two patches
queued:

27aeb3da5f97c55f61d92e3dbfb738762f76dc32 Merge tag 'omap-cleanup-for-v3.5' into tmp-merge
2c65e7440d56b3b285d1c95563b4dcce8e40dea3 GPMC: add ECC control definitions
355f8eee48134ba10ca81664ee90eeb240f5f928 ARM: OMAP2+: GPMC: resolve type-conversion warning from sparse

Looks your patch applies to v3.4-rc6 and what I have queued without
conflicts, so I suggest you merge both via MTD patches:

Acked-by: Tony Lindgren <tony@atomide.com>

 
> [1] http://lists.infradead.org/pipermail/linux-mtd/2012-April/040965.html
> [2] http://lists.infradead.org/pipermail/linux-mtd/2012-April/041020.html
