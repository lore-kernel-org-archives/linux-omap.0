From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Fri, 13 Jan 2017 08:44:00 -0800
Message-ID: <20170113164400.GX2630@atomide.com>
References: <20170112213016.19367-1-tony@atomide.com>
 <927792da-2e90-b2ae-1206-8fcb504d7551@ti.com>
 <20170112221933.GM2630@atomide.com>
 <1c8967b7-d59b-e53d-feeb-80c71464fb94@ti.com>
 <20170112230456.GS2630@atomide.com>
 <aafe7afb-6d8a-2fef-acdd-bd331151d16a@ti.com>
 <20170113000314.GU2630@atomide.com>
 <20170113161731.GV2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170113161731.GV2630-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170113 08:27]:
> @@ -316,11 +318,12 @@ static irqreturn_t cppi41_irq(int irq, void *data)
>  			__iormb();
>  
>  		while (val) {
> +			unsigned long flags;
>  			u32 desc, len;
>  			int error;
>  
>  			error = pm_runtime_get(cdd->ddev.dev);
> -			if (error < 0)
> +			if ((error != -EINPROGRESS) && error < 0)
>  				dev_err(cdd->ddev.dev, "%s pm runtime get: %i\n",
>  					__func__, error);
>  
> @@ -340,6 +343,11 @@ static irqreturn_t cppi41_irq(int irq, void *data)
>  			else
>  				len = pd_trans_len(c->desc->pd0);
>  
> +			/* This warning should never trigger */
> +			spin_lock_irqsave(&cdd->lock, flags);
> +			WARN_ON(cdd->is_suspended);
> +			spin_unlock_irqrestore(&cdd->lock, flags);
> +
>  			c->residue = pd_trans_len(c->desc->pd6) - len;
>  			dma_cookie_complete(&c->txd);
>  			dmaengine_desc_get_callback_invoke(&c->txd, NULL);

Hmm this check needs to be before cppi41_pop_desc() already as that does
cppi_readl(). And the spinlocks here don't help anything, we just want
to see a warning if we hit a bug somewhere else.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
