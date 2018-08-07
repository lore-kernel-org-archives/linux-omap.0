From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays with direct mapping
Date: Tue, 07 Aug 2018 19:19:57 +0200
Message-ID: <5726821.9hm6pNmUJb@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-10-jmkrzyszt@gmail.com> <20180807191420.04431e8e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807191420.04431e8e@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday, August 7, 2018 7:14:20 PM CEST Boris Brezillon wrote:
> On Tue,  7 Aug 2018 00:29:15 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Certain GPIO array lookup results may map directly to GPIO pins of a
> > single GPIO chip in hardware order.  If that condition is recognized
> > and handled efficiently, significant performance gain of get/set array
> > functions may be possible.
> > 
> > While processing a request for an array of GPIO descriptors, verify if
> > the descriptors just collected represent consecutive pins of a single
> > GPIO chip.  Pass that information with the array to the caller so it
> > can benefit from enhanced performance as soon as bitmap based get/set
> > array functions which can make efficient use of that are available.
> > 
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > ---
> >  Documentation/driver-api/gpio/consumer.rst |  4 +++-
> >  drivers/gpio/gpiolib.c                     | 14 ++++++++++++++
> >  include/linux/gpio/consumer.h              |  1 +
> >  3 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
> > index aa03f389d41d..38a990b5f3b6 100644
> > --- a/Documentation/driver-api/gpio/consumer.rst
> > +++ b/Documentation/driver-api/gpio/consumer.rst
> > @@ -109,11 +109,13 @@ For a function using multiple GPIOs all of those can be obtained with one call::
> >  					   enum gpiod_flags flags)
> >  
> >  This function returns a struct gpio_descs which contains an array of
> > -descriptors::
> > +descriptors.  It may also contain a valid descriptor of a single GPIO chip in
> > +case the array strictly matches pin hardware layout of the chip::
> >  
> >  	struct gpio_descs {
> >  		unsigned int ndescs;
> >  		struct gpio_desc *desc[];
> > +		struct gpio_chip *chip;
> 
> chip is placed at the beginning of the struct in the real code, which
> is expected since putting it at the end won't work because of the
> desc[] declaration.

Yes, I've already noticed that and will fix on next iteration, thanks.

Janusz
