From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/8] usb: musb: Change end point selection to use new IO access
Date: Mon, 24 Nov 2014 11:05:03 -0800
Message-ID: <1416855906-13931-6-git-send-email-tony@atomide.com>
References: <1416855906-13931-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416855906-13931-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Apelete Seketeli <apelete-fIDRvF7C5ezk1uMJSBkQmQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This allows the endpoints to work when multiple MUSB glue
layers are built in.

Cc: Fabio Baltieri <fabio.baltieri-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Apelete Seketeli <apelete-fIDRvF7C5ezk1uMJSBkQmQ@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/am35x.c     |  1 +
 drivers/usb/musb/da8xx.c     |  1 +
 drivers/usb/musb/jz4740.c    |  1 +
 drivers/usb/musb/musb_core.c | 38 +++++++++++++++++++++++++++++++++++++-
 drivers/usb/musb/musb_core.h | 37 +------------------------------------
 drivers/usb/musb/musb_dsps.c |  1 +
 drivers/usb/musb/musb_io.h   |  2 ++
 drivers/usb/musb/musb_regs.h | 11 -----------
 drivers/usb/musb/musbhsdma.c |  7 ++++---
 drivers/usb/musb/tusb6010.c  | 13 +++++++++++++
 drivers/usb/musb/ux500.c     |  1 +
 11 files changed, 62 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 13d1d77..1ea4a67 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -438,6 +438,7 @@ static void am35x_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 }
 
 static const struct musb_platform_ops am35x_ops = {
+	.quirks		= MUSB_INDEXED_EP,
 	.init		= am35x_musb_init,
 	.exit		= am35x_musb_exit,
 
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 058775e..c9079c8 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -458,6 +458,7 @@ static int da8xx_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops da8xx_ops = {
+	.quirks		= MUSB_INDEXED_EP,
 	.init		= da8xx_musb_init,
 	.exit		= da8xx_musb_exit,
 
diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index d118729..40e9874 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -106,6 +106,7 @@ static int jz4740_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops jz4740_musb_ops = {
+	.quirks		= MUSB_INDEXED_EP,
 	.init		= jz4740_musb_init,
 	.exit		= jz4740_musb_exit,
 };
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2fbe149..48ddc82 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -229,6 +229,27 @@ static u32 musb_default_fifo_offset(u8 epnum)
 	return 0x20 + (epnum * 4);
 }
 
+/* "flat" mapping: each endpoint has its own i/o address */
+static void musb_flat_ep_select(void __iomem *mbase, u8 epnum)
+{
+}
+
+static u32 musb_flat_ep_offset(u8 epnum, u16 offset)
+{
+	return 0x100 + (0x10 * epnum) + offset;
+}
+
+/* "indexed" mapping: INDEX register controls register bank select */
+static void musb_indexed_ep_select(void __iomem *mbase, u8 epnum)
+{
+	musb_writeb(mbase, MUSB_INDEX, epnum);
+}
+
+static u32 musb_indexed_ep_offset(u8 epnum, u16 offset)
+{
+	return 0x10 + offset;
+}
+
 static u8 musb_default_readb(const void __iomem *addr, unsigned offset)
 {
 	return __raw_readb(addr + offset);
@@ -1534,7 +1555,7 @@ static int musb_core_init(u16 musb_type, struct musb *musb)
 		}
 #endif
 
-		hw_ep->regs = MUSB_EP_OFFSET(i, 0) + mbase;
+		hw_ep->regs = musb->io.ep_offset(i, 0) + mbase;
 		hw_ep->target_regs = musb_read_target_reg_base(i, mbase);
 		hw_ep->rx_reinit = 1;
 		hw_ep->tx_reinit = 1;
@@ -2004,6 +2025,21 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	if (musb->ops->quirks)
 		musb->io.quirks = musb->ops->quirks;
 
+	/* At least tusb6010 has it's own offsets.. */
+	if (musb->ops->ep_offset)
+		musb->io.ep_offset = musb->ops->ep_offset;
+	if (musb->ops->ep_select)
+		musb->io.ep_select = musb->ops->ep_select;
+
+	/* ..and some devices use indexed offset or flat offset */
+	if (musb->io.quirks & MUSB_INDEXED_EP) {
+		musb->io.ep_offset = musb_indexed_ep_offset;
+		musb->io.ep_select = musb_indexed_ep_select;
+	} else {
+		musb->io.ep_offset = musb_flat_ep_offset;
+		musb->io.ep_select = musb_flat_ep_select;
+	}
+
 	if (musb->ops->fifo_offset)
 		musb->io.fifo_offset = musb->ops->fifo_offset;
 	else
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 7c7f38c..02f62cb 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -124,41 +124,6 @@ enum musb_g_ep0_state {
 #define OTG_TIME_A_AIDL_BDIS	200		/* min 200 msec */
 #define OTG_TIME_B_ASE0_BRST	100		/* min 3.125 ms */
 
-
-/*************************** REGISTER ACCESS ********************************/
-
-/* Endpoint registers (other than dynfifo setup) can be accessed either
- * directly with the "flat" model, or after setting up an index register.
- */
-
-#if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_SOC_OMAP2430) \
-		|| defined(CONFIG_SOC_OMAP3430) || defined(CONFIG_BLACKFIN) \
-		|| defined(CONFIG_ARCH_OMAP4)
-/* REVISIT indexed access seemed to
- * misbehave (on DaVinci) for at least peripheral IN ...
- */
-#define	MUSB_FLAT_REG
-#endif
-
-/* TUSB mapping: "flat" plus ep0 special cases */
-#if defined(CONFIG_USB_MUSB_TUSB6010) || \
-	defined(CONFIG_USB_MUSB_TUSB6010_MODULE)
-#define musb_ep_select(_mbase, _epnum) \
-	musb_writeb((_mbase), MUSB_INDEX, (_epnum))
-#define	MUSB_EP_OFFSET			MUSB_TUSB_OFFSET
-
-/* "flat" mapping: each endpoint has its own i/o address */
-#elif	defined(MUSB_FLAT_REG)
-#define musb_ep_select(_mbase, _epnum)	(((void)(_mbase)), ((void)(_epnum)))
-#define	MUSB_EP_OFFSET			MUSB_FLAT_OFFSET
-
-/* "indexed" mapping: INDEX register controls register bank select */
-#else
-#define musb_ep_select(_mbase, _epnum) \
-	musb_writeb((_mbase), MUSB_INDEX, (_epnum))
-#define	MUSB_EP_OFFSET			MUSB_INDEXED_OFFSET
-#endif
-
 /****************************** FUNCTIONS ********************************/
 
 #define MUSB_HST_MODE(_musb)\
@@ -514,7 +479,7 @@ static inline int musb_read_fifosize(struct musb *musb,
 	u8 reg = 0;
 
 	/* read from core using indexed model */
-	reg = musb_readb(mbase, MUSB_EP_OFFSET(epnum, MUSB_FIFOSIZE));
+	reg = musb_readb(mbase, musb->io.ep_offset(epnum, MUSB_FIFOSIZE));
 	/* 0's returned when no more endpoints */
 	if (!reg)
 		return -ENODEV;
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 48bc09e..b7f2efc 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -636,6 +636,7 @@ static int dsps_musb_reset(struct musb *musb)
 }
 
 static struct musb_platform_ops dsps_ops = {
+	.quirks		= MUSB_INDEXED_EP,
 	.init		= dsps_musb_init,
 	.exit		= dsps_musb_exit,
 
diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index 14aa217..8a57a6f 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -37,6 +37,8 @@
 
 #include <linux/io.h>
 
+#define musb_ep_select(_mbase, _epnum)	musb->io.ep_select((_mbase), (_epnum))
+
 /**
  * struct musb_io - IO functions for MUSB
  * @quirks:	platform specific flags
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index b2b1f73..92b4c3d 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -287,19 +287,8 @@
 #define MUSB_FIFOSIZE		0x0F
 #define MUSB_CONFIGDATA		MUSB_FIFOSIZE	/* Re-used for EP0 */
 
-/* Offsets to endpoint registers in indexed model (using INDEX register) */
-#define MUSB_INDEXED_OFFSET(_epnum, _offset)	\
-	(0x10 + (_offset))
-
-/* Offsets to endpoint registers in flat models */
-#define MUSB_FLAT_OFFSET(_epnum, _offset)	\
-	(0x100 + (0x10*(_epnum)) + (_offset))
-
 #if defined(CONFIG_USB_MUSB_TUSB6010) ||	\
 	defined(CONFIG_USB_MUSB_TUSB6010_MODULE)
-/* TUSB6010 EP0 configuration register is special */
-#define MUSB_TUSB_OFFSET(_epnum, _offset)	\
-	(0x10 + _offset)
 #include "tusb6010.h"		/* Needed "only" for TUSB_EP0_CONF */
 #endif
 
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index e8e9f9a..ab7ec09 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -195,6 +195,7 @@ static int dma_channel_abort(struct dma_channel *channel)
 {
 	struct musb_dma_channel *musb_channel = channel->private_data;
 	void __iomem *mbase = musb_channel->controller->base;
+	struct musb *musb = musb_channel->controller->private_data;
 
 	u8 bchannel = musb_channel->idx;
 	int offset;
@@ -202,7 +203,7 @@ static int dma_channel_abort(struct dma_channel *channel)
 
 	if (channel->status == MUSB_DMA_STATUS_BUSY) {
 		if (musb_channel->transmit) {
-			offset = MUSB_EP_OFFSET(musb_channel->epnum,
+			offset = musb->io.ep_offset(musb_channel->epnum,
 						MUSB_TXCSR);
 
 			/*
@@ -215,7 +216,7 @@ static int dma_channel_abort(struct dma_channel *channel)
 			csr &= ~MUSB_TXCSR_DMAMODE;
 			musb_writew(mbase, offset, csr);
 		} else {
-			offset = MUSB_EP_OFFSET(musb_channel->epnum,
+			offset = musb->io.ep_offset(musb_channel->epnum,
 						MUSB_RXCSR);
 
 			csr = musb_readw(mbase, offset);
@@ -326,7 +327,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 					    (musb_channel->max_packet_sz - 1)))
 				    ) {
 					u8  epnum  = musb_channel->epnum;
-					int offset = MUSB_EP_OFFSET(epnum,
+					int offset = musb->io.ep_offset(epnum,
 								    MUSB_TXCSR);
 					u16 txcsr;
 
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 38efebc..fe69bad 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -131,6 +131,17 @@ static u32 tusb_fifo_offset(u8 epnum)
 	return 0x200 + (epnum * 0x20);
 }
 
+static u32 tusb_ep_offset(u8 epnum, u16 offset)
+{
+	return 0x10 + offset;
+}
+
+/* TUSB mapping: "flat" plus ep0 special cases */
+static void tusb_ep_select(void __iomem *mbase, u8 epnum)
+{
+	musb_writeb(mbase, MUSB_INDEX, epnum);
+}
+
 /*
  * TUSB6010 doesn't allow 8-bit access; 16-bit access is the minimum.
  */
@@ -1174,6 +1185,8 @@ static const struct musb_platform_ops tusb_ops = {
 	.init		= tusb_musb_init,
 	.exit		= tusb_musb_exit,
 
+	.ep_offset	= tusb_ep_offset,
+	.ep_select	= tusb_ep_select,
 	.fifo_offset	= tusb_fifo_offset,
 	.readb		= tusb_readb,
 	.writeb		= tusb_writeb,
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index dc666e9..c170501 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -188,6 +188,7 @@ static int ux500_musb_exit(struct musb *musb)
 }
 
 static const struct musb_platform_ops ux500_ops = {
+	.quirks		= MUSB_INDEXED_EP,
 	.init		= ux500_musb_init,
 	.exit		= ux500_musb_exit,
 
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
