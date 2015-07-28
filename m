From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] Input: tsc2005 - convert to gpiod
Date: Mon, 27 Jul 2015 17:51:38 -0700
Message-ID: <20150728005138.GH3613@dtor-ws>
References: <1437595485-16421-1-git-send-email-sre@kernel.org>
 <1437595485-16421-6-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437595485-16421-6-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-input@vger.kernel.org, Michael Welling <mwelling@emacinc.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 22, 2015 at 10:04:45PM +0200, Sebastian Reichel wrote:
> The GPIOD API can be used from boardcode, so that
> the DT check can be removed. To avoid breaking
> existing boardcode, _optional() variant has been
> chosen. For completly removing the DT check, the
> regulator has also been made optional, so that it
> could be supplied from boardcode.
> 
> As a side-effect the patch fixes the after-probe
> reset GPIO state, so that the device is not kept
> in reset state.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/input/touchscreen/tsc2005.c | 47 ++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
> index f82b860..bf1b782 100644
> --- a/drivers/input/touchscreen/tsc2005.c
> +++ b/drivers/input/touchscreen/tsc2005.c
> @@ -30,11 +30,11 @@
>  #include <linux/delay.h>
>  #include <linux/pm.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/tsc2005.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/regmap.h>
> +#include <linux/gpio/consumer.h>
>  
>  /*
>   * The touchscreen interface operates as follows:
> @@ -180,7 +180,7 @@ struct tsc2005 {
>  
>  	struct regulator	*vio;
>  
> -	int			reset_gpio;
> +	struct gpio_desc	*reset_gpio;
>  	void			(*set_reset)(bool enable);
>  };
>  
> @@ -318,8 +318,8 @@ static void tsc2005_stop_scan(struct tsc2005 *ts)
>  
>  static void tsc2005_set_reset(struct tsc2005 *ts, bool enable)
>  {
> -	if (ts->reset_gpio >= 0)
> -		gpio_set_value(ts->reset_gpio, enable);
> +	if (ts->reset_gpio)
> +		gpiod_set_value_cansleep(ts->reset_gpio, enable);
>  	else if (ts->set_reset)
>  		ts->set_reset(enable);
>  }
> @@ -611,34 +611,23 @@ static int tsc2005_probe(struct spi_device *spi)
>  	ts->x_plate_ohm = x_plate_ohm;
>  	ts->esd_timeout = esd_timeout;
>  
> -	if (np) {
> -		ts->reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
> -		if (ts->reset_gpio == -EPROBE_DEFER)
> -			return ts->reset_gpio;
> -		if (ts->reset_gpio < 0) {
> -			dev_err(&spi->dev, "error acquiring reset gpio: %d\n",
> -				ts->reset_gpio);
> -			return ts->reset_gpio;
> -		}
> +	ts->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> +						 GPIOD_OUT_HIGH);
> +	if (IS_ERR(ts->reset_gpio)) {
> +		error = PTR_ERR(ts->reset_gpio);
> +		dev_err(&spi->dev, "error acquiring reset gpio: %d\n", error);
> +		return error;
> +	}
>  
> -		error = devm_gpio_request_one(&spi->dev, ts->reset_gpio, 0,
> -					      "reset-gpios");
> -		if (error) {
> -			dev_err(&spi->dev, "error requesting reset gpio: %d\n",
> -				error);
> -			return error;
> -		}
> +	ts->vio = devm_regulator_get_optional(&spi->dev, "vio");
> +	if (IS_ERR(ts->vio)) {
> +		error = PTR_ERR(ts->vio);
> +		dev_err(&spi->dev, "vio regulator missing (%d)", error);
> +		return error;
> +	}

I wonder if we should actually make it devm_regulator_get()because if we
have full constraints then we'll simply get a dummy regulator here if
vio-supply is not defined.

Can be done as a follow-up though.

I've applied all 5.

Thanks.

-- 
Dmitry
