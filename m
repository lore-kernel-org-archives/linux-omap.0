From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/4] power_supply: bq27x00: separate common code
Date: Sun, 19 Oct 2008 01:36:00 +0400
Message-ID: <20081018213600.GB1272@oksana.dev.rtsoft.ru>
References: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com> <1224277248-17021-2-git-send-email-felipe.balbi@nokia.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:18182 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750928AbYJRVgC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Oct 2008 17:36:02 -0400
Content-Disposition: inline
In-Reply-To: <1224277248-17021-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>

On Sat, Oct 18, 2008 at 12:00:45AM +0300, Felipe Balbi wrote:
> put common code into a separate file and link it to new
> drivers which will come in later patches.

Looks good. Though I would prefer platform_device approach.
Nobody want to implement this though... don't know why, it is
quite easy...
http://kerneltrap.org/mailarchive/linux-kernel/2008/6/23/2198444


Few comments below.

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  drivers/power/bq27x00.c |  190 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/power/bq27x00.h |   54 +++++++++++++
>  2 files changed, 244 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/power/bq27x00.c
>  create mode 100644 drivers/power/bq27x00.h
> 
> diff --git a/drivers/power/bq27x00.c b/drivers/power/bq27x00.c
> new file mode 100644
> index 0000000..5609829
> --- /dev/null
> +++ b/drivers/power/bq27x00.c
> @@ -0,0 +1,190 @@
> +/*
> + * bq27x00.c - Shared functions between BQ27200 and BQ27000
> + *
> + * Copyright (C) 2008 Texas Instruments, Inc.
> + *
> + * Author: Texas Instruments
> + *
> + * This package is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/param.h>
> +#include <linux/jiffies.h>
> +#include <linux/workqueue.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +
> +#include "bq27x00.h"
> +
> +unsigned int cache_time = 60000;

I think it should be static, no?

> +module_param(cache_time, uint, 0644);
> +MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> +
> +enum power_supply_property bq27x00_props[] = {

static?

> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_TEMP,
> +};
> +
> +static int bq27x00_read(u8 reg, int *rt_value, int b_single,
> +	struct bq27x00_device_info *di);
> +
> +/*
> + * Return the battery temperature in Celcius degrees
> + * Or < 0 if something fails.
> + */
> +static int bq27x00_temperature(struct bq27x00_device_info *di)
> +{
> +	int ret, temp = 0;
> +
> +	ret = bq27x00_read(BQ27x00_REG_TEMP, &temp, 0, di);
> +	if (ret) {
> +		pr_err("BQ27x00 battery driver:"
> +			"Error reading temperature from the battery\n");

dev_err()

> +		return ret;
> +	}
> +
> +	return (temp >> 2) - 273;
> +}
> +
> +/*
> + * Return the battery Voltage in milivolts
> + * Or < 0 if something fails.
> + */
> +static int bq27x00_voltage(struct bq27x00_device_info *di)
> +{
> +	int ret, volt = 0;
> +
> +	ret = bq27x00_read(BQ27x00_REG_VOLT, &volt, 0, di);
> +	if (ret) {
> +		pr_err("BQ27x00 battery driver:"
> +			"Error reading battery voltage from the battery\n");

dev_err()

> +		return ret;
> +	}
> +
> +	return volt;
> +}
> +
> +/*
> + * Return the battery average current
> + * Note that current can be negative signed as well
> + * Or 0 if something fails.
> + */
> +static int bq27x00_current(struct bq27x00_device_info *di)
> +{
> +	int ret, curr = 0, flags = 0;

int ret;
int cur = 0;
int flags = 0;

The same applies for other functions.

> +
> +	ret = bq27x00_read(BQ27x00_REG_AI, &curr, 0, di);
> +	if (ret) {
> +		dev_dbg(di->dev, "Error reading current from the battery\n");
> +		return 0;
> +	}
> +	ret = bq27x00_read(BQ27x00_REG_FLAGS, &flags, 0, di);
> +	if (ret < 0) {
> +		dev_dbg(di->dev, "Error reading battery flags\n");
> +		return 0;
> +	}
> +	if ((flags & (1 << 7)) != 0) {
> +		pr_debug("Negative current\n");

Why not dev_dbg() here?

> +		return -curr;
> +	} else {
> +		return curr;
> +	}
> +}
> +
> +/*
> + * Return the battery Relative State-of-Charge
> + * Or < 0 if something fails.
> + */
> +static int bq27x00_rsoc(struct bq27x00_device_info *di)
> +{
> +	int ret, rsoc = 0;
> +
> +	ret = bq27x00_read(BQ27x00_REG_RSOC, &rsoc, 1, di);
> +	if (ret) {
> +		pr_err("BQ27x00 battery driver:"
> +			"Error reading battery Relative"
> +			"State-of-Charge\n");

dev_err()

> +		return ret;
> +	}
> +	return rsoc;
> +}
> +
> +static int bq27x00_read(u8 reg, int *rt_value, int b_single,
> +	struct bq27x00_device_info *di)
> +{
> +	return di->bus->read(reg, rt_value, b_single, di);
> +}
> +
> +/*
> + * Read the battery temp, voltage, current and relative state of charge.
> + */
> +void bq27x00_read_status(struct bq27x00_device_info *di)
> +{
> +	if (di->update_time && time_before(jiffies, di->update_time +
> +					msecs_to_jiffies(cache_time)))
> +		return;
> +
> +	di->temp_C = bq27x00_temperature(di);
> +	di->voltage_uV = bq27x00_voltage(di);
> +	di->current_uA = bq27x00_current(di);
> +	di->charge_rsoc = bq27x00_rsoc(di);
> +
> +	di->update_time = jiffies;
> +}
> +
> +int bq27x00_get_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					union power_supply_propval *val)
> +{
> +	struct bq27x00_device_info *di = to_bq27x00_device_info(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval = di->voltage_uV;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval = di->current_uA;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		val->intval = di->charge_rsoc;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		val->intval = di->temp_C;

Per Documentation/power/power_supply_class.txt we return temperature
in tenths of degree Celsius. I think the driver doesn't convert it to
proper units. (The same applies to the driver that it already
in the battery-2.6.git tree. :-( We should fix that).

> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval = di->charge_rsoc;

I don't quite get it. In what units rsoc is? PROP_CAPACITY should
be in percents, not uAh.

See Documentation/power/power_supply_class.txt

> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		if (di->voltage_uV == 0)
> +			val->intval = 0;
> +		else
> +			val->intval = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +void bq27x00_powersupply_init(struct bq27x00_device_info *di)
> +{
> +	di->bat.type = POWER_SUPPLY_TYPE_BATTERY;
> +	di->bat.properties = bq27x00_props;
> +	di->bat.num_properties = ARRAY_SIZE(bq27x00_props);
> +	di->bat.get_property = bq27x00_get_property;
> +	di->bat.external_power_changed = NULL;
> +}
> +
> diff --git a/drivers/power/bq27x00.h b/drivers/power/bq27x00.h
> new file mode 100644
> index 0000000..f465ed8
> --- /dev/null
> +++ b/drivers/power/bq27x00.h
> @@ -0,0 +1,54 @@
> +/*
> + * bq27x00.h - exported symbols placeholder
> + *
> + * Copyright (C) 2008 Texas Instruments, Inc.
> + * Copyright (C) 2008 Nokia Corporation
> + *
> + * Author: Texas Instruments
> + *
> + * This package is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + */

#ifndef __POWER_BQ27X00_H
#define __POWER_BQ27X00_H

> +#define BQ27x00_REG_TEMP		0x06
> +#define BQ27x00_REG_VOLT		0x08
> +#define BQ27x00_REG_RSOC		0x0B /* Relative State-of-Charge */
> +#define BQ27x00_REG_AI			0x14
> +#define BQ27x00_REG_FLAGS		0x0A
> +#define HIGH_BYTE(A)			((A) << 8)

This macros has a problem that we fixed once already:

http://git.infradead.org/battery-2.6.git?a=commitdiff;h=8aef7e8f8de2d900da892085edbf14ea35fe6881

> +
> +struct bq27x00_device_info {
> +	struct device		*dev;
> +	unsigned long		update_time;
> +	int			voltage_uV;
> +	int			current_uA;
> +	int			temp_C;
> +	int			charge_rsoc;
> +	struct bq27x00_access_methods	*bus;
> +	struct power_supply	bat;
> +	struct delayed_work	monitor_work;
> +};
> +
> +struct bq27x00_access_methods {
> +	int (*read)(u8 reg, int *rt_value, int b_single,
> +		struct bq27x00_device_info *di);
> +};
> +
> +extern unsigned int cache_time;

It seems this extern isn't used anywhere. Plus the name is too generic
for global symbol.

> +extern enum power_supply_property bq27x00_props[];

It seems you don't need this extern.

> +extern void bq27x00_powersupply_init(struct bq27x00_device_info *di);
> +extern void bq27x00_read_status(struct bq27x00_device_info *di);
> +extern int bq27x00_get_property(struct power_supply *psy,
> +		enum power_supply_property psp,
> +		union power_supply_propval *val);

Ditto for these two.

> +
> +#define to_bq27x00_device_info(x) container_of((x), \
> +				struct bq27x00_device_info, bat);
> +

#endif /* __POWER_BQ27X00_H */


Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
