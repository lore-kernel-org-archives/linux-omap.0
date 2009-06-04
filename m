From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 16/20] omapfb: dispc: Allow multiple external IRQ handlers
Date: Thu,  4 Jun 2009 20:52:41 +0300
Message-ID: <024fee28b6c89decf0d50747127db8fc61ac789e.1244131952.git.imre.deak@nokia.com>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
 <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
 <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
 <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
 <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com>
 <5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
 <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
 <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
 <9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
 <08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
 <057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
 <310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
 <5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
 <d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
 <d83034cc97924164ca9949fee84bfb480ad5c806.1244131952.git.imre.deak@nokia.com>
 <36ddd74a50b8c225b2c571035c67dbff4686b881.1244131952.git.imre.deak@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38819 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbZFDR5N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:57:13 -0400
In-Reply-To: <36ddd74a50b8c225b2c571035c67dbff4686b881.1244131952.git.imre.deak@nokia.com>
In-Reply-To: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
References: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, Daniel Stone <daniel.stone@nokia.com>, Imre Deak <imre.deak@nokia.com>

From: Daniel Stone <daniel.stone@nokia.com>

Previously, the only external (to dispc.c) IRQ handler was RFBI's
frame done handler.  dispc's IRQ framework was very dumb: you could only
have one handler, and the semantics of {request,free}_irq were odd, to
say the least.

The new framework allows multiple consumers to register arbitrary IRQ
masks.

Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 drivers/video/omap/dispc.c |   95 +++++++++++++++++++++++++++-----------------
 drivers/video/omap/dispc.h |    7 ++-
 drivers/video/omap/rfbi.c  |    7 ++-
 3 files changed, 67 insertions(+), 42 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 9adf54e..350b444 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -155,6 +155,8 @@ struct resmap {
 	unsigned long	*map;
 };
 
