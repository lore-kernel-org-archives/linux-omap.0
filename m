From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap: OMAP_IOMMU not visible in menuconfig
Date: Wed,  8 Sep 2010 20:21:21 +0530
Message-ID: <1283957481-16682-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58725 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902Ab0IHOv1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Sep 2010 10:51:27 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o88EpOs2023108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 8 Sep 2010 09:51:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The menu option to select CONFIG_OMAP_IOMMU
was not visible in the menuconfig due to missing
description.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/plat-omap/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e39a417..2a114a9 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -98,7 +98,7 @@ config OMAP_MBOX_KFIFO_SIZE
 	  module parameter).
 
 config OMAP_IOMMU
-	tristate
+	tristate "OMAP IOMMU support"
 
 config OMAP_IOMMU_DEBUG
        tristate "Export OMAP IOMMU internals in DebugFS"
-- 
1.6.2.4

