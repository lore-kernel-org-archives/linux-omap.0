From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] dmaengine: cppi41: Add basic PM runtime support
Date: Mon, 22 Aug 2016 22:28:23 +0530
Message-ID: <20160822165823.GQ2890@localhost>
References: <20160819225940.12653-1-tony@atomide.com>
 <20160819225940.12653-3-tony@atomide.com>
 <20160822064152.GP2890@localhost>
 <20160822142148.bylnbykob4xy3xb3@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160822142148.bylnbykob4xy3xb3-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 22, 2016 at 07:21:48AM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> [160821 23:34]:
> > On Fri, Aug 19, 2016 at 03:59:40PM -0700, Tony Lindgren wrote:
> > @@ -349,6 +358,12 @@ static dma_cookie_t cppi41_tx_submit(struct dma_async_tx_descriptor *tx)
> > >  static int cppi41_dma_alloc_chan_resources(struct dma_chan *chan)
> > >  {
> > >  	struct cppi41_channel *c = to_cpp41_chan(chan);
> > > +	struct cppi41_dd *cdd = c->cdd;
> > > +	int error;
> > > +
> > > +	error = pm_runtime_get_sync(cdd->ddev.dev);
> > 
> > This will be problematic. The alloc callback are not supposed to sleep, so
> > we cannot use a _sync() call here :(
> > 
> > This is explicitly documented in Documentation/dmaengine/provider.txt
> 
> Hmm but for device_alloc_chan_resources and device_free_chan_resources
> we have "These functions can sleep" in the documentation?

which is correct :)

> 
> Maybe you got confused with the patch @@ line saying cppi41_tx_submit
> although the pm_runtime_get is in cppi41_dma_alloc_chan_resources?
> Or else I'm confused :)

Ah, I was trying to finish this before I took my lunch break and looks like
messed it up. Sorry..
Never to rush a review again!

> Anyways, if necessary we could move the call to cppi_writel out of
> cppi41_dma_alloc_chan_resources I think.

I think alloc is fine, I will take a detailed look tomorrow...

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
