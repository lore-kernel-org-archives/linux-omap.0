From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] i2c-omap: add mpu wake up latency constraint in i2c
Date: Mon, 26 Apr 2010 15:58:51 -0700
Message-ID: <20100426225851.GR7225@atomide.com>
References: <1271876654-13613-1-git-send-email-khilman@deeprootsystems.com>
 <1271876654-13613-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49521 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab0DZW6x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 18:58:53 -0400
Content-Disposition: inline
In-Reply-To: <1271876654-13613-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [100421 11:59]:
> From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> 
> While waiting for completion of the i2c transfer, the
> MPU could hit OFF mode and cause several msecs of
> delay that made i2c transfers fail more often. The
> extra delays and subsequent re-trys cause i2c clocks
> to be active more often. This has also an negative
> effect on power consumption.
> 
> Created a mechanism for passing and using the
> constraint setting function in driver code. The used
> mpu wake up latency constraints are now set individually
> per bus, and they are calculated based on clock rate
> and fifo size.
> 
> Thanks to Jarkko Nikula, Moiz Sonasath, Paul Walmsley,
> and Nishanth Menon for tuning out the details of
> this patch.

<snip>

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
> +static void __init omap_set_i2c_constraint_func(
> +				struct omap_i2c_bus_platform_data *pd)
> +{
> +	if (cpu_is_omap34xx())
> +		pd->set_mpu_wkup_lat = omap_i2c_set_wfc_mpu_wkup_lat;
> +	else
> +		pd->set_mpu_wkup_lat = NULL;
> +}
> +
>  static int __init omap_i2c_nr_ports(void)
>  {
>  	int ports = 0;

<snip>

> @@ -161,9 +189,10 @@ static int __init omap_register_i2c_bus_cmdline(void)
>  {
>  	int i, err = 0;
>  
> -	for (i = 0; i < ARRAY_SIZE(i2c_rate); i++)
> -		if (i2c_rate[i] & OMAP_I2C_CMDLINE_SETUP) {
> -			i2c_rate[i] &= ~OMAP_I2C_CMDLINE_SETUP;
> +	for (i = 0; i < ARRAY_SIZE(i2c_pdata); i++)
> +		if (i2c_pdata[i].clkrate & OMAP_I2C_CMDLINE_SETUP) {
> +			i2c_pdata[i].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
> +			omap_set_i2c_constraint_func(&i2c_pdata[i]);
>  			err = omap_i2c_add_bus(i + 1);
>  			if (err)
>  				goto out;
> @@ -197,9 +226,11 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
>  			return err;
>  	}
>  
> -	if (!i2c_rate[bus_id - 1])
> -		i2c_rate[bus_id - 1] = clkrate;
> -	i2c_rate[bus_id - 1] &= ~OMAP_I2C_CMDLINE_SETUP;
> +	if (!i2c_pdata[bus_id - 1].clkrate)
> +		i2c_pdata[bus_id - 1].clkrate = clkrate;
> +
> +	omap_set_i2c_constraint_func(&i2c_pdata[bus_id - 1]);
> +	i2c_pdata[bus_id - 1].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
>  
>  	return omap_i2c_add_bus(bus_id);
>  }

Looks like this all could be done in omap_i2c_add_bus a bit simpler.

Regards,

Tony
