From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 5/6] OMAP: I2C: Convert i2c driver to use
 omap_device/omap_hwmod
Date: Wed, 24 Feb 2010 14:08:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321A2075B@dbde02.ent.ti.com>
References: <1266582437-22398-1-git-send-email-rnayak@ti.com>
	<1266582437-22398-2-git-send-email-rnayak@ti.com>
	<1266582437-22398-3-git-send-email-rnayak@ti.com>
	<1266582437-22398-4-git-send-email-rnayak@ti.com>
	<1266582437-22398-5-git-send-email-rnayak@ti.com>
 <87d3zvychy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49013 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400Ab0BXIiU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 03:38:20 -0500
In-Reply-To: <87d3zvychy.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin, 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, February 24, 2010 1:02 AM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 5/6] OMAP: I2C: Convert i2c driver to use 
> omap_device/omap_hwmod
> 
> Rajendra Nayak <rnayak@ti.com> writes:
> 
> > This patch converts the i2c driver to use omap_device/omap_hwmod.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Hi Rajendra,
> 
> Rather than using omap_device functions via platform_data pointers,
> can you try to do this using runtime PM?  You can use my
> pm-wip/runtime branch (based on top of my pm-wip/hwmods branch.)  I
> also have a pm-wip/mmc branch on top of the runtime branch that does
> this for the MMC if you'd like to compare.

Ok.. I'll repost the patch using runtime PM instead of the omap_device
api's.

regards,
Rajendra

