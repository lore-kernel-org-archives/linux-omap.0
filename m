From: Daniel Stone <daniel.stone@nokia.com>
Subject: [PATCH 2/2] FB: OMAP: DISPC: Allow multiple external IRQ handlers
Date: Wed, 27 Aug 2008 04:31:27 +0300
Message-ID: <1219800687-11044-2-git-send-email-daniel.stone@nokia.com>
References: <20080827012736.GA10868@intune.research.nokia.com>
 <1219800687-11044-1-git-send-email-daniel.stone@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41475 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbYH0BbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 21:31:03 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7R1UlkX020894
	for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 04:30:59 +0300
Received: from intune.research.nokia.com (intune.research.nokia.com [172.21.50.54])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m7R1UIVE002985
	for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 04:30:18 +0300
In-Reply-To: <1219800687-11044-1-git-send-email-daniel.stone@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Previously, the only external (to dispc.c) IRQ handler was RFBI's
frame done handler.  dispc's IRQ framework was very dumb: you could only
have one handler, and the semantics of {request,free}_irq were odd, to
say the least.

The new framework allows multiple consumers to register arbitrary IRQ
masks.

Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
---
 drivers/video/omap/dispc.c |   94 ++++++++++++++++++++++++++-----------------
 drivers/video/omap/dispc.h |    7 ++-
 drivers/video/omap/rfbi.c  |    6 ++-
 3 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index df50a2f..2a9d8aa 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -160,6 +160,8 @@ struct resmap {
 	unsigned long	*map;
 };
 
+#define MAX_IRQ_HANDLERS            4
+
 static struct {
 	u32		base;
 
@@ -172,9 +174,11 @@ static struct {
 
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
@@ -814,56 +818,70 @@ static void set_lcd_timings(void)
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
 	u32 stat = dispc_read_reg(DISPC_IRQSTATUS);
+	int i = 0;
 
 	if (stat & DISPC_IRQ_FRAMEMASK)
 		complete(&dispc.frame_done);
@@ -875,8 +893,11 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
 		}
 	}
 
-	if ((stat & dispc.enabled_irqs) && dispc.irq_callback)
-		dispc.irq_callback(dispc.irq_callback_data);
+	for (i = 0; i < MAX_IRQ_HANDLERS; i++) {
+		if (unlikely(dispc.irq_handlers[i].callback &&
+			     (stat & dispc.irq_handlers[i].irq_mask)))
+		dispc.irq_handlers[i].callback(dispc.irq_handlers[i].data);
+	}
 
 	dispc_write_reg(DISPC_IRQSTATUS, stat);
 
@@ -1471,8 +1492,7 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	l = dispc_read_reg(DISPC_IRQSTATUS);
 	dispc_write_reg(DISPC_IRQSTATUS, l);
 
-	/* Enable those that we handle always */
-	omap_dispc_enable_irqs(DISPC_IRQ_FRAMEMASK);
+	recalc_irq_mask();
 
 	if ((r = request_irq(INT_24XX_DSS_IRQ, omap_dispc_irq_handler,
 			   0, MODULE_NAME, fbdev)) < 0) {
diff --git a/drivers/video/omap/dispc.h b/drivers/video/omap/dispc.h
index eb1512b..f7746f4 100644
--- a/drivers/video/omap/dispc.h
+++ b/drivers/video/omap/dispc.h
@@ -37,7 +37,8 @@ extern void omap_dispc_set_lcd_size(int width, int height);
 extern void omap_dispc_enable_lcd_out(int enable);
 extern void omap_dispc_enable_digit_out(int enable);
 
-extern int  omap_dispc_request_irq(void (*callback)(void *data), void *data);
-extern void omap_dispc_free_irq(void);
-
+extern int  omap_dispc_request_irq(unsigned long irq_mask,
+                                   void (*callback)(void *data), void *data);
+extern void omap_dispc_free_irq(unsigned long irq_mask,
+                                void (*callback)(void *data), void *data);
 #endif
diff --git a/drivers/video/omap/rfbi.c b/drivers/video/omap/rfbi.c
index 4f1f4be..7bc7780 100644
--- a/drivers/video/omap/rfbi.c
+++ b/drivers/video/omap/rfbi.c
@@ -57,6 +57,7 @@
 
 #define DISPC_BASE		0x48050400
 #define DISPC_CONTROL		0x0040
+#define DISPC_IRQ_FRAMEMASK     0x0001
 
 static struct {
 	u32		base;
@@ -547,7 +548,8 @@ static int rfbi_init(struct omapfb_device *fbdev)
 	l = (0x01 << 2);
 	rfbi_write_reg(RFBI_CONTROL, l);
 
-	if ((r = omap_dispc_request_irq(rfbi_dma_callback, NULL)) < 0) {
+	if ((r = omap_dispc_request_irq(DISPC_IRQ_FRAMEMASK, rfbi_dma_callback,
+                                        NULL)) < 0) {
 		dev_err(fbdev->dev, "can't get DISPC irq\n");
 		rfbi_enable_clocks(0);
 		return r;
@@ -564,7 +566,7 @@ static int rfbi_init(struct omapfb_device *fbdev)
 
 static void rfbi_cleanup(void)
 {
-	omap_dispc_free_irq();
+	omap_dispc_free_irq(DISPC_IRQ_FRAMEMASK, rfbi_dma_callback, NULL);
 	rfbi_put_clocks();
 }
 
-- 
1.5.6.3

