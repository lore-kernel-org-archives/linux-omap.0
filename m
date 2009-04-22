From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH] OMAP2/3: DMA: implement trans copy and const fill
Date: Wed, 22 Apr 2009 10:14:38 +0300
Message-ID: <1240384478-9626-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54111 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbZDVHQV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 03:16:21 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3M7FsKh023832
	for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 02:16:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Implement transparent copy and constant fill features for OMAP2/3.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/dma.c              |   81 +++++++++++++++++++++------------
 arch/arm/plat-omap/include/mach/dma.h |    1 +
 2 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 3fd0e77..060ac71 100755
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -310,41 +310,62 @@ EXPORT_SYMBOL(omap_set_dma_transfer_params);
 
 void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 {
-	u16 w;
-
 	BUG_ON(omap_dma_in_1510_mode());
 
-	if (cpu_class_is_omap2()) {
-		REVISIT_24XX();
-		return;
-	}
+	if (cpu_class_is_omap1()) {
+		u16 w;
 
-	w = dma_read(CCR2(lch));
-	w &= ~0x03;
+		w = dma_read(CCR2(lch));
+		w &= ~0x03;
 
-	switch (mode) {
-	case OMAP_DMA_CONSTANT_FILL:
-		w |= 0x01;
-		break;
-	case OMAP_DMA_TRANSPARENT_COPY:
-		w |= 0x02;
-		break;
-	case OMAP_DMA_COLOR_DIS:
-		break;
-	default:
-		BUG();
+		switch (mode) {
+		case OMAP_DMA_CONSTANT_FILL:
+			w |= 0x01;
+			break;
+		case OMAP_DMA_TRANSPARENT_COPY:
+			w |= 0x02;
+			break;
+		case OMAP_DMA_COLOR_DIS:
+			break;
+		default:
+			BUG();
+		}
+		dma_write(w, CCR2(lch));
+
+		w = dma_read(LCH_CTRL(lch));
+		w &= ~0x0f;
+		/* Default is channel type 2D */
+		if (mode) {
+			dma_write((u16)color, COLOR_L(lch));
+			dma_write((u16)(color >> 16), COLOR_U(lch));
+			w |= 1;		/* Channel type G */
+		}
+		dma_write(w, LCH_CTRL(lch));
 	}
-	dma_write(w, CCR2(lch));
 
-	w = dma_read(LCH_CTRL(lch));
-	w &= ~0x0f;
-	/* Default is channel type 2D */
-	if (mode) {
-		dma_write((u16)color, COLOR_L(lch));
-		dma_write((u16)(color >> 16), COLOR_U(lch));
-		w |= 1;		/* Channel type G */
+	if (cpu_class_is_omap2()) {
+		u32 val;
+
+		val = dma_read(CCR(lch));
+		val &= ~((1 << 17) | (1 << 16));
+
+		switch (mode) {
+		case OMAP_DMA_CONSTANT_FILL:
+			val |= 1 << 16;
+			break;
+		case OMAP_DMA_TRANSPARENT_COPY:
+			val |= 1 << 17;
+			break;
+		case OMAP_DMA_COLOR_DIS:
+			break;
+		default:
+			BUG();
+		}
+		dma_write(val, CCR(lch));
+
+		color &= 0xffffff;
+		dma_write(color, COLOR(lch));
 	}
-	dma_write(w, LCH_CTRL(lch));
 }
 EXPORT_SYMBOL(omap_set_dma_color_mode);
 
diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-omap/include/mach/dma.h
index 224b077..4e34f47 100644
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -144,6 +144,7 @@
 #define OMAP_DMA4_CSSA_U(n)		0
 #define OMAP_DMA4_CDSA_L(n)		0
 #define OMAP_DMA4_CDSA_U(n)		0
+#define OMAP1_DMA_COLOR(n)		0
 
 /*----------------------------------------------------------------------------*/
 
-- 
1.6.1.2

