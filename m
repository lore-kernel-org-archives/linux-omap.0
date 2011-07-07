From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC PATCH 5/5] OMAP: I2C: Convert I2C driver to use device tree
Date: Thu, 7 Jul 2011 22:43:49 +0530
Message-ID: <20110707171349.GC3124@manju-desktop>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
 <1309426647-31587-6-git-send-email-manjugk@ti.com>
 <20110706190803.GN4871@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:52760 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752852Ab1GGRN6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 13:13:58 -0400
Received: by mail-pv0-f179.google.com with SMTP id 18so666920pvg.10
        for <linux-omap@vger.kernel.org>; Thu, 07 Jul 2011 10:13:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110706190803.GN4871@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Wed, Jul 06, 2011 at 01:08:03PM -0600, Grant Likely wrote:
> On Thu, Jun 30, 2011 at 03:07:27PM +0500, G, Manjunath Kondaiah wrote:
> > 
> > The OMAP I2C driver is modified to use platform_device data from
> > device tree data structures.
> > 
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> 
> Mostly looks good, but a few things that need to be fixed.  You can
> probably even get this change merged for v3.1

Thanks. I will fix the review comments and we can have these changes with
board-omapx-dt.c file so that dt and not dt builds can co exist.

For complete functionality with dt build, omap hwmod needs to be handled
through DT framework. I am waiting for comments from omap hwmod maintainers.

> 
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   30 +++++++++++++++++++++++++++++-
> >  1 files changed, 29 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index ae1545b..d4ccc52 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -38,9 +38,13 @@
> >  #include <linux/clk.h>
> >  #include <linux/io.h>
> >  #include <linux/of_i2c.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_address.h>
> >  #include <linux/slab.h>
> >  #include <linux/i2c-omap.h>
> >  #include <linux/pm_runtime.h>
> > +#include <plat/i2c.h>
> >  
> >  /* I2C controller revisions */
> >  #define OMAP_I2C_REV_2			0x20
> > @@ -972,6 +976,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
> >  	.functionality	= omap_i2c_func,
> >  };
> >  
> > +static const struct of_device_id omap_i2c_of_match[];
> >  static int __devinit
> >  omap_i2c_probe(struct platform_device *pdev)
> >  {
> > @@ -979,10 +984,15 @@ omap_i2c_probe(struct platform_device *pdev)
> >  	struct i2c_adapter	*adap;
> >  	struct resource		*mem, *irq, *ioarea;
> >  	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
> > +	const struct of_device_id *match;
> >  	irq_handler_t isr;
> >  	int r;
> >  	u32 speed = 0;
> >  
> > +	match = of_match_device(omap_i2c_of_match, &pdev->dev);
> > +	if (!match)
> > +		dev_err(&pdev->dev, "DT: i2c device match not found.......\n");
> > +
> 
> This isn't an error.  It just mean that the device wasn't registered
> from the device tree, and it needs to get its configuration from
> pdata.
> 
> In fact, you don't even need this block since the driver never uses
> the match entry returned by of_match_device()

ok. I will remove this.
> 
> >  	/* NOTE: driver uses the static register mapping */
> >  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!mem) {
> > @@ -1007,10 +1017,19 @@ omap_i2c_probe(struct platform_device *pdev)
> >  		r = -ENOMEM;
> >  		goto err_release_region;
> >  	}
> > -
> 
> Don't drop the empty line.
> 
> > +	/* I2C device without DT might use this */
> 
> No need for the comment.
ok
> 
> >  	if (pdata != NULL) {
> >  		speed = pdata->clkrate;
> >  		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
> > +	} else if (pdev->dev.of_node) {
> > +		const unsigned int *prop;
> > +		prop = of_get_property(pdev->dev.of_node,
> > +				"clock-frequency", NULL);
> > +		if (prop)
> > +			speed = be32_to_cpup(prop);
> > +		else
> > +			speed = 100;
> 
> There is a new function that makes this easier.  Do this instead:
> 
> 	speed = 100;
> 	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency", &prop)
> 		speed = prop / 1000000; /* speed in Hz, this might be wrong */
These patches got merged after posting this series. I will take care of it in
the next version.

BTW, I have posted seperate patch to use above API for code optimization.


> 
> > +		dev->set_mpu_wkup_lat = NULL;
> 
> dev is kzalloced, which means set_mpu_wkup_lat is already NULL.
> 
> >  	} else {
> >  		speed = 100;	/* Default speed */
> >  		dev->set_mpu_wkup_lat = NULL;
> > @@ -1045,6 +1064,7 @@ omap_i2c_probe(struct platform_device *pdev)
> >  
> >  	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> >  
> > +
> 
> Drop the unrelated whitespace change.
> 
> >  	if (dev->rev <= OMAP_I2C_REV_ON_3430)
> >  		dev->errata |= I2C_OMAP3_1P153;
> >  
> > @@ -1073,6 +1093,7 @@ omap_i2c_probe(struct platform_device *pdev)
> >  				       (1000 * speed / 8);
> >  	}
> >  
> > +
> 
> Ditto.
> 
> >  	/* reset ASAP, clearing any IRQs */
> >  	omap_i2c_init(dev);
> >  
> > @@ -1162,6 +1183,12 @@ static int omap_i2c_resume(struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static const struct of_device_id omap_i2c_of_match[] = {
> > +	{.compatible = "ti,omap_i2c", },
> > +	{},
> > +}
> > +MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
> > +
> 
> This needs to be protected with #ifdef CONFIG_OF/#else/#endif.  Don't
> break non-dt builds.
> 

ok. Thanks.

-Manjunath
