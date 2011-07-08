From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap board updates for v3.1 merge window
Date: Fri, 8 Jul 2011 03:25:21 -0700
Message-ID: <20110708102521.GS5783@atomide.com>
References: <20110707162911.GL5783@atomide.com>
 <201107072240.58987.arnd@arndb.de>
 <20110708083042.GQ5783@atomide.com>
 <201107081054.01295.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53935 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751476Ab1GHKZ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 06:25:27 -0400
Content-Disposition: inline
In-Reply-To: <201107081054.01295.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>

* Arnd Bergmann <arnd@arndb.de> [110708 01:49]:
> On Friday 08 July 2011 10:30:42 Tony Lindgren wrote:
> > 
> > * Arnd Bergmann <arnd@arndb.de> [110707 13:36]:
> > > On Thursday 07 July 2011 18:29:11 Tony Lindgren wrote:
> > > > Please pull omap board updates from:
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-board
> > > > 
> > > > These are currently on top of the fixes you pulled earlier but
> > > > could be also rebased on the earlier cleanup if you prefer that.
> > > 
> > > I would generally prefer them to be independent, even if that causes
> > > minor conflicts. If some branches are built on top of others, that
> > > mainly means I have to remember the order in which to send them
> > > upstream, and my memory for these things is limited.
> > 
> > Sure. So let's wait on this one a bit. I'll send you some more cleanup
> > first as I just noticed that the TWL cleanup series will conflict with
> > these patches.
> 
> Sorry for being unclear, I forgot to say that I did in fact pull your tree
> already.

OK no problem that's fine with me.

BTW, looks like your tree is no longer showing up on kernel.org?
 
> > I need to base these board files on all the cleanup though, otherwise
> > things will get messy with merge and build conflicts.
> > 
> > Unfortunately there will be dependencies between branches until we
> > have the driver probe and bus (hwmod) code initializing things
> > using device tree data..
> 
> I already need to stage things out a bit, because the omap fixes
> depend on the omap cleanups, while the imx cleanups depend on the
> pxa fixes. So it's likely going to be something like
> 
> * fixes
> * cleanup
> * more fixes
> * more cleanup
> * new subarchitectures
> * new boards
> * wait for devicetree to get pulled in
> * more cleanups based on device tree
> * other new features

It's getting messy :)

Tony
