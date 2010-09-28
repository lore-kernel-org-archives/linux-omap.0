From: "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 5/5] OMAP: I2C: Convert i2c driver to use PM runtime
	api's
Date: Tue, 28 Sep 2010 11:28:08 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF05981F@dbde02.ent.ti.com>
References: <1285078036-12789-1-git-send-email-rnayak@ti.com>
 <1285078036-12789-2-git-send-email-rnayak@ti.com>
 <1285078036-12789-3-git-send-email-rnayak@ti.com>
 <1285078036-12789-4-git-send-email-rnayak@ti.com>
 <1285078036-12789-5-git-send-email-rnayak@ti.com>
 <1285078036-12789-6-git-send-email-rnayak@ti.com>
 <20100927223645.GJ21564@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100927223645.GJ21564-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Ben Dooks [mailto:ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org]
> Sent: Tuesday, September 28, 2010 4:07 AM
> To: Nayak, Rajendra
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org;
> khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; Kevin Hilman; Paul Walmsley
> Subject: Re: [PATCH v3 5/5] OMAP: I2C: Convert i2c driver to use PM runtime api's
> 
> On Tue, Sep 21, 2010 at 07:37:16PM +0530, Rajendra Nayak wrote:
> > This patch converts the i2c driver to use PM runtime apis
> >
> > Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> > Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> > Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   67 +++++++++++++----------------------------
> >  1 files changed, 21 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index 7674efb..126bde9 100644
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
> > @@ -265,45 +264,18 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
> >  				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
> >  }
> >
> > -static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> > +static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> >  {
> > -	int ret;
> > +	struct platform_device *pdev;
> > +	struct omap_i2c_bus_platform_data *pdata;
> >
> > -	dev->iclk = clk_get(dev->dev, "ick");
> > -	if (IS_ERR(dev->iclk)) {
> > -		ret = PTR_ERR(dev->iclk);
> > -		dev->iclk = NULL;
> > -		return ret;
> > -	}
> > +	WARN_ON(!dev->idle);
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
> > +	pdev = to_platform_device(dev->dev);
> > +	pdata = pdev->dev.platform_data;
> >
> > -	return 0;
> > -}
> > +	pm_runtime_get_sync(&pdev->dev);
> >
> > -static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
> > -{
> > -	clk_put(dev->fclk);
> > -	dev->fclk = NULL;
> > -	clk_put(dev->iclk);
> > -	dev->iclk = NULL;
> > -}
> > -
> > -static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> > -{
> > -	WARN_ON(!dev->idle);
> > -
> > -	clk_enable(dev->iclk);
> > -	clk_enable(dev->fclk);
> >  	if (cpu_is_omap34xx()) {
> >  		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> >  		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
> > @@ -326,10 +298,15 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> >
> >  static void omap_i2c_idle(struct omap_i2c_dev *dev)
> >  {
> > +	struct platform_device *pdev;
> > +	struct omap_i2c_bus_platform_data *pdata;
> >  	u16 iv;
> >
> >  	WARN_ON(dev->idle);
> >
> > +	pdev = to_platform_device(dev->dev);
> > +	pdata = pdev->dev.platform_data;
> > +
> >  	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> >  	if (dev->rev >= OMAP_I2C_REV_ON_4430)
> >  		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
> > @@ -345,8 +322,8 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
> >  		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> >  	}
> >  	dev->idle = 1;
> > -	clk_disable(dev->fclk);
> > -	clk_disable(dev->iclk);
> > +
> > +	pm_runtime_put_sync(&pdev->dev);
> >  }
> >
> >  static int omap_i2c_init(struct omap_i2c_dev *dev)
> > @@ -356,6 +333,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> >  	unsigned long fclk_rate = 12000000;
> >  	unsigned long timeout;
> >  	unsigned long internal_clk = 0;
> > +	struct clk *fclk;
> >
> >  	if (dev->rev >= OMAP_I2C_REV_2) {
> >  		/* Disable I2C controller before soft reset */
> > @@ -414,7 +392,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> >  		 * always returns 12MHz for the functional clock, we can
> >  		 * do this bit unconditionally.
> >  		 */
> > -		fclk_rate = clk_get_rate(dev->fclk);
> > +		fclk = clk_get(dev->dev, "fck");
> > +		fclk_rate = clk_get_rate(fclk);
> >
> >  		/* TRM for 5912 says the I2C clock must be prescaled to be
> >  		 * between 7 - 12 MHz. The XOR input clock is typically
> > @@ -443,7 +422,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> >  			internal_clk = 9600;
> >  		else
> >  			internal_clk = 4000;
> > -		fclk_rate = clk_get_rate(dev->fclk) / 1000;
> > +		fclk = clk_get(dev->dev, "fck");
> > +		fclk_rate = clk_get_rate(fclk) / 1000;
> 
> You don't put the clk after getting it and using it once?

clk_get needs an equivalent clk_put and not clk_get_rate. clk_get_rate
is used to merely know the existing rate of the clock.
 
> 
> >  		/* Compute prescaler divisor */
> >  		psc = fclk_rate / internal_clk;
> > @@ -1046,14 +1026,12 @@ omap_i2c_probe(struct platform_device *pdev)
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
> > @@ -1125,8 +1103,6 @@ err_free_irq:
> >  err_unuse_clocks:
> >  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> >  	omap_i2c_idle(dev);
> > -	omap_i2c_put_clocks(dev);
> > -err_iounmap:
> >  	iounmap(dev->base);
> >  err_free_mem:
> >  	platform_set_drvdata(pdev, NULL);
> > @@ -1148,7 +1124,6 @@ omap_i2c_remove(struct platform_device *pdev)
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
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> --
> Ben
> 
> Q:      What's a light-year?
> A:      One-third less calories than a regular year.
