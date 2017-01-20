From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: musb: Fix host mode error -71 regression
Date: Fri, 20 Jan 2017 13:23:47 -0600
Message-ID: <20170120192322.GC14571@uda0271908>
References: <20170119022959.30793-1-tony@atomide.com>
 <20170119022959.30793-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170119022959.30793-2-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 18, 2017 at 06:29:58PM -0800, Tony Lindgren wrote:
> Commit 467d5c980709 ("usb: musb: Implement session bit based runtime PM for
> musb-core") started implementing musb generic runtime PM support by
> introducing devctl register session bit based state control.
> 
> This caused a regression where if a USB mass storage device is connected
> to a USB hub, we can get:
> 
> usb 1-1: reset high-speed USB device number 2 using musb-hdrc
> usb 1-1: device descriptor read/64, error -71
> usb 1-1.1: new high-speed USB device number 4 using musb-hdrc
> 
> This is because before the USB storage device is connected, musb is
> in OTG_STATE_A_SUSPEND. And we currently only set need_finish_resume
> in musb_stage0_irq() and the related code calling finish_resume_work
> in musb_resume() and musb_runtime_resume() never gets called.
> 
> To fix the issue, we can call schedule_delayed_work() directly in
> musb_stage0_irq() to have finish_resume_work run.
> 
> And we should no longer never get interrupts when when suspended.
> We have changed musb to no longer need pm_runtime_irqsafe().
> The need_finish_resume flag was added in commit 9298b4aad37e ("usb:
> musb: fix device hotplug behind hub") and no longer applies as far
> as I can tell. So let's just remove the earlier code that no longer
> is needed.
> 
> Fixes: 467d5c980709 ("usb: musb: Implement session bit based
> runtime PM for musb-core")
> Reported-by: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Applied. Thanks.
-Bin.

> ---
>  drivers/usb/musb/musb_core.c | 15 ++-------------
>  drivers/usb/musb/musb_core.h |  1 -
>  2 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -594,11 +594,11 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>  						| MUSB_PORT_STAT_RESUME;
>  				musb->rh_timer = jiffies
>  					+ msecs_to_jiffies(USB_RESUME_TIMEOUT);
> -				musb->need_finish_resume = 1;
> -
>  				musb->xceiv->otg->state = OTG_STATE_A_HOST;
>  				musb->is_active = 1;
>  				musb_host_resume_root_hub(musb);
> +				schedule_delayed_work(&musb->finish_resume_work,
> +					msecs_to_jiffies(USB_RESUME_TIMEOUT));
>  				break;
>  			case OTG_STATE_B_WAIT_ACON:
>  				musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
> @@ -2710,11 +2710,6 @@ static int musb_resume(struct device *dev)
>  	mask = MUSB_DEVCTL_BDEVICE | MUSB_DEVCTL_FSDEV | MUSB_DEVCTL_LSDEV;
>  	if ((devctl & mask) != (musb->context.devctl & mask))
>  		musb->port1_status = 0;
> -	if (musb->need_finish_resume) {
> -		musb->need_finish_resume = 0;
> -		schedule_delayed_work(&musb->finish_resume_work,
> -				      msecs_to_jiffies(USB_RESUME_TIMEOUT));
> -	}
>  
>  	/*
>  	 * The USB HUB code expects the device to be in RPM_ACTIVE once it came
> @@ -2766,12 +2761,6 @@ static int musb_runtime_resume(struct device *dev)
>  
>  	musb_restore_context(musb);
>  
> -	if (musb->need_finish_resume) {
> -		musb->need_finish_resume = 0;
> -		schedule_delayed_work(&musb->finish_resume_work,
> -				msecs_to_jiffies(USB_RESUME_TIMEOUT));
> -	}
> -
>  	spin_lock_irqsave(&musb->lock, flags);
>  	error = musb_run_resume_work(musb);
>  	if (error)
> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -410,7 +410,6 @@ struct musb {
>  
>  	/* is_suspended means USB B_PERIPHERAL suspend */
>  	unsigned		is_suspended:1;
> -	unsigned		need_finish_resume :1;
>  
>  	/* may_wakeup means remote wakeup is enabled */
>  	unsigned		may_wakeup:1;
> -- 
> 2.11.0
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
