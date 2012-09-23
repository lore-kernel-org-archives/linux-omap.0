From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
Date: Sun, 23 Sep 2012 12:09:33 -0700
Message-ID: <20120923190933.GS28835@atomide.com>
References: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com>
 <20120921205322.GK28835@atomide.com>
 <20120921231039.GN28835@atomide.com>
 <alpine.DEB.2.00.1209220002290.6510@utopia.booyaka.com>
 <20120922002111.GP28835@atomide.com>
 <alpine.DEB.2.00.1209220211090.8626@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30211 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753853Ab2IWTJg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Sep 2012 15:09:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209220211090.8626@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120922 10:48]:
> On Fri, 21 Sep 2012, Tony Lindgren wrote:
> 
> > Hmm I wonder what's causing it then? There must be something
> > else in tmp-merge at commit abfee61f that causes the problems.
> > Maybe try to merge with that commit and see what you get?
> 
> Probably the merge with the clock patches was causing trouble.
> 
> > That commit can't be used as a base though as that's temporary
> > most likely.. But we can create a base to use out of the
> > branches once we know them, you can do it yourself too.
> 
> Your tmp-merge contains branch/tag merges that haven't yet gone upstream 
> to arm-soc.  I don't know which of those merges you consider stable (aside 
> from the upstream ones, obviously).  For this one it looks like the clock 
> patches were the ones causing the merge trouble.  So since that series 
> also came from me and is unmerged, will just merge the clock and hwmod 
> patches into a new pull request on v3.6-rc6 + cleanup-fixes-for-v3.7 + 
> omap-devel-am33xx-for-v3.7.  Hopefully that will work for you...

Well tmp-merge is a merge of the upstream branches, but the branch
itself is temporary. The issue here is that's it's too messy to get
your branch merged currently because of the various merge conflicts with
other branches. Trying to merge in your updated branch for testing
into tmp-merge with the other branches produces:

CONFLICT (content): Merge conflict in drivers/spi/spi-omap2-mcspi.c
CONFLICT (content): Merge conflict in arch/arm/mach-omap2/omap_hwmod.c
CONFLICT (content): Merge conflict in arch/arm/mach-omap2/gpmc.c
CONFLICT (content): Merge conflict in arch/arm/mach-omap2/devices.c
CONFLICT (content): Merge conflict in arch/arm/mach-omap2/clkt_dpll.c
CONFLICT (content): Merge conflict in arch/arm/mach-omap2/clkt_clksel.c
CONFLICT (content): Merge conflict in arch/arm/mach-omap2/clkt34xx_dpll3m2.c

It seems to be conflicting with your own formatting changes,
am33xx changes, PMU changes and RNG changes. Sounds like we're
safest to wait for -rc1 to for the dependencies to clear?

Regards,

Tony
