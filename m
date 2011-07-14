From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCHv2 2/5] regulator: omap smps regulator driver
Date: Wed, 13 Jul 2011 23:29:04 -0700
Message-ID: <20110714062904.GC22467@google.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
 <1310565638-13140-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:32923 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab1GNG3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 02:29:11 -0400
Content-Disposition: inline
In-Reply-To: <1310565638-13140-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, khilman@ti.com

On Wed, Jul 13, 2011 at 05:00:35PM +0300, Tero Kristo wrote:
> OMAP SMPS regulator driver provides access to OMAP voltage processor
> controlled regulators. These include VDD1 and VDD2 for OMAP3 and additionally
> VDD3 for OMAP4. SMPS regulators use the OMAP voltage layer for the actual
> voltage regulation operations.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
...
> +	for (i = 0; i < pdata->num_regulators; i++) {
> +		initdata = pdata->regulators[i];
> +
> +		c = &initdata->constraints;
> +		c->valid_modes_mask &= REGULATOR_MODE_NORMAL;
> +		c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE;
> +		c->always_on = true;
> +
> +		voltdm = omap_voltage_domain_lookup(
> +			initdata->consumer_supplies[0].dev_name);
> +
> +		if (IS_ERR(voltdm)) {
> +			dev_err(&pdev->dev, "can't find voltdm %s, %ld\n",
> +				initdata->consumer_supplies[0].dev_name,
> +				PTR_ERR(voltdm));
> +			return PTR_ERR(voltdm);


Or maybe continue to next loop iteration.

> +		}
> +		info = kzalloc(sizeof(struct omap_smps_reg_info), GFP_KERNEL);
> +
> +		info->voltdm = voltdm;


Check kzalloc NULL return.

> +		info->desc.ops = &omap_smps_ops;
> +		info->desc.name = c->name;
> +		info->desc.type = REGULATOR_VOLTAGE;
> +		info->desc.n_voltages = 0;
> +		rdev = regulator_register(&info->desc, &pdev->dev, initdata,
> +			info);
> +		if (IS_ERR(rdev)) {
> +			dev_err(&pdev->dev, "can't register %s, %ld\n",
> +				info->desc.name, PTR_ERR(rdev));
> +			return PTR_ERR(rdev);

Or suggest continue to next loop iteration.

> +		}
> +		platform_set_drvdata(pdev, rdev);

Performed in a loop, but only last iteration's rdev is set as the
driver data for pdev.  Platform driver data should be pdata?

> +	}
> +
> +	return 0;
> +}
> +
> +static int omap_smps_reg_remove(struct platform_device *pdev)
> +{
> +	regulator_unregister(platform_get_drvdata(pdev));


Should kfree() the struct omap_smps_reg_info data structure(s) and
platform_set_drvdata(pdev, NULL) ?


Todd
