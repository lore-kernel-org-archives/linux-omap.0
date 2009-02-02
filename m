From: "Pillai, Manikandan" <mani.pillai@ti.com>
Subject: RE: [PATCH 2/2] Adding and building TPS6235x based PR785 board
 support
Date: Mon, 2 Feb 2009 09:22:30 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403FA790614@dbde02.ent.ti.com>
References: <1233307390-14974-1-git-send-email-mani.pillai@ti.com>
 <20090130115313.GB18825@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41867 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754016AbZBBDwx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Feb 2009 22:52:53 -0500
In-Reply-To: <20090130115313.GB18825@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi,

Pls find my comments inlined.

> -----Original Message-----
> From: Mark Brown [mailto:broonie@sirena.org.uk]
> Sent: Friday, January 30, 2009 5:23 PM
> To: Pillai, Manikandan
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/2] Adding and building TPS6235x based PR785 board
> support
> 
> On Fri, Jan 30, 2009 at 02:53:10PM +0530, Manikandan Pillai wrote:
> 
> > --- a/arch/arm/plat-omap/i2c.c
> > +++ b/arch/arm/plat-omap/i2c.c
> > @@ -27,6 +27,8 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/i2c.h>
> >  #include <mach/mux.h>
> > +#include <linux/string.h>
> > +#include <linux/regulator/machine.h>
> 
> > +#if defined(CONFIG_OMAP3EVM_PR785)
> > +/* This is the callback function used to find the correct
> > + * i2c platform child for the regulator consumer
> > +*/
> > +int omap_i2c_match_child(struct device *dev, void *data)
> > +{
> > +	struct regulator_init_data *reg_init_data = dev->platform_data;
> > +	char *name = data;
> > +
> > +	/* Child does not match */
> > +	if (strcmp(name, reg_init_data->consumer_supplies->supply))
> > +		return 0;
> > +	else
> > +		return 1;
> > +}
> > +
> > +int omap_i2c_register_child(struct platform_device *pdev_parent,
> > +			const char *name, struct platform_device **pdev)
> > +{
> > +	int ret = 0;
> > +
> > +	*pdev = platform_device_alloc(name, -1);
> > +	if (pdev == NULL) {
> > +		dev_err(&(*pdev)->dev, "Failed to alloc i2c-child %s\n", name);
> > +		return -1;
> > +	}
> > +
> > +	(*pdev)->dev.parent = &pdev_parent->dev;
> > +	if (!strcmp(name, "vdd2_consumer"))
> > +		(*pdev)->dev.platform_data = &vdd2_tps_regulator_data;
> > +	else if (!strcmp(name, "vdd1_consumer"))
> > +		(*pdev)->dev.platform_data = &vdd1_tps_regulator_data;
> > +
> > +
> > +	ret = platform_device_add(*pdev);
> > +	if (ret != 0) {
> > +		dev_err(&(*pdev)->dev, "Failed to register %s: %d\n",
> > +			name, ret);
> > +		platform_device_put(*pdev);
> > +		*pdev = NULL;
> > +	}
> > +	return ret;
> > +}
> > +#endif
> 
> I'm not sure what this is intended for but if it's in the generic OMAP
> I2C driver it shouldn't be conditional on this particular EVM and
> shouldn't have hard coded references to board specific things.
[Pillai, Manikandan] I can move this to board-omap3evm.c.


> 
> > @@ -160,5 +216,16 @@ int __init omap_register_i2c_bus(int bus_id, u32
> clkrate,
> >
> >  	omap_i2c_mux_pins(bus_id - 1);
> > -	return platform_device_register(pdev);
> > +	platform_device_register(pdev);
> > +#if defined(CONFIG_OMAP3EVM_PR785)
> > +	if (bus_id == 1) {
> > +		omap_i2c_register_child(pdev, "vdd2_consumer", \
> > +				&vdd2_platform_device);
> > +		omap_i2c_register_child(pdev, "vdd1_consumer", \
> > +				&vdd1_platform_device);
> > +		tps62352_core_consumers.dev = &vdd2_platform_device->dev;
> > +		tps62352_mpu_consumers.dev = &vdd1_platform_device->dev;
> > +	}
> > +#endif
> > +	return 0;
> 
> Ditto.  It's important to remember that this I2C driver is going to be
> used by all OMAP systems using I2C - patching in ifdefs for setting up
> each board isn't going to scale, they would end up obscuring the code
> for the I2C controller itself.
[Pillai, Manikandan] I can move this to board-omap3evm.c. I shall be using
static struct platform_device omap_i2c_devices[]  as extern in board-omap3evm.c
to register the child platform device.

> 
> > diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> > index 0dacb18..fdc5f5b 100644
> > --- a/drivers/regulator/Makefile
> > +++ b/drivers/regulator/Makefile
> > @@ -12,5 +12,6 @@ obj-$(CONFIG_REGULATOR_TWL4030) += twl4030-regulator.o
> >  obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
> >  obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
> >  obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
> > +obj-$(CONFIG_REGULATOR_TPS6235X)+= tps6235x-regulator.o
> >
> 
> This wants to be in your previous patch, as do the changes to the
> regulator driver below.
[Pillai, Manikandan] OK

