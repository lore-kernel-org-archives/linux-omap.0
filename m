From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 20/59] omap: namespace cleanup to arch/arm/plat-omap/dma.c
Date: Wed, 12 Nov 2008 00:56:39 +0200
Message-ID: <1226444238-14614-21-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40067 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbYKKXBV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:01:21 -0500
In-Reply-To: <1226444238-14614-20-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/dma.c |   86 +++++++++++++++++++++++-----------------------
 1 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c4e5ba3..8a67a45 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -177,7 +177,7 @@ static inline int get_gdma_dev(int req)
 	u32 reg = OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
 	int shift = ((req - 1) % 5) * 6;
 
-	return ((omap_readl(reg) >> shift) & 0x3f) + 1;
+	return ((__raw_readl(reg) >> shift) & 0x3f) + 1;
 }
 
 static inline void set_gdma_dev(int req, int dev)
@@ -186,10 +186,10 @@ static inline void set_gdma_dev(int req, int dev)
 	int shift = ((req - 1) % 5) * 6;
 	u32 l;
 
-	l = omap_readl(reg);
+	l = __raw_readl(reg);
 	l &= ~(0x3f << shift);
 	l |= (dev - 1) << shift;
-	omap_writel(l, reg);
+	__raw_writel(l, reg);
 }
 #else
 #define set_gdma_dev(req, dev)	do {} while (0)
@@ -228,10 +228,10 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 			BUG();
 			return;
 		}
-		l = omap_readl(reg);
+		l = __raw_readl(reg);
 		l &= ~(0xf << 8);
 		l |= (priority & 0xf) << 8;
