From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH] ARM: OMAP2+: dma: Define dma capabilities register bitfields and use them.
Date: Fri, 4 May 2012 12:59:42 +0530
Message-ID: <1336116582-11099-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50973 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab2EDH3t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 03:29:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: santosh.shilimkar@ti.com, r.sricharan@ti.com

The system dma module has capabiities register indicating
the support for descriptor loading, constant fill, etc.
Use this instead of OMAP revision check to identify the features
supported runtime.

This avoids patching the code for feature SOCs which has
those capabilities.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/dma.c             |   11 +++++++----
 arch/arm/plat-omap/include/plat/dma.h |    5 +++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index b19d849..ff75abe 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -227,10 +227,6 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 
 	dma_stride		= OMAP2_DMA_STRIDE;
 	dma_common_ch_start	= CSDP;
-	if (cpu_is_omap3630() || cpu_is_omap44xx())
-		dma_common_ch_end = CCDN;
-	else
-		dma_common_ch_end = CCFN;
 
 	p = kzalloc(sizeof(struct omap_system_dma_plat_info), GFP_KERNEL);
 	if (!p) {
@@ -277,6 +273,13 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 		dev_err(&pdev->dev, "%s: kzalloc fail\n", __func__);
 		return -ENOMEM;
 	}
+
+	/* Check the capabilities register for descriptor loading feature */
+	if (dma_read(CAPS_0, 0) & DMA_HAS_DESCRIPTOR_CAPS)
+		dma_common_ch_end = CCDN;
+	else
+		dma_common_ch_end = CCFN;
+
 	return 0;
 }
 
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index dc562a5..7742204 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -312,6 +312,11 @@
 #define CLEAR_CSR_ON_READ		BIT(0xC)
 #define IS_WORD_16			BIT(0xD)
 
+/* Defines for DMA Capabilities */
+#define DMA_HAS_TRANSPARENT_CAPS	(0x1 << 18)
+#define DMA_HAS_CONSTANT_FILL_CAPS	(0x1 << 19)
+#define DMA_HAS_DESCRIPTOR_CAPS		(0x3 << 20)
+
 enum omap_reg_offsets {
 
 GCR,		GSCR,		GRST1,		HW_ID,
-- 
1.7.1

