From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 2/3] usb: musb: cppi41: Detect aborted transfers in cppi41_dma_callback()
Date: Thu, 19 Jan 2017 11:06:58 +0100
Message-ID: <20170119100659.11370-3-abailon@baylibre.com>
References: <20170119100659.11370-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119100659.11370-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Update cppi41_dma_callback() to detect an aborted transfer.
This was not required before because cppi41_dma_callback() was only
invoked on transfer completion.
In order to make CPPI 4.1 driver more generic, cppi41_dma_callback()
will be invoked after a transfer abort in order to let the MUSB driver
perform some action such as acknowledge the interrupt that may be fired
during a teardown.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/usb/musb/musb_cppi41.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
index f7d3d27..1fe7eae 100644
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -99,7 +99,8 @@ static bool musb_is_tx_fifo_empty(struct musb_hw_ep *hw_ep)
 	return true;
 }
 
-static void cppi41_dma_callback(void *private_data);
+static void cppi41_dma_callback(void *private_data,
+				const struct dmaengine_result *result);
 
 static void cppi41_trans_done(struct cppi41_dma_channel *cppi41_channel)
 {
@@ -154,7 +155,7 @@ static void cppi41_trans_done(struct cppi41_dma_channel *cppi41_channel)
 		if (WARN_ON(!dma_desc))
 			return;
 
-		dma_desc->callback = cppi41_dma_callback;
+		dma_desc->callback_result = cppi41_dma_callback;
 		dma_desc->callback_param = &cppi41_channel->channel;
 		cppi41_channel->cookie = dma_desc->tx_submit(dma_desc);
 		trace_musb_cppi41_cont(cppi41_channel);
@@ -204,7 +205,8 @@ static enum hrtimer_restart cppi41_recheck_tx_req(struct hrtimer *timer)
 	return ret;
 }
 
-static void cppi41_dma_callback(void *private_data)
+static void cppi41_dma_callback(void *private_data,
+				const struct dmaengine_result *result)
 {
 	struct dma_channel *channel = private_data;
 	struct cppi41_dma_channel *cppi41_channel = channel->private_data;
@@ -221,6 +223,9 @@ static void cppi41_dma_callback(void *private_data)
 	if (controller->controller.dma_callback)
 		controller->controller.dma_callback(&controller->controller);
 
+	if (result->result == DMA_TRANS_ABORTED)
+		return;
+
 	spin_lock_irqsave(&musb->lock, flags);
 
 	dmaengine_tx_status(cppi41_channel->dc, cppi41_channel->cookie,
@@ -403,7 +408,7 @@ static bool cppi41_configure_channel(struct dma_channel *channel,
 	if (!dma_desc)
 		return false;
 
-	dma_desc->callback = cppi41_dma_callback;
+	dma_desc->callback_result = cppi41_dma_callback;
 	dma_desc->callback_param = channel;
 	cppi41_channel->cookie = dma_desc->tx_submit(dma_desc);
 	cppi41_channel->channel.rx_packet_done = false;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
