From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 1/4] usb: musb: musb_cppi41: Fix the address of teardown and autoreq registers
Date: Wed, 20 Sep 2017 21:26:09 +0200
Message-ID: <20170920192612.16169-2-abailon@baylibre.com>
References: <20170920192612.16169-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920192612.16169-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The DA8xx and DSPS platforms don't use the same address for few registers.
On Da8xx, this is causing some issues (e.g. teardown that doesn't work).
Configure the address of the register during the init and use them instead
of constants.

Reported-by: nsekhar-l0cyMroinI0@public.gmane.org
Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/musb_cppi41.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index ba255280a624..d66416a27146 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -26,6 +26,9 @@
 
 #define MUSB_DMA_NUM_CHANNELS 15
 
+#define DA8XX_USB_AUTOREQ	0x14
+#define DA8XX_USB_TEARDOWN	0x1c
+
 struct cppi41_dma_controller {
 	struct dma_controller controller;
 	struct cppi41_dma_channel rx_channel[MUSB_DMA_NUM_CHANNELS];
@@ -35,6 +38,9 @@ struct cppi41_dma_controller {
 	u32 rx_mode;
 	u32 tx_mode;
 	u32 auto_req;
+
+	u32 tdown_reg;
+	u32 autoreq_reg;
 };
 
 static void save_rx_toggle(struct cppi41_dma_channel *cppi41_channel)
@@ -364,8 +370,8 @@ static void cppi41_set_autoreq_mode(struct cppi41_dma_channel *cppi41_channel,
 	if (new_mode == old_mode)
 		return;
 	controller->auto_req = new_mode;
-	musb_writel(controller->controller.musb->ctrl_base, USB_CTRL_AUTOREQ,
-		    new_mode);
+	musb_writel(controller->controller.musb->ctrl_base,
+		    controller->autoreq_reg, new_mode);
 }
 
 static bool cppi41_configure_channel(struct dma_channel *channel,
@@ -581,12 +587,13 @@ static int cppi41_dma_channel_abort(struct dma_channel *channel)
 
 	do {
 		if (is_tx)
-			musb_writel(musb->ctrl_base, USB_TDOWN, tdbit);
+			musb_writel(musb->ctrl_base, controller->tdown_reg,
+				    tdbit);
 		ret = dmaengine_terminate_all(cppi41_channel->dc);
 	} while (ret == -EAGAIN);
 
 	if (is_tx) {
-		musb_writel(musb->ctrl_base, USB_TDOWN, tdbit);
+		musb_writel(musb->ctrl_base, controller->tdown_reg, tdbit);
 
 		csr = musb_readw(epio, MUSB_TXCSR);
 		if (csr & MUSB_TXCSR_TXPKTRDY) {
@@ -727,6 +734,14 @@ cppi41_dma_controller_create(struct musb *musb, void __iomem *base)
 	controller->controller.is_compatible = cppi41_is_compatible;
 	controller->controller.musb = musb;
 
+	if (musb->io.quirks & MUSB_DA8XX) {
+		controller->tdown_reg = DA8XX_USB_TEARDOWN;
+		controller->autoreq_reg = DA8XX_USB_AUTOREQ;
+	} else {
+		controller->tdown_reg = USB_TDOWN;
+		controller->autoreq_reg = USB_CTRL_AUTOREQ;
+	}
+
 	ret = cppi41_dma_controller_start(controller);
 	if (ret)
 		goto plat_get_fail;
-- 
2.13.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
