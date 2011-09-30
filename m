From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] dmtimer changes for v3.2 merge window
Date: Fri, 30 Sep 2011 13:43:19 -0700
Message-ID: <20110930204319.GM6324@atomide.com>
References: <20110928220237.GE6324@atomide.com>
 <201109302213.42435.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61780 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab1I3UnX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 16:43:23 -0400
Content-Disposition: inline
In-Reply-To: <201109302213.42435.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [110930 12:40]:
> On Thursday 29 September 2011, Tony Lindgren wrote:
> > Please pull omap dmtimer changes from:
> > 
> > git://github.com/tmlind/linux.git dmtimer
> > 
> > This series completes the system timer separation from the
> > driver like features. It also adds support for v2 ip that is
> > available for some timers starting with omap4.
> > 
> > After this series arch/arm/plat-omap/dmtimer.c could be
> > moved to live under drivers somewhere, but there is still
> > discussion going on which features should be supported in
> > a generic way.
> > 
> > This series depends on the cleanup you pulled earlier.
> > As this series adds some new features like runtime PM suppport,
> > I've kept it separate from cleanup.
> 
> Looks really nice. I've put it into another top-level branch
> named next/dmtimer for now. I'm open for suggestions on whether
> I should generally push branches like this separately Linuswards
> or better aggregate multiple standalone features into a single
> branch. 

How about a branch called driver?

There are still lots of pieces of code under arch/arm that should
be eventually moved to live under drivers. For example the mux
code and most of PM code can eventually be under drivers.

But before that can be done some preparation is often needed,
the actual move to live under drivers should be handled then
by the driver and subsystem maintainers.

Regards,

Tony
