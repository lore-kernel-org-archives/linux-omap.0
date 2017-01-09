From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 09/11] dmaengine: cppi41: Fix a race between PM runtime and channel abort
Date: Mon,  9 Jan 2017 17:06:54 +0100
Message-ID: <20170109160656.3470-10-abailon@baylibre.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109160656.3470-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

cppi41_dma_issue_pending() may be called while the device is runtime
suspended. In that case, the descritpor will be push to the pending
list and then be queued to hardware queue.
But if cppi41_stop_chan() is called before the device got time to
resume, then the descriptor will remain in the pending list and be
queued to hardware queue after the teardown.
During the channel stop, check if there is a pendding descriptor
and if so, remove it.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 4318e53..e8470b1 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -751,10 +751,17 @@ static int cppi41_stop_chan(struct dma_chan *chan)
 {
 	struct cppi41_channel *c = to_cpp41_chan(chan);
 	struct cppi41_dd *cdd = c->cdd;
+	unsigned long flags;
 	u32 desc_num;
 	u32 desc_phys;
 	int ret;
 
+	/* Remove pending descriptor that haven't been pushed to queue */
+	spin_lock_irqsave(&cdd->lock, flags);
+	if (!list_empty(&c->node))
+		list_del_init(&c->node);
+	spin_unlock_irqrestore(&cdd->lock, flags);
+
 	desc_phys = lower_32_bits(c->desc_phys);
 	desc_num = (desc_phys - cdd->descs_phys) / sizeof(struct cppi41_desc);
 	if (!cdd->chan_busy[desc_num])
@@ -812,6 +819,7 @@ static int cppi41_add_chans(struct device *dev, struct cppi41_dd *cdd)
 		cchan->desc_phys = cdd->descs_phys;
 		cchan->desc_phys += i * sizeof(struct cppi41_desc);
 		cchan->chan.device = &cdd->ddev;
+		INIT_LIST_HEAD(&cchan->node);
 		list_add_tail(&cchan->chan.device_node, &cdd->ddev.channels);
 	}
 	cdd->first_td_desc = n_chans;
@@ -1301,7 +1309,7 @@ static int __maybe_unused cppi41_runtime_resume(struct device *dev)
 	spin_lock_irqsave(&cdd->lock, flags);
 	list_for_each_entry_safe(c, _c, &cdd->pending, node) {
 		push_desc_queue(c);
-		list_del(&c->node);
+		list_del_init(&c->node);
 	}
 	spin_unlock_irqrestore(&cdd->lock, flags);
 
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
