From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH 01/11] OMAP: DMA: Introduce DMA device attributes
Date: Thu, 29 Jul 2010 15:28:55 +0530
Message-ID: <1280397545-27323-2-git-send-email-manjugk@ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59290 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756400Ab0G2KBC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jul 2010 06:01:02 -0400
In-Reply-To: <1280397545-27323-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Anand Sawant <sawant@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Basak Partha <p-basak2@ti.com>, Charulatha V <charu@ti.com>

This patches introduces OMAP DMA device attributes for using the same in
DMA platform driver for all OMAP's and HWMOD database(OMAP2PLUS onwards)

Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/plat-omap/include/plat/dma.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 02232ca..ff60f11 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -398,6 +398,22 @@
 #define DMA_CH_PRIO_HIGH		0x1
 #define DMA_CH_PRIO_LOW			0x0 /* Def */
 
+/* Attributes for OMAP DMA Contrllers */
+#define ENABLE_1510_MODE		(1 << 0)
+#define DMA_LINKED_LCH			(1 << 1)
+#define GLOBAL_PRIORITY			(1 << 2)
+#define RESERVE_CHANNEL			(1 << 3)
+#define SRC_PORT			(2 << 3)
+#define DST_PORT			(2 << 4)
+#define IS_CSSA_32			(2 << 5)
+#define IS_CDSA_32			(2 << 6)
+#define SRC_INDEX			(4 << 6)
+#define DST_INDEX			(4 << 7)
+#define IS_BURST_ONLY4			(4 << 8)
+#define CLEAR_CSR_ON_READ		(4 << 9)
+#define IS_WORD_16			(8 << 9)
+#define IS_RW_PRIORIY			(8 << 0xA)
+
 enum omap_dma_burst_mode {
 	OMAP_DMA_DATA_BURST_DIS = 0,
 	OMAP_DMA_DATA_BURST_4,
@@ -463,6 +479,12 @@ struct omap_dma_channel_params {
 #endif
 };
 
+struct omap_dma_dev_attr {
+	u32 dma_dev_attr;
+	u16 dma_lch_count;
+	u16 dma_chan_count;
+	struct omap_dma_lch *dma_chan;
+};
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
-- 
1.7.0.4

