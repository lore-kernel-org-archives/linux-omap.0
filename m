From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv3] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Wed, 18 Jan 2017 08:53:09 -0800
Message-ID: <20170118165308.GC7403@atomide.com>
References: <20170117175524.3484-1-tony@atomide.com>
 <20170118142501.GA10928@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170118142501.GA10928@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170118 06:26]:
> With this v3, I still get -71 error when a device is plugged to a hub to
> musb. It doesn't happen though if the device is already plugged to the hub
> before attaching the hub to musb.
> 
> [  177.579300] usb 1-1: reset high-speed USB device number 2 using musb-hdrc
> [  177.719308] usb 1-1: device descriptor read/64, error -71
> [  178.350297] usb 1-1.1: new high-speed USB device number 4 using musb-hdrc

I think the -71 issue is a different regression. I've verified that v4.8.y
does not have this, but v4.9.y does have it.

So far the easiest way for me to reproduce the -71 problem is by plugging
a USB drive into a connected hub. If I connect the hub with USB drive already
plugged into the hub, it does not happen.

With the hub connected musb is already active when the USB drive is plugged
in. So I'm now suspecting this -71 regression is not related to runtime PM
changes. Bisect and boot and plug devices time I think unless you have
better ideas?

> And I still get -115 error flooding with thumb drive.
> 
> [  236.880068] cppi41-dma-engine 47400000.dma-controller: cppi41_irq pm runtime get: -115
> 
> I tested with TI AM335x GP EVM. The problems happen on both musb ports.

OK. So it's pointless to try to play with the autosuspend timeout.

Let's just do a WARN(!pm_runtime_active(cdd->ddev.dev->parent)) there
until we have musb_cppi41.c dma calls properly paired and don't have
dma requests lingering.

Care to try the updated patch below? It won't help with the -71 issue
but the $subject issue should be fixed. And you should not see the
WARN() trigger with your tests presumably.

Regards,

Tony

8< ----------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Mon, 16 Jan 2017 09:52:10 -0800
Subject: [PATCH] dmaengine: cppi41: Fix oops in cppi41_runtime_resume

Commit fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
together with recent MUSB changes allowed USB and DMA on BeagleBone to idle
when no cable is connected. But looks like few corner case issues still
remain.

Looks like just by re-plugging USB cable about ten or so times on BeagleBone
when configured in USB peripheral mode we can get warnings and eventually
trigger an oops in cppi41 DMA:

WARNING: CPU: 0 PID: 14 at drivers/dma/cppi41.c:1154 cppi41_runtime_suspend+
x28/0x38 [cppi41]
...

WARNING: CPU: 0 PID: 14 at drivers/dma/cppi41.c:452
push_desc_queue+0x94/0x9c [cppi41]
...

Unable to handle kernel NULL pointer dereference at virtual
address 00000104
pgd = c0004000
[00000104] *pgd=00000000
Internal error: Oops: 805 [#1] SMP ARM
...
[<bf0d92cc>] (cppi41_runtime_resume [cppi41]) from [<c0589838>]
(__rpm_callback+0xc0/0x214)
[<c0589838>] (__rpm_callback) from [<c05899ac>] (rpm_callback+0x20/0x80)
[<c05899ac>] (rpm_callback) from [<c0589460>] (rpm_resume+0x504/0x78c)
[<c0589460>] (rpm_resume) from [<c058a1a0>] (pm_runtime_work+0x60/0xa8)
[<c058a1a0>] (pm_runtime_work) from [<c0156120>] (process_one_work+0x2b4/0x808)

This is because of a race with runtime PM and cppi41_dma_issue_pending()
as reported by Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> in earlier
set of patches. Based on mailing list discussions we however came to the
conclusion that a different fix from Alexandre's fix is needed in order
to guarantee that DMA is really active when we try to use it.

To fix the issue, we need to add a driver specific flag as we otherwise
can have -EINPROGRESS state set by runtime PM and can't rely on
pm_runtime_active() to tell us when we can use the DMA.

And we need to make sure the DMA transfers get triggered in the queued
order. So let's always queue the transfers, then flush the queue
from both cppi41_dma_issue_pending() and cppi41_runtime_resume()
as suggested by Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> in an
earlier example patch.

For reference, this is also documented in Documentation/power/runtime_pm.txt
in the example at the end of the file as pointed out by Grygorii Strashko
<grygorii.strashko-l0cyMroinI0@public.gmane.org>.

Based on earlier patches from Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
and Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> modified based on
testing and what was discussed on the mailing lists.

Note that additional patches are still needed depending on how we want
to handle the cppi41 runtime PM. So far cppi41 is always coupled with
musb driver, and musb guarantees that cppi41 is always active during
use. So until we have a better solution, let's just WARN() if the musb
parent is not active to avoid pointless EINPROGRESS warnings during
USB mass storage enumeration. As cppi41 is properly clocked with musb
being active, we can safely do this.

Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Reported-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/dma/cppi41.c | 51 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -153,6 +153,8 @@ struct cppi41_dd {
 
 	/* context for suspend/resume */
 	unsigned int dma_tdfdq;
+
+	bool is_suspended;
 };
 
 #define FIST_COMPLETION_QUEUE	93
@@ -317,12 +319,10 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 
 		while (val) {
 			u32 desc, len;
-			int error;
 
-			error = pm_runtime_get(cdd->ddev.dev);
-			if (error < 0)
-				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
-					__func__, error);
+			/* Revisit when musb_cppi41.c dma calls are paired */
+			WARN(!pm_runtime_active(cdd->ddev.dev->parent),
+			     "%s parent not active?\n", __func__);
 
 			q_num = __fls(val);
 			val &= ~(1 << q_num);
@@ -343,9 +343,6 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 			c->residue = pd_trans_len(c->desc->pd6) - len;
 			dma_cookie_complete(&c->txd);
 			dmaengine_desc_get_callback_invoke(&c->txd, NULL);
-
-			pm_runtime_mark_last_busy(cdd->ddev.dev);
-			pm_runtime_put_autosuspend(cdd->ddev.dev);
 		}
 	}
 	return IRQ_HANDLED;
