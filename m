From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Resubmitting TWL4030 GPIO driver
Date: Tue, 8 May 2007 15:20:13 -0700
Message-ID: <20070508222012.GP32547@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47DCC861@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47DCC861@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Syed Mohammed, Khasim <x0khasim@ti.com> [070508 12:29]:
> After Incorporating Review comments.
> 
> This adds TWL4030 GPIO driver support. Required for TWL4030 Keypad and other
> TWL4030 GPIO dependent modules.

...

> +/*
> + * twl4030 GPIO request function
> + */
> +int twl4030_request_gpio(int gpio)
> +{
> +	int ret = 0;
> +
> +	if (unlikely(gpio >= TWL4030_GPIO_MAX)) {
> +		return -EPERM;
> +	}
> +
> +	down(&gpio_sem);
> +	if (gpio_usage_count & (0x1 << gpio)) {
> +		ret = -EBUSY;
> +	} else {
> +		u8 clear_pull[6] = { 0, 0, 0, 0, 0, 0 };
> +		/* First time usage? - switch on GPIO module */
> +		if (!gpio_usage_count) {
> +			ret =
> +			gpio_twl4030_write(REG_GPIO_CTRL,
> +					MASK_GPIO_CTRL_GPIO_ON);
> +			ret = gpio_twl4030_write(REG_GPIO_SIH_CTRL, 0x00);
> +		}
> +		if (!ret) {
> +			gpio_usage_count |= (0x1 << gpio);
> +		}
> +		ret =
> +		twl4030_i2c_write(TWL4030_MODULE_GPIO, clear_pull,
> +				REG_GPIOPUPDCTR1, 5);
> +	}
> +	up(&gpio_sem);
> +	return ret;
> +}

Can you please remove the unnecessary braces used for one liners
throughout the code?

This is something that will cause comments when trying to send this
to I2C list. Ideally all the new patches we integrate will be ready
be sent upstream also :)

Tony
