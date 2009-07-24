From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [RFC][PATCH 0/3]ARM:OMAP4 iommu-provide support for OMAP4
Date: Fri, 24 Jul 2009 12:21:18 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD3B@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53811 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138AbZGXRVc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 13:21:32 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Pasam, Vijay" <vpasam@ti.com>

Hi,

This series of patches provides IOMMU support for OMAP4 co-processors (Ducati and Tesla).
This series is based of kernel.org 2.6.31-rc1 kernel.

[PATCH 1/3] ARM:OMAP4 iommu:changes in iommu for OMAP4

[PATCH 2/3] ARM:OMAP4 iommu:add omap4 support in iommu

[PATCH 3/3] ARM:OMAP4 iommu:provide build support for omap4 iommu

Summary of changes
=================

arch/arm/mach-omap2/Makefile           |    2 +-
arch/arm/mach-omap2/iommu2.c           |    8 +--
arch/arm/mach-omap2/omap4-iommu.c      |  112 --------------------------------
arch/arm/plat-omap/Kconfig             |    8 +--
arch/arm/plat-omap/include/mach/irqs.h |    2 +-
arch/arm/plat-omap/iommu.c             |   12 +---
6 files changed, 9 insertions(+), 135 deletions(-)
 
The patches can be pulled from
git://dev.omapzoom.org/pub/scm/tisyslink/kernel-syslink.git upstream

May I request you to please provide your comments.

Thank you,
Best regards,
Hari

