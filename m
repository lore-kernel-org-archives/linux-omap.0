From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [GIT PULL] omap iommu: for-next for 2.6.35-rc1
Date: Wed, 02 Jun 2010 10:50:54 +0300 (EEST)
Message-ID: <20100602.105054.59678037.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44361 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab0FBHvM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 03:51:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

Hi Tony,

Patches for for-next for omap iommu module.

The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:

  Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)

are available in the git repository at:
  git://gitorious.org/~doyu/lk/mainline.git v2.6.35-rc1-iommu

Hiroshi DOYU (3):
      omap iommu: Introduce iopgd_is_table MACRO
      omap iommu: Rename iopte_[p,v]addr -> iopte_page_[p,v]addr
      omap iommu: move iommu_disable at fault to the above layer

Kanigeri, Hari (2):
      omap iommu: update irq mask to be specific about twl and tlb
      omap iommu: add functionality to get TLB miss interrupt

 arch/arm/mach-omap2/iommu2.c            |   44 ++++++++++++++++++++++++------
 arch/arm/plat-omap/include/plat/iommu.h |    2 +
 arch/arm/plat-omap/iommu.c              |   27 ++++++++++++++++---
 arch/arm/plat-omap/iopgtable.h          |    8 +++--
 4 files changed, 65 insertions(+), 16 deletions(-)
