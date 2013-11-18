From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] input: touchscreen: fix spelling mistake in
 TSC/ADC DT binding
Date: Mon, 18 Nov 2013 11:40:29 +0000
Message-ID: <20131118114029.GD30853@e106331-lin.cambridge.arm.com>
References: <1382386404-6659-1-git-send-email-balbi@ti.com>
 <1382386404-6659-2-git-send-email-balbi@ti.com>
 <52663A58.9070706@linutronix.de>
 <20131022120253.GD9340@gimli>
 <20131114111958.GG16396@e106331-lin.cambridge.arm.com>
 <20131114155404.GE15835@saruman.home>
 <20131115155540.GF24831@e106331-lin.cambridge.arm.com>
 <20131115175356.GJ4698@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131115175356.GJ4698@saruman.home>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "rob@landley.net" <rob@landley.net>, "bcousson@baylibre.com" <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 15, 2013 at 05:53:56PM +0000, Felipe Balbi wrote:
> Hi,
>=20
> On Fri, Nov 15, 2013 at 03:55:40PM +0000, Mark Rutland wrote:
> > > > > > > diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/=
drivers/input/touchscreen/ti_am335x_tsc.c
> > > > > > > index e1c5300..b61df9d 100644
> > > > > > > --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > > > > +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > > > > @@ -348,9 +348,16 @@ static int titsc_parse_dt(struct pla=
tform_device *pdev,
> > > > > > >  	if (err < 0)
> > > > > > >  		return err;
> > > > > > > =20
> > > > > > > -	err =3D of_property_read_u32(node, "ti,coordiante-reado=
uts",
> > > > > > > +	/*
> > > > > > > +	 * try with new binding first. If it fails, still try w=
ith
> > > > > > > +	 * bogus, miss-spelled version.
> > > > > > > +	 */
> > > > > > > +	err =3D of_property_read_u32(node, "ti,coordinate-reado=
uts",
> > > > > > >  			&ts_dev->coordinate_readouts);
> > > > > > >  	if (err < 0)
> > > > > > > +		err =3D of_property_read_u32(node, "ti,coordiante-read=
outs",
> > > > > > > +				&ts_dev->coordinate_readouts);
> > > > > > > +	if (err < 0)
> > > > > > >  		return err;
> > > > > >=20
> > > > > > Thanks, very good. Do we keep this fallback for ever or jus=
t for a year
> > > > > > or two?
> > > > >=20
> > > > > That's for DT maintainers to decide but considering DT is an =
ABI, I
> > > > > guess we need to keep for 30 years or so :-p
> > > >=20
> > > > We keep it as long as we have to. If no-one's relying on the ty=
po by the
> > > > next merge window, I see no reason we'd have to keep support fo=
r the
> > >=20
> > > and how could you know that ? considering it's an ABI, how could =
you
> > > ever know that ?
> >=20
> > If you know that the only user of a binding is a dts for a particul=
ar
> > product that you're in charge of, then you'd know the set of kernel=
 +
> > dtb combinations out there, and can judge.
>=20
> once the binding has made into mainline, it's next to impossible to
> figure out who has downloaded a tarball containing that driver and ma=
de
> a product out of it.
>=20
> Besides keeping that check in the driver won't hurt at all in the lon=
g
> run. I would give it at least until 4.0 before thinking about removin=
g,
> and that might still not be enough time.

That sounds sensible to me. As mentioned before I'd recommend adding a
warning for the typo now in the (possibly na=C3=AFve) hope that it will
encourage people to fix up their dts early.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