-		omap_writel(l, reg);
+		__raw_writel(l, reg);
 	}
 
 	if (cpu_class_is_omap2()) {
@@ -1086,7 +1086,7 @@ int omap_dma_running(void)
 
 	/* Check if LCD DMA is running */
 	if (cpu_is_omap16xx())
-		if (omap_readw(OMAP1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
+		if (__raw_readw(OMAP1610_DMA_LCD_CCR) & OMAP_DMA_CCR_EN)
 			return 1;
 
 	for (lch = 0; lch < dma_chan_count; lch++)
@@ -2126,63 +2126,63 @@ static void set_b1_regs(void)
 	}
 
 	if (omap_dma_in_1510_mode()) {
-		omap_writew(top >> 16, OMAP1510_DMA_LCD_TOP_F1_U);
-		omap_writew(top, OMAP1510_DMA_LCD_TOP_F1_L);
-		omap_writew(bottom >> 16, OMAP1510_DMA_LCD_BOT_F1_U);
-		omap_writew(bottom, OMAP1510_DMA_LCD_BOT_F1_L);
+		__raw_writew(top >> 16, OMAP1510_DMA_LCD_TOP_F1_U);
+		__raw_writew(top, OMAP1510_DMA_LCD_TOP_F1_L);
+		__raw_writew(bottom >> 16, OMAP1510_DMA_LCD_BOT_F1_U);
+		__raw_writew(bottom, OMAP1510_DMA_LCD_BOT_F1_L);
 
 		return;
 	}
 
 	/* 1610 regs */
-	omap_writew(top >> 16, OMAP1610_DMA_LCD_TOP_B1_U);
-	omap_writew(top, OMAP1610_DMA_LCD_TOP_B1_L);
-	omap_writew(bottom >> 16, OMAP1610_DMA_LCD_BOT_B1_U);
-	omap_writew(bottom, OMAP1610_DMA_LCD_BOT_B1_L);
+	__raw_writew(top >> 16, OMAP1610_DMA_LCD_TOP_B1_U);
+	__raw_writew(top, OMAP1610_DMA_LCD_TOP_B1_L);
+	__raw_writew(bottom >> 16, OMAP1610_DMA_LCD_BOT_B1_U);
+	__raw_writew(bottom, OMAP1610_DMA_LCD_BOT_B1_L);
 
-	omap_writew(en, OMAP1610_DMA_LCD_SRC_EN_B1);
-	omap_writew(fn, OMAP1610_DMA_LCD_SRC_FN_B1);
+	__raw_writew(en, OMAP1610_DMA_LCD_SRC_EN_B1);
+	__raw_writew(fn, OMAP1610_DMA_LCD_SRC_FN_B1);
 
-	w = omap_readw(OMAP1610_DMA_LCD_CSDP);
+	w = __raw_readw(OMAP1610_DMA_LCD_CSDP);
 	w &= ~0x03;
 	w |= lcd_dma.data_type;
-	omap_writew(w, OMAP1610_DMA_LCD_CSDP);
+	__raw_writew(w, OMAP1610_DMA_LCD_CSDP);
 
-	w = omap_readw(OMAP1610_DMA_LCD_CTRL);
+	w = __raw_readw(OMAP1610_DMA_LCD_CTRL);
 	/* Always set the source port as SDRAM for now*/
 	w &= ~(0x03 << 6);
 	if (lcd_dma.callback != NULL)
 		w |= 1 << 1;		/* Block interrupt enable */
 	else
 		w &= ~(1 << 1);
-	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
+	__raw_writew(w, OMAP1610_DMA_LCD_CTRL);
 
 	if (!(lcd_dma.rotate || lcd_dma.mirror ||
 	      lcd_dma.vxres || lcd_dma.xscale || lcd_dma.yscale))
 		return;
 
-	w = omap_readw(OMAP1610_DMA_LCD_CCR);
+	w = __raw_readw(OMAP1610_DMA_LCD_CCR);
 	/* Set the double-indexed addressing mode */
 	w |= (0x03 << 12);
-	omap_writew(w, OMAP1610_DMA_LCD_CCR);
+	__raw_writew(w, OMAP1610_DMA_LCD_CCR);
 
-	omap_writew(ei, OMAP1610_DMA_LCD_SRC_EI_B1);
-	omap_writew(fi >> 16, OMAP1610_DMA_LCD_SRC_FI_B1_U);
-	omap_writew(fi, OMAP1610_DMA_LCD_SRC_FI_B1_L);
+	__raw_writew(ei, OMAP1610_DMA_LCD_SRC_EI_B1);
+	__raw_writew(fi >> 16, OMAP1610_DMA_LCD_SRC_FI_B1_U);
+	__raw_writew(fi, OMAP1610_DMA_LCD_SRC_FI_B1_L);
 }
 
 static irqreturn_t lcd_dma_irq_handler(int irq, void *dev_id)
 {
 	u16 w;
 
-	w = omap_readw(OMAP1610_DMA_LCD_CTRL);
+	w = __raw_readw(OMAP1610_DMA_LCD_CTRL);
 	if (unlikely(!(w & (1 << 3)))) {
 		printk(KERN_WARNING "Spurious LCD DMA IRQ\n");
 		return IRQ_NONE;
 	}
 	/* Ack the IRQ */
 	w |= (1 << 3);
-	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
+	__raw_writew(w, OMAP1610_DMA_LCD_CTRL);
 	lcd_dma.active = 0;
 	if (lcd_dma.callback != NULL)
 		lcd_dma.callback(w, lcd_dma.cb_data);
@@ -2228,7 +2228,7 @@ void omap_free_lcd_dma(void)
 		return;
 	}
 	if (!enable_1510_mode)
-		omap_writew(omap_readw(OMAP1610_DMA_LCD_CCR) & ~1,
+		__raw_writew(__raw_readw(OMAP1610_DMA_LCD_CCR) & ~1,
 			    OMAP1610_DMA_LCD_CCR);
 	lcd_dma.reserved = 0;
 	spin_unlock(&lcd_dma.lock);
@@ -2247,15 +2247,15 @@ void omap_enable_lcd_dma(void)
 	if (enable_1510_mode || !lcd_dma.ext_ctrl)
 		return;
 
-	w = omap_readw(OMAP1610_DMA_LCD_CTRL);
+	w = __raw_readw(OMAP1610_DMA_LCD_CTRL);
 	w |= 1 << 8;
-	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
+	__raw_writew(w, OMAP1610_DMA_LCD_CTRL);
 
 	lcd_dma.active = 1;
 
-	w = omap_readw(OMAP1610_DMA_LCD_CCR);
+	w = __raw_readw(OMAP1610_DMA_LCD_CCR);
 	w |= 1 << 7;
-	omap_writew(w, OMAP1610_DMA_LCD_CCR);
+	__raw_writew(w, OMAP1610_DMA_LCD_CCR);
 }
 EXPORT_SYMBOL(omap_enable_lcd_dma);
 
@@ -2264,15 +2264,15 @@ void omap_setup_lcd_dma(void)
 	BUG_ON(lcd_dma.active);
 	if (!enable_1510_mode) {
 		/* Set some reasonable defaults */
-		omap_writew(0x5440, OMAP1610_DMA_LCD_CCR);
-		omap_writew(0x9102, OMAP1610_DMA_LCD_CSDP);
-		omap_writew(0x0004, OMAP1610_DMA_LCD_LCH_CTRL);
+		__raw_writew(0x5440, OMAP1610_DMA_LCD_CCR);
+		__raw_writew(0x9102, OMAP1610_DMA_LCD_CSDP);
+		__raw_writew(0x0004, OMAP1610_DMA_LCD_LCH_CTRL);
 	}
 	set_b1_regs();
 	if (!enable_1510_mode) {
 		u16 w;
 
-		w = omap_readw(OMAP1610_DMA_LCD_CCR);
+		w = __raw_readw(OMAP1610_DMA_LCD_CCR);
 		/*
 		 * If DMA was already active set the end_prog bit to have
 		 * the programmed register set loaded into the active
@@ -2281,7 +2281,7 @@ void omap_setup_lcd_dma(void)
 		w |= 1 << 11;		/* End_prog */
 		if (!lcd_dma.single_transfer)
 			w |= (3 << 8);	/* Auto_init, repeat */
-		omap_writew(w, OMAP1610_DMA_LCD_CCR);
+		__raw_writew(w, OMAP1610_DMA_LCD_CCR);
 	}
 }
 EXPORT_SYMBOL(omap_setup_lcd_dma);
