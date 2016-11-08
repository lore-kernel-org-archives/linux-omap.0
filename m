From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: musb: Fix sleeping function called from invalid
 context for hdrc glue
Date: Tue, 8 Nov 2016 18:09:17 +0100
Message-ID: <20161108170917.GA3328@localhost>
References: <20161107215020.31399-1-tony@atomide.com>
 <20161107215020.31399-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161107215020.31399-3-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 07, 2016 at 02:50:18PM -0700, Tony Lindgren wrote:
> Commit 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
> glue layer") wrongly added a call for pm_runtime_get_sync to otg_timer
> that runs in softirq context. That causes a "BUG: sleeping function called
> from invalid context" every time when polling the cable status:
> 
> [<c015ebb4>] (__might_sleep) from [<c0413d60>] (__pm_runtime_resume+0x9c/0xa0)
> [<c0413d60>] (__pm_runtime_resume) from [<c04d0bc4>] (otg_timer+0x3c/0x254)
> [<c04d0bc4>] (otg_timer) from [<c0191180>] (call_timer_fn+0xfc/0x41c)
> [<c0191180>] (call_timer_fn) from [<c01915c0>] (expire_timers+0x120/0x210)
> [<c01915c0>] (expire_timers) from [<c0191acc>] (run_timer_softirq+0xa4/0xdc)
> [<c0191acc>] (run_timer_softirq) from [<c010168c>] (__do_softirq+0x12c/0x594)
> 
> I did not notice that as I did not have CONFIG_DEBUG_ATOMIC_SLEEP enabled.
> And looks like also musb_gadget_queue() suffers from the same problem.
> 
> Let's fix the issue by using a list of delayed work then call it on
> resume. Note that we want to do this only when musb core and it's
> parent devices are awake as noted by Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>.
> 
> Also note that we now also need to get rid of static int first as
> that won't work right on devices with two musb instances like am335x.

This paragraph no longer applies to this patch.

> Later on we may be able to remove other delayed work in the musb driver
> and just do it from pending_resume_work. But this should be done only
> for delayed work that does not have other timing requirements beyond
> just being run on resume.
> 
> Fixes: 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
> glue layer")
> Reported-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/usb/musb/musb_core.c   | 69 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/musb/musb_core.h   |  7 +++++
>  drivers/usb/musb/musb_dsps.c   | 24 ++++++++++-----
>  drivers/usb/musb/musb_gadget.c | 22 ++++++++++++--
>  4 files changed, 112 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c

> +static void musb_pending_work(struct work_struct *work)
> +{
> +	struct musb *musb;
> +	struct musb_pending_work *w;
> +	unsigned long flags;
> +	int error;
> +
> +	musb = container_of(work, struct musb, pending_resume_work.work);
> +	error = pm_runtime_get_sync(musb->controller);
> +	if (error < 0) {
> +		dev_err(musb->controller, "failed resume for pending work: %i\n",
> +			error);
> +
> +		return;
> +	}
> +	spin_lock_irqsave(&musb->list_lock, flags);
> +	while (!list_empty(&musb->pending_list)) {

This construct is no longer needed as no work is (and must not be) added
while the controller is resumed and list_for_each_entry_safe() would
therefore do.

> +		w = list_first_entry(&musb->pending_list,
> +				     struct musb_pending_work,
> +				     node);
> +		list_del(&w->node);
> +		spin_unlock_irqrestore(&musb->list_lock, flags);
> +		if (w->callback)
> +			w->callback(musb, w->data);
> +		devm_kfree(musb->controller, w);
> +		spin_lock_irqsave(&musb->list_lock, flags);
> +	}
> +	spin_unlock_irqrestore(&musb->list_lock, flags);
> +	pm_runtime_mark_last_busy(musb->controller);
> +	pm_runtime_put_autosuspend(musb->controller);
> +}

> @@ -2379,6 +2443,7 @@ static int musb_remove(struct platform_device *pdev)
>  
>  	cancel_work_sync(&musb->irq_work);
>  	cancel_delayed_work_sync(&musb->finish_resume_work);
> +	cancel_delayed_work_sync(&musb->pending_resume_work);
>  	cancel_delayed_work_sync(&musb->deassert_reset_work);
>  	pm_runtime_get_sync(musb->controller);
>  	musb_host_cleanup(musb);
> @@ -2604,6 +2669,9 @@ static int musb_resume(struct device *dev)
>  	mask = MUSB_DEVCTL_BDEVICE | MUSB_DEVCTL_FSDEV | MUSB_DEVCTL_LSDEV;
>  	if ((devctl & mask) != (musb->context.devctl & mask))
>  		musb->port1_status = 0;
> +
> +	schedule_delayed_work(&musb->pending_resume_work, 0);
> +

The interactions with system suspend looks a bit suspicious. It seems
you need to drain any pending resume work on suspend for example.

And then the above should not be needed, right?

In fact, the dsps timer must also be cancelled on suspend, or you could
end up calling dsps_check_status() while suspended (it is currently not
cancelled until the parent device is suspended, which could be too
late).

>  	if (musb->need_finish_resume) {
>  		musb->need_finish_resume = 0;
>  		schedule_delayed_work(&musb->finish_resume_work,
> @@ -2649,6 +2717,7 @@ static int musb_runtime_resume(struct device *dev)
>  		return 0;
>  
>  	musb_restore_context(musb);
> +	schedule_delayed_work(&musb->pending_resume_work, 0);
>  
>  	if (musb->need_finish_resume) {
>  		musb->need_finish_resume = 0;

> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -1222,6 +1222,16 @@ void musb_ep_restart(struct musb *musb, struct musb_request *req)
>  		rxstate(musb, req);
>  }
>  
> +void musb_ep_restart_resume_work(struct musb *musb, void *data)

Missing static keyword.

> +{
> +	struct musb_request *req = data;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&musb->lock, flags);
> +	musb_ep_restart(musb, req);
> +	spin_unlock_irqrestore(&musb->lock, flags);
> +}

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
