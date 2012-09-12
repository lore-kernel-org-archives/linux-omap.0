From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCHv8 21/22] i2c: omap: switch over to autosuspend API
Date: Wed, 12 Sep 2012 16:03:35 -0700
Message-ID: <87627iu9mg.fsf@deeprootsystems.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
	<1347447496-16793-22-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347447496-16793-22-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
	(Shubhrajyoti D.'s message of "Wed, 12 Sep 2012 16:28:15 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>
> this helps us reduce unnecessary pm transitions
> in case we have another i2c message starting soon.
>
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

I tracked the PM regression down to this patch.

> ---
>  drivers/i2c/busses/i2c-omap.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 6d38a57..122f517 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -55,6 +55,9 @@
>  /* timeout waiting for the controller to respond */
>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
>  
> +/* timeout for pm runtime autosuspend */
> +#define OMAP_I2C_PM_TIMEOUT		1000	/* ms */
> +
>  /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
>  enum {
>  	OMAP_I2C_REV_REG = 0,
> @@ -645,7 +648,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  
>  	omap_i2c_wait_for_bb(dev);
>  out:
> -	pm_runtime_put(dev->dev);
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);

Reverting this change allows CORE to hit retention again.

I didn't debug this any further, so I'm not sure exactly why the async
suspend works but not the autosuspend.

Kevin