> 
> Basically, this patch will be the same, except for instead of
> 
> 	if (pdata->device_enable)
> 		pdata->device_enable(pdev);
> 
> you do
> 
> 	pm_runtime_get_sync(dev)
>         
> 
> and instead of 
> 
> 	if (pdata->device_enable)
> 		pdata->device_enable(pdev);
> 
> you do
> 
> 	pm_runtime_put_sync(dev)
> 
> under the hood, the runtime PM core will do reference counting and
> then call OMAP device when needed.
> 
> Kevin
> 
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   81 
> ++++++++++++++++-------------------------
> >  1 files changed, 32 insertions(+), 49 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c 
> b/drivers/i2c/busses/i2c-omap.c
> > index 0037e31..520ac5a 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -38,6 +42,8 @@
> >  #include <linux/clk.h>
> >  #include <linux/io.h>
> >  
> > +#include <plat/i2c.h>
> > +
> >  /* I2C controller revisions */
> >  #define OMAP_I2C_REV_2			0x20
> >  
> > @@ -161,8 +167,6 @@ struct omap_i2c_dev {
> >  	struct device		*dev;
> >  	void __iomem		*base;		/* virtual */
> >  	int			irq;
> > -	struct clk		*iclk;		/* Interface clock */
> > -	struct clk		*fclk;		/* Functional clock */
> >  	struct completion	cmd_complete;
> >  	struct resource		*ioarea;
> >  	u32			speed;		/* Speed of bus 
> in Khz */
> > @@ -197,45 +201,19 @@ static inline u16 
> omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
> >  	return __raw_readw(i2c_dev->base + reg);
> >  }
> >  
> > -static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> > +static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> >  {
> > -	int ret;
> > -
> > -	dev->iclk = clk_get(dev->dev, "ick");
> > -	if (IS_ERR(dev->iclk)) {
> > -		ret = PTR_ERR(dev->iclk);
> > -		dev->iclk = NULL;
> > -		return ret;
> > -	}
> > +	struct platform_device *pdev;
> > +	struct omap_i2c_platform_data *pdata;
> >  
> > -	dev->fclk = clk_get(dev->dev, "fck");
> > -	if (IS_ERR(dev->fclk)) {
> > -		ret = PTR_ERR(dev->fclk);
> > -		if (dev->iclk != NULL) {
> > -			clk_put(dev->iclk);
> > -			dev->iclk = NULL;
> > -		}
> > -		dev->fclk = NULL;
> > -		return ret;
> > -	}
> > -
> > -	return 0;
> > -}
> > +	WARN_ON(!dev->idle);
> >  
> > -static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
> > -{
> > -	clk_put(dev->fclk);
> > -	dev->fclk = NULL;
> > -	clk_put(dev->iclk);
> > -	dev->iclk = NULL;
> > -}
> > +	pdev = container_of(dev->dev, struct platform_device, dev);
> > +	pdata = pdev->dev.platform_data;
> >  
> > -static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> > -{
> > -	WARN_ON(!dev->idle);
> > +	if (pdata->device_enable)
> > +		pdata->device_enable(pdev);
> >  
> > -	clk_enable(dev->iclk);
> > -	clk_enable(dev->fclk);
> >  	if (cpu_is_omap34xx()) {
> >  		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> >  		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, 
> dev->pscstate);
> > @@ -258,10 +236,15 @@ static void omap_i2c_unidle(struct 
> omap_i2c_dev *dev)
> >  
> >  static void omap_i2c_idle(struct omap_i2c_dev *dev)
> >  {
> > +	struct platform_device *pdev;
> > +	struct omap_i2c_platform_data *pdata;
> >  	u16 iv;
> >  
> >  	WARN_ON(dev->idle);
> >  
> > +	pdev = container_of(dev->dev, struct platform_device, dev);
> > +	pdata = pdev->dev.platform_data;
> > +
> >  	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> >  	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
> >  	if (dev->rev < OMAP_I2C_REV_2) {
> > @@ -273,8 +256,8 @@ static void omap_i2c_idle(struct 
> omap_i2c_dev *dev)
> >  		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> >  	}
> >  	dev->idle = 1;
> > -	clk_disable(dev->fclk);
> > -	clk_disable(dev->iclk);
> > +	if (pdata->device_idle)
> > +		pdata->device_idle(pdev);
> >  }
> >  
> >  static int omap_i2c_init(struct omap_i2c_dev *dev)
> > @@ -284,6 +267,7 @@ static int omap_i2c_init(struct 
> omap_i2c_dev *dev)
> >  	unsigned long fclk_rate = 12000000;
> >  	unsigned long timeout;
> >  	unsigned long internal_clk = 0;
> > +	struct clk *fclk;
> >  
> >  	if (dev->rev >= OMAP_I2C_REV_2) {
> >  		/* Disable I2C controller before soft reset */
> > @@ -340,7 +324,8 @@ static int omap_i2c_init(struct 
> omap_i2c_dev *dev)
> >  		 * always returns 12MHz for the functional clock, we can
> >  		 * do this bit unconditionally.
> >  		 */
> > -		fclk_rate = clk_get_rate(dev->fclk);
> > +		fclk = clk_get(dev->dev, "fck");
> > +		fclk_rate = clk_get_rate(fclk);
> >  
> >  		/* TRM for 5912 says the I2C clock must be 
> prescaled to be
> >  		 * between 7 - 12 MHz. The XOR input clock is typically
> > @@ -369,7 +354,8 @@ static int omap_i2c_init(struct 
> omap_i2c_dev *dev)
> >  			internal_clk = 9600;
> >  		else
> >  			internal_clk = 4000;
> > -		fclk_rate = clk_get_rate(dev->fclk) / 1000;
> > +		fclk = clk_get(dev->dev, "fck");
> > +		fclk_rate = clk_get_rate(fclk) / 1000;
> >  
> >  		/* Compute prescaler divisor */
> >  		psc = fclk_rate / internal_clk;
> > @@ -856,6 +842,7 @@ omap_i2c_probe(struct platform_device *pdev)
> >  	struct i2c_adapter	*adap;
> >  	struct resource		*mem, *irq, *ioarea;
> >  	irq_handler_t isr;
> > +	struct omap_i2c_platform_data *pdata;
> >  	int r;
> >  	u32 speed = 0;
> >  
> > @@ -884,8 +871,10 @@ omap_i2c_probe(struct platform_device *pdev)
> >  		goto err_release_region;
> >  	}
> >  
> > -	if (pdev->dev.platform_data != NULL)
> > -		speed = *(u32 *)pdev->dev.platform_data;
> > +	pdata = pdev->dev.platform_data;
> > +
> > +	if (pdata->rate)
> > +		speed = pdata->rate;
> >  	else
> >  		speed = 100;	/* Defualt speed */
> >  
> > @@ -901,9 +890,6 @@ omap_i2c_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, dev);
> >  
> > -	if ((r = omap_i2c_get_clocks(dev)) != 0)
> > -		goto err_iounmap;
> > -
> >  	omap_i2c_unidle(dev);
> >  
> >  	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> > @@ -963,8 +949,6 @@ err_free_irq:
> >  err_unuse_clocks:
> >  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> >  	omap_i2c_idle(dev);
> > -	omap_i2c_put_clocks(dev);
> > -err_iounmap:
> >  	iounmap(dev->base);
> >  err_free_mem:
> >  	platform_set_drvdata(pdev, NULL);
> > @@ -986,7 +970,6 @@ omap_i2c_remove(struct platform_device *pdev)
> >  	free_irq(dev->irq, dev);
> >  	i2c_del_adapter(&dev->adapter);
> >  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> > -	omap_i2c_put_clocks(dev);
> >  	iounmap(dev->base);
> >  	kfree(dev);
> >  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -- 
> > 1.5.4.7
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 