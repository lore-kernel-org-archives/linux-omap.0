From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 08/10] pwm-backlight: Use new enable_gpio field
Date: Tue, 01 Oct 2013 12:39:36 -0600
Message-ID: <524B16E8.5080506@wwwdotorg.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com> <1379972467-11243-9-git-send-email-treding@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379972467-11243-9-git-send-email-treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openezx-devel-ZwoEplunGu3n3BO9LpVK+9i2O/JbrIOy@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/23/2013 03:41 PM, Thierry Reding wrote:
> Make use of the new enable_gpio field and allow it to be set from DT as
> well. Now that all legacy users of platform data have been converted to
> initialize this field to an invalid value, it is safe to use the field
> from the driver.

> diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt

>  Optional properties:

> +  - enable-gpios: a list of GPIOs to enable and disable the backlight

That seems to imply that multiple GPIOs are legal. Was that intended? If
not, I would suggest:

- enable-gpios: contains a single GPIO specifier for the GPIO which
		enables/disables the backlight. See [1] for the format.

>  
>  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
+ [1]: Documentation/devicetree/bindings/gpio/gpio.txt

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c

> @@ -51,12 +55,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness,
>  		     pb->lth_brightness;
>  
>  	pwm_config(pb->pwm, duty_cycle, pb->period);
> +
> +	if (gpio_is_valid(pb->enable_gpio)) {
> +		if (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW)
> +			gpio_set_value(pb->enable_gpio, 0);
> +		else
> +			gpio_set_value(pb->enable_gpio, 1);
> +	}

Feel completely free to ignore this, but when the difference in two
code-paths is solely in function parameters, I prefer to calculate the
parameter inside the if statement, then call the function outside the
conditional code, to highlight the common/different parts:

int value;

/* or an if statement for the next 1 line, if you don't like ?: */
value = (pb->enable_gpio_flags & PWM_BACKLIGHT_GPIO_ACTIVE_LOW) ? 0 : 1;
gpio_set_value((pb->enable_gpio, value);

> @@ -148,11 +168,10 @@ static int pwm_backlight_parse_dt(struct device *dev,

> +	data->enable_gpio = of_get_named_gpio_flags(node, "enable-gpios", 0,
> +						    &flags);
> +	if (gpio_is_valid(data->enable_gpio) && (flags & OF_GPIO_ACTIVE_LOW))
> +		data->enable_gpio_flags |= PWM_BACKLIGHT_GPIO_ACTIVE_LOW;

This doesn't seem to handle deferred probe correctly; I would expect
something more like:

	data->enable_gpio = of_get_named_gpio_flags(...);
	if (data->enable_gpio == -EPROBE_DEFERRED)
		return data->enable_gpio;
	if (gpio_is_valid(...))
		...
	return 0;

I suppose it's possible that the value filters down to
gpio_request_one() and this actually does work out OK, but that feels
very accidental/implicit to me.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
