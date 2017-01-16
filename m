From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Mon, 16 Jan 2017 15:33:30 -0800
Message-ID: <20170116233329.GF7403@atomide.com>
References: <20170113180132.9188-1-tony@atomide.com>
 <d6fddff7-3d00-1de1-ebbf-ee2a949a6284@ti.com>
 <20170113190126.GE2630@atomide.com>
 <c80b51a2-1acd-914c-17b8-32754ea9ce3e@ti.com>
 <c58cebdf-5752-098a-8b3e-de99f6af14af@ti.com>
 <c1bbb731-940e-6d04-f127-222050d831b8@ti.com>
 <20170113215936.GF2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170113215936.GF2630-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170113 14:00]:
> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [170113 13:37]:
> > > Simplified diff with fix on top of your patch:
> > > 
> > > diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> > > index ce37a1a..9e9403a 100644
> > > --- a/drivers/dma/cppi41.c
> > > +++ b/drivers/dma/cppi41.c
> > > @@ -319,12 +319,6 @@ static irqreturn_t cppi41_irq(int irq, void *data)
> > >  
> > >  		while (val) {
> > >  			u32 desc, len;
> > > -			int error;
> > > -
> > > -			error = pm_runtime_get(cdd->ddev.dev);
> > > -			if ((error != -EINPROGRESS) && (error < 0))
> > > -				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
> > > -					__func__, error);
> > >  
> > >  			/* This warning should never trigger */
> > >  			WARN_ON(cdd->is_suspended);
> > > @@ -500,7 +494,6 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
> > >  	spin_unlock_irqrestore(&cdd->lock, flags);
> > >  
> > >  	pm_runtime_mark_last_busy(cdd->ddev.dev);
> > > -	pm_runtime_put_autosuspend(cdd->ddev.dev);
> > >  }
> > >  
> > >  static u32 get_host_pd0(u32 length)
> > > 
> > 
> > Ok. this is incorrect in case of USB hub and will just hide the problem
> > by incrementing PM runtime usage counter every time USB host is connected :(
> 
> Yeah if anything changes in those two nested loops, the pm_runtime counts
> get unbalanced.
> 
> > Once USB hub is connected the PM runtime usage counter will became 1 and stay
> > 1 after disconnection. Which means that some descriptor was pushed in Q, but IRQ
> > was not triggered.
> > 
> > Don't know how to proceed as I'm not so familiar with musb :(
> 
> I'm now playing with saving the queue manager value and kicking the
> PM runtime if we have transfers in progress. Looks like the dma
> registers are zero while there are transfers in progress, or at least
> I have not yet found any hardware registers that would tell that.

Looks like drivers/usb/musb/musb_cppi41.c is not properly terminating
dma transactions.. The following additional patch makes things behave
without warnings for me.

I'll fold the drivers/dma/cppi41.c changes to $subject patch and repost,
then will post a separate musb fix for drivers/usb/musb/musb_cppi41.c
that avoids the warning after some more investigating.

Luckily the warning is harmless in this case as musb and cppi41 are
in the same device so the common parent is powered and cppi41 is
getting clocked.

Regards,

Tony

8< ---------------------------
diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -705,19 +705,31 @@ static int cppi41_stop_chan(struct dma_chan *chan)
 	u32 desc_phys;
 	int ret;
 
+	ret = pm_runtime_get(cdd->ddev.dev);
+	if ((ret != -EINPROGRESS) && (ret < 0))
+		dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
+			__func__, ret);
+	WARN_ON(cdd->is_suspended);
+
 	desc_phys = lower_32_bits(c->desc_phys);
 	desc_num = (desc_phys - cdd->descs_phys) / sizeof(struct cppi41_desc);
-	if (!cdd->chan_busy[desc_num])
-		return 0;
+	if (!cdd->chan_busy[desc_num]) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = cppi41_tear_down_chan(c);
 	if (ret)
-		return ret;
+		goto out;
 
 	WARN_ON(!cdd->chan_busy[desc_num]);
 	cdd->chan_busy[desc_num] = NULL;
 
-	return 0;
+out:
+	pm_runtime_mark_last_busy(cdd->ddev.dev);
+	pm_runtime_put_autosuspend(cdd->ddev.dev);
+
+	return ret;
 }
 
 static void cleanup_chans(struct cppi41_dd *cdd)
diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
--- a/drivers/usb/musb/musb_cppi41.c
+++ b/drivers/usb/musb/musb_cppi41.c
@@ -445,9 +445,16 @@ static struct dma_channel *cppi41_dma_channel_allocate(struct dma_controller *c,
 static void cppi41_dma_channel_release(struct dma_channel *channel)
 {
 	struct cppi41_dma_channel *cppi41_channel = channel->private_data;
+	struct musb_hw_ep *hw_ep = cppi41_channel->hw_ep;
+	int error;
 
 	trace_musb_cppi41_free(cppi41_channel);
 	if (cppi41_channel->is_allocated) {
+		error = dmaengine_terminate_all(cppi41_channel->dc);
+		if (error)
+			dev_err(hw_ep->musb->controller,
+				"dma terminate failed: %i\n",
+				error);
 		cppi41_channel->is_allocated = 0;
 		channel->status = MUSB_DMA_STATUS_FREE;
 		channel->actual_len = 0;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
