From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Wed, 23 Dec 2015 13:52:45 +0100
Message-ID: <1450875165.2648.7.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-5-git-send-email-contact@paulk.fr>
	 <20151223115632.GS16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-XLQwfScQ/NojBFJkcsRx"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151223115632.GS16023@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Milo Kim <milo.kim@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-XLQwfScQ/NojBFJkcsRx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 23 d=C3=A9cembre 2015 =C3=A0 11:56 +0000, Mark Brown a =C3=A9cr=
it :
> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
>=20
> > +	gpio =3D lp->pdata->enable_gpio;
> > +	if (!gpio_is_valid(gpio))
> > +		return 0;
> > +
> > +	/* Always set enable GPIO high. */
> > +	ret =3D devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP=
872X EN");
> > +	if (ret) {
> > +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> > +		return ret;
> > +	}
>=20
> This isn't really adding support for the enable GPIO as the changelog
> suggests, it's requesting but not managing the GPIO.  Since there is
> core support for manging enable GPIOs this seems especially silly,
> please tell the core about the GPIO and then it will work at runtime
> too.

You're right, I had clearly overlooked this, thanks for pointing it out.
Will send v2 using GPIO handling from core.

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-XLQwfScQ/NojBFJkcsRx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWepkeAAoJEIT9weqP7pUMuDsP/0alAJgTvGF6ghwMJLMhulJy
dhAUXr302bxZPMmFpjAir42dLv617bgfNzLmLH30MGgtpb25e8sOvnJJQZz+MRRH
Rgr/yhLOnWn/gLSvwEiTx/AywrG5/dgTQvS0xnzr6A6XY5HoIuaDReHuVXIhrJDK
tekMct8IpzlalU3ttUGsvBfoSwbW3J7n6+O0A3LNzxYxa7Hl0FQaXOQzE4ijbuJ9
f+Wf6lamk9HC5bdqFpEXFqq+SjPHIEGK86BGbl2Qwn7uf3sMEKI3NK96QnonumQl
Kztl4LX9CY9N0n6zjLv10gxpsbWi8pXa8D9yOUilI/hsrW0PwpGBJySVH1HaWUdl
+Gy3XF10ge8B1cU0QateqMVM3DkF+JcQpJM23QmShWCRfM27EgR1cyRmkjqXyxVp
XzAZF5JCf9DoIlqbqGt4RBeC8O8wwU9mHwYiT9018+33QRMpTHYgSns+5B0lZ/EH
JV5DXnrxgYu3eTO768eUHhcAcBbGAAcxGGtTuhYsuyDXei86VzSCDrEHNeWWjRs6
+MwSLHY67thAyxGyA1hVM+HghG8wILcd15ju2kNsJ2wySICwfJ2vzE387S3Rhk+i
233vWPDO7eXVS4EsN/XQGqBVdM6r78MSssshycKyZAhJGt7qw8BuyMeSzvRKTRLJ
72yADobRhcbAfr9cFcTx
=BqzR
-----END PGP SIGNATURE-----

--=-XLQwfScQ/NojBFJkcsRx--
