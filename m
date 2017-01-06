From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv3] mfd: cpcap: Add minimal support
Date: Thu, 5 Jan 2017 16:08:23 -0800
Message-ID: <20170106000823.GB2630@atomide.com>
References: <20161206004856.11996-1-tony@atomide.com>
 <20170103163515.GM2977@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170103163515.GM2977@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [170103 08:32]:
> On Mon, 05 Dec 2016, Tony Lindgren wrote:
> > +static int cpcap_init_irq_chip(struct cpcap_ddata *cpcap, int irq_chip,
> > +			       int irq_start, int nr_irqs)
> > +{
> > +	struct regmap_irq_chip *chip = &cpcap_irq_chip[irq_chip];
> > +	int i, ret;
> > +
> > +	for (i = irq_start; i < irq_start + nr_irqs; i++) {
> > +		struct regmap_irq *cpcap_irq = &cpcap->irqs[i];
> > +
> > +		cpcap_irq->reg_offset =
> > +			((i - irq_start) / cpcap->regmap_conf->val_bits) *
> > +			cpcap->regmap_conf->reg_stride;
> > +		cpcap_irq->mask = BIT(i % cpcap->regmap_conf->val_bits);
> 
> If a code segment takes more than a few seconds to work out, it's
> either too cluttered (break it down), too complex (simplify it) or if
> neither of the first two approaches are possible, then a comment is
> required.

Hmm yeah I could not read that myself any longer :) Will split.

> > +static int cpcap_probe(struct spi_device *spi)
> > +{
> > +	const struct of_device_id *match;
> > +	int ret = -EINVAL;
> 
> What is the purpose of initialising ret?

Seems to be not needed.

> > +	struct cpcap_ddata *cpcap;
> > +
> > +	match = of_match_device(of_match_ptr(cpcap_of_match), &spi->dev);
> > +	if (!match)
> > +		return -ENODEV;
> > +
> > +	cpcap = devm_kzalloc(&spi->dev, sizeof(*cpcap), GFP_KERNEL);
> > +	if (!cpcap)
> > +		return -ENOMEM;
> > +
> > +	cpcap->spi = spi;
> > +	spi_set_drvdata(spi, cpcap);
> > +
> > +	spi->bits_per_word = 16;
> > +	spi->mode = SPI_MODE_0 | SPI_CS_HIGH;
> > +
> > +	ret = spi_setup(spi);
> > +	if (ret < 0)
> > +		return ret;
> 
> Is it possible for spi_setup() to return >0?
> 
> If not, then "if (!ret)" will do.

You're right, the kerneldoc for spi_setup() says:

"Return: zero on success, else a negative error code."

Need to use "if (ret)" to return on error though, not "if (!ret)".

> > +static struct spi_driver cpcap_driver = {
> > +	.driver = {
> > +		.name = "cpcap-core",
> > +		.of_match_table = cpcap_of_match,
> 
> of_match_ptr() ?

Well there needs to be a platform specific init added at least in some
cases. I have not quite yet deciphered what all it does for droid 4
as it's already done for kexec based booting.

> > + * Copyright (C) 2016 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>.
> 
> Actually, it's more traditional to place the CR at the top.

Sure. Will repost v4 shortly.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
