From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap board updates for v3.1 merge window
Date: Fri, 8 Jul 2011 01:30:42 -0700
Message-ID: <20110708083042.GQ5783@atomide.com>
References: <20110707162911.GL5783@atomide.com>
 <201107072240.58987.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49264 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753137Ab1GHIat (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 04:30:49 -0400
Content-Disposition: inline
In-Reply-To: <201107072240.58987.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>

* Arnd Bergmann <arnd@arndb.de> [110707 13:36]:
> On Thursday 07 July 2011 18:29:11 Tony Lindgren wrote:
> > Please pull omap board updates from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-board
> > 
> > These are currently on top of the fixes you pulled earlier but
> > could be also rebased on the earlier cleanup if you prefer that.
> 
> I would generally prefer them to be independent, even if that causes
> minor conflicts. If some branches are built on top of others, that
> mainly means I have to remember the order in which to send them
> upstream, and my memory for these things is limited.

Sure. So let's wait on this one a bit. I'll send you some more cleanup
first as I just noticed that the TWL cleanup series will conflict with
these patches.

I need to base these board files on all the cleanup though, otherwise
things will get messy with merge and build conflicts.

Unfortunately there will be dependencies between branches until we
have the driver probe and bus (hwmod) code initializing things
using device tree data..

Regards,

Tony
