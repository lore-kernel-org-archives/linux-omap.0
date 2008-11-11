From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 50/59] omap: namespace cleanup to drivers/video/omap/lcdc.c
Date: Wed, 12 Nov 2008 00:57:09 +0200
Message-ID: <1226444238-14614-51-git-send-email-me@felipebalbi.com>
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
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
 <1226444238-14614-30-git-send-email-me@felipebalbi.com>
 <1226444238-14614-31-git-send-email-me@felipebalbi.com>
 <1226444238-14614-32-git-send-email-me@felipebalbi.com>
 <1226444238-14614-33-git-send-email-me@felipebalbi.com>
 <1226444238-14614-34-git-send-email-me@felipebalbi.com>
 <1226444238-14614-35-git-send-email-me@felipebalbi.com>
 <1226444238-14614-36-git-send-email-me@felipebalbi.com>
 <1226444238-14614-37-git-send-email-me@felipebalbi.com>
 <1226444238-14614-38-git-send-email-me@felipebalbi.com>
 <1226444238-14614-39-git-send-email-me@felipebalbi.com>
 <1226444238-14614-40-git-send-email-me@felipebalbi.com>
 <1226444238-14614-41-git-send-email-me@felipebalbi.com>
 <1226444238-14614-42-git-send-email-me@felipebalbi.com>
 <1226444238-14614-43-git-send-email-me@felipebalbi.com>
 <1226444238-14614-44-git-send-email-me@felipebalbi.com>
 <1226444238-14614-45-git-send-email-me@felipebalbi.com>
 <1226444238-14614-46-git-send-email-me@felipebalbi.com>
 <1226444238-14614-47-git-send-email-me@felipebalbi.com>
 <1226444238-14614-48-git-send-email-me@felipebalbi.com>
 <1226444238-14614-49-git-send-email-me@felipebalbi.com>
 <1226444238-14614-50-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56604 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbYKKXFL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:05:11 -0500
In-Reply-To: <1226444238-14614-50-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/video/omap/lcdc.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
index 6e2ea75..5b97526 100644
--- a/drivers/video/omap/lcdc.c
+++ b/drivers/video/omap/lcdc.c
@@ -123,7 +123,7 @@ static void set_load_mode(enum lcdc_load_mode mode)
 {
 	u32 l;
 
-	l = omap_readl(OMAP_LCDC_CONTROL);
+	l = __raw_readl(OMAP_LCDC_CONTROL);
 	l &= ~(3 << 20);
 	switch (mode) {
 	case OMAP_LCDC_LOAD_PALETTE:
@@ -137,18 +137,18 @@ static void set_load_mode(enum lcdc_load_mode mode)
 	default:
 		BUG();
 	}
-	omap_writel(l, OMAP_LCDC_CONTROL);
+	__raw_writel(l, OMAP_LCDC_CONTROL);
 }
 
 static void enable_controller(void)
 {
 	u32 l;
 
-	l = omap_readl(OMAP_LCDC_CONTROL);
+	l = __raw_readl(OMAP_LCDC_CONTROL);
 	l |= OMAP_LCDC_CTRL_LCD_EN;
 	l &= ~OMAP_LCDC_IRQ_MASK;
 	l |= lcdc.irq_mask | OMAP_LCDC_IRQ_DONE;	/* enabled IRQs */
-	omap_writel(l, OMAP_LCDC_CONTROL);
+	__raw_writel(l, OMAP_LCDC_CONTROL);
 }
 
 static void disable_controller_async(void)
@@ -156,7 +156,7 @@ static void disable_controller_async(void)
 	u32 l;
 	u32 mask;
 
-	l = omap_readl(OMAP_LCDC_CONTROL);
+	l = __raw_readl(OMAP_LCDC_CONTROL);
 	mask = OMAP_LCDC_CTRL_LCD_EN | OMAP_LCDC_IRQ_MASK;
 	/*
 	 * Preserve the DONE mask, since we still want to get the
@@ -164,7 +164,7 @@ static void disable_controller_async(void)
 	 */
 	mask &= ~OMAP_LCDC_IRQ_DONE;
 	l &= ~mask;
-	omap_writel(l, OMAP_LCDC_CONTROL);
+	__raw_writel(l, OMAP_LCDC_CONTROL);
 }
 
 static void disable_controller(void)
