From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for v3.2 merge window breakage
Date: Mon, 7 Nov 2011 16:51:21 -0800
Message-ID: <20111108005120.GI31337@atomide.com>
References: <20111107204929.GZ31337@atomide.com>
 <20111107212919.GI15294@n2100.arm.linux.org.uk>
 <20111107214724.GA31337@atomide.com>
 <20111108001840.GF31337@atomide.com>
 <20111108004214.GN15294@n2100.arm.linux.org.uk>
 <20111108004457.GO15294@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39035 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750771Ab1KHAvY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 19:51:24 -0500
Content-Disposition: inline
In-Reply-To: <20111108004457.GO15294@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111107 16:10]:
> On Tue, Nov 08, 2011 at 12:42:14AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 07, 2011 at 04:18:41PM -0800, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [111107 13:12]:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [111107 12:54]:
> > > > > Arnd,
> > > > > 
> > > > > Don't pull this - there's yet more crap in OMAP to be fixed before
> > > > > these go to mainline.  OMAP3 is severely broken at the moment with,
> > > > > to put it bluntly, totally fucked up OMAP hwmod code, and should be
> > > > > fixed *now* by folk before this pull request.
> > > > > 
> > > > > The fixes are damned trivial I expect even Tony can fix it without
> > > > > reference to Paul.
> > > > 
> > > > > >       ARM: OMAP3: hwmod: fix variant registration and remove SmartReflex from common list
> > > > 
> > > > Sounds like the above patch already queued should fix the issues you
> > > > are seeing with hwmod?
> > > > 
> > > > Or do you still have other issues you're having?
> > > 
> > > Sounds like all Russell's issues are all dealt with:
> > > 
> > > http://marc.info/?l=linux-arm-kernel&m=132070787220812&w=2
> > > 
> > > Arnd, if you have not pulled yet, Kevin just posted one more export.h
> > > fix for THIS_MODULE for cpuidle. I'll add that patch into fixes,
> > > and will post a new pull request.
> > 
> > Arnd isn't around much at the moment.
> > 
> > I've forwarded your request to Linus already, so adding to it may not go
> > down too well.

OK, well looks like the earlier version got pulled in.
 
> For the avoidance of doubt, as you've already updated it leave it as-is.

Let's leave that for another series then.

Tony
