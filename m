From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] omap iommu: add initial debugfs support
Date: Tue, 11 Aug 2009 12:26:17 +0300
Message-ID: <20090811092617.GR1938@atomide.com>
References: <1248272642-5200-1-git-send-email-Hiroshi.DOYU@nokia.com> <20090811.115337.70184536.Hiroshi.DOYU@nokia.com> <20090811091958.GQ1938@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65078 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbZHKNdZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 09:33:25 -0400
Content-Disposition: inline
In-Reply-To: <20090811091958.GQ1938@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090811 12:19]:
> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [090811 11:54]:
> > Hi Tony,
> > 
> > From: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
> > Subject: [PATCH 1/1] omap iommu: add initial debugfs support
> > Date: Wed, 22 Jul 2009 16:24:02 +0200
> > 
> > > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > > 
> > > This enables to peek the following data.
> > > 
> > > $ /debug/iommu/isp# ls
> > > mem             nr_tlb_entries  regs
> > > mmap            pagetable       tlb
> > > $ /debug/iommu/isp# head pagetable
> > > L:      da:      pa:
> > > -----------------------------------------
> > > 2: 00001000 8ae4a002
> > > 2: 00002000 8e7bb002
> > > 2: 00003000 8ae49002
> > > 2: 00004000 8ae65002
> > > .....
> > > 
> > > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > 
> > Please apply this one too if there's no problem.
> 
> OK, will add it into my omap-upstream queue.

Looks like it needs to be refreshed, can you please repost?

Hunk #1 FAILED at 135.
Hunk #2 succeeded at 166 with fuzz 2 (offset 11 lines).
1 out of 2 hunks FAILED -- rejects in file arch/arm/plat-omap/include/mach/iommu.h
patching file arch/arm/plat-omap/iommu-debug.c
patching file arch/arm/plat-omap/iommu.c
Hunk #1 FAILED at 120.
Hunk #2 FAILED at 148.
Hunk #3 FAILED at 207.
Hunk #4 succeeded at 422 with fuzz 2 (offset 71 lines).
Hunk #5 FAILED at 659.
Hunk #6 FAILED at 670.
Hunk #7 FAILED at 814.
Hunk #8 FAILED at 833.
7 out of 8 hunks FAILED -- rejects in file arch/arm/plat-omap/iommu.c
Patch apply does not apply (enforce with -f)


Regards,

Tony
