From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 0/2] omap:iommu-enable TLB miss interrupt
Date: Mon, 17 May 2010 18:12:28 -0500
Message-ID: <1274137950-18759-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50696 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755886Ab0EQXGa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 May 2010 19:06:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Hari Kanigeri <h-kanigeri2@ti.com>

The current iommu module doesn't provide the mechanism to get MMU fault on
TLB miss when working with locked TLB entries and TWL disabled. 
To get the TLB miss interrupt, the TWL should be disabled.
This patch set provides the mechanism to disable TWL and enable TLB miss
interrupt.

Hari Kanigeri (2):
  omap: iommu-update irq mask to be specific about twl
  omap: iommu-add functionality to get TLB miss interrupt

 arch/arm/mach-omap2/iommu2.c            |   23 +++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/iommu.h |    2 ++
 arch/arm/plat-omap/iommu.c              |   12 ++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

