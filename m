From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCHv4] media: i2c/adp1653: devicetree support for adp1653
Date: Fri, 3 Apr 2015 10:21:29 +0200
Message-ID: <20150403082129.GA10671@amd>
References: <20150402143846.GA11687@amd>
 <20150402203417.GA6336@amd>
 <CABxcv=nfg_D9HvXUd4PBFJ5a1XST=PCDEZCjkTtbu_u7cc1+ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABxcv=nfg_D9HvXUd4PBFJ5a1XST=PCDEZCjkTtbu_u7cc1+ug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, sakari.ailus-X3B1VOXEql0@public.gmane.org, m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> > Fixed feedback by Sakari.
> >
> > Please apply,
> 
> There is no need to ask for patches to be applied IMHO. It is expected
> that people post patches wanting them to be applied unless there is an
> RFC prefix in the subject or say explicitly that the patch is for
> testing and should not be picked.

See history of this patch.

> > diff --git a/Documentation/devicetree/bindings/media/i2c/adp1653.txt b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> 
> When adding DT bindings, the Documentation portion should be in a
> separate patch and should come in the series before the patch
> implementing the binding. That makes the change easier to review,
> please take a look to points 1 and 3 in
> Documentation/devicetree/bindings/submitting-patches.txt.

Because actual patch at the end of email is too much eye clutter for
the poor device tree people, I can prepare nice series... producing
more work for me and more noise on the lists? No, thanks.

> > +Required Properties:
> > +
> > +  - compatible: Must contain be "adi,adp1653"
> > +
> > +  - reg: I2C slave address
> > +
> > +  - gpios: References to the GPIO that controls the power for the chip.
> 
> The convention nowadays is to not use unnamed DT properties for GPIOs
> but instead use a prefix that explains what those GPIOs are used for.
> So something like "power-gpios" or "power-gpio" (if there is only one
> GPIO) will be more suitable. Please take a look to
> Documentation/gpio/board.txt for more details.

Ok. Actually, reading docs below, "power-gpio" will not work, and it
needs to be "power-gpios", right?

> > +       if (!of_find_property(node, "gpios", NULL)) {
> > +               dev_err(&client->dev, "No gpio node\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       pd->power_gpio = of_get_gpio_flags(node, 0, &flags);
> 
> The old integer-based GPIO interface is deprecated and we want to get
> rid of it so please use the descriptor-based for new code. For example
> you want to use gpiod_get() instead of of_get_gpio_flags().
> Documentation/gpio/gpio.txt describes the new interface.

Ok.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
