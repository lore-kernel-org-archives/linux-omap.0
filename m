From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/12] musb_hdrc: Allow tusb3.0 and greater to use
	multichannel DMA
Date: Thu, 11 Oct 2007 10:05:14 -0700
Message-ID: <11921223262203-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1192122325531-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Allow tusb3.0 and greater to use multichannel DMA

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index fbb402c..5026f2b 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -34,7 +34,7 @@ static void tusb_source_power(struct musb *musb, int is_on);
  * Checks the revision. We need to use the DMA register as 3.0 does not
  * have correct versions for TUSB_PRCM_REV or TUSB_INT_CTRL_REV.
  */
-static u8 tusb_get_revision(struct musb *musb)
+u8 tusb_get_revision(struct musb *musb)
 {
 	void __iomem	*tbase = musb->ctrl_base;
 	u32		die_id;
diff --git a/drivers/usb/musb/tusb6010.h b/drivers/usb/musb/tusb6010.h
index 16a311a..7ef6abf 100644
--- a/drivers/usb/musb/tusb6010.h
+++ b/drivers/usb/musb/tusb6010.h
@@ -13,6 +13,8 @@
 #ifndef __TUSB6010_H__
 #define __TUSB6010_H__
 
+extern u8 tusb_get_revision(struct musb *musb);
+
 #ifdef CONFIG_USB_TUSB6010
 #define musb_in_tusb()			1
 #else
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 42c6a6b..09a6a3c 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -20,18 +20,6 @@
 
 #include "musb_core.h"
 
-/*
- * REVISIT: With TUSB2.0 only one dmareq line can be used at a time.
- * This should get fixed in hardware at some point.
- */
-#define BROKEN_DMAREQ
-
-#ifdef BROKEN_DMAREQ
-#define dmareq_works()		0
-#else
-#define dmareq_works()		1
-#endif
-
 #define to_chdat(c)		(struct tusb_omap_dma_ch *)(c)->private_data
 
 #define MAX_DMAREQ		5	/* REVISIT: Really 6, but req5 not OK */
@@ -67,6 +55,7 @@ struct tusb_omap_dma {
 	int				ch;
 	s8				dmareq;
 	s8				sync_dev;
+	unsigned			multichannel:1;
 };
 
 static int tusb_omap_dma_start(struct dma_controller *c)
@@ -91,8 +80,6 @@ static int tusb_omap_dma_stop(struct dma_controller *c)
 	return 0;
 }
 
-#ifdef BROKEN_DMAREQ
-
 /*
  * Allocate dmareq0 to the current channel unless it's already taken
  */
@@ -128,11 +115,6 @@ static inline void tusb_omap_free_shared_dmareq(struct tusb_omap_dma_ch *chdat)
 	musb_writel(chdat->tbase, TUSB_DMA_EP_MAP, 0);
 }
 
-#else
-#define tusb_omap_use_shared_dmareq(x, y)	do {} while (0)
-#define tusb_omap_free_shared_dmareq(x, y)	do {} while (0)
-#endif
-
 /*
  * See also musb_dma_completion in plat_uds.c and musb_g_[tx|rx]() in
  * musb_gadget.c.
@@ -151,7 +133,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	if (dmareq_works())
+	if (tusb_dma->multichannel)
 		ch = chdat->ch;
 	else
 		ch = tusb_dma->ch;
@@ -201,7 +183,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 		channel->actual_len += pio;
 	}
 
-	if (!dmareq_works())
+	if (!tusb_dma->multichannel)
 		tusb_omap_free_shared_dmareq(chdat);
 
 	channel->status = MUSB_DMA_STATUS_FREE;
@@ -283,7 +265,6 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 		return false;
 	}
 
-
 	chdat->transfer_len = len & ~0x1f;
 
 	if (len < packet_sz)
@@ -291,7 +272,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	else
 		chdat->transfer_packet_sz = packet_sz;
 
-	if (dmareq_works()) {
+	if (tusb_dma->multichannel) {
 		ch = chdat->ch;
 		dmareq = chdat->dmareq;
 		sync_dev = chdat->sync_dev;
@@ -441,7 +422,7 @@ static int tusb_omap_dma_abort(struct dma_channel *channel)
 	struct tusb_omap_dma_ch	*chdat = to_chdat(channel);
 	struct tusb_omap_dma	*tusb_dma = chdat->tusb_dma;
 
-	if (!dmareq_works()) {
+	if (!tusb_dma->multichannel) {
 		if (tusb_dma->ch >= 0) {
 			omap_stop_dma(tusb_dma->ch);
 			omap_free_dma(tusb_dma->ch);
@@ -574,7 +555,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 	channel->desired_mode = 0;
 	channel->actual_len = 0;
 
-	if (dmareq_works()) {
+	if (tusb_dma->multichannel) {
 		ret = tusb_omap_dma_allocate_dmareq(chdat);
 		if (ret != 0)
 			goto free_dmareq;
@@ -668,7 +649,7 @@ void dma_controller_destroy(struct dma_controller *c)
 		}
 	}
 
-	if (!dmareq_works() && tusb_dma && tusb_dma->ch >= 0)
+	if (!tusb_dma->multichannel && tusb_dma && tusb_dma->ch >= 0)
 		omap_free_dma(tusb_dma->ch);
 
 	kfree(tusb_dma);
@@ -710,6 +691,9 @@ dma_controller_create(struct musb *musb, void __iomem *base)
 	tusb_dma->controller.channel_abort = tusb_omap_dma_abort;
 	tusb_dma->controller.private_data = tusb_dma;
 
+	if (tusb_get_revision(musb) >= TUSB_REV_30)
+		tusb_dma->multichannel = 1;
+
 	for (i = 0; i < MAX_DMAREQ; i++) {
 		struct dma_channel	*ch;
 		struct tusb_omap_dma_ch	*chdat;
-- 
1.5.2.5
