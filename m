From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
Date: Tue, 10 Dec 2013 11:50:54 -0800
Message-ID: <20131210195054.GS13171@atomide.com>
References: <pull-1386643347-596413>
 <20131210185902.GO13171@atomide.com>
 <20131210192726.GR13171@atomide.com>
 <201312102039.42933.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22282 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab3LJTvB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 14:51:01 -0500
Content-Disposition: inline
In-Reply-To: <201312102039.42933.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <paul@pwsan.com>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aida Mynzhasova <aida.mynzhasova@skitlab.ru>

* Arnd Bergmann <arnd@arndb.de> [131210 11:41]:
> On Tuesday 10 December 2013, Tony Lindgren wrote:
> > board-ti8168evm.c
> > 
> > I doubt ti8168evm has even worked for a long time.. It's in pretty
> > sorry state unfortunately with missing clock support and missing
> > handle_irq entry in the board-ti8168evm.c.
> 
> Does that imply the entire ti81xx soc support is lacking, or just
> that board specifically? It seems to be the only board file that
> ever got merged.

It's an omap3 variant and it's still waiting for the clock patches 
that now unfortunately have a dependency to the the omap clock
move to drivers/clk. Aida Mynzhasova posted some patches few months
ago here:

http://www.spinics.net/lists/linux-omap/msg96341.html

Since it's an omap3 variant, we should be able to make it usable
quite easily, so no need to remove the whole support at least
yet. Plus it seems to be an active TI part, so people are still it.

But it's definitely not a show stopper for making omap3 to boot in
device tree only mode.

Regards,

Tony
