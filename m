From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [GIT PULL] OMAP DSS changes for .38 merge window
Date: Fri, 7 Jan 2011 22:25:41 +0900
Message-ID: <20110107132541.GA31660@linux-sh.org>
References: <1294404103.3968.56.camel@nubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:48465 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab1AGN1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 08:27:42 -0500
Content-Disposition: inline
In-Reply-To: <1294404103.3968.56.camel@nubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>

On Fri, Jan 07, 2011 at 02:41:43PM +0200, Tomi Valkeinen wrote:
> Hello Paul,
> 
> Here are some OMAP display changes for .38. I hope they are not too
> late, but the holidays messed up my schedules a bit.
> 
No, no problem. I usually aim to do two merges per merge window on
average, one at the beginning and one nearer the end. There are often
many patches that have dependencies that are blocked while other trees
merge that get sent off when their dependencies have been met.

> I made two branches, as I'm not sure which is better:
> 
> for-paul-38 - This one is the original non-rebased branch. This causes a
> trivial conflict with fbdev/master in drivers/video/omap2/vram.c (SZ_2M
> is the right one), and also it contains a patch (memblock: fix
> memblock_is_region_memory()) which is not yet in mainline, but is in
> Andrew Morton's tree.
> 
> for-paul-38-rebased - The above branch rebased on top of v2.6.37, and
> the memblock commit removed.
> 
> Which one you prefer? Or is there some other way I should handle this?
> 
> I could merge v2.6.37 to my branch, which would remove the conflict, but
> that would still leave the memblock patch. I guess the patch is going in
> soon, but as it's not in my area, I don't feel it's right to get it in
> via my patch set. Alternatively I could wait until the patch is in
> Linus' tree, but that could make it tight to be in time for the merge
> window.
> 
Andrew usually patch-bombs near the end of the window, so it's generally
a good idea to have things settled before then. In this case if the patch
is already destined for mainline then I can just pull the rebased branch,
send that out, and then once -mm syncs up everything should be good to go
for -rc1.

Looking at the change in question, it's just a correctness fix and
doesn't impact the API from the driver point of view, so at least there
won't be build damage if they're out of sync for a couple of days
(although it may trigger some nasty surprises for anyone unlucky enough
to bisect in the middle).

In any event, unless you absolutely need the change to be upstream first,
I'll plan to pull the rebase branch. If you need it there earlier we can
probably also just prod Andrew and get that one patch off earlier than
the rest of the -mm bits.
