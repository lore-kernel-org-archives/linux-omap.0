From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Tue, 24 Sep 2013 08:27:03 -0700
Message-ID: <20130924152703.GL2684@atomide.com>
References: <1379860848-29020-1-git-send-email-javier.martinez@collabora.co.uk>
 <CACRpkdb35DouKsZ+9aWfQmER1vmAaK1dR7VXjoFHTLRR+hBezg@mail.gmail.com>
 <524125F4.4060608@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <524125F4.4060608@collabora.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Balaji T K <balajitk@ti.com>, Jon Hunter <jgchunter@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [130923 22:49]:
> On 09/23/2013 10:15 PM, Linus Walleij wrote:
> > <javier.martinez@collabora.co.uk> wrote:
> > - When a second caller calls omap_gpio_request() it should
> >   be OK as well, but only if the flags corresponds to the
> >   previously enabled input mode. Else it should be
> >   disallowed.
> > 
> > - The same should happen for _set_gpio_direction() if a pin
> >   previously set up for IRQ gets a request to be used as
> >   output.
> > 
> > If this cannot be tracked in the driver, it is certainly a candidate
> > for something that gpiolib should be doing. And then I'm open to
> > solutions to how we can do that.
> > 
> 
> Ok, this can be tracked in the driver, will add it when posting v2 soon.
> 
> > If this needs to be applied pronto to fix the regression I'm
> > happy with that too, if we add a big boilerplate stating the above
> > problem and that it needs to be *fixed* at some point.

In the mainline kernel, the regression is happening at least for
smsc911x using boards, so that's omap3-igep.dtsi and omap3-tobi.dts
currently. Also MMC card detection for omap4 is failing. Then
of course there are tons of boards where we don't have the .dts
files in the mainline kernel yet.

So maybe let's do a minimal fix for the -rc cycle first?

Then the extra checks can be queued for the next merge window
if it gets too intrusive.

> > But in either case I want this to be tested on OMAP1 before
> > I apply it, as in a Tested-by tag.
> >
> 
> Agreed. Even though this is a fix for a long standing issue I prefer it to be
> tested extensively than applying the patch in a rush just to learn that causes
> regressions and have to be reverted as it happens last time.
> 
> So as you said let's wait until we have a few Tested-by tags by people using
> different OMAP platforms specially OMAP1.

Yup.

Regards,

Tony
