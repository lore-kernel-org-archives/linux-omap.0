From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 0/4][v4]OMAP:IOMMU support for OMAP4 and TLB preservation support
Date: Thu, 22 Apr 2010 18:26:07 -0500
Message-ID: <1271978771-26889-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35267 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772Ab0DVXIV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 19:08:21 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3MN8Kor017181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Apr 2010 18:08:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap <linux-omap@vger.kernel.org> Tony Lindgren
	<tony@atomide.com> Hiroshi Doyu" <Hiroshi.DOYU@nokia.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>

Following are the revised patches addressing the comments from Tony, Felipe, and Hiroshi
to address multi-omap support and make TLB locking mechanism generic.

Hari Kanigeri (4):
  OMAP:iommu renamed omap3-iommu to omap-iommu
  OMAP:iommu support for OMAP4
  OMAP:iommu - missing check for TLB valid entry
  OMAP:iommu- add TLB preservation support

 arch/arm/mach-omap2/Makefile               |    4 +-
 arch/arm/mach-omap2/iommu2.c               |    6 +-
 arch/arm/mach-omap2/omap-iommu.c           |  157 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap3-iommu.c          |  105 -------------------
 arch/arm/plat-omap/include/plat/omap44xx.h |    3 +
 arch/arm/plat-omap/iommu.c                 |   43 +++++---
 6 files changed, 191 insertions(+), 127 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap-iommu.c
 delete mode 100644 arch/arm/mach-omap2/omap3-iommu.c

