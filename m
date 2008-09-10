From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] MUSB: fix memory corruption when using more than max
	endpoints
Date: Wed, 10 Sep 2008 13:36:16 +0300
Message-ID: <20080910103616.GQ16796@gandalf.research.nokia.com>
References: <1221026036-26477-1-git-send-email-khilman@deeprootsystems.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1221026036-26477-1-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Let's keep linux-usb on the loop for musb related patches ;-)

On Wed, Sep 10, 2008 at 08:53:56AM +0300, ext Kevin Hilman wrote:
> There is no check if platform code passes in more endpoints (num_eps)
> than the maximum number of enpoints (MUSB_C_NUM_EPS.)  The result is
> that allocate_instance() happily writes past the end of 'struct musb'
> corrupting memory.
> 
> The fix below increases the max to 32 (used on omap3) and also adds a
> BUG() if the platform code requests more than the max.
> 
> This memory corruption was triggering various forms of crashes/panics
> with kmem_cache_alloc() in the backtrace.
> 
> Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>

Looks ok, I'll put to my series.

> ---
>  drivers/usb/musb/musb_core.c |    1 +
>  drivers/usb/musb/musb_core.h |    2 +-
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index c939f81..a132d9f 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1806,6 +1806,7 @@ allocate_instance(struct device *dev,
>  	musb->ctrl_base = mbase;
>  	musb->nIrq = -ENODEV;
>  	musb->config = config;
> +	BUG_ON(musb->config->num_eps > MUSB_C_NUM_EPS);

It's good to have this check here.

>  	for (epnum = 0, ep = musb->endpoints;
>  			epnum < musb->config->num_eps;
>  			epnum++, ep++) {
> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> index 8222725..5040ceb 100644
> --- a/drivers/usb/musb/musb_core.h
> +++ b/drivers/usb/musb/musb_core.h
> @@ -153,7 +153,7 @@ static inline void musb_host_rx(struct musb *m, u8 e) {}
>  /****************************** CONSTANTS ********************************/
>  
>  #ifndef MUSB_C_NUM_EPS
> -#define MUSB_C_NUM_EPS ((u8)16)
> +#define MUSB_C_NUM_EPS ((u8)32)

16 is the right number.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
