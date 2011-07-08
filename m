From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap board updates for v3.1 merge window
Date: Fri, 8 Jul 2011 10:54:01 +0200
Message-ID: <201107081054.01295.arnd@arndb.de>
References: <20110707162911.GL5783@atomide.com> <201107072240.58987.arnd@arndb.de> <20110708083042.GQ5783@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52776 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab1GHIyh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 04:54:37 -0400
In-Reply-To: <20110708083042.GQ5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>

On Friday 08 July 2011 10:30:42 Tony Lindgren wrote:
> 
> * Arnd Bergmann <arnd@arndb.de> [110707 13:36]:
> > On Thursday 07 July 2011 18:29:11 Tony Lindgren wrote:
> > > Please pull omap board updates from:
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-board
> > > 
> > > These are currently on top of the fixes you pulled earlier but
> > > could be also rebased on the earlier cleanup if you prefer that.
> > 
> > I would generally prefer them to be independent, even if that causes
> > minor conflicts. If some branches are built on top of others, that
> > mainly means I have to remember the order in which to send them
> > upstream, and my memory for these things is limited.
> 
> Sure. So let's wait on this one a bit. I'll send you some more cleanup
> first as I just noticed that the TWL cleanup series will conflict with
> these patches.

Sorry for being unclear, I forgot to say that I did in fact pull your tree
already.

> I need to base these board files on all the cleanup though, otherwise
> things will get messy with merge and build conflicts.
> 
> Unfortunately there will be dependencies between branches until we
> have the driver probe and bus (hwmod) code initializing things
> using device tree data..

I already need to stage things out a bit, because the omap fixes
depend on the omap cleanups, while the imx cleanups depend on the
pxa fixes. So it's likely going to be something like

* fixes
* cleanup
* more fixes
* more cleanup
* new subarchitectures
* new boards
* wait for devicetree to get pulled in
* more cleanups based on device tree
* other new features

	Arnd
