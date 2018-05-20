From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alsa-devel] [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO
 lookup table
Date: Sun, 20 May 2018 13:08:22 -0700
Message-ID: <20180520200822.GA119427@dtor-ws>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <3427199.r4OBoDP6Xz@z50>
 <CAHp75VcUxjubx=zOGyCjmpjCk5RBLPCaHcaOieDie9LdTCa+5g@mail.gmail.com>
 <5456625.lDWjtgZygK@z50>
 <20180520192705.GA12883@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180520192705.GA12883@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-fbdev@vger.kernel.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Richard Weinberger <richard@nod.at>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-input <linux-input@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sun, May 20, 2018 at 09:27:05PM +0200, Ladislav Michl wrote:
> On Sat, May 19, 2018 at 11:55:51PM +0200, Janusz Krzysztofik wrote:
> > On Saturday, May 19, 2018 8:00:38 PM CEST Andy Shevchenko wrote:
> > > On Sat, May 19, 2018 at 2:15 AM, Janusz Krzysztofik <jmkrzyszt@gmail.com> 
> > wrote:
> > > > On Friday, May 18, 2018 11:21:14 PM CEST Andy Shevchenko wrote:
> > > >> On Sat, May 19, 2018 at 12:09 AM, Janusz Krzysztofik
> > > >> 
> > > >> <jmkrzyszt@gmail.com> wrote:
> > > >> > +       gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy",
> > > >> > GPIOD_IN);
> > > >> > +       if (!IS_ERR_OR_NULL(gpiod_rdy)) {
> > > >> 
> > > >> So, is it optional or not at the end?
> > > >> If it is, why do we check for NULL?
> > > > 
> > > > As far as I can understand, nand_chip->dev_ready() callback is optional.
> > > > That's why I decided to use the _optional variant of devm_gpiod_get(). In
> > > > case of ams-delta, the dev_ready() callback depends on availability of
> > > > the 'rdy' GPIO pin. As a consequence, I'm checking for both NULL and ERR
> > > > in order to decide if dev_ready() will be supported.
> > > > 
> > > > I can pretty well replace it with the standard form and check for ERR only
> > > > if the purpose of the _optional form is different.
> > > 
> > > NULL check in practice discards the _optional part of gpiod_get(). So,
> > > either you use non-optional variant and decide how to handle an
> > > errors, or user _optional w/o NULL check.
> > 
> > OK, I'm going to use something like the below while submitting v2:
> > 
> > -	gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
> > -	if (!IS_ERR_OR_NULL(gpiod_rdy)) {
> > -		this->dev_ready = ams_delta_nand_ready;
> > -	} else {
> > -		this->dev_ready = NULL;
> > -		pr_notice("Couldn't request gpio for Delta NAND ready.\n");
> > +	priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy",
> > +						  GPIOD_IN);
> > +	if (IS_ERR(priv->gpiod_rdy)) {
> > +		err = PTR_ERR(priv->gpiod_nwp);
> ??? --------------------------------^^^^^^^^^
> > +		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
> > +		goto err_gpiod;
> 
> Driver will just use worst case delay instead of RDY signal, so this
> is perhaps too strict. I will work with degraded performance.

If RDY signal is not available then the board should not define it.
Degrading performance and having users wondering because RDY is
sometimes not available is not great. Especially if we get -EPROBE_DEFER
here.

Thanks.

-- 
Dmitry
