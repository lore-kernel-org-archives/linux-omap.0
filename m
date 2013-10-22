From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] input: touchscreen: fix spelling mistake in TSC/ADC
 DT binding
Date: Tue, 22 Oct 2013 07:02:53 -0500
Message-ID: <20131022120253.GD9340@gimli>
References: <1382386404-6659-1-git-send-email-balbi@ti.com>
 <1382386404-6659-2-git-send-email-balbi@ti.com>
 <52663A58.9070706@linutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52663A58.9070706@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, dmitry.torokhov@gmail.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 22, 2013 at 10:42:00AM +0200, Sebastian Andrzej Siewior wrote:
> On 10/21/2013 10:13 PM, Felipe Balbi wrote:
> > diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/=
touchscreen/ti_am335x_tsc.c
> > index e1c5300..b61df9d 100644
> > --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> > +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> > @@ -348,9 +348,16 @@ static int titsc_parse_dt(struct platform_device *=
pdev,
> >  	if (err < 0)
> >  		return err;
> > =20
> > -	err =3D of_property_read_u32(node, "ti,coordiante-readouts",
> > +	/*
> > +	 * try with new binding first. If it fails, still try with
> > +	 * bogus, miss-spelled version.
> > +	 */
> > +	err =3D of_property_read_u32(node, "ti,coordinate-readouts",
> >  			&ts_dev->coordinate_readouts);
> >  	if (err < 0)
> > +		err =3D of_property_read_u32(node, "ti,coordiante-readouts",
> > +				&ts_dev->coordinate_readouts);
> > +	if (err < 0)
> >  		return err;
>=20
> Thanks, very good. Do we keep this fallback for ever or just for a year
> or two?

That's for DT maintainers to decide but considering DT is an ABI, I
guess we need to keep for 30 years or so :-p

--=20
balbi

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSZmltAAoJEIaOsuA1yqRERcIQAKOJhR2abNPihxEOg0lnKb7O
f/8UI3L7RdHadFGBzjP5pxZ2BIwdc78ro9MNwlEeQV61etvnLSjqbGvQv5yuulR3
HtkIWltn/ILlUSb0tTXecxlN53EyTpRw0d+uFSsv4r/Op1HLBxt39W0Uv8GajQfO
4cAGhWELOOt3u8/rHE/zG4dBhAXwJ/HNIakebOAoXmyworZLvGxf0xLCVpFopYKB
EHw8wJDK6CEiV+SeZOzToelAkTYbCdqNRdwFdXpufRWkYRBvan+1bFW9fkW3FscM
kab3YZpO9DkV4mZvGaF45mfwo+6VhHEnYWz0fsdc1jdLoe0eiZMHrsPrTDpFB4+j
+wC4ToBzEgOJPn6QG0pcgztzbIRXsPVi7/y8kXzyrfG/IGncfFrt+Cm6roxq886g
4qLjc6zdQtrnhb2xOO8OriPbxptJULzUyst/dzPYGhCAfLCR8VMI70dMrvKLtOaj
DvbYVWuZsUu+ODFvDD5XWQgxfCXm8vaqbUGX12XUtbKGiraJP5RfT4yShM8j5wbH
Kc2XSklu3r8tsZVzx9UcHVcxiovX9k2Q2mIgqm9d84RnWsPKjff0oNl7fsnabnvl
v1JN5kNvf7SfXJJY6ayBm4QkJDqWhRwSuuvooHpdivavMqz+22Gr9UKt59NnbzH+
APDN6p1u/zPmn58sCtAq
=C9jL
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
