From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/4] power_supply: bq27200: separate bq27200-specific
	driver
Date: Sun, 19 Oct 2008 01:34:54 +0300
Message-ID: <20081018223442.GV31842@frodo>
References: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com> <1224277248-17021-2-git-send-email-felipe.balbi@nokia.com> <1224277248-17021-3-git-send-email-felipe.balbi@nokia.com> <20081018214635.GA12264@oksana.dev.rtsoft.ru>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36641 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbYJRWfI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 18:35:08 -0400
Content-Disposition: inline
In-Reply-To: <20081018214635.GA12264@oksana.dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>

On Sun, Oct 19, 2008 at 01:46:35AM +0400, Anton Vorontsov wrote:
> > diff --git a/drivers/power/bq27200.c b/drivers/power/bq27200.c
> > new file mode 100644
> > index 0000000..ef03743
> > --- /dev/null
> > +++ b/drivers/power/bq27200.c
> > @@ -0,0 +1,202 @@
> > +/*
> > + * bq27200.c - BQ27200 battery driver
> > + *
> > + * Copyright (C) 2008 Texas Instruments, Inc.
> > + * Copyright (C) 2008 Nokia Corporation
> > + *
> > + * Author: Texas Instruments
> > + *
> > + * This package is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> > + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> > + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> > + *
> > + */
> > +#include <linux/module.h>
> > +#include <linux/param.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/delay.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/i2c.h>
> > +
> > +#include "bq27x00.h"
> > +
> > +static struct i2c_client *bq_client;
> 
> :-(
> 
> Platform device approach would eliminate need for this...

sure... that looks nice.

> > +static inline int bq27200_read(u8 reg, int *rt_value, int b_single,
> > +	struct bq27x00_device_info *di)
> > +{
> > +	struct i2c_client *client = bq_client;
> > +	struct i2c_msg msg[1];
> > +	unsigned char data[2];
> > +	int err;
> > +
> > +	if (!client->adapter)
> > +		return -ENODEV;
> > +
> > +	msg->addr = client->addr;
> > +	msg->flags = 0;
> > +	msg->len = 1;
> > +	msg->buf = data;
> > +
> > +	data[0] = reg;
> > +	err = i2c_transfer(client->adapter, msg, 1);
> > +
> > +	if (err >= 0) {
> 
> Would look better if you swap the success/fail cases:
> 
> if (err < 0) {
> 	dev_err();
> 	return err;
> }
> 
> success-code-here;

yeah, brain fart.

> > +static int __init bq27200_probe(struct i2c_client *client,
> > +		const struct i2c_device_id *id)
> > +{
> > +	struct bq27x00_device_info *di;
> > +	struct bq27x00_access_methods *bus;
> > +	int retval = 0;
> > +
> > +	di = kzalloc(sizeof(*di), GFP_KERNEL);
> > +	if (!di) {
> > +		dev_dbg(&client->dev, "could not allocate dev info's memory\n");
> > +		retval = -ENOMEM;
> > +		goto err_di;
> > +	}
> > +
> > +	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
> > +	if (!bus) {
> > +		dev_dbg(&client->dev, "could not allocate bus' memory\n");
> > +		retval = -ENOMEM;
> > +		goto err_bus;
> > +	}
> > +
> > +	i2c_set_clientdata(client, di);
> > +	di->dev = &client->dev;
> > +	di->bat.name = "bq27200";
> > +	bus->read = &bq27200_read;
> > +	di->bus = bus;
> > +	bq_client = client;
> > +
> > +	bq27x00_powersupply_init(di);
> > +
> > +	retval = power_supply_register(&client->dev, &di->bat);
> > +	if (retval) {
> > +		dev_dbg(&client->dev, "could not register power_supply, %d\n",
> > +				retval);
> > +		goto err_psy;
> > +	}
> > +
> > +	INIT_DELAYED_WORK(&di->monitor_work, bq27200_work);
> > +	schedule_delayed_work(&di->monitor_work, 100);
> 
> This should be done before registering the power supply. Otherwise
> code may use the di->monitor_work before it has initialized.

that's right, good catch.

> > +static const struct i2c_device_id bq27200_id[] = {
> > +	{ "bq27200", 0 },
> 
> No need for ", 0".

doesn't the static variables automatic initialization to 0 (or NULL)
only work with the gnu style struct declaration ??

I mean:

static const struct i2c_device_id b27200_id[] = {
	{
		.name	= "bq27200",
	},
};

Anyways, I'm only following the standard used by Jean (i2c maintainer).

-- 
balbi
