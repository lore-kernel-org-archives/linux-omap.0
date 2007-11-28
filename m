From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.24-rc3-omap1] tsc210x build fixes
Date: Wed, 28 Nov 2007 12:49:18 -0800
Message-ID: <20071128204918.GY11825@atomide.com>
References: <200711232320.36987.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200711232320.36987.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [071123 23:24]:
> Build fixes for the tsc210x driver.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> --- a/drivers/hwmon/tsc210x_sensors.c
> +++ b/drivers/hwmon/tsc210x_sensors.c
> @@ -41,7 +41,7 @@ #include <linux/spi/tsc210x.h>
>  struct tsc210x_hwmon {
>  	int bat[2], aux[2], temp[2];
>  
> -	struct class_device *dev;
> +	struct device *dev;
>  	struct tsc210x_config *pdata;
>  #ifdef CONFIG_APM
>  	/* prevent APM from colliding with normal hwmon accessors */
> --- a/drivers/input/touchscreen/tsc210x_ts.c
> +++ b/drivers/input/touchscreen/tsc210x_ts.c
> @@ -96,7 +96,7 @@ static int tsc210x_ts_probe(struct platf
>  	dev->name = "TSC210x Touchscreen";
>  	dev->cdev.dev = &pdev->dev;
>  	dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
> -	dev->keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
> +	dev->keybit[BIT_WORD(BTN_TOUCH)] |= BIT_MASK(BTN_TOUCH);
>  	dev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
>  	dev->phys = "tsc210x/input0";
>  	dev->id.bustype = BUS_HOST;

Pushing today.

Tony
