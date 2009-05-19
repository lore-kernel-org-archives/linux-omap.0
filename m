From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/10] ARM: OMAP2/3: DMA: implement trans copy and const fill
Date: Tue, 19 May 2009 16:38:50 -0700
Message-ID: <20090519233850.12760.62413.stgit@localhost>
References: <20090519232905.12760.15490.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58292 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbZESXiu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 19:38:50 -0400
In-Reply-To: <20090519232905.12760.15490.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Implement transparent copy and constant fill features for OMAP2/3.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c              |   77 +++++++++++++++++++++------------
 arch/arm/plat-omap/include/mach/dma.h |    1 
 2 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 7fc8c04..58d98ad 100644
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
index 54fe966..35fefdb 100644
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -144,6 +144,7 @@
 #define OMAP_DMA4_CSSA_U(n)		0
 #define OMAP_DMA4_CDSA_L(n)		0
 #define OMAP_DMA4_CDSA_U(n)		0
+#define OMAP1_DMA_COLOR(n)		0
 
 /*----------------------------------------------------------------------------*/
 

