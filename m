From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: twl4030: fix regression for twl gpio outputs for
 led pins
Date: Fri, 13 Dec 2013 09:28:11 -0800
Message-ID: <20131213172810.GE28184@atomide.com>
References: <1386953222-26396-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386953222-26396-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [131213 08:48]:
> Commit 0b2aa8b (gpio: twl4030: Fix regression for twl gpio output)
> introduces yet another regression by ignoring the fact that we use twl
> gpio even for LED. For example, leda (offset 18) is used for USB port2
> power on beagleboard-xm.
> 
> The original logic was supposed to setup the TWL4030 GPIO direction
> if the offset was < TWL4030_GPIO_MAX, and anything greater used
> twl4030_led_set_value as part of twl_set to setup the LED pin. However,
> with the commit mentioned above, LEDa pin request will result in fail
> as the GPIO number for LEDa is equal to TWL4030_GPIO_MAX and USB fails
> to function on beagleboard-xm. This is reported in the log as:
> hsusb2_vbus: Failed to request enable GPIO510: -22
> 
> To fix this, we should handle the fail case of
> twl4030_set_gpio_direction independent of the offset < TWL4030_GPIO_MAX
> check.

Heh again :) Linus has already queued a similar fix, see
"[PATCH v2 1/1] gpio: twl4030: Fix regression for twl gpio LED output".

Regards,

Tony



 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Applies on v3.13-rc3
> 
> Tested on beagleboard-xm which uses ethernet over usb:
> before the patch (USB regression): http://pastebin.mozilla.org/3769443
> After this patch: http://pastebin.mozilla.org/3769454
> 
>  drivers/gpio/gpio-twl4030.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
> index b97d6a6..9242276 100644
> --- a/drivers/gpio/gpio-twl4030.c
> +++ b/drivers/gpio/gpio-twl4030.c
> @@ -354,11 +354,16 @@ static void twl_set(struct gpio_chip *chip, unsigned offset, int value)
>  static int twl_direction_out(struct gpio_chip *chip, unsigned offset, int value)
>  {
>  	struct gpio_twl4030_priv *priv = to_gpio_twl4030(chip);
> -	int ret = -EINVAL;
> +	int ret = 0;
>  
>  	mutex_lock(&priv->mutex);
> -	if (offset < TWL4030_GPIO_MAX)
> +	if (offset < TWL4030_GPIO_MAX) {
>  		ret = twl4030_set_gpio_direction(offset, 0);
> +		if (ret) {
> +			mutex_unlock(&priv->mutex);
> +			return ret;
> +		}
> +	}
>  
>  	priv->direction |= BIT(offset);
>  	mutex_unlock(&priv->mutex);
> -- 
> 1.7.9.5
> 
