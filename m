From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dmaengine: cppi41: Ignore EINPROGRESS for PM
 runtime in interrupt handler
Date: Mon, 9 Jan 2017 10:39:47 -0800
Message-ID: <20170109183946.GK2630@atomide.com>
References: <20170109170337.6957-1-abailon@baylibre.com>
 <20170109170337.6957-3-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170109170337.6957-3-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> [170109 09:04]:
> We can occasionally get -EINPROGRESS for pm_runtime_get.
> This is happening when an interrupt is fired before PM runtime had time
> to update the PM state to RESUMED.
> In that case, don't print any error.

Hmm if the cppi41 interrupt fires, the device has resumed :)

I think we should have a cppi41.c specific flag that we can set
at the end of cppi41_resume() instead of list_empty() or
pm_runtime_active().

Regars,

Tony


> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/dma/cppi41.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> index 025fee4..2306020 100644
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
> @@ -320,7 +320,7 @@ static irqreturn_t cppi41_irq(int irq, void *data)
>  			int error;
>  
>  			error = pm_runtime_get(cdd->ddev.dev);
> -			if (error < 0)
> +			if ((error != -EINPROGRESS) && error < 0)
>  				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
>  					__func__, error);
>  
> @@ -492,8 +492,7 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
>  		 */
>  		if (error == -EINPROGRESS) {
>  			spin_lock_irqsave(&cdd->lock, flags);
> -			if (list_empty(&cdd->pending))
> -				active = true;
> +			active = !!list_empty(&cdd->pending);
>  			spin_unlock_irqrestore(&cdd->lock, flags);
>  		}
>  	}
> -- 
> 2.10.2
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
