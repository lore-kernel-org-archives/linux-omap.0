From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap iommu: patch for v2.6.34-rc7
Date: Fri, 14 May 2010 12:08:49 -0700
Message-ID: <20100514190849.GZ3428@atomide.com>
References: <20100514.104036.15239017.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49531 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759150Ab0ENTIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 15:08:53 -0400
Content-Disposition: inline
In-Reply-To: <20100514.104036.15239017.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [100514 00:36]:
> Hi Tony,
> 
> The patches was sent on:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27968.html
> 
> The following changes since commit b57f95a38233a2e73b679bea4a5453a1cc2a1cc9:
> 
>   Linux 2.6.34-rc7 (2010-05-09 18:36:28 -0700)
> 
> are available in the git repository at:
>   git://gitorious.org/~doyu/lk/mainline.git v2.6.34-rc7.iommu
> 
> Hiroshi DOYU (5):
>       omap iommu: Introduce iteration macro for iotlb entry scan
>       omap iommu: Make CONFIG_OMAP_IOMMU_DEBUG selectable
>       omap iommu: Insert a gap page between IOVMAs against override
>       omap iommu: Exit iteration if no possibility of available area
>       omap iommu: Reject unaligned addresses at setting page table entry
> 
> Kanigeri, Hari (4):
>       omap iommu: renamed omap3-iommu to omap-iommu
>       omap iommu: support for OMAP4
>       omap iommu: missing check for TLB valid entry
>       omap iommu: add TLB preservation support
> 
>  arch/arm/mach-omap2/Makefile               |    5 +-
>  arch/arm/mach-omap2/iommu2.c               |    6 +-
>  arch/arm/mach-omap2/omap-iommu.c           |  157 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap3-iommu.c          |  105 -------------------
>  arch/arm/plat-omap/Kconfig                 |    9 ++-
>  arch/arm/plat-omap/include/plat/omap44xx.h |    3 +
>  arch/arm/plat-omap/iommu.c                 |  101 ++++++++++++------
>  arch/arm/plat-omap/iovmm.c                 |    9 +-
>  8 files changed, 244 insertions(+), 151 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap-iommu.c
>  delete mode 100644 arch/arm/mach-omap2/omap3-iommu.c

Thanks, I've pulled this into omap-for-linus.

Regards,

Tony