@@ -272,7 +272,7 @@ static irqreturn_t lcdc_irq_handler(int irq, void *dev_id)
 {
 	u32 status;
 
-	status = omap_readl(OMAP_LCDC_STATUS);
+	status = __raw_readl(OMAP_LCDC_STATUS);
 
 	if (status & (OMAP_LCDC_STAT_FUF | OMAP_LCDC_STAT_SYNC_LOST))
 		reset_controller(status);
@@ -285,9 +285,9 @@ static irqreturn_t lcdc_irq_handler(int irq, void *dev_id)
 			 * only when the controller is reenabled and we don't
 			 * want to get more interrupts.
 			 */
-			l = omap_readl(OMAP_LCDC_CONTROL);
+			l = __raw_readl(OMAP_LCDC_CONTROL);
 			l &= ~OMAP_LCDC_IRQ_DONE;
-			omap_writel(l, OMAP_LCDC_CONTROL);
+			__raw_writel(l, OMAP_LCDC_CONTROL);
 			complete(&lcdc.last_frame_complete);
 		}
 		if (status & OMAP_LCDC_STAT_LOADED_PALETTE) {
@@ -307,7 +307,7 @@ static irqreturn_t lcdc_irq_handler(int irq, void *dev_id)
 		    OMAP_LCDC_STAT_LOADED_PALETTE |
 		    OMAP_LCDC_STAT_ABC |
 		    OMAP_LCDC_STAT_LINE_INT);
-	omap_writel(status, OMAP_LCDC_STATUS);
+	__raw_writel(status, OMAP_LCDC_STATUS);
 	return IRQ_HANDLED;
 }
 
@@ -504,7 +504,7 @@ static void inline setup_regs(void)
 	unsigned long lck;
 	int pcd;
 
-	l = omap_readl(OMAP_LCDC_CONTROL);
+	l = __raw_readl(OMAP_LCDC_CONTROL);
 	l &= ~OMAP_LCDC_CTRL_LCD_TFT;
 	l |= is_tft ? OMAP_LCDC_CTRL_LCD_TFT : 0;
 #ifdef CONFIG_MACH_OMAP_PALMTE
@@ -513,26 +513,26 @@ static void inline setup_regs(void)
 		l |= (is_tft && panel->bpp == 8) ? 0x810000 : 0;
 /*	} */
 #endif
-	omap_writel(l, OMAP_LCDC_CONTROL);
+	__raw_writel(l, OMAP_LCDC_CONTROL);
 
-	l = omap_readl(OMAP_LCDC_TIMING2);
+	l = __raw_readl(OMAP_LCDC_TIMING2);
 	l &= ~(((1 << 6) - 1) << 20);
 	l |= (panel->config & OMAP_LCDC_SIGNAL_MASK) << 20;
-	omap_writel(l, OMAP_LCDC_TIMING2);
+	__raw_writel(l, OMAP_LCDC_TIMING2);
 
 	l = panel->x_res - 1;
 	l |= (panel->hsw - 1) << 10;
 	l |= (panel->hfp - 1) << 16;
 	l |= (panel->hbp - 1) << 24;
-	omap_writel(l, OMAP_LCDC_TIMING0);
+	__raw_writel(l, OMAP_LCDC_TIMING0);
 
 	l = panel->y_res - 1;
 	l |= (panel->vsw - 1) << 10;
 	l |= panel->vfp << 16;
 	l |= panel->vbp << 24;
-	omap_writel(l, OMAP_LCDC_TIMING1);
+	__raw_writel(l, OMAP_LCDC_TIMING1);
 
-	l = omap_readl(OMAP_LCDC_TIMING2);
+	l = __raw_readl(OMAP_LCDC_TIMING2);
 	l &= ~0xff;
 
 	lck = clk_get_rate(lcdc.lcd_ck);
@@ -550,7 +550,7 @@ static void inline setup_regs(void)
 	}
 	l |= pcd & 0xff;
 	l |= panel->acb << 8;
-	omap_writel(l, OMAP_LCDC_TIMING2);
+	__raw_writel(l, OMAP_LCDC_TIMING2);
 
 	/* update panel info with the exact clock */
 	panel->pixel_clock = lck / pcd / 1000;
@@ -795,7 +795,7 @@ static int omap_lcdc_init(struct omapfb_device *fbdev, int ext_mode,
 	lcdc.ext_mode = ext_mode;
 
 	l = 0;
-	omap_writel(l, OMAP_LCDC_CONTROL);
+	__raw_writel(l, OMAP_LCDC_CONTROL);
 
 	/* FIXME:
 	 * According to errata some platforms have a clock rate limitiation
-- 
1.6.0.2.307.gc427

