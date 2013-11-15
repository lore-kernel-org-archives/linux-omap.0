From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] input: touchscreen: fix spelling mistake in TSC/ADC
 DT binding
Date: Fri, 15 Nov 2013 11:53:56 -0600
Message-ID: <20131115175356.GJ4698@saruman.home>
References: <1382386404-6659-1-git-send-email-balbi@ti.com>
 <1382386404-6659-2-git-send-email-balbi@ti.com>
 <52663A58.9070706@linutronix.de>
 <20131022120253.GD9340@gimli>
 <20131114111958.GG16396@e106331-lin.cambridge.arm.com>
 <20131114155404.GE15835@saruman.home>
 <20131115155540.GF24831@e106331-lin.cambridge.arm.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbA9xpzOQlG26JSn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55221 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab3KORyf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Nov 2013 12:54:35 -0500
Content-Disposition: inline
In-Reply-To: <20131115155540.GF24831@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "rob@landley.net" <rob@landley.net>, "bcousson@baylibre.com" <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--IbA9xpzOQlG26JSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 15, 2013 at 03:55:40PM +0000, Mark Rutland wrote:
> > > > > > diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/driver=
s/input/touchscreen/ti_am335x_tsc.c
> > > > > > index e1c5300..b61df9d 100644
> > > > > > --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > > > +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > > > @@ -348,9 +348,16 @@ static int titsc_parse_dt(struct platform_=
device *pdev,
> > > > > >  	if (err < 0)
> > > > > >  		return err;
> > > > > > =20
> > > > > > -	err =3D of_property_read_u32(node, "ti,coordiante-readouts",
> > > > > > +	/*
> > > > > > +	 * try with new binding first. If it fails, still try with
> > > > > > +	 * bogus, miss-spelled version.
> > > > > > +	 */
> > > > > > +	err =3D of_property_read_u32(node, "ti,coordinate-readouts",
> > > > > >  			&ts_dev->coordinate_readouts);
> > > > > >  	if (err < 0)
> > > > > > +		err =3D of_property_read_u32(node, "ti,coordiante-readouts",
> > > > > > +				&ts_dev->coordinate_readouts);
> > > > > > +	if (err < 0)
> > > > > >  		return err;
> > > > >=20
> > > > > Thanks, very good. Do we keep this fallback for ever or just for =
a year
> > > > > or two?
> > > >=20
> > > > That's for DT maintainers to decide but considering DT is an ABI, I
> > > > guess we need to keep for 30 years or so :-p
> > >=20
> > > We keep it as long as we have to. If no-one's relying on the typo by =
the
> > > next merge window, I see no reason we'd have to keep support for the
> >=20
> > and how could you know that ? considering it's an ABI, how could you
> > ever know that ?
>=20
> If you know that the only user of a binding is a dts for a particular
> product that you're in charge of, then you'd know the set of kernel +
> dtb combinations out there, and can judge.

once the binding has made into mainline, it's next to impossible to
figure out who has downloaded a tarball containing that driver and made
a product out of it.

Besides keeping that check in the driver won't hurt at all in the long
run. I would give it at least until 4.0 before thinking about removing,
and that might still not be enough time.

--=20
balbi

--IbA9xpzOQlG26JSn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJShl+0AAoJEIaOsuA1yqREofcP/jU5i67IMZOBLdbk9/C68m96
TsdwClJC+pfUEV3gJP1wufJS/2xeCm4kEupFlmkJbmrrW7fZaPrf0n1NFdCX/jvA
IV7QKMkprzcyjB+QGUvEy11VJs332fH3j/BMej9rbPiOHU+toZPnRdvWbRwzqzrm
zQIN+tKW61NhhKYopg9wQ+4vuFQJ9z2WvEdpjyknyzGiUnjfKbcmD/4Hy3TSoqg1
CIyAI2+//q5AiW0lePFMmffeFUjf/VKTwENRW/CjVoO/vwQjX426OCAfn63edQwS
COQU0/DdJXQG3hqkXsAL0rgfZZu/bE+K4RuYwsW+G6i7JEI6lkfU/1ozzXgbk/fl
G/3q29PQjQiQwIQftRwSkeQsRtTyvYeOmaYw5I4J08Oz7FYOnzgLV2hufvfZzjy6
sGHWROg89Djhqjf9UQCTTETE1sbDbKDIoRn0FBzcNqHmvf7I2UrXPqfiKcgjM2Kd
VlX8gMeF+9KakuPRDw0ctoX1GLw3IYPndZdchT6KU8pzgvVZM6qU65OPefWw86zS
y6hiOaSy6s5qQ2tU9Xibjb310puS9H/wOu3MzE5nyoiR5lwvtIs/UjcT1Ytwd8sq
2xnngWLeSNdEZ8kB0P/RJduYf1SOhGf1LmTM8QdhXDdSKqtVyTdpxOrHVGgqOe4M
rDgxjzC/+VsbldCG0cxt
=jkgP
-----END PGP SIGNATURE-----

--IbA9xpzOQlG26JSn--
