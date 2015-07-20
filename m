From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] input: touchscreen: pixcir_i2c_ts: Add support
 for optional wakeup interrupt
Date: Sun, 19 Jul 2015 23:25:34 -0700
Message-ID: <20150720062534.GB13092@dtor-ws>
References: <1437367814-27785-1-git-send-email-vigneshr@ti.com>
 <1437367814-27785-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437367814-27785-2-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Roger Quadros <rogerq@ti.com>, Henrik Rydberg <rydberg@bitmath.org>, Frodo Lai <frodo.lai@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 20, 2015 at 10:20:13AM +0530, Vignesh R wrote:
> On am437x-gp-evm, pixcir touchscreen can wake the system from low power
> state by generating wake-up interrupt via pinctrl and IO daisy chain.
> Add support for optional wakeup interrupt source by regsitering to
> automated wake IRQ framework introduced by commit 4990d4fe327b ("PM /
> Wakeirq: Add automated device wake IRQ handling").
> This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
> support for optional wake-up")
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> v2:
>  * use of_irq_get_byname()
>  * remove enable/disable_wake_irq()
> 
>  drivers/input/touchscreen/pixcir_i2c_ts.c | 17 +++++++++++++----
>  include/linux/input/pixcir_ts.h           |  1 +
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index 8f3e243a62bf..b9cebf274678 100644
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
> @@ -364,8 +366,6 @@ static int __maybe_unused pixcir_i2c_ts_suspend(struct device *dev)
>  				goto unlock;
>  			}
>  		}
> -
> -		enable_irq_wake(client->irq);
>  	} else if (input->users) {
>  		ret = pixcir_stop(ts);
>  	}
> @@ -386,8 +386,6 @@ static int __maybe_unused pixcir_i2c_ts_resume(struct device *dev)
>  	mutex_lock(&input->mutex);
>  
>  	if (device_may_wakeup(&client->dev)) {
> -		disable_irq_wake(client->irq);
> -
>  		if (!input->users) {
>  			ret = pixcir_stop(ts);
>  			if (ret) {
> @@ -445,6 +443,8 @@ static struct pixcir_ts_platform_data *pixcir_parse_dt(struct device *dev)
>  	dev_dbg(dev, "%s: x %d, y %d, gpio %d\n", __func__,
>  		pdata->x_max + 1, pdata->y_max + 1, pdata->gpio_attb);
>  
> +	pdata->wakeirq = of_irq_get_byname(dev->of_node, "wakeupirq");
> +
>  	return pdata;
>  }
>  #else
> @@ -564,11 +564,20 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, tsdata);
>  	device_init_wakeup(&client->dev, 1);
>  
> +	/* Register wakeirq */
> +	error = pdata->wakeirq ?

Hmm, I guess the condition should be pdata->wakeirq > 0.

> +		dev_pm_set_dedicated_wake_irq(dev, pdata->wakeirq) :
> +		dev_pm_set_wake_irq(dev, client->irq);
> +	if (error)
> +		dev_info(dev, "unable to get wakeirq %d\n",
> +			 error);
> +
>  	return 0;
>  }
>  
>  static int pixcir_i2c_ts_remove(struct i2c_client *client)
>  {
> +	dev_pm_clear_wake_irq(&client->dev);
>  	device_init_wakeup(&client->dev, 0);
>  
>  	return 0;
> diff --git a/include/linux/input/pixcir_ts.h b/include/linux/input/pixcir_ts.h
> index 7bae83b7c396..da573de5a5ee 100644
> --- a/include/linux/input/pixcir_ts.h
> +++ b/include/linux/input/pixcir_ts.h
> @@ -58,6 +58,7 @@ struct pixcir_ts_platform_data {
>  	int x_max;
>  	int y_max;
>  	int gpio_attb;		/* GPIO connected to ATTB line */
> +	int wakeirq;
>  	struct pixcir_i2c_chip_data chip;
>  };
>  
> -- 
> 2.4.5
> 

-- 
Dmitry
