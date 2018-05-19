From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO
	lookup table
Date: Sat, 19 May 2018 23:55:51 +0200
Message-ID: <5456625.lDWjtgZygK@z50>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <3427199.r4OBoDP6Xz@z50>
 <CAHp75VcUxjubx=zOGyCjmpjCk5RBLPCaHcaOieDie9LdTCa+5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAHp75VcUxjubx=zOGyCjmpjCk5RBLPCaHcaOieDie9LdTCa+5g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-fbdev@vger.kernel.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Richard Weinberger <richard@nod.at>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-input <linux-input@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Saturday, May 19, 2018 8:00:38 PM CEST Andy Shevchenko wrote:
> On Sat, May 19, 2018 at 2:15 AM, Janusz Krzysztofik <jmkrzyszt@gmail.com> 
wrote:
> > On Friday, May 18, 2018 11:21:14 PM CEST Andy Shevchenko wrote:
> >> On Sat, May 19, 2018 at 12:09 AM, Janusz Krzysztofik
> >> 
> >> <jmkrzyszt@gmail.com> wrote:
> >> > +       gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy",
> >> > GPIOD_IN);
> >> > +       if (!IS_ERR_OR_NULL(gpiod_rdy)) {
> >> 
> >> So, is it optional or not at the end?
> >> If it is, why do we check for NULL?
> > 
> > As far as I can understand, nand_chip->dev_ready() callback is optional.
> > That's why I decided to use the _optional variant of devm_gpiod_get(). In
> > case of ams-delta, the dev_ready() callback depends on availability of
> > the 'rdy' GPIO pin. As a consequence, I'm checking for both NULL and ERR
> > in order to decide if dev_ready() will be supported.
> > 
> > I can pretty well replace it with the standard form and check for ERR only
> > if the purpose of the _optional form is different.
> 
> NULL check in practice discards the _optional part of gpiod_get(). So,
> either you use non-optional variant and decide how to handle an
> errors, or user _optional w/o NULL check.

OK, I'm going to use something like the below while submitting v2:

-	gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
-	if (!IS_ERR_OR_NULL(gpiod_rdy)) {
-		this->dev_ready = ams_delta_nand_ready;
-	} else {
-		this->dev_ready = NULL;
-		pr_notice("Couldn't request gpio for Delta NAND ready.\n");
+	priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy",
+						  GPIOD_IN);
+	if (IS_ERR(priv->gpiod_rdy)) {
+		err = PTR_ERR(priv->gpiod_nwp);
+		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
+		goto err_gpiod;
 	}
 
+	if (priv->gpiod_rdy)
+		this->dev_ready = ams_delta_nand_ready;

> 
> >> > +err_gpiod:
> >> > +       if (err == -ENODEV || err == -ENOENT)
> >> > +               err = -EPROBE_DEFER;
> >> 
> >> Hmm...
> > 
> > Amstrad Delta uses gpio-mmio driver. Unfortunatelty that driver is not
> > availble before device init phase, unlike other crucial GPIO drivers which
> > are initialized earlier, e.g. during the postcore or at latetst the
> > subsys phase. Hence, devices which depend on GPIO pins provided by
> > gpio-mmio must either be declared late or fail softly so they get another
> > chance of being probed succesfully.
> > 
> > I thought of replacing the gpio-mmio platform driver with bgpio functions
> > it exports but for now I haven't implemented it, not even shared the
> > idea.
> > 
> > Does it really hurt to return -EPROBE_DEFER if a GPIO pin can't be
> > obtained?
> I'm only concerned if it would be an infinite defer in the case when
> driver will never appear.
> But I don't remember the details.

Deferred probes are handled effectively during late_initcall, no risk of 
infinite defer, see drivers/base/dd.c for details.

Thanks,
Janusz
