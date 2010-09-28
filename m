From: "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 5/5] OMAP: I2C: Convert i2c driver to use PM runtime
	api's
Date: Tue, 28 Sep 2010 14:26:26 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF05991C@dbde02.ent.ti.com>
References: <1285078036-12789-1-git-send-email-rnayak@ti.com>
 <1285078036-12789-2-git-send-email-rnayak@ti.com>
 <1285078036-12789-3-git-send-email-rnayak@ti.com>
 <1285078036-12789-4-git-send-email-rnayak@ti.com>
 <1285078036-12789-5-git-send-email-rnayak@ti.com>
 <1285078036-12789-6-git-send-email-rnayak@ti.com>
 <20100927223645.GJ21564@trinity.fluff.org>
 <0680EC522D0CC943BC586913CF3768C003FF05981F@dbde02.ent.ti.com>
 <0680EC522D0CC943BC586913CF3768C003FF05988F@dbde02.ent.ti.com>
 <20100928074840.GA29252@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100928074840.GA29252-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org]
> Sent: Tuesday, September 28, 2010 1:19 PM
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
> That's no reason to avoid using it.

Ok, I'll post an updated patch with the matching clk_put's in place.