@@ -2294,13 +2294,13 @@ void omap_stop_lcd_dma(void)
 	if (enable_1510_mode || !lcd_dma.ext_ctrl)
 		return;
 
-	w = omap_readw(OMAP1610_DMA_LCD_CCR);
+	w = __raw_readw(OMAP1610_DMA_LCD_CCR);
 	w &= ~(1 << 7);
-	omap_writew(w, OMAP1610_DMA_LCD_CCR);
+	__raw_writew(w, OMAP1610_DMA_LCD_CCR);
 
-	w = omap_readw(OMAP1610_DMA_LCD_CTRL);
+	w = __raw_readw(OMAP1610_DMA_LCD_CTRL);
 	w &= ~(1 << 8);
-	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
+	__raw_writew(w, OMAP1610_DMA_LCD_CTRL);
 }
 EXPORT_SYMBOL(omap_stop_lcd_dma);
 
@@ -2366,9 +2366,9 @@ static int __init omap_init_dma(void)
 			u16 w;
 
 			/* this would prevent OMAP sleep */
-			w = omap_readw(OMAP1610_DMA_LCD_CTRL);
+			w = __raw_readw(OMAP1610_DMA_LCD_CTRL);
 			w &= ~(1 << 8);
-			omap_writew(w, OMAP1610_DMA_LCD_CTRL);
+			__raw_writew(w, OMAP1610_DMA_LCD_CTRL);
 		}
 	} else if (cpu_class_is_omap2()) {
 		u8 revision = dma_read(REVISION) & 0xff;
-- 
1.6.0.2.307.gc427

