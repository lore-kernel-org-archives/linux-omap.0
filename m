From: Tony Lindgren <tony@atomide.com>
Subject: Re: Bunch of machines are not booting in next again, GPIO regression?
Date: Wed, 17 Feb 2016 12:22:25 -0800
Message-ID: <20160217202224.GD21202@atomide.com>
References: <20160217192755.GC21202@atomide.com>
 <20160217195543.GA871@jcartwri.amer.corp.natinst.com>
 <20160217201259.GA16028@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160217201259.GA16028@deathstar>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Josh Cartwright <joshc@ni.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Michael Welling <mwelling@ieee.org> [160217 12:13]:
> On Wed, Feb 17, 2016 at 01:55:43PM -0600, Josh Cartwright wrote:
> > On Wed, Feb 17, 2016 at 11:27:55AM -0800, Tony Lindgren wrote:
> > > Hi Linus,
> > > 
> > > Looks like ff2b13592299 ("gpio: make the gpiochip a real device")
> > > broke booting on all omaps, and probably other machines too according
> > > to this:
> > > 
> > > https://kernelci.org/boot/all/job/next/kernel/next-20160217/
> > > 
> > > So far we've gone from 1 failed machine with next-20160216 to
> > > 18 failed machines with next-20160217.
> > > 
> > > The error I'm getting on omaps is below with debug_ll enable,
> > > any ideas?
> > 
> > Hey Tony-
> > 
> > Looks like the newly allocated gpio_device object isn't zeroed,
> > confusing dev_set_name.  Can you give this a try?
> > 
> >   Josh
> > 
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index d8511cd..59f0045 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -435,7 +435,7 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
> >  	 * First: allocate and populate the internal stat container, and
> >  	 * set up the struct device.
> >  	 */
> > -	gdev = kmalloc(sizeof(*gdev), GFP_KERNEL);
> > +	gdev = kzalloc(sizeof(*gdev), GFP_KERNEL);
> >  	if (!gdev)
> >  		return -ENOMEM;
> >  	gdev->dev.bus = &gpio_bus_type;
> 
> As you can see by my post on the GPIO mailing list, a boot failure
> was occurring on the Dragonboard 410C:
> http://permalink.gmane.org/gmane.linux.kernel.gpio/14360
> 
> With the above patch the board now boots. Good catch.

Yup fixes the issue for me too.

Thanks,

Tony

