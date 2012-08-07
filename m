From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] I2C: OMAP: xfer: fix runtime PM get/put balance on error
Date: Mon, 06 Aug 2012 17:28:44 -0700
Message-ID: <87wr1b35qb.fsf@ti.com>
References: <1340761532-27231-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340761532-27231-1-git-send-email-khilman-l0cyMroinI0@public.gmane.org> (Kevin
	Hilman's message of "Tue, 26 Jun 2012 18:45:32 -0700")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Wolfram,

Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> writes:

> In omap_i2c_xfer(), ensure pm_runtime_put() is called, even on
> failure.
>
> Without this, after a failed xfer, the runtime PM usecount will have
> been incremented, but not decremented causing the usecount to never
> reach zero after a failure.  This keeps the device always runtime PM
> enabled which keeps the enclosing power domain active, and prevents
> full-chip retention/off from happening during idle.
>
> Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
> ---
> This patch applies to current i2c-embedded/for-next branch

This one is needed for v3.6.  Can you queue this up as a fix for
v3.6-rc?

Thanks,

Kevin

>  drivers/i2c/busses/i2c-omap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 9895fa7..b105733 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -582,7 +582,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  
>  	r = pm_runtime_get_sync(dev->dev);
>  	if (IS_ERR_VALUE(r))
> -		return r;
> +		goto out;
>  
>  	r = omap_i2c_wait_for_bb(dev);
>  	if (r < 0)
