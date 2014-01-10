From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Fri, 10 Jan 2014 10:51:11 -0800
Message-ID: <20140110185110.GM31323@atomide.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <52CF12FB.6000602@ti.com>
 <20140109231513.GA11648@saruman.home>
 <52CFC2F1.706@ti.com>
 <20140110161352.GG6665@saruman.home>
 <52D02037.3090705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34068 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751698AbaAJSvU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jan 2014 13:51:20 -0500
Content-Disposition: inline
In-Reply-To: <52D02037.3090705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: balbi@ti.com, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [140110 08:32]:
> On 01/10/2014 06:13 PM, Felipe Balbi wrote:
> >On Fri, Jan 10, 2014 at 11:52:49AM +0200, Tero Kristo wrote:
> >>On 01/10/2014 01:15 AM, Felipe Balbi wrote:
> >>>On Thu, Jan 09, 2014 at 03:22:03PM -0600, Nishanth Menon wrote:
> >>>>
> >>>>conflicts with be changes on Tony's be branch.
> >>>>commit 80f304dd2360cf5d50953c4eb4e902536f6a1263
> >>>>     ARM: OMAP2+: raw read and write endian fix
> >>>>
> >>>>Conflict:
> >>>>arch/arm/mach-omap2/clkt_clksel.c
> >>>>arch/arm/mach-omap2/clkt_dpll.c
> >>>>arch/arm/mach-omap2/clkt_iclk.c
> >>>>arch/arm/mach-omap2/clock.c
> >>>>arch/arm/mach-omap2/clock36xx.c
> >>>>arch/arm/mach-omap2/dpll3xxx.c
> >>>>arch/arm/mach-omap2/dpll44xx.c
> >>>>
> >>>>Both change raw_readls -> should now be just clk api instead which
> >>>>already does readl_relaxed etc.. If Tony feels like, then we should
> >>>>probably post a branch based on 'be' branch for easy merge.

This should be a trivial merge conflict to handle, so let's not base
things on the BE changes.

> >>I think all of these fails are caused by the initially bugged
> >>Makefile + Kconfig under mach-omap2. Seems like they can be fixed by
> >>the patches I inlined at the end (will also post them as proper
> >>patches to l-o list after this.) The question is, should Mike go
> >>ahead and merge these along with the base clk patches or how should
> >>we handle them? Patch 1 must be merged, patch 2 is a nice to have one
> >>which allows DRA7 only builds (doing DRA7 only build currently seems
> >>not possible.)
> >
> >If it's OK with Tony, I would suggest having a branch with both patches
> >below which both Tony and Mike merge before merging CCF series. That way
> >we avoid bisection problems.

I can queue those two separately as fixes.
 
> That reminds me, I think the baseline branch for the mach-omap2
> patches is still somewhat unclear to me, what should be used for
> this? And which patches should be put there (the mach-omap2 patches
> depend on the drivers/clk/ti part basically, so I need to put at
> least those there also.)

I would keep the clock patches against some mainline -rc commit if
possible, and if there are non trivial merge conflicts, the omap
to use as the base is commit adfe9361b236154215d4b0fc8b6d79995394b15c.

In any case, it's probably best that Mike merges this all via his
clock tree unless there non-trivial merge conflicts.

Regards,

Tony
