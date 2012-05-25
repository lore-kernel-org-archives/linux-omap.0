From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv9 07/10] I2C: OMAP: Handle error check for pm runtime
Date: Fri, 25 May 2012 15:06:04 -0700
Message-ID: <87likfkjar.fsf@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
	<1335969135-20858-8-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335969135-20858-8-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Wed, 2 May 2012 20:02:12 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> If PM runtime get_sync fails return with the error
> so that no further reads/writes goes through the interface.
> This will avoid possible abort. Add a error message in case
> of failure with the cause of the failure.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 44e8cfa..a72874e 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -585,7 +585,9 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	int i;
>  	int r;
>  
> -	pm_runtime_get_sync(dev->dev);
> +	r = pm_runtime_get_sync(dev->dev);
> +	if (r < 0)
> +		return r;

nit: please use IS_ERR_VALUE() 

Kevin
