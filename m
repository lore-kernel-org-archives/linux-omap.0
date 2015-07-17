From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] input: touchscreen: pixcir_i2c_ts: Add support for
 optional wakeup interrupt
Date: Fri, 17 Jul 2015 14:51:22 -0700
Message-ID: <20150717215122.GC39282@dtor-ws>
References: <1437115241-17859-1-git-send-email-vigneshr@ti.com>
 <1437115241-17859-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437115241-17859-2-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Frodo Lai <frodo.lai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Vignesh,

On Fri, Jul 17, 2015 at 12:10:40PM +0530, Vignesh R wrote:
> On am437x-gp-evm, pixcir touchscreen can wake the system from low power
> state by generating wake-up interrupt via pinctrl and IO daisy chain.
> Add support for optional wakeup interrupt source by regsitering to
> automated wake IRQ framework introduced by commit 4990d4fe327b ("PM /
> Wakeirq: Add automated device wake IRQ handling").
> This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
> support for optional wake-up")
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/input/touchscreen/pixcir_i2c_ts.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index 8f3e243a62bf..f7c602027fbd 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -29,6 +29,8 @@
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/pm_wakeirq.h>
>  
>  #define PIXCIR_MAX_SLOTS       5 /* Max fingers supported by driver */
>  
> @@ -38,6 +40,7 @@ struct pixcir_i2c_ts_data {
>  	const struct pixcir_ts_platform_data *pdata;
>  	bool running;
>  	int max_fingers;	/* Max fingers supported in this instance */
> +	int wakeirq;
>  };
>  
>  struct pixcir_touch {
> @@ -564,11 +567,22 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, tsdata);
>  	device_init_wakeup(&client->dev, 1);
>  
> +	/* Register wakeirq, if available */
> +	tsdata->wakeirq = of_irq_get(dev->of_node, 1);

Can we put this in platform data and parse in pixcir_parse_dt() please?
Also, why not of_irq_get_byname()?

> +	if (tsdata->wakeirq) {
> +		error = dev_pm_set_dedicated_wake_irq(dev,
> +						      tsdata->wakeirq);
> +		if (error)
> +			dev_dbg(dev, "unable to get wakeirq %d\n",
> +				error);
> +	}

Shouldn't his actually be:

	error = tsdata->wakeirq ?
		dev_pm_set_dedicated_wake_irq(dev, tsdata->wakeirq) :
		dev_pm_set_wake_irq(dev, client->irq);
	if (error) {
		...
	}

and then we can get rid of enable_irq_wake()/disable_irq_wake() in
pixcir_i2c_ts_suspend() and pixcir_i2c_ts_resume().

> +
>  	return 0;
>  }
>  
>  static int pixcir_i2c_ts_remove(struct i2c_client *client)
>  {
> +	dev_pm_clear_wake_irq(&client->dev);
>  	device_init_wakeup(&client->dev, 0);

I wonder if driver core should be responsible for clearing wake irq and
also for clearing wakeup flag.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
