From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] dma: cpp41: Fix handling of error path
Date: Tue, 15 Nov 2016 14:05:03 +0530
Message-ID: <8d1e380a-ec75-3893-ea50-65e1526d58ea@ti.com>
References: <20161111192852.25399-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161111192852.25399-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Saturday 12 November 2016 12:58 AM, Tony Lindgren wrote:
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
> 
> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
> @@ -366,8 +366,11 @@ static int cppi41_dma_alloc_chan_resources(struct dma_chan *chan)
>  	int error;
>  
>  	error = pm_runtime_get_sync(cdd->ddev.dev);
> -	if (error < 0)
> +	if (error < 0) {
> +		pm_runtime_put_noidle(cdd->ddev.dev);
> +

If pm_runtime_get_sync() fails due to callback error, then
rpm_callback() sets dev.power.runtime_error to an error value which gets
cleared by an explicit call to pm_runtime_set_suspended().

This will tell the framework that the status of device is suspended.
Else, the failure will be sticky and on subsequent attempts,
rpm_resume() will keep returning early instead of trying to resume the
device again.

This is as far as I can gather from code. So, I believe the recovery
path should be:

	if (error < 0) {
		pm_runtime_set_suspended(cdd->ddev.dev);
		pm_runtime_put_noidle(cdd->ddev.dev);

		...

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
