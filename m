From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
Date: Fri, 16 Nov 2012 10:53:55 -0800
Message-ID: <87y5i1crb0.fsf@deeprootsystems.com>
References: <1353067706-29491-1-git-send-email-anilkumar@ti.com>
	<1353067706-29491-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47083 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab2KPSxo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 13:53:44 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2047366pad.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Nov 2012 10:53:44 -0800 (PST)
In-Reply-To: <1353067706-29491-2-git-send-email-anilkumar@ti.com> (AnilKumar
	Ch's message of "Fri, 16 Nov 2012 17:38:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: a.zummo@towertech.it, sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, broonie@opensource.wolfsonmicro.com, rob.herring@calxeda.com, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Colin Foe-Parker <colin.foeparker@logicpd.com>

AnilKumar Ch <anilkumar@ti.com> writes:

> From: Colin Foe-Parker <colin.foeparker@logicpd.com>
>
> Set tps65217 PMIC status to OFF if power enable toggle is
> supported. Also adds platform data flag, which should be
> passed from board init data.

nit: changelog mentions platform_data, but the code is using DT.

Kevin

> Signed-off-by: Colin Foe-Parker <colin.foeparker@logicpd.com>
> [anilkumar@ti.com: move the additions to tps65217 MFD driver]
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  .../devicetree/bindings/regulator/tps65217.txt     |    4 ++++
>  drivers/mfd/tps65217.c                             |   12 ++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b/Documentation/devicetree/bindings/regulator/tps65217.txt
> index d316fb8..4f05d20 100644
> --- a/Documentation/devicetree/bindings/regulator/tps65217.txt
> +++ b/Documentation/devicetree/bindings/regulator/tps65217.txt
> @@ -11,6 +11,9 @@ Required properties:
>    using the standard binding for regulators found at
>    Documentation/devicetree/bindings/regulator/regulator.txt.
>  
> +Optional properties:
> +- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN toggle.
> +
>    The valid names for regulators are:
>    tps65217: dcdc1, dcdc2, dcdc3, ldo1, ldo2, ldo3 and ldo4
>  
> @@ -20,6 +23,7 @@ Example:
>  
>  	tps: tps@24 {
>  		compatible = "ti,tps65217";
> +		ti,pmic-shutdown-controller;
>  
>  		regulators {
>  			dcdc1_reg: dcdc1 {
> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 3fb32e6..c7f17d8 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -160,6 +160,7 @@ static int __devinit tps65217_probe(struct i2c_client *client,
>  	unsigned int version;
>  	unsigned int chip_id = ids->driver_data;
>  	const struct of_device_id *match;
> +	bool status_off = false;
>  	int ret;
>  
>  	if (client->dev.of_node) {
> @@ -170,6 +171,8 @@ static int __devinit tps65217_probe(struct i2c_client *client,
>  			return -EINVAL;
>  		}
>  		chip_id = (unsigned int)match->data;
> +		status_off = of_property_read_bool(client->dev.of_node,
> +					"ti,pmic-shutdown-controller");
>  	}
>  
>  	if (!chip_id) {
> @@ -207,6 +210,15 @@ static int __devinit tps65217_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	/* Set the PMIC to shutdown on PWR_EN toggle */
> +	if (status_off) {
> +		ret = tps65217_set_bits(tps, TPS65217_REG_STATUS,
> +				TPS65217_STATUS_OFF, TPS65217_STATUS_OFF,
> +				TPS65217_PROTECT_NONE);
> +		if (ret)
> +			dev_warn(tps->dev, "unable to set the status OFF\n");
> +	}
> +
>  	dev_info(tps->dev, "TPS65217 ID %#x version 1.%d\n",
>  			(version & TPS65217_CHIPID_CHIP_MASK) >> 4,
>  			version & TPS65217_CHIPID_REV_MASK);
