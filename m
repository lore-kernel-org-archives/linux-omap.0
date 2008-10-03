From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] OMAP clock updates for post 2.6.27
Date: Fri, 3 Oct 2008 09:38:22 +0300
Message-ID: <20081003063817.GH23962@atomide.com>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002201715.GC12718@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60115 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbYJCGfg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 02:35:36 -0400
Content-Disposition: inline
In-Reply-To: <20081002201715.GC12718@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081002 23:17]:
> On Thu, Oct 02, 2008 at 10:37:46AM -0600, Paul Walmsley wrote:
> > This patch series updates the OMAP2/3 clock tree. Some patches are
> > from Tony's previous omap2-upstream series, and were already posted to
> > linux-arm-kernel and reviewed[1].  The remaining patches are mostly
> > clockdomain updates.
> 
> Great.
> 
> > The series can be pulled from:
> > 
> >    git://git.pwsan.com/linux-2.6 omap-clock-upstream
> > 
> > The branch is based on rmk/devel, since powerdomain and clockdomain
> > changes are not yet in mainline.
> 
> I assume then you haven't read the top commit on my devel branch, which
> reads:
> 
>     DO NOT BASE YOUR TREE ON THE DEVEL BRANCH
> 
>     Merge branch 'master' into devel
> 
> The reason is that 'devel' is a convenience merge branch of currently
> about 25 other sub-branches for people who want to get the entire lot
> of changes.  As such, the merges found there are frequently discarded
> and recreated.

Sorry, there's been some miscommunication here. The idea was just to post
the patches for review, and then have them pullable for you after you've
gotten your current devel into the mainline.

> If you want something more stable and omap related, that can be
> arranged.

Yeah if you have some commit that we can have the patches rebased on
before you merge with mainline, that would be great.

The current plan is to have following series of patches pullable
for you:

- Remaining 8 patches from previous omap2-upstream that you already
  looked before the header move. I'll repost these as they've shrank
  quite a bit with your recent changes.

- McBSP patches already posted last week.

- One new patch for sram to make omap3 support compile. Not yet posted,
  will try to get this posted today.

- Minimal board support for Beagle and Overo. Not yet posted, will try
  to get this posted today also.

- Then these 10 patches from Paul if you have enough time to look
  through them.

I'll also post the MMC init clean up, but that won't happen until
next week. Anyways, lots of patches but that gets minimal omap3 booting
with mainline.

Tony
