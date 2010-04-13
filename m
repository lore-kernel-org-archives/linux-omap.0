From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH] omap-3630 NAND: enable NAND io in prefetch-irq mode
Date: Tue, 13 Apr 2010 23:07:24 +0530
Message-ID: <1271180246-31779-13-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1271180246-31779-1-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-2-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-3-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-4-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-5-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-6-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-7-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-8-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-9-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-10-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-11-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-12-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46823 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab0DMRhf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Apr 2010 13:37:35 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3DHbVDg030511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Apr 2010 12:37:34 -0500
In-Reply-To: <1271180246-31779-12-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>

Update config file to enable NAND in prefetch IRQ mode for ZOOM3 and 3630SDP .

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 arch/arm/configs/omap_3630sdp_defconfig |    1 +
 arch/arm/configs/omap_zoom3_defconfig   |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap_3630sdp_defconfig b/arch/arm/configs/omap_3630sdp_defconfig
index a623927..9dfce1a
--- a/arch/arm/configs/omap_3630sdp_defconfig
+++ b/arch/arm/configs/omap_3630sdp_defconfig
@@ -525,6 +525,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_OMAP_PREFETCH=y
 # CONFIG_MTD_NAND_OMAP_PREFETCH_DMA is not set
+CONFIG_MTD_NAND_OMAP_PREFETCH_IRQ=y
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
diff --git a/arch/arm/configs/omap_zoom3_defconfig b/arch/arm/configs/omap_zoom3_defconfig
index 1a12e3e..27b16ed
--- a/arch/arm/configs/omap_zoom3_defconfig
+++ b/arch/arm/configs/omap_zoom3_defconfig
@@ -534,6 +534,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_OMAP_PREFETCH=y
 # CONFIG_MTD_NAND_OMAP_PREFETCH_DMA is not set
+CONFIG_MTD_NAND_OMAP_PREFETCH_IRQ=y
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
-- 
1.5.4.7

