From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: Re: [PATCH v3] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Thu, 10 May 2012 19:45:27 +0200
Message-ID: <20120510174527.GA11275@parrot.com>
References: <1335442669-13474-1-git-send-email-ivan.djelic@parrot.com>
 <20120509002927.GF5088@atomide.com>
 <20120509081047.GC17333@parrot.com>
 <20120509153141.GI5088@atomide.com>
 <1336655257.2625.8.camel@sauron.fi.intel.com>
 <20120510151725.GA11107@parrot.com>
 <1336665138.2243.1.camel@brekeke>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:46647 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760383Ab2EJRpb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 13:45:31 -0400
Content-Disposition: inline
In-Reply-To: <1336665138.2243.1.camel@brekeke>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: "afzal@ti.com" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On Thu, May 10, 2012 at 04:52:18PM +0100, Artem Bityutskiy wrote:
> On Thu, 2012-05-10 at 17:17 +0200, Ivan Djelic wrote:
> > But in order to do so, I need the changes that Afzal has submitted
> > (in particular [3]). Those changes (and as a consequence, my new patch)
> > won't hit 3.5.
> > 
> > So, when Afzal's patches are pushed, I'll submit a new, single MTD patch.
> 
> But this is not going to happen this merge window as I understood, may
> be not even the next one. We need to make UBIFS happy sooner than that,
> I think. So may be we go forward with your original patch?

I'm OK with this too, as the patches are ready and tested.
The MTD patch is [2], it depends on [1] which has been pushed, then dropped by Tony.
Do you need me to repost [2] ?

Tony, sorry to backpedal on this: would you re-push patch [1], if indeed Afzal's patches
are not going to be merged soon ? In the meantime, I can prepare a patch on top of Afzal's to
have a smooth transition w.r.t BCH support. What do you think ?

Best Regards,
--
Ivan

[1] http://lists.infradead.org/pipermail/linux-mtd/2012-April/040965.html
[2] http://lists.infradead.org/pipermail/linux-mtd/2012-April/041020.html
