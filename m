From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [GIT PULL] OMAP DSS changes for .38 merge window
Date: Fri, 07 Jan 2011 15:37:32 +0200
Message-ID: <1294407452.3968.81.camel@nubuntu>
References: <1294404103.3968.56.camel@nubuntu>
	 <20110107132541.GA31660@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:57053 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab1AGNhh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 08:37:37 -0500
In-Reply-To: <20110107132541.GA31660@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Mundt <lethal@linux-sh.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>

On Fri, 2011-01-07 at 22:25 +0900, ext Paul Mundt wrote:
> On Fri, Jan 07, 2011 at 02:41:43PM +0200, Tomi Valkeinen wrote:
> > Hello Paul,
> > 
> > Here are some OMAP display changes for .38. I hope they are not too
> > late, but the holidays messed up my schedules a bit.
> > 
> No, no problem. I usually aim to do two merges per merge window on
> average, one at the beginning and one nearer the end. There are often
> many patches that have dependencies that are blocked while other trees
> merge that get sent off when their dependencies have been met.

Ok, good. There are still some patches going around reviews that would
be nice to get in .38, but time is running short so I decided to send
the current patches.

I guess it's not out-of-the-question to get driver changes in in early
rcs, but I'd rather get everything pulled during the merge window. Also,
some of the patches still out there touch OMAP's arch/ files, so they
are not plain driver changes.

> 
> > I made two branches, as I'm not sure which is better:
> > 
> > for-paul-38 - This one is the original non-rebased branch. This causes a
> > trivial conflict with fbdev/master in drivers/video/omap2/vram.c (SZ_2M
> > is the right one), and also it contains a patch (memblock: fix
> > memblock_is_region_memory()) which is not yet in mainline, but is in
> > Andrew Morton's tree.
> > 
> > for-paul-38-rebased - The above branch rebased on top of v2.6.37, and
> > the memblock commit removed.
> > 
> > Which one you prefer? Or is there some other way I should handle this?
> > 
> > I could merge v2.6.37 to my branch, which would remove the conflict, but
> > that would still leave the memblock patch. I guess the patch is going in
> > soon, but as it's not in my area, I don't feel it's right to get it in
> > via my patch set. Alternatively I could wait until the patch is in
> > Linus' tree, but that could make it tight to be in time for the merge
> > window.
> > 
> Andrew usually patch-bombs near the end of the window, so it's generally
> a good idea to have things settled before then. In this case if the patch
> is already destined for mainline then I can just pull the rebased branch,
> send that out, and then once -mm syncs up everything should be good to go
> for -rc1.
> 
> Looking at the change in question, it's just a correctness fix and
> doesn't impact the API from the driver point of view, so at least there
> won't be build damage if they're out of sync for a couple of days
> (although it may trigger some nasty surprises for anyone unlucky enough
> to bisect in the middle).
> 
> In any event, unless you absolutely need the change to be upstream first,
> I'll plan to pull the rebase branch. If you need it there earlier we can
> probably also just prod Andrew and get that one patch off earlier than
> the rest of the -mm bits.

No, the fix is not needed urgently. The memblock fix is only important
for some rare use cases, which I don't think anyone is currently using
(allocating video memory from SDRAM at a predefined address).

 Tomi


