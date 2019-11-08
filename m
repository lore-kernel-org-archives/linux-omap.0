From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal:  Enable addition power
 management
Date: Fri, 8 Nov 2019 12:45:31 -0800
Message-ID: <20191108204531.GN5610@atomide.com>
References: <20191108200501.29864-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191108200501.29864-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, hns@goldelico.com, adam.ford@logicpd.com, Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [191108 20:05]:
> The bandgap sensor can be idled when the processor is too, but it
> isn't currently being done, so the power consumption of OMAP3
> boards can elevated if the bangap sensor is enabled.

Great, thanks for doing this!

> This patch attempts to use some additional power management
> to idle the clock to the bandgap when not needed.

Maybe add also something like this to the patch description:

As otherwise the bandgap clock blocks deeper idle states
the SoC. To must idle bandgap with cpu_notifier instead of
runtime PM to avoid tagging it with pm_runtime_irq_safe()
that we want to stop using for drivers in general.

> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
...
> +static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
> +				  unsigned long cmd, void *v)
> +{
> +	struct ti_bandgap *bgp;
> +
> +	bgp = container_of(nb, struct ti_bandgap, nb);
> +
> +	spin_lock(&bgp->lock);
> +	switch (cmd) {
> +	case CPU_CLUSTER_PM_ENTER:
> +		if (bgp->is_suspended)
> +			break;
> +		ti_bandgap_save_ctxt(bgp);
> +		ti_bandgap_power(bgp, false);
> +		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
> +			clk_disable_unprepare(bgp->fclock);
> +		break;
> +	case CPU_CLUSTER_PM_ENTER_FAILED:
> +	case CPU_CLUSTER_PM_EXIT:
> +		if (bgp->is_suspended)
> +			break;
> +		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
> +			clk_prepare_enable(bgp->fclock);
> +		ti_bandgap_power(bgp, true);
> +		ti_bandgap_restore_ctxt(bgp);
> +		break;
> +	}
> +	spin_unlock(&bgp->lock);
> +
> +	return NOTIFY_OK;
> +}

You need to use clk_disable() and clk_enable() instead
of the prepare and unprepare variants here because
the prepare and unprepare variants are helpers for
non-atomic context and won't necessarily work for the
cpu_notifier. See the comments in include/linux/clk.h
for clock_prepare_enable().

I tested this briefly with CONFIG_OMAP3_THERMAL=y and
after idling the UARTs on torpedo, and it still hits
off mode during idle consuming 5 - 7 mW for the
main_battery_som line as measured with the shunt :)
So this means we can finally then enable also
CONFIG_OMAP3_THERMAL=y in the defconfigs.

Also, you may want to check if the driver needs to
save and restore it's context in the notifier as that
might get lost during the off mode depending what
domain it's at.

Regards,

Tony
