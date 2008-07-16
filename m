From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git pull request for omap patches for post 2.6.26
Date: Wed, 16 Jul 2008 11:01:24 +0300
Message-ID: <20080716080121.GA31248@atomide.com>
References: <20080703101139.GE14276@atomide.com> <20080707200537.GP29191@flint.arm.linux.org.uk> <20080708074005.GA17594@atomide.com> <20080716071835.GB30135@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50665 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbYGPH75 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 03:59:57 -0400
Content-Disposition: inline
In-Reply-To: <20080716071835.GB30135@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080716 10:18]:
> Russell,
> 
> * Tony Lindgren <tony@atomide.com> [080708 10:39]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [080707 23:06]:
> > > On Thu, Jul 03, 2008 at 01:11:42PM +0300, Tony Lindgren wrote:
> > > > Please pull the omap patches for post-2.6.26 from:
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap2-upstream
> > > 
> > > I pulled this some time back but never merged it - but I did look at it.
> > > 
> > > However, I never got around to looking at your other patches on the
> > > mailing list I'm afraid.
> > 
> > Yes, I think you've only commented on the patches in the first series
> > so far. Let me know if you have any comments on the other patches
> > and I'll fix them ASAP.
> 
> If you are swamped with looking at the patches and want to only
> pull the first omap series out of the three, then you can pull only the
> omap-upstream branch.
> 
> Unfortunately this option would then leave omap2-clock and omap2-upstream
> patches to the next merge window.

Well looks like all omap-upstream and few omap2-clock patches have been
merged. I've rebased the remaining omap2-clock and omap2-upstream
patches. Will repost those two series.


> > Basically once these patches are merged, we're a only missing board-*.c
> > files under mach-omap2 to be again mostly in sync with mainline tree for
> > mach-omap2. So hopefully only one more merge window of lots of patches
> > after this merge window!
> > 
> > Currently plat-omap and mach-omap1 are pretty close in sync with
> > mainline tree except for some board-*.c under mach-omap1.
> > 
> > > Looking at what's in this git tree, there's at least a number of commits
> > > early on which are empty.  I've not really looked much further.
> > 
> > Looks like there were the two already merged fixed still there, I've
> > run stg clean on the series and rebased against 2.6.26-rc9. I've also
> > verified that the series applies against your current tree. The location
> > to pull from is same as earlier.
> > 
> > > Since I've only just remembered about this, I think I'm going to have to
> > > say "no more" to further community PXA commits this side of the merge
> > > window to make sufficient time to look at your OMAP stuff properly.
> > 
> > It would be nice to have merging mach-* patches more distributed so
> > you don't have to spend so much time looking at that stuff.
> > 
> > Regards,
> > 
> > Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
