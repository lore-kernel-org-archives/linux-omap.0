From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [GIT PULL] omap iommu: updates for 2.6.35-rc1
Date: Mon, 31 May 2010 12:36:37 +0300 (EEST)
Message-ID: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33785 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756267Ab0EaJho (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 05:37:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, x0124230@ti.com

Hi Tony,

Here are the latest updates for omap iommu module.

The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:

  Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)

are available in the git repository at:
  git://gitorious.org/~doyu/lk/mainline.git v2.6.35-rc1-iommu

Hiroshi DOYU (4):
      omap iommu: Introduce iopgd_is_table MACRO
      omap iommu: Rename iopte_[p,v]addr -> iopte_page_[p,v]addr
      omap iommu: move iommu_disable at fault to the above layer
      omap iommu: Make omap-iommu.o built-in

Kanigeri, Hari (3):
      omap iommu: update ducati mmu irq define name
      omap iommu: update irq mask to be specific about twl and tlb
      omap iommu: add functionality to get TLB miss interrupt

Satish (1):
      omap iommu: Fix Memory leak

 arch/arm/mach-omap2/Makefile            |    5 +++-
 arch/arm/mach-omap2/iommu2.c            |   44 ++++++++++++++++++++++++------
 arch/arm/mach-omap2/omap-iommu.c        |    2 +-
 arch/arm/plat-omap/include/plat/iommu.h |    2 +
 arch/arm/plat-omap/iommu.c              |   27 ++++++++++++++++---
 arch/arm/plat-omap/iopgtable.h          |    8 +++--
 arch/arm/plat-omap/iovmm.c              |    4 ++-
 7 files changed, 73 insertions(+), 19 deletions(-)
