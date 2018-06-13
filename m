From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH 04/10] Input: ams_delta_serio: Replace power GPIO with regulator
Date: Wed, 13 Jun 2018 03:01:05 +0200
Message-ID: <2655614.ErW8VuCT6r@z50>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com> <20180609140224.32606-4-jmkrzyszt@gmail.com> <20180612221724.GB38773@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612221724.GB38773@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, "David S . Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday, June 13, 2018 12:17:24 AM CEST Dmitry Torokhov wrote:
> On Sat, Jun 09, 2018 at 04:02:18PM +0200, Janusz Krzysztofik wrote:
> > ...
> > +	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
> > +	if (IS_ERR(priv->vcc)) {
> > +		err = PTR_ERR(priv->vcc);
> > +		dev_err(&pdev->dev, "regulator request failed (%d)\n", err);
> > +		/* Fail softly if the regulator is not available yet */
> > +		if (err == -ENODEV)
> > +			err = -EPROBE_DEFER;
> 
> Hmm, if regulator is not ready yet, devm_regulator_get() should be
> returning -EPROBE_DEFER already, we should not have to convert -ENODEV
> to -EPROBE_DEFER...

Regulator is not ready because its initialization at subsys_initcall is 
deferred by not ready GPIO pin, that in turn is caused by gpio-mmio driver, 
unlike many other GPIO drivers, registered as late as at device_initcall.

I agree devm_regulator_get() could return -EPROBE_DEFER in this case, but I 
can see it does that only when of_get_regulator() indicates the regulator 
should exist. In non-dt case there is apparently no way to justify if it 
should unless its consumer supply table was already in place. For that,  
registration of that table would have to be independent of successful 
registration of the regulator itself while it's not. Maybe it should, but 
that's a separate topic for a separate discussion, I think.

> Is it because we have_full_constraints() returns false? You might need
> to add call to regulator_has_full_constraints() to your board file.

If have_full_constraints() returned true before the regulator or its consumer 
supply table is ready, devm_regulator_get() would happily return a dummy 
regulator and our keyboard would never get its power.

I'm afraid we have to live with that return code conversion as long as the 
only user of this driver is not migrated to dt.

Thanks,
Janusz
