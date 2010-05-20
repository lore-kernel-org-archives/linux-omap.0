From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 0/2][v2] omap:iommu-enable TLB miss interrupt
Date: Thu, 20 May 2010 16:10:21 -0500
Message-ID: <1274389823-4051-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43135 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655Ab0ETVD4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 17:03:56 -0400
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
to enable TWL.

Hari Kanigeri (2):
  omap: iommu-update irq mask to be specific about twl and tlb
  omap: iommu-add functionality to get TLB miss interrupt

 arch/arm/mach-omap2/iommu2.c            |   36 ++++++++++++++++++++++++-------
 arch/arm/plat-omap/include/plat/iommu.h |    2 +
 arch/arm/plat-omap/iommu.c              |   17 ++++++++++++++
 3 files changed, 47 insertions(+), 8 deletions(-)

