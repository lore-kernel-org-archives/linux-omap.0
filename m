From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/10] OMAP clock updates for post 2.6.27
Date: Mon, 6 Oct 2008 16:12:25 +0100
Message-ID: <20081006151225.GB27466@flint.arm.linux.org.uk>
References: <20081002163508.15385.43247.stgit@localhost.localdomain> <20081002201715.GC12718@flint.arm.linux.org.uk> <alpine.DEB.2.00.0810060840430.354@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52439 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbYJFPMg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 11:12:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0810060840430.354@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Mon, Oct 06, 2008 at 08:48:38AM -0600, Paul Walmsley wrote:
> On Thu, 2 Oct 2008, Russell King - ARM Linux wrote:
> 
> > On Thu, Oct 02, 2008 at 10:37:46AM -0600, Paul Walmsley wrote:
> > > The series can be pulled from:
> > > 
> > >    git://git.pwsan.com/linux-2.6 omap-clock-upstream
> > > 
> > > The branch is based on rmk/devel, since powerdomain and clockdomain
> > > changes are not yet in mainline.
> > 
> > I assume then you haven't read the top commit on my devel branch, which
> > reads:
> > 
> >     DO NOT BASE YOUR TREE ON THE DEVEL BRANCH
> > 
> >     Merge branch 'master' into devel
> > 
> > The reason is that 'devel' is a convenience merge branch of currently
> > about 25 other sub-branches for people who want to get the entire lot
> > of changes.  As such, the merges found there are frequently discarded
> > and recreated.
> 
> Sorry about that - thanks for the explanation.
> 
> > If you want something more stable and omap related, that can be
> > arranged.
> 
> That would be great.  Is this the omap-all branch?

Yes - I doubt that there'll be many differences in the changes between
the two, so probably just rebasing them will be sufficient.  (FYI, you
can rebase a range of commits onto another branch using 'git rebase' -
git rebase --onto target-branch first-commit^ branch-name - see the help.)
