From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2] usb: musb: musb_cppi41: Update an error message
Date: Fri,  5 May 2017 14:52:33 +0200
Message-ID: <20170505125233.27015-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

If dma_request_slave_channel() failed to return a channel,
then the driver will print an error and request to defer probe,
regardless of the cause of the failure.
Only defer if the DMA is not ready yet and print an error to explain
that we are deferring probe.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/musb_cppi41.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index e7c8b1b..4718d0d 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -673,10 +673,12 @@ static int cppi41_dma_controller_start(struct cppi41_dma_controller *controller)
 		musb_dma->status = MUSB_DMA_STATUS_FREE;
 		musb_dma->max_len = SZ_4M;
 
-		dc = dma_request_slave_channel(dev->parent, str);
-		if (!dc) {
-			dev_err(dev, "Failed to request %s.\n", str);
-			ret = -EPROBE_DEFER;
+		dc = dma_request_chan(dev->parent, str);
+		if (IS_ERR(dc)) {
+			ret = PTR_ERR(dc);
+			dev_err(dev, "Failed to request %s%s.\n", str,
+				ret == -EPROBE_DEFER
+				? ", deferring probe" : "");
 			goto err;
 		}
 		cppi41_channel->dc = dc;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