+#define MAX_IRQ_HANDLERS            4
+
 static struct {
 	void __iomem	*base;
 
@@ -167,9 +169,11 @@ static struct {
 
 	int		ext_mode;
 
-	unsigned long	enabled_irqs;
-	void		(*irq_callback)(void *);
-	void		*irq_callback_data;
+	struct {
+		u32	irq_mask;
+		void	(*callback)(void *);
+		void	*data;
+	} irq_handlers[MAX_IRQ_HANDLERS];
 	struct completion	frame_done;
 
 	int		fir_hinc[OMAPFB_PLANE_NUM];
@@ -809,56 +813,70 @@ static void set_lcd_timings(void)
 	panel->pixel_clock = fck / lck_div / pck_div / 1000;
 }
 
-int omap_dispc_request_irq(void (*callback)(void *data), void *data)
+static void recalc_irq_mask(void)
 {
-	int r = 0;
+	int i;
+	unsigned long irq_mask = DISPC_IRQ_MASK_ERROR;
 
-	BUG_ON(callback == NULL);
+	for (i = 0; i < MAX_IRQ_HANDLERS; i++) {
+		if (!dispc.irq_handlers[i].callback)
+			continue;
 
-	if (dispc.irq_callback)
-		r = -EBUSY;
-	else {
-		dispc.irq_callback = callback;
-		dispc.irq_callback_data = data;
+		irq_mask |= dispc.irq_handlers[i].irq_mask;
 	}
 
-	return r;
-}
-EXPORT_SYMBOL(omap_dispc_request_irq);
-
-void omap_dispc_enable_irqs(int irq_mask)
-{
 	enable_lcd_clocks(1);
-	dispc.enabled_irqs = irq_mask;
-	irq_mask |= DISPC_IRQ_MASK_ERROR;
 	MOD_REG_FLD(DISPC_IRQENABLE, 0x7fff, irq_mask);
 	enable_lcd_clocks(0);
 }
-EXPORT_SYMBOL(omap_dispc_enable_irqs);
 
-void omap_dispc_disable_irqs(int irq_mask)
+int omap_dispc_request_irq(unsigned long irq_mask, void (*callback)(void *data),
+			   void *data)
 {
-	enable_lcd_clocks(1);
-	dispc.enabled_irqs &= ~irq_mask;
-	irq_mask &= ~DISPC_IRQ_MASK_ERROR;
-	MOD_REG_FLD(DISPC_IRQENABLE, 0x7fff, irq_mask);
-	enable_lcd_clocks(0);
+	int i;
+
+	BUG_ON(callback == NULL);
+
+	for (i = 0; i < MAX_IRQ_HANDLERS; i++) {
+		if (dispc.irq_handlers[i].callback)
+			continue;
+
+		dispc.irq_handlers[i].irq_mask = irq_mask;
+		dispc.irq_handlers[i].callback = callback;
+		dispc.irq_handlers[i].data = data;
+		recalc_irq_mask();
+
+		return 0;
+	}
+
+	return -EBUSY;
 }
-EXPORT_SYMBOL(omap_dispc_disable_irqs);
+EXPORT_SYMBOL(omap_dispc_request_irq);
 
-void omap_dispc_free_irq(void)
+void omap_dispc_free_irq(unsigned long irq_mask, void (*callback)(void *data),
+			 void *data)
 {
-	enable_lcd_clocks(1);
-	omap_dispc_disable_irqs(DISPC_IRQ_MASK_ALL);
-	dispc.irq_callback = NULL;
-	dispc.irq_callback_data = NULL;
-	enable_lcd_clocks(0);
+	int i;
+
+	for (i = 0; i < MAX_IRQ_HANDLERS; i++) {
+		if (dispc.irq_handlers[i].callback == callback &&
+		    dispc.irq_handlers[i].data == data) {
+			dispc.irq_handlers[i].irq_mask = 0;
+			dispc.irq_handlers[i].callback = NULL;
+			dispc.irq_handlers[i].data = NULL;
+			recalc_irq_mask();
+			return;
+		}
+	}
+
+	BUG();
 }
 EXPORT_SYMBOL(omap_dispc_free_irq);
 
 static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
 {
 	u32 stat;
+	int i = 0;
 
 	enable_lcd_clocks(1);
 
@@ -873,8 +891,12 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
 		}
 	}
 
-	if ((stat & dispc.enabled_irqs) && dispc.irq_callback)
-		dispc.irq_callback(dispc.irq_callback_data);
+	for (i = 0; i < MAX_IRQ_HANDLERS; i++) {
+		if (unlikely(dispc.irq_handlers[i].callback &&
+			     (stat & dispc.irq_handlers[i].irq_mask)))
+			dispc.irq_handlers[i].callback(
+						dispc.irq_handlers[i].data);
+	}
 
 	dispc_write_reg(DISPC_IRQSTATUS, stat);
 
@@ -1410,8 +1432,7 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	l = dispc_read_reg(DISPC_IRQSTATUS);
 	dispc_write_reg(DISPC_IRQSTATUS, l);
 
-	/* Enable those that we handle always */
-	omap_dispc_enable_irqs(DISPC_IRQ_FRAMEMASK);
+	recalc_irq_mask();
 
 	if ((r = request_irq(INT_24XX_DSS_IRQ, omap_dispc_irq_handler,
 			   0, MODULE_NAME, fbdev)) < 0) {
diff --git a/drivers/video/omap/dispc.h b/drivers/video/omap/dispc.h
index ef720a7..c15ea77 100644
--- a/drivers/video/omap/dispc.h
+++ b/drivers/video/omap/dispc.h
@@ -37,9 +37,10 @@ extern void omap_dispc_set_lcd_size(int width, int height);
 extern void omap_dispc_enable_lcd_out(int enable);
 extern void omap_dispc_enable_digit_out(int enable);
 
-extern int  omap_dispc_request_irq(void (*callback)(void *data), void *data);
-extern void omap_dispc_free_irq(void);
+extern int omap_dispc_request_irq(unsigned long irq_mask,
+				   void (*callback)(void *data), void *data);
+extern void omap_dispc_free_irq(unsigned long irq_mask,
+				 void (*callback)(void *data), void *data);
 
 extern const struct lcd_ctrl omap2_int_ctrl;
-
 #endif
diff --git a/drivers/video/omap/rfbi.c b/drivers/video/omap/rfbi.c
index 9332d6c..ee01e84 100644
--- a/drivers/video/omap/rfbi.c
+++ b/drivers/video/omap/rfbi.c
@@ -57,6 +57,7 @@
 
 #define DISPC_BASE		0x48050400
 #define DISPC_CONTROL		0x0040
+#define DISPC_IRQ_FRAMEMASK     0x0001
 
 static struct {
 	void __iomem	*base;
@@ -553,7 +554,9 @@ static int rfbi_init(struct omapfb_device *fbdev)
 	l = (0x01 << 2);
 	rfbi_write_reg(RFBI_CONTROL, l);
 
-	if ((r = omap_dispc_request_irq(rfbi_dma_callback, NULL)) < 0) {
+	r = omap_dispc_request_irq(DISPC_IRQ_FRAMEMASK, rfbi_dma_callback,
+				   NULL);
+	if (r < 0) {
 		dev_err(fbdev->dev, "can't get DISPC irq\n");
 		rfbi_enable_clocks(0);
 		return r;
@@ -570,7 +573,7 @@ static int rfbi_init(struct omapfb_device *fbdev)
 
 static void rfbi_cleanup(void)
 {
-	omap_dispc_free_irq();
+	omap_dispc_free_irq(DISPC_IRQ_FRAMEMASK, rfbi_dma_callback, NULL);
 	rfbi_put_clocks();
 	iounmap(rfbi.base);
 }
-- 
1.6.3.1

