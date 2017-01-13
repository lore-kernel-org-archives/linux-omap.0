From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Fri, 13 Jan 2017 08:17:31 -0800
Message-ID: <20170113161731.GV2630@atomide.com>
References: <20170112213016.19367-1-tony@atomide.com>
 <927792da-2e90-b2ae-1206-8fcb504d7551@ti.com>
 <20170112221933.GM2630@atomide.com>
 <1c8967b7-d59b-e53d-feeb-80c71464fb94@ti.com>
 <20170112230456.GS2630@atomide.com>
 <aafe7afb-6d8a-2fef-acdd-bd331151d16a@ti.com>
 <20170113000314.GU2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170113000314.GU2630-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170112 16:04]:
> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [170112 15:43]:
> > @@ -457,38 +449,36 @@ static void push_desc_queue(struct cppi41_channel *c)
> >         cppi_writel(reg, cdd->qmgr_mem + QMGR_QUEUE_D(c->q_num));
> >  }
> >  
> > -static void pending_desc(struct cppi41_channel *c)
> > +static void cppi41_dma_issue_pending(struct dma_chan *chan)
> >  {
> > +       struct cppi41_channel *c = to_cpp41_chan(chan);
> >         struct cppi41_dd *cdd = c->cdd;
> > +       int error;
> > +       struct cppi41_channel *_c;
> >         unsigned long flags;
> >  
> >         spin_lock_irqsave(&cdd->lock, flags);
> >         list_add_tail(&c->node, &cdd->pending);
> > -       spin_unlock_irqrestore(&cdd->lock, flags);
> > -}
> > -
> > -static void cppi41_dma_issue_pending(struct dma_chan *chan)
> > -{
> > -       struct cppi41_channel *c = to_cpp41_chan(chan);
> > -       struct cppi41_dd *cdd = c->cdd;
> > -       int error;
> >  
> >         error = pm_runtime_get(cdd->ddev.dev);
> > -       if ((error != -EINPROGRESS) && error < 0) {
> > +       if (error < 0) {
> >                 pm_runtime_put_noidle(cdd->ddev.dev);
> >                 dev_err(cdd->ddev.dev, "Failed to pm_runtime_get: %i\n",
> >                         error);
> > -
> > +               spin_unlock_irqrestore(&cdd->lock, flags);
> >                 return;
> >         }
> >  
> > -       if (likely(pm_runtime_active(cdd->ddev.dev)))
> > -               push_desc_queue(c);
> > -       else
> > -               pending_desc(c);
> > +       if (!cdd->is_suspended) {
> > +               list_for_each_entry_safe(c, _c, &cdd->pending, node) {
> > +                       push_desc_queue(c);
> > +                       list_del(&c->node);
> > +               };
> > +       }
> >  
> >         pm_runtime_mark_last_busy(cdd->ddev.dev);
> >         pm_runtime_put_autosuspend(cdd->ddev.dev);
> > +       spin_lock_irqsave(&cdd->lock, flags);
> >  }
> 
> So always add to the queue no matter, then always flush the queue
> directly if active? Yeah that might work :)
> 
> Don't we need spinlock in the list_for_each_entry_safe() to prevent
> it racing with runtime_resume() though?

I could not apply for me as looks like your mail server replaced tabs
with spaces it seems :(

But anyways here's your basic idea plugged into my recent patch and
it seems to work. I maybe have missed something though while reading
so please check.

The pm_runtime_get/mark_last_busy/put_autosuspend and WARN_ON() we
want to keep in cppi41_irq() at least for now :)

And I'm thinking we must also callcppi41_run_queue() with spinlock
held to prevent out of order triggering of the DMA transfers.

Does this look OK to you?

Regards,

Tony

8< -----------------------
diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
index d5ba43a87a68..6ee593eb2acb 100644
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -153,6 +153,8 @@ struct cppi41_dd {
 
 	/* context for suspend/resume */
 	unsigned int dma_tdfdq;
+
+	bool is_suspended;
 };
 
 #define FIST_COMPLETION_QUEUE	93
@@ -316,11 +318,12 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 			__iormb();
 
 		while (val) {
+			unsigned long flags;
 			u32 desc, len;
 			int error;
 
 			error = pm_runtime_get(cdd->ddev.dev);
-			if (error < 0)
+			if ((error != -EINPROGRESS) && error < 0)
 				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
 					__func__, error);
 
@@ -340,6 +343,11 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 			else
 				len = pd_trans_len(c->desc->pd0);
 
+			/* This warning should never trigger */
+			spin_lock_irqsave(&cdd->lock, flags);
+			WARN_ON(cdd->is_suspended);
+			spin_unlock_irqrestore(&cdd->lock, flags);
+
 			c->residue = pd_trans_len(c->desc->pd6) - len;
 			dma_cookie_complete(&c->txd);
 			dmaengine_desc_get_callback_invoke(&c->txd, NULL);
@@ -457,20 +465,26 @@ static void push_desc_queue(struct cppi41_channel *c)
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
@@ -482,10 +496,11 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
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
@@ -1150,6 +1165,11 @@ static int __maybe_unused cppi41_resume(struct device *dev)
 static int __maybe_unused cppi41_runtime_suspend(struct device *dev)
 {
 	struct cppi41_dd *cdd = dev_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cdd->lock, flags);
+	cdd->is_suspended = true;
+	spin_unlock_irqrestore(&cdd->lock, flags);
 
 	WARN_ON(!list_empty(&cdd->pending));
 
@@ -1159,14 +1179,11 @@ static int __maybe_unused cppi41_runtime_suspend(struct device *dev)
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
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
