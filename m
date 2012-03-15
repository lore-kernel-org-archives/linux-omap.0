From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: clock: fix race in disable all clocks
Date: Thu, 15 Mar 2012 12:39:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203151236560.7108@utopia.booyaka.com>
References: <1331835871-13328-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37929 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031532Ab2COSjJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 14:39:09 -0400
In-Reply-To: <1331835871-13328-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Todd Poynor <toddpoynor@google.com>, Tony Lindgren <tony@atomide.com>

Hi

adding Todd to cc

On Thu, 15 Mar 2012, Nishanth Menon wrote:

> clk_disable_unused is invoked when CONFIG_OMAP_RESET_CLOCKS=y.
> Since clk_disable_unused is called as lateinitcall, there can
> be more than a few workqueues executing off secondary CPU(s).
> The current code does the following:
> a) checks if clk is unused
> b) holds lock
> c) disables clk
> d) unlocks
> 
> Between (a) and (b) being executed on CPU0, It is possible to
> have a driver executing on CPU1 which could do a get_sync->clk_get
> (and increase the use_count) of the clock which was just about
> to be disabled by clk_disable_unused.
> 
> We ensure instead that the entire list traversal is protected by
> the lock allowing for parent child clock traversal which could be
> potentially be done by runtime operations to be safe as well.
> 
> Reported-by: Todd Poynor <toddpoynor@google.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, I'll queue this for v3.4-rc1.

In the medium term, we should get rid of CONFIG_OMAP_RESET_CLOCKS, at 
least for the OMAP2+ chips, and just do this by default.  But this will 
need to wait until all of the OMAP2+ devices and drivers have been 
converted to use hwmod.  Patches to that end are also gladly accepted :-)
In 3.5 we should be in pretty good shape for OMAP4, but OMAP2/3 will still 
need some work.



- Paul
