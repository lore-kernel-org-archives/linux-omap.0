From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap iommu: for-next for 2.6.35-rc1
Date: Fri, 2 Jul 2010 12:04:11 +0300
Message-ID: <20100702090411.GH6632@atomide.com>
References: <20100602.105054.59678037.Hiroshi.DOYU@nokia.com>
 <20100629.075744.104054771.Hiroshi.DOYU@nokia.com>
 <20100702.093534.115912504.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60944 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757954Ab0GBJED (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 05:04:03 -0400
Content-Disposition: inline
In-Reply-To: <20100702.093534.115912504.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [100702 09:29]:
> 
> Do you have any plan for pulling for-next patches?
> 
> I have some "omap iommu" and "omap mailbox" patches for for-next. Now
> the merge window seems so small and I don't want to miss it.

Pulled now into omap-for-linus for the next merge window. Sorry
for the delay.

BTW, I did not add that Makefile fix into omap-fixes-for-linus,
I figured we should first make sure to get the pending fixes
in, and then maybe do another set of fixes.

But looks like that's in your for-next, so we might as well
keep it there. If there's urgent need to get that in as a fix,
let me know ASAP, I can still rebuild omap-for-linus as that's
the only set merged there.

Regards,

Tony
 
> > The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:
> > 
> >   Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)
> > 
> > are available in the git repository at:
> >   git://gitorious.org/~doyu/lk/mainline.git v2.6.35-rc3-iommu-for-next
> > 
> > Hiroshi DOYU (4):
> >       omap iommu: Introduce iopgd_is_table MACRO
> >       omap iommu: Rename iopte_[p,v]addr -> iopte_page_[p,v]addr
> >       omap iommu: move iommu_disable at fault to the above layer
> >       omap iommu: Make omap-iommu.o built-in
> > 
> > Kanigeri, Hari (3):
> >       omap iommu: update irq mask to be specific about twl and tlb
> >       omap iommu: add functionality to get TLB miss interrupt
> >       omap iommu: update ducati mmu irq define name
> > 
> >  arch/arm/mach-omap2/Makefile            |    5 +++-
> >  arch/arm/mach-omap2/iommu2.c            |   44 ++++++++++++++++++++++++------
> >  arch/arm/mach-omap2/omap-iommu.c        |    2 +-
> >  arch/arm/plat-omap/include/plat/iommu.h |    2 +
> >  arch/arm/plat-omap/iommu.c              |   27 ++++++++++++++++---
> >  arch/arm/plat-omap/iopgtable.h          |    8 +++--
> >  6 files changed, 70 insertions(+), 18 deletions(-)
