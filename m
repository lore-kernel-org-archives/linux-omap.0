From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 01/11] dmaengine: cppi41: rename platform variables
Date: Mon,  9 Jan 2017 17:06:46 +0100
Message-ID: <20170109160656.3470-2-abailon@baylibre.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109160656.3470-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently, only the am335x is supported by the driver.
Though the driver has a glue layer to support different platforms,
some platform variable names are not prefixed with the platform name.
To facilitate the addition of a new platform,
rename some variables owned by the am335x glue.

Currently, only the am335x is supported by the driver.
Though the driver provide a glue layer that should be used to support
another platforms. Rename variable specifics to the am335x glue.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index d5ba43a..25ee71d 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -156,7 +156,7 @@ struct cppi41_dd {
 };
 
 #define FIST_COMPLETION_QUEUE	93
-static struct chan_queues usb_queues_tx[] = {
+static struct chan_queues am335x_usb_queues_tx[] = {
 	/* USB0 ENDP 1 */
 	[ 0] = { .submit = 32, .complete =  93},
 	[ 1] = { .submit = 34, .complete =  94},
@@ -192,7 +192,7 @@ static struct chan_queues usb_queues_tx[] = {
 	[29] = { .submit = 90, .complete = 139},
 };
 
-static const struct chan_queues usb_queues_rx[] = {
+static const struct chan_queues am335x_usb_queues_rx[] = {
 	/* USB0 ENDP 1 */
 	[ 0] = { .submit =  1, .complete = 109},
 	[ 1] = { .submit =  2, .complete = 110},
@@ -918,8 +918,9 @@ static bool cpp41_dma_filter_fn(struct dma_chan *chan, void *param)
 	else
 		queues = cdd->queues_rx;
 
-	BUILD_BUG_ON(ARRAY_SIZE(usb_queues_rx) != ARRAY_SIZE(usb_queues_tx));
-	if (WARN_ON(cchan->port_num > ARRAY_SIZE(usb_queues_rx)))
+	BUILD_BUG_ON(ARRAY_SIZE(am335x_usb_queues_rx) !=
+		     ARRAY_SIZE(am335x_usb_queues_tx));
+	if (WARN_ON(cchan->port_num > ARRAY_SIZE(am335x_usb_queues_rx)))
 		return false;
 
 	cchan->q_num = queues[cchan->port_num].submit;
@@ -947,15 +948,15 @@ static struct dma_chan *cppi41_dma_xlate(struct of_phandle_args *dma_spec,
 			&dma_spec->args[0]);
 }
 
-static const struct cppi_glue_infos usb_infos = {
+static const struct cppi_glue_infos am335x_usb_infos = {
 	.isr = cppi41_irq,
-	.queues_rx = usb_queues_rx,
-	.queues_tx = usb_queues_tx,
+	.queues_rx = am335x_usb_queues_rx,
+	.queues_tx = am335x_usb_queues_tx,
 	.td_queue = { .submit = 31, .complete = 0 },
 };
 
 static const struct of_device_id cppi41_dma_ids[] = {
-	{ .compatible = "ti,am3359-cppi41", .data = &usb_infos},
+	{ .compatible = "ti,am3359-cppi41", .data = &am335x_usb_infos},
 	{},
 };
 MODULE_DEVICE_TABLE(of, cppi41_dma_ids);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
