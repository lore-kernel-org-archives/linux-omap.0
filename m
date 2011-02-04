From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to
 configure pendown_gpio
Date: Fri, 4 Feb 2011 19:02:50 +0530
Message-ID: <20110204133250.GB2070@m-desktop>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
 <20110203165405.GB12802@core.coreip.homeip.net>
 <20110203171953.GA13997@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110203171953.GA13997@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, LW@karo-electronics.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, gadiyar@ti.com, charu@ti.com, grinberg@compulab.co.il, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 03, 2011 at 09:19:53AM -0800, Dmitry Torokhov wrote:
> On Thu, Feb 03, 2011 at 08:54:05AM -0800, Dmitry Torokhov wrote:
> > On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
> > > The ads7846 driver requests a gpio but does not currently
> > > configure it explicitly as an input. Use gpio_request_one
> > > to request and configure it at one shot.
> > > 
> > > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> > > Cc: Dmitry Torokhov <dtor@mail.ru>
> > 
> > Will apply this one, the other one is a bit messy IMO, will have to
> > think about it.
> > 
> 
> Something like below should do I think.
Patch looks good but it applies only on top of previous patch:
https://patchwork.kernel.org/patch/529941/

Why to have two patches for this fix?

Both the patches can be merged as:

diff --git a/drivers/input/touchscreen/ads7846.c
b/drivers/input/touchscreen/ads7846.c
index 14ea54b..940967b 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -941,29 +941,30 @@ static int __devinit ads7846_setup_pendown(struct
spi_device *spi, struct ads784
 	struct ads7846_platform_data *pdata = spi->dev.platform_data;
 	int err;
 
-	/* REVISIT when the irq can be triggered active-low, or if for
	some
+	/*
+	 * REVISIT when the irq can be triggered active-low, or if for
some
 	 * reason the touchscreen isn't hooked up, we don't need to
 	 * access
 	 * the pendown state.
 	 */
-	if (!pdata->get_pendown_state &&
	!gpio_is_valid(pdata->gpio_pendown)) {
-		dev_err(&spi->dev, "no get_pendown_state nor
		gpio_pendown?\n");
-		return -EINVAL;
-	}
 
 	if (pdata->get_pendown_state) {
 		ts->get_pendown_state = pdata->get_pendown_state;
-		return 0;
-	}
+	} else if (gpio_is_valid(pdata->gpio_pendown)) {
+
+		err = gpio_request_one(pdata->gpio_pendown,
GPIOF_DIR_IN,
+
"ads7846_pendown");
+		if (err) {
+			dev_err(&spi->dev, "failed to request pendown
GPIO%d\n",
+				pdata->gpio_pendown);
+			return err;
+		}
 
-	err = gpio_request(pdata->gpio_pendown, "ads7846_pendown");
-	if (err) {
-		dev_err(&spi->dev, "failed to request pendown GPIO%d\n",
-			pdata->gpio_pendown);
-		return err;
+		ts->gpio_pendown = pdata->gpio_pendown;
+	} else {
+		dev_err(&spi->dev, "no get_pendown_state nor
gpio_pendown?\n");
+		return -EINVAL;
 	}
 
-	ts->gpio_pendown = pdata->gpio_pendown;
-
 	return 0;
 }
 
@@ -1353,7 +1354,7 @@ static int __devinit ads7846_probe(struct
spi_device *spi)
  err_put_regulator:
 	regulator_put(ts->reg);
  err_free_gpio:
-	if (ts->gpio_pendown != -1)
+	if (!ts->get_pendown_state)
 		gpio_free(ts->gpio_pendown);
  err_cleanup_filter:
 	if (ts->filter_cleanup)
@@ -1383,8 +1384,13 @@ static int __devexit ads7846_remove(struct
spi_device *spi)
 	regulator_disable(ts->reg);
 	regulator_put(ts->reg);
 
-	if (ts->gpio_pendown != -1)
+	if (!ts->get_pendown_state) {
+		/*
+		 * If we are not using specialized pendown method we
must
+		 * have been relying on gpio we set up ourselves.
+		 */
 		gpio_free(ts->gpio_pendown);
+	}
 
 	if (ts->filter_cleanup)
 		ts->filter_cleanup(ts->filter_data);


> 
> -- 
> Dmitry
> 
> 
> Input: ads7846 - check proper condition when freeing gpio
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> When driver uses custom pendown detection method gpio_pendown is not
> set up and so we should not try to free it, otherwise we are presented
> with:
> 
> ------------[ cut here ]------------
> WARNING: at drivers/gpio/gpiolib.c:1258 gpio_free+0x100/0x12c()
> Modules linked in:
> [<c0061208>] (unwind_backtrace+0x0/0xe4) from [<c0091f58>](warn_slowpath_common+0x4c/0x64)
> [<c0091f58>] (warn_slowpath_common+0x4c/0x64) from [<c0091f88>](warn_slowpath_null+0x18/0x1c)
> [<c0091f88>] (warn_slowpath_null+0x18/0x1c) from [<c024e610>](gpio_free+0x100/0x12c)
> [<c024e610>] (gpio_free+0x100/0x12c) from [<c03e9fbc>](ads7846_probe+0xa38/0xc5c)
> [<c03e9fbc>] (ads7846_probe+0xa38/0xc5c) from [<c02cff14>](spi_drv_probe+0x18/0x1c)
> [<c02cff14>] (spi_drv_probe+0x18/0x1c) from [<c028bca4>](driver_probe_device+0xc8/0x184)
> [<c028bca4>] (driver_probe_device+0xc8/0x184) from [<c028bdc8>](__driver_attach+0x68/0x8c)
> [<c028bdc8>] (__driver_attach+0x68/0x8c) from [<c028b4c8>](bus_for_each_dev+0x48/0x74)
> [<c028b4c8>] (bus_for_each_dev+0x48/0x74) from [<c028ae08>](bus_add_driver+0xa0/0x220)
> [<c028ae08>] (bus_add_driver+0xa0/0x220) from [<c028c0c0>](driver_register+0xa8/0x134)
> [<c028c0c0>] (driver_register+0xa8/0x134) from [<c0050550>](do_one_initcall+0xcc/0x1a4)
> [<c0050550>] (do_one_initcall+0xcc/0x1a4) from [<c00084e4>](kernel_init+0x14c/0x214)
> [<c00084e4>] (kernel_init+0x14c/0x214) from [<c005b494>](kernel_thread_exit+0x0/0x8)
> ---[ end trace 4053287f8a5ec18f ]---
> 
> Also rearrange ads7846_setup_pendown() to have only one exit point
> returning success.
> 
> Reported-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/touchscreen/ads7846.c |   39 ++++++++++++++++++++---------------
>  1 files changed, 22 insertions(+), 17 deletions(-)
> 
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 0e9492d..b1217e1 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -946,30 +946,30 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>  	struct ads7846_platform_data *pdata = spi->dev.platform_data;
>  	int err;
>  
> -	/* REVISIT when the irq can be triggered active-low, or if for some
> +	/*
> +	 * REVISIT when the irq can be triggered active-low, or if for some
>  	 * reason the touchscreen isn't hooked up, we don't need to access
>  	 * the pendown state.
>  	 */
> -	if (!pdata->get_pendown_state && !gpio_is_valid(pdata->gpio_pendown)) {
> -		dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");
> -		return -EINVAL;
> -	}
>  
>  	if (pdata->get_pendown_state) {
>  		ts->get_pendown_state = pdata->get_pendown_state;
> -		return 0;
> -	}
> +	} else if (gpio_is_valid(pdata->gpio_pendown)) {
> +
> +		err = gpio_request_one(pdata->gpio_pendown, GPIOF_DIR_IN,
> +							"ads7846_pendown");
> +		if (err) {
> +			dev_err(&spi->dev, "failed to request pendown GPIO%d\n",
> +				pdata->gpio_pendown);
> +			return err;
> +		}
>  
> -	err = gpio_request_one(pdata->gpio_pendown, GPIOF_DIR_IN,
> -						"ads7846_pendown");
> -	if (err) {
> -		dev_err(&spi->dev, "failed to request pendown GPIO%d\n",
> -			pdata->gpio_pendown);
> -		return err;
> +		ts->gpio_pendown = pdata->gpio_pendown;
> +	} else {
> +		dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");
> +		return -EINVAL;
>  	}
>  
> -	ts->gpio_pendown = pdata->gpio_pendown;
> -
>  	return 0;
>  }
>  
> @@ -1359,7 +1359,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
>   err_put_regulator:
>  	regulator_put(ts->reg);
>   err_free_gpio:
> -	if (ts->gpio_pendown != -1)
> +	if (!ts->get_pendown_state)
>  		gpio_free(ts->gpio_pendown);
>   err_cleanup_filter:
>  	if (ts->filter_cleanup)
> @@ -1389,8 +1389,13 @@ static int __devexit ads7846_remove(struct spi_device *spi)
>  	regulator_disable(ts->reg);
>  	regulator_put(ts->reg);
>  
> -	if (ts->gpio_pendown != -1)
> +	if (!ts->get_pendown_state) {
> +		/*
> +		 * If we are not using specialized pendown method we must
> +		 * have been relying on gpio we set up ourselves.
> +		 */
>  		gpio_free(ts->gpio_pendown);
> +	}
>  
>  	if (ts->filter_cleanup)
>  		ts->filter_cleanup(ts->filter_data);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
