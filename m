From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3] usb: musb: musb_cppi41: Update an error message
Date: Fri, 19 May 2017 15:27:47 +0200
Message-ID: <20170519132747.4730-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

If dma_request_slave_channel() failed to return a channel,
then the driver will print an error and request to defer probe,
regardless of the cause of the failure.
Defer if the DMA is not ready yet otherwise print an error.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/musb_cppi41.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index e7c8b1b..2c6ad93 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -673,12 +673,14 @@ static int cppi41_dma_controller_start(struct cppi41_dma_controller *controller)
 		musb_dma->status = MUSB_DMA_STATUS_FREE;
 		musb_dma->max_len = SZ_4M;
 
-		dc = dma_request_slave_channel(dev->parent, str);
-		if (!dc) {
-			dev_err(dev, "Failed to request %s.\n", str);
-			ret = -EPROBE_DEFER;
+		dc = dma_request_chan(dev->parent, str);
+		if (IS_ERR(dc)) {
+			ret = PTR_ERR(dc);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to request %s.\n", str);
 			goto err;
 		}
+
 		cppi41_channel->dc = dc;
 	}
 	return 0;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
