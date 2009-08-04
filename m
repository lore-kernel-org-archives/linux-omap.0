From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [PATCH v1 0/3] ARM:OMAP4 iommu-provide support for OMAP4
Date: Tue, 4 Aug 2009 17:29:45 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3ABDBABA@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51197 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbZHDW35 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 18:29:57 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>


Hi,

Please find the revised set of patches based on the comments received on initial patch set.
Reference: http://marc.info/?l=linux-omap&m=124845609532585&w=2

This patch set fixes the following issues in the original patch set.
============================================

- Use if (!cpu_is_omap44xx()) check instead of compile flag CONFIG_ARCH_OMAP4 (Comment by: Hiroshi Doyu)

- Remove "depends on ARCH_OMAP" for IOMMU menu option (Comment by: Hiroshi Doyu)

- Remove clock names from IOMMU declarations (Comment by: Felipe Balbi)

- Fixed the copy right year to 2008-2009 (Comment by: Santosh Shilimkar)


Summary of changes:
=================
 arch/arm/mach-omap2/Makefile           |    2 +-
 arch/arm/mach-omap2/iommu2.c           |    8 +--
 arch/arm/mach-omap2/omap4-iommu.c      |  110 --------------------------------
 arch/arm/plat-omap/Kconfig             |    7 +--
 arch/arm/plat-omap/include/mach/irqs.h |    2 +-
 arch/arm/plat-omap/iommu.c             |   12 +---
 6 files changed, 10 insertions(+), 131 deletions(-)

The patches can be pulled from
git://dev.omapzoom.org/pub/scm/tisyslink/kernel-syslink.git upstream

Thank you,
Best regards,
Hari

