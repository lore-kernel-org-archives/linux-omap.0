From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/17] soc: ti: pruss: Configure SYSCFG properly during
 probe/remove
Date: Fri, 23 Nov 2018 08:26:04 -0800
Message-ID: <20181123162604.GA53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542886753-17625-6-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181122 11:39]:
> +/* firmware must be idle when calling this function */
> +static void pruss_disable_module(struct device *dev)
> +{
> +	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
> +
> +	/* configure Smart Standby */
> +	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_MODE_MASK,
> +			  SYSCFG_STANDBY_MODE_SMART);
> +
> +	/* initiate MStandby */
> +	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_INIT,
> +			  SYSCFG_STANDBY_INIT);
> +
> +	/* tell PRCM to initiate IDLE request */
> +	pm_runtime_put_sync(dev);
> +}
> +
> +static int pruss_enable_module(struct device *dev)
> +{
> +	struct pruss_soc_bus *psoc_bus = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* tell PRCM to de-assert IDLE request */
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		return ret;
> +	}
> +
> +	/* configure for Smart Idle & Smart Standby */
> +	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_IDLE_MODE_MASK,
> +			  SYSCFG_IDLE_MODE_SMART);
> +	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_MODE_MASK,
> +			  SYSCFG_STANDBY_MODE_SMART);
> +
> +	return ret;
> +}

Yeah so nothing PRU specific here, this you should be able to
handle in a generic way with drivers/bus/ti-sysc.c.

Regards,

Tony
