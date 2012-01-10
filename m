From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv8 4/5] twl4030: add support for external voltage get/set
Date: Mon, 09 Jan 2012 17:11:11 -0800
Message-ID: <871ur8weds.fsf@ti.com>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
	<1323444589-19940-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:50171 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755753Ab2AJBLP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 20:11:15 -0500
Received: by mail-yx0-f173.google.com with SMTP id m6so833850yen.4
        for <linux-omap@vger.kernel.org>; Mon, 09 Jan 2012 17:11:14 -0800 (PST)
In-Reply-To: <1323444589-19940-5-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Fri, 9 Dec 2011 17:29:48 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Tero Kristo <t-kristo@ti.com> writes:

> This is needed for SMPS regulators, which use the OMAP voltage
> processor for voltage get/set functions instead of the normal I2C
> channel. For this purpose, regulator_init_data->driver_data contents
> are expanded, it is now a struct which contains function pointers
> for the set/get voltage operations, a data pointer for these, and
> the previously used features bitmask.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

Seems to me like the get/set override should be more generic (part of
regulator core) instead of TWL specific?

Otherwise, whenever someone hooks up a non-TWL regulator to an OMAP and
is using HW control (via VC/VP), they'll have to duplicate all of this
stuff in their regulator driver?

Kevin


> ---
>  drivers/mfd/twl-core.c            |   16 ++++++++++++++-
>  drivers/regulator/twl-regulator.c |   39 ++++++++++++++++++++++++++++++++----
>  include/linux/i2c/twl.h           |    7 ++++++
>  3 files changed, 56 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 01ecfee..009f62b 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -609,6 +609,8 @@ add_regulator_linked(int num, struct regulator_init_data *pdata,
>  		unsigned num_consumers, unsigned long features)
>  {
>  	unsigned sub_chip_id;
> +	struct twl_regulator_driver_data drv_data;
> +
>  	/* regulator framework demands init_data ... */
>  	if (!pdata)
>  		return NULL;
> @@ -618,7 +620,19 @@ add_regulator_linked(int num, struct regulator_init_data *pdata,
>  		pdata->num_consumer_supplies = num_consumers;
>  	}
>  
> -	pdata->driver_data = (void *)features;
> +	if (pdata->driver_data) {
> +		/* If we have existing drv_data, just add the flags */
> +		struct twl_regulator_driver_data *tmp;
> +		tmp = pdata->driver_data;
> +		tmp->features |= features;
> +	} else {
> +		/* add new driver data struct, used only during init */
> +		drv_data.features = features;
> +		drv_data.set_voltage = NULL;
> +		drv_data.get_voltage = NULL;
> +		drv_data.data = NULL;
> +		pdata->driver_data = &drv_data;
> +	}
>  
>  	/* NOTE:  we currently ignore regulator IRQs, e.g. for short circuits */
>  	sub_chip_id = twl_map[TWL_MODULE_PM_MASTER].sid;
> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
> index 11cc308..29eda40 100644
> --- a/drivers/regulator/twl-regulator.c
> +++ b/drivers/regulator/twl-regulator.c
> @@ -58,6 +58,16 @@ struct twlreg_info {
>  
>  	/* chip specific features */
>  	unsigned long 		features;
> +
> +	/*
> +	 * optional override functions for voltage set/get
> +	 * these are currently only used for SMPS regulators
> +	 */
> +	int			(*get_voltage)(void *data);
> +	int			(*set_voltage)(void *data, int min_uV);
> +
> +	/* data passed from board for external get/set voltage */
> +	void			*data;
>  };
>  
>  
> @@ -522,15 +532,25 @@ twl4030smps_set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV,
>  	struct twlreg_info *info = rdev_get_drvdata(rdev);
>  	int vsel = DIV_ROUND_UP(min_uV - 600000, 12500);
>  
> -	twlreg_write(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS_4030,
> -		vsel);
> +	if (info->set_voltage) {
> +		return info->set_voltage(info->data, min_uV);
> +	} else {
> +		twlreg_write(info, TWL_MODULE_PM_RECEIVER,
> +			VREG_VOLTAGE_SMPS_4030, vsel);
> +	}
> +
>  	return 0;
>  }
>  
>  static int twl4030smps_get_voltage(struct regulator_dev *rdev)
>  {
>  	struct twlreg_info *info = rdev_get_drvdata(rdev);
> -	int vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER,
> +	int vsel;
> +
> +	if (info->get_voltage)
> +		return info->get_voltage(info->data);
> +
> +	vsel = twlreg_read(info, TWL_MODULE_PM_RECEIVER,
>  		VREG_VOLTAGE_SMPS_4030);
>  
>  	return vsel * 12500 + 600000;
> @@ -1052,6 +1072,7 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
>  	struct regulator_init_data	*initdata;
>  	struct regulation_constraints	*c;
>  	struct regulator_dev		*rdev;
> +	struct twl_regulator_driver_data	*drvdata;
>  
>  	for (i = 0, info = NULL; i < ARRAY_SIZE(twl_regs); i++) {
>  		if (twl_regs[i].desc.id != pdev->id)
> @@ -1066,8 +1087,16 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
>  	if (!initdata)
>  		return -EINVAL;
>  
> -	/* copy the features into regulator data */
> -	info->features = (unsigned long)initdata->driver_data;
> +	drvdata = initdata->driver_data;
> +
> +	if (!drvdata)
> +		return -EINVAL;
> +
> +	/* copy the driver data into regulator data */
> +	info->features = drvdata->features;
> +	info->data = drvdata->data;
> +	info->set_voltage = drvdata->set_voltage;
> +	info->get_voltage = drvdata->get_voltage;
>  
>  	/* Constrain board-specific capabilities according to what
>  	 * this driver and the chip itself can actually do.
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 114c0f6..7157e88 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -747,6 +747,13 @@ struct twl4030_platform_data {
>  	struct regulator_init_data		*vio6025;
>  };
>  
> +struct twl_regulator_driver_data {
> +	int		(*set_voltage)(void *data, int min_uV);
> +	int		(*get_voltage)(void *data);
> +	void		*data;
> +	unsigned long	features;
> +};
> +
>  /*----------------------------------------------------------------------*/
>  
>  int twl4030_sih_setup(int module);
