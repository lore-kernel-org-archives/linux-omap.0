From: "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 5/5] OMAP: I2C: Convert i2c driver to use PM runtime
	api's
Date: Wed, 29 Sep 2010 09:30:30 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF2DAF35@dbde02.ent.ti.com>
References: <1285078036-12789-1-git-send-email-rnayak@ti.com>
 <1285078036-12789-2-git-send-email-rnayak@ti.com>
 <1285078036-12789-3-git-send-email-rnayak@ti.com>
 <1285078036-12789-4-git-send-email-rnayak@ti.com>
 <1285078036-12789-5-git-send-email-rnayak@ti.com>
 <1285078036-12789-6-git-send-email-rnayak@ti.com>
 <20100927223645.GJ21564@trinity.fluff.org>
 <0680EC522D0CC943BC586913CF3768C003FF05981F@dbde02.ent.ti.com>
 <0680EC522D0CC943BC586913CF3768C003FF05988F@dbde02.ent.ti.com>
 <20100928233334.GS21564@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100928233334.GS21564-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Ben Dooks [mailto:ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org]
> Sent: Wednesday, September 29, 2010 5:04 AM
> To: Nayak, Rajendra
> Cc: Ben Dooks; Paul Walmsley; Kevin Hilman; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; linux-
> omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH v3 5/5] OMAP: I2C: Convert i2c driver to use PM runtime api's
> 
> On Tue, Sep 28, 2010 at 12:29:01PM +0530, Nayak, Rajendra wrote:
> > <snip>...
> > > > >
> > > > >  static int omap_i2c_init(struct omap_i2c_dev *dev)
> > > > > @@ -356,6 +333,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> > > > >  	unsigned long fclk_rate = 12000000;
> > > > >  	unsigned long timeout;
> > > > >  	unsigned long internal_clk = 0;
> > > > > +	struct clk *fclk;
> > > > >
> > > > >  	if (dev->rev >= OMAP_I2C_REV_2) {
> > > > >  		/* Disable I2C controller before soft reset */
> > > > > @@ -414,7 +392,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> > > > >  		 * always returns 12MHz for the functional clock, we can
> > > > >  		 * do this bit unconditionally.
> > > > >  		 */
> > > > > -		fclk_rate = clk_get_rate(dev->fclk);
> > > > > +		fclk = clk_get(dev->dev, "fck");
> > > > > +		fclk_rate = clk_get_rate(fclk);
> > > > >
> > > > >  		/* TRM for 5912 says the I2C clock must be prescaled to be
> > > > >  		 * between 7 - 12 MHz. The XOR input clock is typically
> > > > > @@ -443,7 +422,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> > > > >  			internal_clk = 9600;
> > > > >  		else
> > > > >  			internal_clk = 4000;
> > > > > -		fclk_rate = clk_get_rate(dev->fclk) / 1000;
> > > > > +		fclk = clk_get(dev->dev, "fck");
> > > > > +		fclk_rate = clk_get_rate(fclk) / 1000;
> > > >
> > > > You don't put the clk after getting it and using it once?
> > >
> > > clk_get needs an equivalent clk_put and not clk_get_rate. clk_get_rate
> > > is used to merely know the existing rate of the clock.
> >
> > Sorry, I guess you did mean the clk_get above the clk_get_rate does not have
> > an equivalent clk_put.
> > I could put a clk_put for readability, but a clk_put on OMAP actually does map
> > to an empty function.
> > See arch/arm/plat-omap/include/plat/clkdev.h
> > clk_get merely returns a pointer to the clk struct and does not do any usecounting,
> > hence a clk_put does not do anything.
> 
> clk_get() should have a reference counter, and on many systems does.
> 
> This is why we ask people to put clk_put() when they don't need the
> clock any more. It may not do anything on your system, but it will
> set a good example to anyone copying your driver code.

I agree. There is an updated patch now posted with the clk_put's in place.

> 
> As such, I should really go and read up all about this new runtime-pm
> and hwmod stuff before further commentign on the changes.

Ok. Thanks.

> 
> > >
> > > >
> > > > >  		/* Compute prescaler divisor */
> > > > >  		psc = fclk_rate / internal_clk;
> > > > > @@ -1046,14 +1026,12 @@ omap_i2c_probe(struct platform_device *pdev)
> > > > >  	else
> > > > >  		dev->reg_shift = 2;
> > > > >
> > > > > -	if ((r = omap_i2c_get_clocks(dev)) != 0)
> > > > > -		goto err_iounmap;
> > > > > -
> > > > >  	if (cpu_is_omap44xx())
> > > > >  		dev->regs = (u8 *) omap4_reg_map;
> > > > >  	else
> > > > >  		dev->regs = (u8 *) reg_map;
> > > > >
> > > > > +	pm_runtime_enable(&pdev->dev);
> > > > >  	omap_i2c_unidle(dev);
> > > > >
> > > > >  	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> > > > > @@ -1125,8 +1103,6 @@ err_free_irq:
> > > > >  err_unuse_clocks:
> > > > >  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> > > > >  	omap_i2c_idle(dev);
> > > > > -	omap_i2c_put_clocks(dev);
> > > > > -err_iounmap:
> > > > >  	iounmap(dev->base);
> > > > >  err_free_mem:
> > > > >  	platform_set_drvdata(pdev, NULL);
> > > > > @@ -1148,7 +1124,6 @@ omap_i2c_remove(struct platform_device *pdev)
> > > > >  	free_irq(dev->irq, dev);
> > > > >  	i2c_del_adapter(&dev->adapter);
> > > > >  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> > > > > -	omap_i2c_put_clocks(dev);
> > > > >  	iounmap(dev->base);
> > > > >  	kfree(dev);
> > > > >  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > > --
> > > > > 1.5.4.7
> > > > >
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > > > > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > >
> > > > --
> > > > --
> > > > Ben
> > > >
> > > > Q:      What's a light-year?
> > > > A:      One-third less calories than a regular year.
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> --
> --
> Ben
> 
> Q:      What's a light-year?
> A:      One-third less calories than a regular year.
