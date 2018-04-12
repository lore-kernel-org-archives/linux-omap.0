From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/14] ARM: OMAP2+: omap_hwmod: Introduce
 HWMOD_NEEDS_REIDLE
Date: Thu, 12 Apr 2018 07:34:04 -0700
Message-ID: <20180412143404.GY5700@atomide.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523505239-16229-4-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180412 03:56]:
> From: Dave Gerlach <d-gerlach@ti.com>
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -208,6 +208,27 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +/**
> + * _omap_device_check_reidle_hwmods - check all hwmods in device for reidle flag
> + * @od: struct omap_device *od
> + *
> + * Checks underlying hwmods for reidle flag, if present, remove from hwmod
> + * list and set flag in omap_device to keep track.  Returns 0.
> + */
> +static int _omap_device_check_reidle_hwmods(struct omap_device *od)
> +{
> +	int i;
> +
> +	for (i = 0; i < od->hwmods_cnt; i++) {
> +		if (od->hwmods[i]->flags & HWMOD_NEEDS_REIDLE) {
> +			od->flags |= OMAP_DEVICE_HAS_REIDLE_HWMODS;
> +			omap_hwmod_disable_reidle(od->hwmods[i]);
> +		}
> +	}
> +
> +	return 0;
> +}

Let's not add any more dependencies to omap_device stuff, this will go away
anyways with ti-sysc.

> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> +static int _omap_device_pm_notifier(struct notifier_block *self,
> +				    unsigned long action, void *dev)
> +{
> +	switch (action) {
> +	case PM_POST_SUSPEND:
> +		_reidle_all();
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block pm_nb = {
> +	.notifier_call = _omap_device_pm_notifier,
> +};

This seems like the right place to do it :) So for places where
I suggested cpu_pm notifiers, maybe this is actually what you
want to do for pinctrl and gpio etc. Please keep in mind that
for gpio we do save and restore context it dynamically too during
idle, so it's not just suspend and resume. That's why I was thinking
cpu_pm notifiers, but maybe there's a better solution that covers
both PM runtime and suspend.

Regards,

Tony
