From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v3 03/13] OMAP: DMA: Introduce DMA device attributes
Date: Tue, 26 Oct 2010 18:55:03 +0530
Message-ID: <1288099513-1854-4-git-send-email-manjugk@ti.com>
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57741 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932116Ab0JZNZA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 09:25:00 -0400
In-Reply-To: <1288099513-1854-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch introduces OMAP DMA device attributes for using the same in
DMA platform driver for all OMAP's and HWMOD database(OMAP2PLUS onwards)

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/include/plat/dma.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 5e28d26..9757b22 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -296,6 +296,22 @@
 #define DMA_ERRATA_i88			(1 << 4)
 #define DMA_ERRATA_3_3			(1 << 5)
 
+/* Attributes for OMAP DMA Contrllers */
+#define ENABLE_1510_MODE		(1 << 0x0)
+#define DMA_LINKED_LCH			(1 << 0x1)
+#define GLOBAL_PRIORITY			(1 << 0x2)
+#define RESERVE_CHANNEL			(1 << 0x3)
+#define SRC_PORT			(1 << 0x4)
+#define DST_PORT			(1 << 0x5)
+#define IS_CSSA_32			(1 << 0x6)
+#define IS_CDSA_32			(1 << 0x7)
+#define SRC_INDEX			(1 << 0x8)
+#define DST_INDEX			(1 << 0x9)
+#define IS_BURST_ONLY4			(1 << 0xA)
+#define CLEAR_CSR_ON_READ		(1 << 0xB)
+#define IS_WORD_16			(1 << 0xC)
+#define IS_RW_PRIORITY			(1 << 0xD)
+
 enum omap_dma_burst_mode {
 	OMAP_DMA_DATA_BURST_DIS = 0,
 	OMAP_DMA_DATA_BURST_4,
@@ -361,6 +377,10 @@ struct omap_dma_channel_params {
 #endif
 };
 
+struct omap_dma_dev_attr {
+	u32 dev_caps;
+	u16 lch_count;
+};
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
-- 
1.7.1

