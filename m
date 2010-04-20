From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH 0/3][V2] OMAP:  IOMMU patches to support OMAP4 and TLB
 preservation support
Date: Tue, 20 Apr 2010 16:30:47 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B3445E3@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59878 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755418Ab0DTVaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 17:30:55 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>

Following are the revised patches addressing the comments from Santosh, Felipe, and Hiroshi.

The detailed changed list is:

Hari Kanigeri(3):
	OMAP:iommu support for OMAP4
	OMAP:iommu - missing check for TLB valid entry
	OMAP:iommu- add TLB preservation support


 arch/arm/mach-omap2/Makefile               |    4 +-
 arch/arm/mach-omap2/iommu2.c               |    6 +-
 arch/arm/mach-omap2/omap-iommu.c           |  134 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap3-iommu.c          |  105 ----------------------
 arch/arm/plat-omap/include/plat/omap44xx.h |    3 +
 arch/arm/plat-omap/iommu.c                 |   13 ++-
 6 files changed, 151 insertions(+), 114 deletions(-)

Thank you,
Best regards,
Hari

