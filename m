From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dma: cpp41: Fix handling of error path
Date: Mon, 14 Nov 2016 15:34:54 +0100
Message-ID: <20161114143454.GQ14744@localhost>
References: <20161111192852.25399-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161111192852.25399-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 11, 2016 at 11:28:52AM -0800, Tony Lindgren wrote:
> If we return early on pm_runtime_get() error, we need to also call
> pm_runtime_put_noidle() as pointed out in a musb related thread
> by Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>. This is to keep the PM runtime
> use counts happy.
> 
> Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
> Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/dma/cppi41.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
 
> @@ -466,6 +472,7 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
>  
>  	error = pm_runtime_get(cdd->ddev.dev);
>  	if ((error != -EINPROGRESS) && error < 0) {
> +		pm_runtime_put_noidle(cdd->ddev.dev);
>  		dev_err(cdd->ddev.dev, "Failed to pm_runtime_get: %i\n",
>  			error);

Will this chunk not introduce rather than fix an imbalance, though? An
error is never returned above, and the corresponding put is done
unconditionally as far as I can tell.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
