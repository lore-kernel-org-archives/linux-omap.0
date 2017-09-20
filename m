From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 2/4] usb: musb: musb_cppi41: Fix cppi41_set_dma_mode() for DA8xx
Date: Wed, 20 Sep 2017 21:26:10 +0200
Message-ID: <20170920192612.16169-3-abailon@baylibre.com>
References: <20170920192612.16169-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920192612.16169-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The way to configure the DMA mode on DA8xx is different from DSPS.
Add a new function to configure DMA mode on DA8xx and use a callback
to call the right function based on the platform.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/musb_cppi41.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index d66416a27146..b2b1306c01cf 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -26,6 +26,7 @@
 
 #define MUSB_DMA_NUM_CHANNELS 15
 
+#define DA8XX_USB_MODE		0x10
 #define DA8XX_USB_AUTOREQ	0x14
 #define DA8XX_USB_TEARDOWN	0x1c
 
@@ -41,6 +42,9 @@ struct cppi41_dma_controller {
 
 	u32 tdown_reg;
 	u32 autoreq_reg;
+
+	void (*set_dma_mode)(struct cppi41_dma_channel *cppi41_channel,
+			     unsigned int mode);
 };
 
 static void save_rx_toggle(struct cppi41_dma_channel *cppi41_channel)
@@ -355,6 +359,32 @@ static void cppi41_set_dma_mode(struct cppi41_dma_channel *cppi41_channel,
 	}
 }
 
+static void da8xx_set_dma_mode(struct cppi41_dma_channel *cppi41_channel,
+		unsigned int mode)
+{
+	struct cppi41_dma_controller *controller = cppi41_channel->controller;
+	struct musb *musb = controller->controller.musb;
+	unsigned int shift;
+	u32 port;
+	u32 new_mode;
+	u32 old_mode;
+
+	old_mode = controller->tx_mode;
+	port = cppi41_channel->port_num;
+
+	shift = (port - 1) * 4;
+	if (!cppi41_channel->is_tx)
+		shift += 16;
+	new_mode = old_mode & ~(3 << shift);
+	new_mode |= mode << shift;
+
+	if (new_mode == old_mode)
+		return;
+	controller->tx_mode = new_mode;
+	musb_writel(musb->ctrl_base, DA8XX_USB_MODE, new_mode);
+}
+
+
 static void cppi41_set_autoreq_mode(struct cppi41_dma_channel *cppi41_channel,
 		unsigned mode)
 {
@@ -379,6 +409,7 @@ static bool cppi41_configure_channel(struct dma_channel *channel,
 				dma_addr_t dma_addr, u32 len)
 {
 	struct cppi41_dma_channel *cppi41_channel = channel->private_data;
+	struct cppi41_dma_controller *controller = cppi41_channel->controller;
 	struct dma_chan *dc = cppi41_channel->dc;
 	struct dma_async_tx_descriptor *dma_desc;
 	enum dma_transfer_direction direction;
@@ -404,7 +435,7 @@ static bool cppi41_configure_channel(struct dma_channel *channel,
 			musb_writel(musb->ctrl_base,
 				RNDIS_REG(cppi41_channel->port_num), len);
 			/* gen rndis */
-			cppi41_set_dma_mode(cppi41_channel,
+			controller->set_dma_mode(cppi41_channel,
 					EP_MODE_DMA_GEN_RNDIS);
 
 			/* auto req */
@@ -413,14 +444,15 @@ static bool cppi41_configure_channel(struct dma_channel *channel,
 		} else {
 			musb_writel(musb->ctrl_base,
 					RNDIS_REG(cppi41_channel->port_num), 0);
-			cppi41_set_dma_mode(cppi41_channel,
+			controller->set_dma_mode(cppi41_channel,
 					EP_MODE_DMA_TRANSPARENT);
 			cppi41_set_autoreq_mode(cppi41_channel,
 					EP_MODE_AUTOREQ_NONE);
 		}
 	} else {
 		/* fallback mode */
-		cppi41_set_dma_mode(cppi41_channel, EP_MODE_DMA_TRANSPARENT);
+		controller->set_dma_mode(cppi41_channel,
+				EP_MODE_DMA_TRANSPARENT);
 		cppi41_set_autoreq_mode(cppi41_channel, EP_MODE_AUTOREQ_NONE);
 		len = min_t(u32, packet_sz, len);
 	}
@@ -737,9 +769,11 @@ cppi41_dma_controller_create(struct musb *musb, void __iomem *base)
 	if (musb->io.quirks & MUSB_DA8XX) {
 		controller->tdown_reg = DA8XX_USB_TEARDOWN;
 		controller->autoreq_reg = DA8XX_USB_AUTOREQ;
+		controller->set_dma_mode = da8xx_set_dma_mode;
 	} else {
 		controller->tdown_reg = USB_TDOWN;
 		controller->autoreq_reg = USB_CTRL_AUTOREQ;
+		controller->set_dma_mode = cppi41_set_dma_mode;
 	}
 
 	ret = cppi41_dma_controller_start(controller);
-- 
2.13.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
