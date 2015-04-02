From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCHv3] media: i2c/adp1653: devicetree support for adp1653
Date: Thu, 2 Apr 2015 22:30:44 +0200
Message-ID: <20150402203043.GB29963@amd>
References: <20150402143846.GA11687@amd>
 <20150402161453.GH20756@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150402161453.GH20756-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, sre-GFxCN5SEZAc@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi!

> Hi Pawel,
> 
> My apologies for the very late reply.
> 
> On Thu, Apr 02, 2015 at 04:38:46PM +0200, Pavel Machek wrote:
> > 
> > 
> > We are moving to device tree support on OMAP3, but that currently
> > breaks ADP1653 driver. This adds device tree support, plus required
> > documentation.
> > 
> > Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > 
> > ---
> > 
> > I'm not sure if it is device tree or media framework, either everyone
> > waits for someone else, or noone really cares.
> 
> Neither. Some people are unfortuantely very busy with many other things as
> well. :-P

Well.. Being busy is ok. Nitpicking is also ok. But both at the same
time... is not good. 

> > Andrew, can you just merge it?
> > 
> > Please apply,
> 
> Please wait just a while.
> 
> I think we can merge this eventually through the linux-media tree, but
> please first see the comments below.
> 

> > +Required properties of the flash LED child node:
> > +
> > +- flash-max-microamp : see Documentation/devicetree/bindings/leds/common.txt
> > +- flash-timeout-us : see Documentation/devicetree/bindings/leds/common.txt
> 
> The documentation says that the maximum value is used if these values are
> not specified. I think I'd make these optional.

I'd rather not: when you make a typo in dts, it would supply maximum
available current, potentially damaging the LED. You will not be able
to tell brightness difference with naked eye...

> >  __adp1653_set_power(struct adp1653_flash *flash, int on)
> >  {
> > -	int ret;
> > +	int ret = 0;
> > +
> > +	if (flash->platform_data->power) {
> > +		ret = flash->platform_data->power(&flash->subdev, on);
> 
> The power() callback should be dropped. It's controlling a GPIO. But that
> can be done later on. The alternative is a patch before this one.

I'd prefer to do it later; we want to keep functionality on N900
without DTS, too.

> >  	flash = devm_kzalloc(&client->dev, sizeof(*flash), GFP_KERNEL);
> >  	if (flash == NULL)
> >  		return -ENOMEM;
> >  
> >  	flash->platform_data = client->dev.platform_data;
> > +	if (!flash->platform_data) {
> 
> I'd check whether dev->of_node is non-NULL instead.

Ok.

> > @@ -438,10 +510,10 @@ static int adp1653_probe(struct i2c_client *client,
> >  		goto free_and_quit;
> >  
> >  	flash->subdev.entity.type = MEDIA_ENT_T_V4L2_SUBDEV_FLASH;
> > -
> 
> I rather liked the newline here. Please don't remove it. :-)

Ok.

> > @@ -464,7 +536,7 @@ static const struct i2c_device_id adp1653_id_table[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, adp1653_id_table);
> >  
> > -static struct dev_pm_ops adp1653_pm_ops = {
> > +static const struct dev_pm_ops adp1653_pm_ops = {
> >  	.suspend	= adp1653_suspend,
> >  	.resume		= adp1653_resume,
> >  };
> >  
> > 
> 
> A corresponding change to the N900 dts would be very nice.

Corresponding change to the dts will come in separate patch. Or do you
have n900 for testing?

> I think you're missing change to adp1653_i2c_driver.driver.of_match_table.

It actually worked for me, which means device tree somehow does it
magic.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
