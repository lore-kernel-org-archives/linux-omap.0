From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 5/5] OMAP: I2C: Convert i2c driver to use PM runtime
 api's
Date: Wed, 25 Aug 2010 14:13:35 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B39A3EBE@dbde02.ent.ti.com>
References: <1281364586-26323-1-git-send-email-rnayak@ti.com>
	<1281364586-26323-2-git-send-email-rnayak@ti.com>
	<1281364586-26323-3-git-send-email-rnayak@ti.com>
	<1281364586-26323-4-git-send-email-rnayak@ti.com>
	<1281364586-26323-5-git-send-email-rnayak@ti.com>
 <87d3t9vuhs.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39832 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663Ab0HYInk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 04:43:40 -0400
In-Reply-To: <87d3t9vuhs.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 24, 2010 3:53 AM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Paul Walmsley
> Subject: Re: [PATCH 5/5] OMAP: I2C: Convert i2c driver to use PM runtime api's
> 
> Rajendra Nayak <rnayak@ti.com> writes:
> 
> > This patch converts the i2c driver to use PM runtime apis for OMAP2+
> > and omap_device api's for OMAP1
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> 
> Some minor comments below, but otherwise looks like the right direction.

Hi Kevin,

Thanks, I'll fix these in the next version.
Rajendra
> 
> Kevin
> 
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   81 ++++++++++++++++++-------------------
> ----
> >  1 files changed, 35 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index 7674efb..387f9c6 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> >  #include <linux/i2c-omap.h>
> > +#include <linux/pm_runtime.h>
> >
> >  /* I2C controller revisions */
> >  #define OMAP_I2C_REV_2			0x20
> > @@ -175,8 +176,6 @@ struct omap_i2c_dev {
> >  	void __iomem		*base;		/* virtual */
> >  	int			irq;
> >  	int			reg_shift;      /* bit shift for I2C register addresses */
> > -	struct clk		*iclk;		/* Interface clock */
> > -	struct clk		*fclk;		/* Functional clock */
> >  	struct completion	cmd_complete;
> >  	struct resource		*ioarea;
> >  	u32			latency;	/* maximum mpu wkup latency */
> > @@ -265,45 +264,25 @@ static inline u16 omap_i2c_read_reg(struct
> omap_i2c_dev *i2c_dev, int reg)
> >  				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
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
> > -
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
> > +	struct platform_device *pdev;
> > +	struct omap_i2c_bus_platform_data *pdata;
> >
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
> 
> <linux/platform_device.h> provides to_platform_device() for this
> 
> > +	pdata = pdev->dev.platform_data;
> >
> > -static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> > -{
> > -	WARN_ON(!dev->idle);
> > +	pm_runtime_get_sync(&pdev->dev);
> > +	/*
> > +	 * This is needed for now to have OMAP1
> > +	 * working as PM runtime is not yet
> > +	 * supported on OMAP1
> > +	 */
> > +	if (pdata->device_enable)
> > +		pdata->device_enable(pdev);
> 
> OMAP1 should work fine on the pm-wip/rutime branch as there is a simple
> runtime PM core for OMAP1 implemented that just manages clocks.
> 
> > -	clk_enable(dev->iclk);
> > -	clk_enable(dev->fclk);
> >  	if (cpu_is_omap34xx()) {
> >  		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> >  		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
> > @@ -326,10 +305,15 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> >
> >  static void omap_i2c_idle(struct omap_i2c_dev *dev)
> >  {
> > +	struct platform_device *pdev;
> > +	struct omap_i2c_bus_platform_data *pdata;
> >  	u16 iv;
> >
> >  	WARN_ON(dev->idle);
> >
> > +	pdev = container_of(dev->dev, struct platform_device, dev);
> > +	pdata = pdev->dev.platform_data;
> > +
> >  	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> >  	if (dev->rev >= OMAP_I2C_REV_ON_4430)
> >  		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
> > @@ -345,8 +329,15 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
> >  		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> >  	}
> >  	dev->idle = 1;
> > -	clk_disable(dev->fclk);
> > -	clk_disable(dev->iclk);
> > +
> > +	pm_runtime_put_sync(&pdev->dev);
> > +	/*
> > +	 * This is needed for now to have OMAP1
> > +	 * working as PM runtime is not yet
> > +	 * supported on OMAP1
> > +	 */
> > +	if (pdata->device_idle)
> > +		pdata->device_idle(pdev);
> 
> ditto
> 
> >  }
> >
> >  static int omap_i2c_init(struct omap_i2c_dev *dev)
> > @@ -356,6 +347,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> >  	unsigned long fclk_rate = 12000000;
> >  	unsigned long timeout;
> >  	unsigned long internal_clk = 0;
> > +	struct clk *fclk;
> >
> >  	if (dev->rev >= OMAP_I2C_REV_2) {
> >  		/* Disable I2C controller before soft reset */
> > @@ -414,7 +406,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> >  		 * always returns 12MHz for the functional clock, we can
> >  		 * do this bit unconditionally.
> >  		 */
> > -		fclk_rate = clk_get_rate(dev->fclk);
> > +		fclk = clk_get(dev->dev, "fck");
> > +		fclk_rate = clk_get_rate(fclk);
> >
> >  		/* TRM for 5912 says the I2C clock must be prescaled to be
> >  		 * between 7 - 12 MHz. The XOR input clock is typically
> > @@ -443,7 +436,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> >  			internal_clk = 9600;
> >  		else
> >  			internal_clk = 4000;
> > -		fclk_rate = clk_get_rate(dev->fclk) / 1000;
> > +		fclk = clk_get(dev->dev, "fck");
> > +		fclk_rate = clk_get_rate(fclk) / 1000;
> >
> >  		/* Compute prescaler divisor */
> >  		psc = fclk_rate / internal_clk;
> > @@ -1046,14 +1040,12 @@ omap_i2c_probe(struct platform_device *pdev)
> >  	else
> >  		dev->reg_shift = 2;
> >
> > -	if ((r = omap_i2c_get_clocks(dev)) != 0)
> > -		goto err_iounmap;
> > -
> >  	if (cpu_is_omap44xx())
> >  		dev->regs = (u8 *) omap4_reg_map;
> >  	else
> >  		dev->regs = (u8 *) reg_map;
> >
> > +	pm_runtime_enable(&pdev->dev);
> >  	omap_i2c_unidle(dev);
> >
> >  	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> > @@ -1125,8 +1117,6 @@ err_free_irq:
> >  err_unuse_clocks:
> >  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> >  	omap_i2c_idle(dev);
> > -	omap_i2c_put_clocks(dev);
> > -err_iounmap:
> >  	iounmap(dev->base);
> >  err_free_mem:
> >  	platform_set_drvdata(pdev, NULL);
> > @@ -1148,7 +1138,6 @@ omap_i2c_remove(struct platform_device *pdev)
> >  	free_irq(dev->irq, dev);
> >  	i2c_del_adapter(&dev->adapter);
> >  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> > -	omap_i2c_put_clocks(dev);
> >  	iounmap(dev->base);
> >  	kfree(dev);
> >  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
