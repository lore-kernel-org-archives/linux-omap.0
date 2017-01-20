From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 3/2] dmaengine: cppi41: Clean up pointless warnings
Date: Fri, 20 Jan 2017 15:07:11 -0600
Message-ID: <20170120210650.GG14571@uda0271908>
References: <20170119164908.9472-1-tony@atomide.com>
 <20170120200753.GM7403@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170120200753.GM7403-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 20, 2017 at 12:07:53PM -0800, Tony Lindgren wrote:
> With patches "dmaengine: cppi41: Fix runtime PM timeouts with USB mass
> storage", and "dmaengine: cppi41: Fix oops in cppi41_runtime_resume",
> the pm_runtime_get/put() in cppi41_irq() is no longer needed. We now
> guarantee that cppi41 is enabled when dma is in use.
> 
> We can still get pointless error -115 when musb is configured as a
> usb peripheral. That's because we should now check for the state of
> is_suspended instead.

I am not sure I understand this paragraph. Do you mean we still get
harmless -115 in peripheral mode? If so how is it caused by is_suspended
check? And the comment below for the check implies the WARN_ON() never
happens...

Regards,
-Bin.

> 
> Let's just remove the now useless code and replace it with a WARN().
> 
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
> 
> Found one more cosmetic issue. With patches 1/2 and 2/2 fixing the
> problems, this can now wait if considered not suitable for the -rc
> cycle.
> 
> ---
>  drivers/dma/cppi41.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
> @@ -323,12 +323,12 @@ static irqreturn_t cppi41_irq(int irq, void *data)
>  
>  		while (val) {
>  			u32 desc, len;
> -			int error;
>  
> -			error = pm_runtime_get(cdd->ddev.dev);
> -			if (error < 0)
> -				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
> -					__func__, error);
> +			/*
> +			 * This should never trigger, see the comments in
> +			 * push_desc_queue()
> +			 */
> +			WARN_ON(cdd->is_suspended);
>  
>  			q_num = __fls(val);
>  			val &= ~(1 << q_num);
> @@ -349,9 +349,6 @@ static irqreturn_t cppi41_irq(int irq, void *data)
>  			c->residue = pd_trans_len(c->desc->pd6) - len;
>  			dma_cookie_complete(&c->txd);
>  			dmaengine_desc_get_callback_invoke(&c->txd, NULL);
> -
> -			pm_runtime_mark_last_busy(cdd->ddev.dev);
> -			pm_runtime_put_autosuspend(cdd->ddev.dev);
>  		}
>  	}
>  	return IRQ_HANDLED;
> -- 
> 2.11.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
