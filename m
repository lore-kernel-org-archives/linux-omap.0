From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/4] usb: musb: da8xx: Use the right dma controller
Date: Mon,  9 Jan 2017 17:38:59 +0100
Message-ID: <20170109163902.5268-2-abailon@baylibre.com>
References: <20170109163902.5268-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109163902.5268-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

da8xx driver is registering and using the cppi dma controller but actually,
the da8xx has a cppi41 dma controller.
Update the driver to register and use the cppi41 dma controller.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/da8xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index e89708d..74dcc07 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -458,14 +458,14 @@ static inline u8 get_vbus_power(struct device *dev)
 }
 
 static const struct musb_platform_ops da8xx_ops = {
-	.quirks		= MUSB_DMA_CPPI | MUSB_INDEXED_EP,
+	.quirks		= MUSB_DMA_CPPI41 | MUSB_INDEXED_EP,
 	.init		= da8xx_musb_init,
 	.exit		= da8xx_musb_exit,
 
 	.fifo_mode	= 2,
-#ifdef CONFIG_USB_TI_CPPI_DMA
-	.dma_init	= cppi_dma_controller_create,
-	.dma_exit	= cppi_dma_controller_destroy,
+#ifdef CONFIG_USB_TI_CPPI41_DMA
+	.dma_init	= cppi41_dma_controller_create,
+	.dma_exit	= cppi41_dma_controller_destroy,
 #endif
 	.enable		= da8xx_musb_enable,
 	.disable	= da8xx_musb_disable,
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
