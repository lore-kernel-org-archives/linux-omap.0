From: Josh Cartwright <joshc@ni.com>
Subject: Re: Bunch of machines are not booting in next again, GPIO regression?
Date: Wed, 17 Feb 2016 16:44:15 -0600
Message-ID: <20160217224415.GA3866@jcartwri.amer.corp.natinst.com>
References: <20160217192755.GC21202@atomide.com>
 <20160217195543.GA871@jcartwri.amer.corp.natinst.com>
 <20160217201259.GA16028@deathstar>
 <20160217202224.GD21202@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160217202224.GD21202@atomide.com>
Content-Disposition: inline
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Michael Welling <mwelling@ieee.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 17, 2016 at 12:22:25PM -0800, Tony Lindgren wrote:
> * Michael Welling <mwelling@ieee.org> [160217 12:13]:
> > On Wed, Feb 17, 2016 at 01:55:43PM -0600, Josh Cartwright wrote:
> > > On Wed, Feb 17, 2016 at 11:27:55AM -0800, Tony Lindgren wrote:
> > > > Hi Linus,
> > > > 
> > > > Looks like ff2b13592299 ("gpio: make the gpiochip a real device")
> > > > broke booting on all omaps, and probably other machines too according
> > > > to this:
> > > > 
> > > > https://kernelci.org/boot/all/job/next/kernel/next-20160217/
> > > > 
> > > > So far we've gone from 1 failed machine with next-20160216 to
> > > > 18 failed machines with next-20160217.
> > > > 
> > > > The error I'm getting on omaps is below with debug_ll enable,
> > > > any ideas?
> > > 
> > > Hey Tony-
> > > 
> > > Looks like the newly allocated gpio_device object isn't zeroed,
> > > confusing dev_set_name.  Can you give this a try?
> > > 
> > >   Josh
> > > 
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index d8511cd..59f0045 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -435,7 +435,7 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
> > >  	 * First: allocate and populate the internal stat container, and
> > >  	 * set up the struct device.
> > >  	 */
> > > -	gdev = kmalloc(sizeof(*gdev), GFP_KERNEL);
> > > +	gdev = kzalloc(sizeof(*gdev), GFP_KERNEL);
> > >  	if (!gdev)
> > >  		return -ENOMEM;
> > >  	gdev->dev.bus = &gpio_bus_type;
> > 
> > As you can see by my post on the GPIO mailing list, a boot failure
> > was occurring on the Dragonboard 410C:
> > http://permalink.gmane.org/gmane.linux.kernel.gpio/14360
> > 
> > With the above patch the board now boots. Good catch.
> 
> Yup fixes the issue for me too.

Linus-

Here's a properly cooked patch.  Otherwise, feel free to squash it in if
it's easier for you.

  Josh

-- 8< --
Subject: [PATCH] gpio: use kzalloc to allocate gpio_device

The use of kmalloc() to allocate the gpio_device leaves the contained struct
device object in an unknown state.  Calling dev_set_name() on a struct device
of unknown state can trigger the free() of an invalid pointer, as seen in the
following backtrace (collected by Tony Lindgren):

  kfree
  kobject_set_name_vargs
  dev_set_name
  gpiochip_add_data
  omap_gpio_probe
  platform_drv_probe
  ...

Reported-by: Michael Welling <mwelling@ieee.org>
Reported-by: Tony Lindgren <tony@atomide.com>
Tested-by: Michael Welling <mwelling@ieee.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d8511cd..59f0045 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -435,7 +435,7 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
 	 * First: allocate and populate the internal stat container, and
 	 * set up the struct device.
 	 */
-	gdev = kmalloc(sizeof(*gdev), GFP_KERNEL);
+	gdev = kzalloc(sizeof(*gdev), GFP_KERNEL);
 	if (!gdev)
 		return -ENOMEM;
 	gdev->dev.bus = &gpio_bus_type;
-- 
2.7.0

