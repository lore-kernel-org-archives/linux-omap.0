From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] i2c-omap: add mpu wake up latency constraint in i2c
Date: Mon, 26 Apr 2010 16:12:19 -0700
Message-ID: <20100426231219.GS7225@atomide.com>
References: <1271876654-13613-1-git-send-email-khilman@deeprootsystems.com>
 <1271876654-13613-2-git-send-email-khilman@deeprootsystems.com>
 <20100426225851.GR7225@atomide.com>
 <8739yhu8b5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60346 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab0DZXMT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 19:12:19 -0400
Content-Disposition: inline
In-Reply-To: <8739yhu8b5.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [100426 15:57]:
> Tony Lindgren <tony@atomide.com> writes:
>  
> +#ifdef CONFIG_ARCH_OMAP3
> +/*
> + * omap_i2c_set_wfc_mpu_wkup_lat - sets mpu wake up constraint
> + * @dev:	i2c bus device pointer
> + * @val:	latency constraint to set, -1 to disable constraint
> + *
> + * When waiting for completion of a i2c transfer, we need to set a wake up
> + * latency constraint for the MPU. This is to ensure quick enough wakeup from
> + * idle, when transfer completes.
> + */
> +static void omap_i2c_set_wfc_mpu_wkup_lat(struct device *dev, int val)
> +{
> +	omap_pm_set_max_mpu_wakeup_lat(dev, val);
> +}
> +#endif
> +

Can't you leave out the above too?

> +	struct omap_i2c_bus_platform_data *pd;
>  	struct resource *res;
>  	resource_size_t base, irq;
>  
>  	pdev = &omap_i2c_devices[bus_id - 1];
> +	pd = pdev->dev.platform_data;
>  	if (bus_id == 1) {
>  		res = pdev->resource;
>  		if (cpu_class_is_omap1()) {
> @@ -122,6 +143,8 @@ static int __init omap_i2c_add_bus(int bus_id)
>  		omap1_i2c_mux_pins(bus_id);
>  	if (cpu_class_is_omap2())
>  		omap2_i2c_mux_pins(bus_id);
> +	if (cpu_is_omap34xx())
> +		pd->set_mpu_wkup_lat = omap_i2c_set_wfc_mpu_wkup_lat;

And then just set
		pd->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat;

Here instead?

BTW, in your version looks like compile will break if CONFIG_ARCH_OMAP3
is not set.

Tony
