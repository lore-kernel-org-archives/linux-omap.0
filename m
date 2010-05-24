From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 0/3][v3] omap:iommu-enable TLB miss interrupt
Date: Sun, 23 May 2010 21:01:49 -0500
Message-ID: <1274666512-19765-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42000 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890Ab0EXBzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 May 2010 21:55:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Hari Kanigeri <h-kanigeri2@ti.com>

The current iommu module doesn't provide the mechanism to get MMU fault on
TLB miss when working with locked TLB entries and TWL disabled.
To get the TLB miss interrupt, the TWL should be disabled.
This patch set provides the option to enable/disable TWL and to enable TLB miss
interrupt.

Based on Hiroshi, the initial patch set was revised to add more flexibility
to enable TWL and cleanup the part of the code that had layering violations.
https://patchwork.kernel.org/patch/101336/

Hari Kanigeri (2):
  omap: iommu-update irq mask to be specific about twl and tlb
  omap: iommu-add functionality to get TLB miss interrupt

Hiroshi DOYU (1):
  omap iommu: move iommu_disable at fault to the above layer

 arch/arm/mach-omap2/iommu2.c            |   44 ++++++++++++++++++++++++------
 arch/arm/plat-omap/include/plat/iommu.h |    2 +
 arch/arm/plat-omap/iommu.c              |   19 +++++++++++++
 3 files changed, 56 insertions(+), 9 deletions(-)

