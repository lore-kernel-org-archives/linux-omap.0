From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 2/3] mfd: lp873x: Add lp873x PMIC support
Date: Mon, 8 Aug 2016 10:57:37 +0530
Message-ID: <57A81849.7010707@ti.com>
References: <1467215067-6486-1-git-send-email-j-keerthy@ti.com>
 <1467215067-6486-3-git-send-email-j-keerthy@ti.com>
 <20160805080322.GO5243@dell> <57A44D21.2080106@ti.com>
 <20160805090147.GT5243@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160805090147.GT5243@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Friday 05 August 2016 02:31 PM, Lee Jones wrote:
> On Fri, 05 Aug 2016, Keerthy wrote:
>> On Friday 05 August 2016 01:33 PM, Lee Jones wrote:
>>> On Wed, 29 Jun 2016, Keerthy wrote:
>>>
>>>> The LP873X chip is a power management IC for Portable Navigation Systems
>>>>       and Tablet Computing devices. It contains the following components:
>>>>
>>>>        - Regulators.
>>>>        - Configurable General Purpose Output Signals(GPO).
>>>>
>>>> PMIC interacts with the main processor through i2c. PMIC has
>>>> couple of LDOs(Linear Regulators), couple of BUCKs (Step-Down DC-DC
>>>> Converter Cores) and GPOs(General Purpose Output Signals).
>>>>
>>>> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>>
>>>> Changes in v4:
>>>>
>>>>     * Added Author.
>>>>     * Added the mfd_cell for gpio.
>>>>
>>>> Changes in v3:
>>>>
>>>>     * Reordered the probe code.
>>>>     * Fixed Typo in Kconfig description.
>>>>     * Removed unused member from struct lp873x.
>>>>
>>>>    drivers/mfd/Kconfig        |  14 +++
>>>>    drivers/mfd/Makefile       |   2 +
>>>>    drivers/mfd/lp873x.c       |  99 +++++++++++++++++
>>>>    include/linux/mfd/lp873x.h | 264 +++++++++++++++++++++++++++++++++++++++++++++
>>>>    4 files changed, 379 insertions(+)
>>>>    create mode 100644 drivers/mfd/lp873x.c
>>>>    create mode 100644 include/linux/mfd/lp873x.h
>>>>
>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>> index 9987d86..e68ac28 100644
>>>> --- a/drivers/mfd/Kconfig
>>>> +++ b/drivers/mfd/Kconfig
>>>> @@ -1221,6 +1221,20 @@ config MFD_TPS65217
>>>>    	  This driver can also be built as a module.  If so, the module
>>>>    	  will be called tps65217.
>>>>
>>>> +config MFD_LP873X
>>>
>>> Nicer as MFD_TI_LP873X I think.
>>>
>>>> +	tristate "TI LP873X Power Management IC"
>>>> +	depends on I2C
>>>> +	select MFD_CORE
>>>> +	select REGMAP_I2C
>>>> +	help
>>>> +	  If you say yes here then you get support for the LP873X series of
>>>> +	  power management integrated circuits(PMIC).
>>>
>>> Power Management Integrated Circuits (PMIC).
>>
>> Okay
>>
>>>
>>>> +	  These include voltage regulators, Thermal protection, Configurable
>>>> +	  general purpose outputs(GPO) that are used in portable devices.
>>>
>>> Some here.  Please standardise your capitalisation.
>>
>> Okay
>>
>>>
>>>> +	  This driver can also be built as a module.  If so, the module
>>>> +	  will be called lp873x.
>>>> +
>>>>    config MFD_TPS65218
>>>>    	tristate "TI TPS65218 Power Management chips"
>>>>    	depends on I2C
>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>>> index 2ba3ba3..7d9b965 100644
>>>> --- a/drivers/mfd/Makefile
>>>> +++ b/drivers/mfd/Makefile
>>>> @@ -22,6 +22,8 @@ obj-$(CONFIG_HTC_EGPIO)		+= htc-egpio.o
>>>>    obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
>>>>    obj-$(CONFIG_HTC_I2CPLD)	+= htc-i2cpld.o
>>>>
>>>> +obj-$(CONFIG_MFD_LP873X)	+= lp873x.o
>>>> +
>>>>    obj-$(CONFIG_MFD_DAVINCI_VOICECODEC)	+= davinci_voicecodec.o
>>>>    obj-$(CONFIG_MFD_DM355EVM_MSP)	+= dm355evm_msp.o
>>>>    obj-$(CONFIG_MFD_TI_AM335X_TSCADC)	+= ti_am335x_tscadc.o
>>>> diff --git a/drivers/mfd/lp873x.c b/drivers/mfd/lp873x.c
>>>> new file mode 100644
>>>> index 0000000..54ed0ce
>>>> --- /dev/null
>>>> +++ b/drivers/mfd/lp873x.c
>>>> @@ -0,0 +1,99 @@
>>>> +/*
>>>> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
>>>> + *
>>>> + * Author: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU General Public License as
>>>> + * published by the Free Software Foundation version 2.
>>>> + *
>>>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>>>> + * kind, whether express or implied; without even the implied warranty
>>>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + */
>>>> +
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/mfd/core.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/regmap.h>
>>>> +
>>>> +#include <linux/mfd/lp873x.h>
>>>> +
>>>> +static const struct regmap_config lp873x_regmap_config = {
>>>> +	.reg_bits = 8,
>>>> +	.val_bits = 8,
>>>> +	.max_register = LP873X_REG_MAX,
>>>> +};
>>>> +
>>>> +static const struct mfd_cell lp873x_cells[] = {
>>>> +	{ .name = "lp873x-regulator", },
>>>> +	{ .name = "lp873x-gpio", },
>>>> +};
>>>> +
>>>> +static int lp873x_probe(struct i2c_client *client,
>>>> +			const struct i2c_device_id *ids)
>>>> +{
>>>> +	struct lp873x *lp873;
>>>> +	int ret;
>>>> +	unsigned int otpid;
>>>> +
>>>> +	lp873 = devm_kzalloc(&client->dev, sizeof(*lp873), GFP_KERNEL);
>>>> +	if (!lp873)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	lp873->dev = &client->dev;
>>>> +
>>>> +	lp873->regmap = devm_regmap_init_i2c(client, &lp873x_regmap_config);
>>>> +	if (IS_ERR(lp873->regmap)) {
>>>> +		ret = PTR_ERR(lp873->regmap);
>>>> +		dev_err(lp873->dev, "Failed to initialize register map: %d\n",
>>>> +			ret);
>>>
>>> Nit: I'd prefer you break after "->dev,".
>>
>> Okay
>>
>>>
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	mutex_init(&lp873->lp873_lock);
>>>
>>> How many locks do you have in 'struct lp873x'?
>>>
>>> I suggest that 'lock' will do fine.
>>
>> Okay.
>>
>>>
>>>> +	ret = regmap_read(lp873->regmap, LP873X_REG_OTP_REV, &otpid);
>>>> +	if (ret) {
>>>> +		dev_err(lp873->dev, "Failed to read OTP ID\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	lp873->rev = otpid & LP873X_OTP_REV_OTP_ID;
>>>> +	i2c_set_clientdata(client, lp873);
>>>> +	ret = mfd_add_devices(lp873->dev, PLATFORM_DEVID_AUTO, lp873x_cells,
>>>> +			      ARRAY_SIZE(lp873x_cells), NULL, 0, NULL);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static const struct of_device_id of_lp873x_match_table[] = {
>>>> +	{ .compatible = "ti,lp8733", },
>>>> +	{ .compatible = "ti,lp8732", },
>>>> +	{}
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, of_lp873x_match_table);
>>>> +
>>>> +static const struct i2c_device_id lp873x_id_table[] = {
>>>> +	{ "lp873x", LP873X },
>>>> +	{ "lp8732", LP873X },
>>>> +	{ "lp8733", LP873X },
>>>
>>> Do you use these IDs at any point?
>>
>> I have lp8733 and lp8732 at the moment. They are register exact but
>> different parts none the less. Hence having separate strings. As of now no
>> differences seen in gpio/regulator modules so not using them anywhere.
>
> I have a patch-set pending on the I2C list that removes all unused
> 'struct i2c_device_id' tables.  To identify which ones are in use and
> which ones can be removed, it would help if you could remove the
> unused .id field.

I guess you are referring to this:

http://www.gossamer-threads.com/lists/linux/kernel/2457552

I applied the above series and i see that by using driver_new in lp873x
MFD driver i no longer need the mandatory i2c_device_id. Thanks.
I will send a series on top of your i2c set v5 without any unused 
device_id. I will add a dependency on your set.

Thanks and Regards,
Keerthy
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
