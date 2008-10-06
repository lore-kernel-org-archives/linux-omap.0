From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/10] OMAP clock updates for post 2.6.27
Date: Mon, 6 Oct 2008 08:48:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810060840430.354@utopia.booyaka.com>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002201715.GC12718@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36844 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbYJFOsd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 10:48:33 -0400
In-Reply-To: <20081002201715.GC12718@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, 2 Oct 2008, Russell King - ARM Linux wrote:

> On Thu, Oct 02, 2008 at 10:37:46AM -0600, Paul Walmsley wrote:
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

Sorry about that - thanks for the explanation.

> If you want something more stable and omap related, that can be
> arranged.

That would be great.  Is this the omap-all branch?


- Paul
