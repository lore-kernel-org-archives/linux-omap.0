From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] dmaengine: cppi41: Fix runtime PM timeouts with USB mass storage
Date: Thu, 19 Jan 2017 08:49:07 -0800
Message-ID: <20170119164908.9472-2-tony@atomide.com>
References: <20170119164908.9472-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170119164908.9472-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Commit fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
added runtime PM support for cppi41, but had corner case issues. Some of
the issues were fixed with commit 098de42ad670 ("dmaengine: cppi41: Fix
unpaired pm runtime when only a USB hub is connected"). That fix however
caused a new regression where we can get error -115 messages with USB on
BeagleBone when connecting a USB mass storage device to a hub.

This is because when connecting a USB mass storage device to a hub, the
initial DMA transfers can take over 200ms to complete and cppi41
autosuspend delay times out.

To fix the issue, we want to implement refcounting for chan_busy array
that contains the active dma transfers. Increasing the autosuspend delay
won't help as that the delay could be potentially seconds, and it's best
to let the USB subsystem to deal with the timeouts on errors.

The earlier attempt for runtime PM was buggy as the pm_runtime_get/put()
calls could get unpaired easily as they did not follow the state of
the chan_busy array as described in commit 098de42ad670 ("dmaengine:
cppi41: Fix unpaired pm runtime when only a USB hub is connected".

Let's fix the issue by adding pm_runtime_get() to where a new transfer
is added to the chan_busy array, and calls to pm_runtime_put() where
chan_busy array entry is cleared. This prevents any autosuspend timeouts
from happening while dma transfers are active.

Fixes: 098de42ad670 ("dmaengine: cppi41: Fix unpaired pm runtime when
only a USB hub is connected")
Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/dma/cppi41.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -257,6 +257,10 @@ static struct cppi41_channel *desc_to_chan(struct cppi41_dd *cdd, u32 desc)
 	BUG_ON(desc_num >= ALLOC_DECS_NUM);
 	c = cdd->chan_busy[desc_num];
 	cdd->chan_busy[desc_num] = NULL;
+
+	/* Usecount for chan_busy[], paired with push_desc_queue() */
+	pm_runtime_put(cdd->ddev.dev);
+
 	return c;
 }
 
@@ -447,6 +451,15 @@ static void push_desc_queue(struct cppi41_channel *c)
 	 */
 	__iowmb();
 
+	/*
+	 * DMA transfers can take at least 200ms to complete with USB mass
+	 * storage connected. To prevent autosuspend timeouts, we must use
+	 * pm_runtime_get/put() when chan_busy[] is modified. This will get
+	 * cleared in desc_to_chan() or cppi41_stop_chan() depending on the
+	 * outcome of the transfer.
+	 */
+	pm_runtime_get(cdd->ddev.dev);
+
 	desc_phys = lower_32_bits(c->desc_phys);
 	desc_num = (desc_phys - cdd->descs_phys) / sizeof(struct cppi41_desc);
 	WARN_ON(cdd->chan_busy[desc_num]);
@@ -705,6 +718,9 @@ static int cppi41_stop_chan(struct dma_chan *chan)
 	WARN_ON(!cdd->chan_busy[desc_num]);
 	cdd->chan_busy[desc_num] = NULL;
 
+	/* Usecount for chan_busy[], paired with push_desc_queue() */
+	pm_runtime_put(cdd->ddev.dev);
+
 	return 0;
 }
 
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
