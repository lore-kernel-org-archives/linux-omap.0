From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] dmaengine: cppi41: Add basic PM runtime support
Date: Mon, 22 Aug 2016 12:11:52 +0530
Message-ID: <20160822064152.GP2890@localhost>
References: <20160819225940.12653-1-tony@atomide.com>
 <20160819225940.12653-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160819225940.12653-3-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 19, 2016 at 03:59:40PM -0700, Tony Lindgren wrote:
> Let's keep the device enabled between cppi41_dma_issue_pending()
> and dmaengine_desc_get_callback_invoke() and rely on the PM runtime
> autoidle timeout elsewhere.
> 
> As the PM runtime is for whole device, not for each channel,
> we need to queue pending transfers if the device is PM runtime
> suspended. Then we start the pending transfers in PM runtime
> resume.
> 
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/dma/cppi41.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 99 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> index 66b84fe..ce8739f 100644
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
> @@ -108,6 +108,8 @@ struct cppi41_channel {
>  	unsigned td_queued:1;
>  	unsigned td_seen:1;
>  	unsigned td_desc_seen:1;
> +
> +	struct list_head node;		/* Node for pending list */
>  };
>  
>  struct cppi41_desc {
> @@ -146,6 +148,9 @@ struct cppi41_dd {
>  	const struct chan_queues *queues_tx;
>  	struct chan_queues td_queue;
>  
> +	struct list_head pending;	/* Pending queued transfers */
> +	spinlock_t lock;		/* Lock for pending list */
> +
>  	/* context for suspend/resume */
>  	unsigned int dma_tdfdq;
>  };
> @@ -332,6 +337,10 @@ static irqreturn_t cppi41_irq(int irq, void *data)
>  			c->residue = pd_trans_len(c->desc->pd6) - len;
>  			dma_cookie_complete(&c->txd);
>  			dmaengine_desc_get_callback_invoke(&c->txd, NULL);
> +
> +			/* Paired with cppi41_dma_issue_pending */
> +			pm_runtime_mark_last_busy(cdd->ddev.dev);
> +			pm_runtime_put_autosuspend(cdd->ddev.dev);
>  		}
>  	}
>  	return IRQ_HANDLED;
> @@ -349,6 +358,12 @@ static dma_cookie_t cppi41_tx_submit(struct dma_async_tx_descriptor *tx)
>  static int cppi41_dma_alloc_chan_resources(struct dma_chan *chan)
>  {
>  	struct cppi41_channel *c = to_cpp41_chan(chan);
> +	struct cppi41_dd *cdd = c->cdd;
> +	int error;
> +
> +	error = pm_runtime_get_sync(cdd->ddev.dev);

This will be problematic. The alloc callback are not supposed to sleep, so
we cannot use a _sync() call here :(

This is explicitly documented in Documentation/dmaengine/provider.txt

> +	if (error < 0)
> +		return error;
>  
>  	dma_cookie_init(chan);
>  	dma_async_tx_descriptor_init(&c->txd, chan);
> @@ -357,11 +372,26 @@ static int cppi41_dma_alloc_chan_resources(struct dma_chan *chan)
>  	if (!c->is_tx)
>  		cppi_writel(c->q_num, c->gcr_reg + RXHPCRA0);
>  
> +	pm_runtime_mark_last_busy(cdd->ddev.dev);
> +	pm_runtime_put_autosuspend(cdd->ddev.dev);
> +
>  	return 0;
>  }
>  
>  static void cppi41_dma_free_chan_resources(struct dma_chan *chan)
>  {
> +	struct cppi41_channel *c = to_cpp41_chan(chan);
> +	struct cppi41_dd *cdd = c->cdd;
> +	int error;
> +
> +	error = pm_runtime_get_sync(cdd->ddev.dev);

same applies here too


-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
