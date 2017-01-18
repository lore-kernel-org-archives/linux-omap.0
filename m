From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Wed, 18 Jan 2017 15:13:09 -0600
Message-ID: <20170118211309.GE10928@uda0271908>
References: <20170117175524.3484-1-tony@atomide.com>
 <20170118142501.GA10928@uda0271908>
 <20170118165308.GC7403@atomide.com>
 <f33ba3b1-a35d-8d63-35ec-db1e0ca96c54@ti.com>
 <20170118181541.GJ7403@atomide.com>
 <20170118184432.GK7403@atomide.com>
 <20170118184840.GD10928@uda0271908>
 <20170118204859.GN7403@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170118204859.GN7403-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 18, 2017 at 12:48:59PM -0800, Tony Lindgren wrote:
> * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170118 10:49]:
> > On Wed, Jan 18, 2017 at 10:44:32AM -0800, Tony Lindgren wrote:
> > > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170118 10:15]:
> > > > * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [170118 10:05]:
> > > > > 
> > > > > 
> > > > > On 01/18/2017 10:53 AM, Tony Lindgren wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170118 06:26]:
> > > > > >> With this v3, I still get -71 error when a device is plugged to a hub to
> > > > > >> musb. It doesn't happen though if the device is already plugged to the hub
> > > > > >> before attaching the hub to musb.
> > > > > >>
> > > > > >> [  177.579300] usb 1-1: reset high-speed USB device number 2 using musb-hdrc
> > > > > >> [  177.719308] usb 1-1: device descriptor read/64, error -71
> > > > > >> [  178.350297] usb 1-1.1: new high-speed USB device number 4 using musb-hdrc
> > > > > > 
> > > > > > I think the -71 issue is a different regression. I've verified that v4.8.y
> > > > > > does not have this, but v4.9.y does have it.
> > > > > > 
> > > > > > So far the easiest way for me to reproduce the -71 problem is by plugging
> > > > > > a USB drive into a connected hub. If I connect the hub with USB drive already
> > > > > > plugged into the hub, it does not happen.
> > > ...
> > > 
> > > > > Sry, but wouldn't be more simple and safe just to drop PM runtime from this driver,
> > > > > as it is part of musb and musb PM state expected to be handled properly by PM runtime now.
> > > > 
> > > > Well we still need PM runtime in cppi41 to initialize it when it gets
> > > > probed and idle it when not used even if musb modules are not loaded.
> > > > 
> > > > Unfortunately until musb_cppi41.c dma calls are fixed, we can't do
> > > > any sane use counting in cppi41.c without adding timeout handling
> > > > to it.
> > > > 
> > > > > More over, There is another possibility related to the current PM runtime implementation and autosuspend
> > > > > - it might introduce delay between time when musb request desc push and time when cppi will actually
> > > > > put this desc in HW queue if cppi was not active.
> > > > > For example, there might not be -71 error seen if CPPI autosuspend is disabled
> > > > > (cppi is active all the time) before plug-in hub and then USB drive.
> > > > 
> > > > I already checked that. The -71 error seems to be a separate issue.
> > > 
> > > OK found it. I can make v4.8.17 produce -71 errors with just commit
> > > 467d5c980709 ("usb: musb: Implement session bit based runtime PM for
> > > musb-core") applied on top of it. So looks like we're missing some
> > > musb quirk handling for the devctl session bit.
> > 
> > Nice!
> 
> And here's a fix for the error -71 regression.
> 
> Bin, can you review and test your earlier case mentioned in
> commit 9298b4aad37e ("usb: musb: fix device hotplug behind hub") with
> the patch below to make sure this is safe to do now starting with v4.9?
> 

This solves the issue, and the patch looks good to me. Thanks for fixing
it up.

Regards,
-Bin.

> Regards,
> 
> Tony
> 
> 8< -----------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Wed, 18 Jan 2017 12:31:25 -0800
> Subject: [PATCH] usb: musb: Fix host mode error -71 regression
> 
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
