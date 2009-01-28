From: Tony Lindgren <tony@atomide.com>
Subject: Re: [ANNOUNCE:RFC] convert OMAP to use clkdev
Date: Wed, 28 Jan 2009 09:15:21 -0800
Message-ID: <20090128171519.GR32148@atomide.com>
References: <20090124120317.GA20593@n2100.arm.linux.org.uk> <20090124170408.GA7172@atomide.com> <20090124173824.GB27329@n2100.arm.linux.org.uk> <20090124183228.GB7172@atomide.com> <20090124184053.GC27329@n2100.arm.linux.org.uk> <20090124190130.GC7172@atomide.com> <20090128101745.GB15907@n2100.arm.linux.org.uk> <20090128155901.GP32148@atomide.com> <20090128161037.GA23301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65391 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbZA1RPY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 12:15:24 -0500
Content-Disposition: inline
In-Reply-To: <20090128161037.GA23301@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090128 08:10]:
> On Wed, Jan 28, 2009 at 07:59:02AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090128 02:17]:
> > > On Sat, Jan 24, 2009 at 11:01:36AM -0800, Tony Lindgren wrote:
> > > > I'll keep the clks-testing branch updated so we all can test it easily,
> > > > and then we'll just flip linux-omap to use that branch for the clocks
> > > > once everything is merged.
> > > 
> > > Note that I'm going to rebase the two omap-clks branches to be on top of
> > > Linus' tree now that my 'master' was merged.
> > 
> > OK, I'll refresh the clks-testing branch in linux-omap tree so people
> > can test it easily.
> 
> Note that you only need my omap-clks2 branch.  As I said in the original
> message, omap-clks2 is a superset of omap-clks1 - so merging omap-clks2
> gets you everything already in omap-clks1.

OK, the clks-testing in linux-omap tree is updated now. Everybody,
please note that this is a temporary branch that will get rebased often.

So if pulling it fails the next time, just do a hard reset on your local
clks-testing branch with git-reset --hard origin/clks-testing after
doing a git-fetch.

Tony
