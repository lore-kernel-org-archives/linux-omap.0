From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: omap iommu: patch for v2.6.34-rc7
Date: Fri, 14 May 2010 10:40:36 +0300 (EEST)
Message-ID: <20100514.104036.15239017.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43957 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757476Ab0ENHlB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 03:41:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

Hi Tony,

The patches was sent on:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg27968.html

The following changes since commit b57f95a38233a2e73b679bea4a5453a1cc2a1cc9:

  Linux 2.6.34-rc7 (2010-05-09 18:36:28 -0700)

are available in the git repository at:
  git://gitorious.org/~doyu/lk/mainline.git v2.6.34-rc7.iommu

Hiroshi DOYU (5):
      omap iommu: Introduce iteration macro for iotlb entry scan
      omap iommu: Make CONFIG_OMAP_IOMMU_DEBUG selectable
      omap iommu: Insert a gap page between IOVMAs against override
      omap iommu: Exit iteration if no possibility of available area
      omap iommu: Reject unaligned addresses at setting page table entry

Kanigeri, Hari (4):
      omap iommu: renamed omap3-iommu to omap-iommu
      omap iommu: support for OMAP4
      omap iommu: missing check for TLB valid entry
      omap iommu: add TLB preservation support

 arch/arm/mach-omap2/Makefile               |    5 +-
 arch/arm/mach-omap2/iommu2.c               |    6 +-
 arch/arm/mach-omap2/omap-iommu.c           |  157 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap3-iommu.c          |  105 -------------------
 arch/arm/plat-omap/Kconfig                 |    9 ++-
 arch/arm/plat-omap/include/plat/omap44xx.h |    3 +
 arch/arm/plat-omap/iommu.c                 |  101 ++++++++++++------
 arch/arm/plat-omap/iovmm.c                 |    9 +-
 8 files changed, 244 insertions(+), 151 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap-iommu.c
 delete mode 100644 arch/arm/mach-omap2/omap3-iommu.c
