From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 3/6] regulator: omap smps regulator driver
Date: Tue, 19 Jul 2011 10:58:17 +0300
Message-ID: <1311062297.10230.22.camel@sokoban>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com> <1311010522-5868-4-git-send-email-t-kristo@ti.com> <20110718182218.GJ25081@legolas.emea.dhcp.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36451 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339Ab1GSH6Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jul 2011 03:58:24 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110718182218.GJ25081@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, "Hilman, Kevin" <khilman@ti.com>, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, "Girdwood, Liam" <lrg@ti.com>

On Mon, 2011-07-18 at 20:22 +0200, Balbi, Felipe wrote:
> Hi,
> 
> On Mon, Jul 18, 2011 at 08:35:19PM +0300, Tero Kristo wrote:
> > diff --git a/drivers/regulator/omap-smps-regulator.c b/drivers/regulator/omap-smps-regulator.c
> > new file mode 100644
> > index 0000000..8b56e4f
> > --- /dev/null
> > +++ b/drivers/regulator/omap-smps-regulator.c
> > @@ -0,0 +1,179 @@
> > +/*
> > + * omap-vp-regulator.c -- support SMPS regulators for OMAP chips
> 
> name is wrong here.
> 
> > + *
> > + * Copyright (C) 2011 Texas Instruments, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/ctype.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/init.h>
> > +#include <linux/err.h>
> > +#include <linux/delay.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/driver.h>
> > +#include <linux/regulator/machine.h>
> > +#include <linux/regulator/omap-smps.h>
> > +#include <plat/voltage.h>
> > +
> > +#define DRIVER_NAME		"omap-smps"
> > +
> > +struct omap_smps_reg_info {
> > +	const char		*vdd_name;
> > +	struct regulator_dev	*rdev;
> > +	struct voltagedomain	*voltdm;
> > +	struct regulator_desc	desc;
> > +};
> > +
> > +static int omap_smps_set_voltage(struct regulator_dev *rdev, int min_uV,
> > +				    int max_uV, unsigned *selector)
> > +{
> > +	struct omap_smps_reg_info	*info = rdev_get_drvdata(rdev);
> > +	return voltdm_scale(info->voltdm, min_uV);
> > +}
> > +
> > +static int omap_smps_get_voltage(struct regulator_dev *rdev)
> > +{
> > +	struct omap_smps_reg_info	*info = rdev_get_drvdata(rdev);
> > +	return omap_vp_get_curr_volt(info->voltdm);
> > +}
> > +
> > +static struct regulator_ops omap_smps_ops = {
> 
> should this be const ?
> 

I think it can be yea, I'll change that for next version.



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