@@ -457,20 +454,26 @@ static void push_desc_queue(struct cppi41_channel *c)
 	cppi_writel(reg, cdd->qmgr_mem + QMGR_QUEUE_D(c->q_num));
 }
 
-static void pending_desc(struct cppi41_channel *c)
+/*
+ * Caller must hold cdd->lock to prevent push_desc_queue()
+ * getting called out of order. We have both cppi41_dma_issue_pending()
+ * and cppi41_runtime_resume() call this function.
+ */
+static void cppi41_run_queue(struct cppi41_dd *cdd)
 {
-	struct cppi41_dd *cdd = c->cdd;
-	unsigned long flags;
+	struct cppi41_channel *c, *_c;
 
-	spin_lock_irqsave(&cdd->lock, flags);
-	list_add_tail(&c->node, &cdd->pending);
-	spin_unlock_irqrestore(&cdd->lock, flags);
+	list_for_each_entry_safe(c, _c, &cdd->pending, node) {
+		push_desc_queue(c);
+		list_del(&c->node);
+	}
 }
 
 static void cppi41_dma_issue_pending(struct dma_chan *chan)
 {
 	struct cppi41_channel *c = to_cpp41_chan(chan);
 	struct cppi41_dd *cdd = c->cdd;
+	unsigned long flags;
 	int error;
 
 	error = pm_runtime_get(cdd->ddev.dev);
@@ -482,10 +485,11 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
 		return;
 	}
 
-	if (likely(pm_runtime_active(cdd->ddev.dev)))
-		push_desc_queue(c);
-	else
-		pending_desc(c);
+	spin_lock_irqsave(&cdd->lock, flags);
+	list_add_tail(&c->node, &cdd->pending);
+	if (!cdd->is_suspended)
+		cppi41_run_queue(cdd);
+	spin_unlock_irqrestore(&cdd->lock, flags);
 
 	pm_runtime_mark_last_busy(cdd->ddev.dev);
 	pm_runtime_put_autosuspend(cdd->ddev.dev);
@@ -1150,8 +1154,12 @@ static int __maybe_unused cppi41_resume(struct device *dev)
 static int __maybe_unused cppi41_runtime_suspend(struct device *dev)
 {
 	struct cppi41_dd *cdd = dev_get_drvdata(dev);
+	unsigned long flags;
 
+	spin_lock_irqsave(&cdd->lock, flags);
+	cdd->is_suspended = true;
 	WARN_ON(!list_empty(&cdd->pending));
+	spin_unlock_irqrestore(&cdd->lock, flags);
 
 	return 0;
 }
@@ -1159,14 +1167,11 @@ static int __maybe_unused cppi41_runtime_suspend(struct device *dev)
 static int __maybe_unused cppi41_runtime_resume(struct device *dev)
 {
 	struct cppi41_dd *cdd = dev_get_drvdata(dev);
-	struct cppi41_channel *c, *_c;
 	unsigned long flags;
 
 	spin_lock_irqsave(&cdd->lock, flags);
-	list_for_each_entry_safe(c, _c, &cdd->pending, node) {
-		push_desc_queue(c);
-		list_del(&c->node);
-	}
+	cdd->is_suspended = false;
+	cppi41_run_queue(cdd);
 	spin_unlock_irqrestore(&cdd->lock, flags);
 
 	return 0;
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
