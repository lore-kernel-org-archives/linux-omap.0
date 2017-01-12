From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dmaengine: cppi41: Fix list not empty warning on
 runtime suspend
Date: Thu, 12 Jan 2017 09:45:16 -0800
Message-ID: <20170112174515.GH2630@atomide.com>
References: <20170109170337.6957-1-abailon@baylibre.com>
 <20170109170337.6957-2-abailon@baylibre.com>
 <20170109183416.GJ2630@atomide.com>
 <20170112170900.GG2630@atomide.com>
 <ac236cf1-d1e1-8f1f-fb62-b63cabf746d6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ac236cf1-d1e1-8f1f-fb62-b63cabf746d6-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [170112 09:24]:
> On 01/12/2017 11:09 AM, Tony Lindgren wrote:
> > Below is what seems to fix issues for me, not seeing any more warnings
> > either.
> > 
> > Care to give it a try with your USB headset?
> 
> This looks more close to what is provided in Documentation\power\runtime_pm.txt
> (example at the end of the file),
> but as per this document custom locking is required to access .active var.

OK so sounds like we're on the right track then :) Here's a version
using atomic.h.

Regards,

Tony

8< -------------------
diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -1,3 +1,4 @@
+#include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -153,6 +154,8 @@ struct cppi41_dd {
 
 	/* context for suspend/resume */
 	unsigned int dma_tdfdq;
+
+	atomic_t active;
 };
 
 #define FIST_COMPLETION_QUEUE	93
@@ -320,7 +323,8 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 			int error;
 
 			error = pm_runtime_get(cdd->ddev.dev);
-			if (error < 0)
+			if (((error != -EINPROGRESS) && error < 0) ||
+			    !atomic_read(&cdd->active))
 				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
 					__func__, error);
 
@@ -482,7 +486,7 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
 		return;
 	}
 
-	if (likely(pm_runtime_active(cdd->ddev.dev)))
+	if (likely(atomic_read(&cdd->active)))
 		push_desc_queue(c);
 	else
 		pending_desc(c);
@@ -1003,6 +1007,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	cdd->ddev.dst_addr_widths = CPPI41_DMA_BUSWIDTHS;
 	cdd->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	cdd->ddev.dev = dev;
+	atomic_set(&cdd->active, 0);
 	INIT_LIST_HEAD(&cdd->ddev.channels);
 	cpp41_dma_info.dma_cap = cdd->ddev.cap_mask;
 
@@ -1151,6 +1156,7 @@ static int __maybe_unused cppi41_runtime_suspend(struct device *dev)
 {
 	struct cppi41_dd *cdd = dev_get_drvdata(dev);
 
+	atomic_set(&cdd->active, 0);
 	WARN_ON(!list_empty(&cdd->pending));
 
 	return 0;
@@ -1159,13 +1165,20 @@ static int __maybe_unused cppi41_runtime_suspend(struct device *dev)
 static int __maybe_unused cppi41_runtime_resume(struct device *dev)
 {
 	struct cppi41_dd *cdd = dev_get_drvdata(dev);
-	struct cppi41_channel *c, *_c;
+	struct cppi41_channel *c;
 	unsigned long flags;
 
+	atomic_set(&cdd->active, 1);
+
 	spin_lock_irqsave(&cdd->lock, flags);
-	list_for_each_entry_safe(c, _c, &cdd->pending, node) {
-		push_desc_queue(c);
+	while (!list_empty(&cdd->pending)) {
+		c = list_first_entry(&cdd->pending,
+				     struct cppi41_channel,
+				     node);
 		list_del(&c->node);
+		spin_unlock_irqrestore(&cdd->lock, flags);
+		push_desc_queue(c);
+		spin_lock_irqsave(&cdd->lock, flags);
 	}
 	spin_unlock_irqrestore(&cdd->lock, flags);
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
