From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/2] dmaengine: cppi41: Ignore EINPROGRESS for PM runtime in interrupt handler
Date: Mon,  9 Jan 2017 18:03:37 +0100
Message-ID: <20170109170337.6957-3-abailon@baylibre.com>
References: <20170109170337.6957-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109170337.6957-1-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We can occasionally get -EINPROGRESS for pm_runtime_get.
This is happening when an interrupt is fired before PM runtime had time
to update the PM state to RESUMED.
In that case, don't print any error.

Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/dma/cppi41.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index 025fee4..2306020 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -320,7 +320,7 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 			int error;
 
 			error = pm_runtime_get(cdd->ddev.dev);
-			if (error < 0)
+			if ((error != -EINPROGRESS) && error < 0)
 				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
 					__func__, error);
 
@@ -492,8 +492,7 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
 		 */
 		if (error == -EINPROGRESS) {
 			spin_lock_irqsave(&cdd->lock, flags);
-			if (list_empty(&cdd->pending))
-				active = true;
+			active = !!list_empty(&cdd->pending);
 			spin_unlock_irqrestore(&cdd->lock, flags);
 		}
 	}
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
