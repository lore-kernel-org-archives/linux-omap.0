From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
Date: Sun, 23 Sep 2012 22:59:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209232233080.31370@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com> <20120921205322.GK28835@atomide.com> <20120921231039.GN28835@atomide.com> <alpine.DEB.2.00.1209220002290.6510@utopia.booyaka.com> <20120922002111.GP28835@atomide.com>
 <alpine.DEB.2.00.1209220211090.8626@utopia.booyaka.com> <20120923190933.GS28835@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37528 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab2IWW7D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Sep 2012 18:59:03 -0400
In-Reply-To: <20120923190933.GS28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, 23 Sep 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [120922 10:48]:
>
> > Your tmp-merge contains branch/tag merges that haven't yet gone upstream 
> > to arm-soc.  I don't know which of those merges you consider stable (aside 
> > from the upstream ones, obviously).
> 
> Well tmp-merge is a merge of the upstream branches, but the branch
> itself is temporary. 

tmp-merge at commit abfee61f contains some branches/tags that aren't 
upstream at arm-soc - for example, Santosh's omap5_arch_timer (3c7c5da) 
and my omap-devel-c-for-3.7 (a238ce7).

> The issue here is that's it's too messy to get
> your branch merged currently because of the various merge conflicts with
> other branches. Trying to merge in your updated branch for testing
> into tmp-merge with the other branches produces:
> 
> CONFLICT (content): Merge conflict in drivers/spi/spi-omap2-mcspi.c
> CONFLICT (content): Merge conflict in arch/arm/mach-omap2/omap_hwmod.c
> CONFLICT (content): Merge conflict in arch/arm/mach-omap2/gpmc.c
> CONFLICT (content): Merge conflict in arch/arm/mach-omap2/devices.c
> CONFLICT (content): Merge conflict in arch/arm/mach-omap2/clkt_dpll.c
> CONFLICT (content): Merge conflict in arch/arm/mach-omap2/clkt_clksel.c
> CONFLICT (content): Merge conflict in arch/arm/mach-omap2/clkt34xx_dpll3m2.c

If you don't want to resolve the conflicts yourself, I'll be happy to do 
it if you give me a stable commit for me to base my pull request on.  But 
probably those conflicts are due to a miscommunication; see below.

> It seems to be conflicting with your own formatting changes,
> am33xx changes, PMU changes and RNG changes.

The PMU changes and RNG changes are in the tag you're pulling.  There 
aren't any previous changes in those areas from me.  Did you drop the 
temporary merge of omap-devel-c-for-3.7 before pulling 
omap-devel-b-c-for-3.7?  I merged the b (hwmod/etc.) and c (clock) pull 
requests into the updated pull request to reduce merge conflicts for you.


- Paul
