From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] leds: add TI LMU backlight driver
Date: Thu, 30 Aug 2018 09:40:57 -0700
Message-ID: <20180830164057.GV7523@atomide.com>
References: <20180829212032.GB15786@amd>
 <20180830082219.GA10133@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180830082219.GA10133@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180830 08:26]:
> This adds backlight support for the following TI LMU
> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
...
> +struct ti_lmu_bank {
> +	struct device *dev;
> +	int bank_id;
> +	const struct ti_lmu_bl_cfg *cfg;
> +	struct ti_lmu *lmu;
> +	const char *label;
> +	int leds;
> +	int current_brightness;
> +	u32 default_brightness;
> +	u32 ramp_up_msec;
> +	u32 ramp_down_msec;
> +
> +	struct notifier_block nb;
> +
> +	struct led_classdev *led;
> +};
> +
> +static int ti_lmu_bl_enable(struct ti_lmu_bank *lmu_bank, bool enable)
> +{
> +	struct regmap *regmap = lmu_bank->lmu->regmap;
> +	unsigned long enable_time = lmu_bank->cfg->reginfo->enable_usec;
> +	u8 *reg = lmu_bank->cfg->reginfo->enable;
> +	u8 mask = BIT(lmu_bank->bank_id);
> +	u8 val = (enable == true) ? mask : 0;
> +	int ret;
> +
> +	if (!reg)
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(regmap, *reg, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	if (enable_time > 0)
> +		usleep_range(enable_time, enable_time + 100);
> +
> +	return 0;
> +}

If it's a led driver, should you just s/ti_lmu_bl/ti_lmu_led/g?

Regards,

Tony
