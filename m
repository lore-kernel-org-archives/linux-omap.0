From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap iommu: updates for 2.6.35-rc1
Date: Mon, 31 May 2010 15:27:04 +0300
Message-ID: <20100531122703.GD30216@atomide.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56869 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab0EaM07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 08:26:59 -0400
Content-Disposition: inline
In-Reply-To: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, x0124230@ti.com

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [100531 12:32]:
> Hi Tony,
> 
> Here are the latest updates for omap iommu module.
> 
> The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:
> 
>   Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)
> 
> are available in the git repository at:
>   git://gitorious.org/~doyu/lk/mainline.git v2.6.35-rc1-iommu
> 
> Hiroshi DOYU (4):
>       omap iommu: Introduce iopgd_is_table MACRO
>       omap iommu: Rename iopte_[p,v]addr -> iopte_page_[p,v]addr
>       omap iommu: move iommu_disable at fault to the above layer
>       omap iommu: Make omap-iommu.o built-in
> 
> Kanigeri, Hari (3):
>       omap iommu: update ducati mmu irq define name
>       omap iommu: update irq mask to be specific about twl and tlb
>       omap iommu: add functionality to get TLB miss interrupt
> 
> Satish (1):
>       omap iommu: Fix Memory leak

This would be into for-next then. During the -rc cycle we can only
merge real fixes and regressions as requested by Linus:

http://lwn.net/Articles/389982/

Do you want to merge some of these as fixes? Maybe both
"omap iommu: update ducati mmu irq define name" and
"omap iommu: Fix Memory leak" patches should be merged as fixes?
If so, then maybe put together another branch for the fixes.

Also, have all these patches been reviewed also on the
linux-arm-kernel list? I don't want to pull them until that's
done.

BTW, I've put together a quick checklist for merging patches
via git:

http://www.elinux.org/OMAP_patch_merging_process

Cheers,

Tony
