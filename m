From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] PWM: Add support for configuring polarity of PWM
Date: Mon, 23 Jul 2012 21:52:49 +0200
Message-ID: <20120723195249.GA7526@avionic-0098.mockup.avionic-design.de>
References: <1342616053-7793-1-git-send-email-avinashphilip@ti.com>
 <20120723083032.GA12868@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E97189D@DBDE01.ent.ti.com>
 <20120723130825.GA21254@avionic-0098.mockup.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E971AE3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <518397C60809E147AF5323E0420B992E3E971AE3@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
List-Id: linux-omap@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2012 at 03:05:26PM +0000, Philip, Avinash wrote:
> On Mon, Jul 23, 2012 at 18:38:25, Thierry Reding wrote:
> > On Mon, Jul 23, 2012 at 12:51:11PM +0000, Philip, Avinash wrote:
> > > On Mon, Jul 23, 2012 at 14:00:32, Thierry Reding wrote:
> > > > On Wed, Jul 18, 2012 at 06:24:13PM +0530, Philip, Avinash wrote:
> > > > >  /*
> > > > >   * pwm_enable - start a PWM output toggling
> > > > >   */
> > > > > @@ -37,6 +47,7 @@ struct pwm_chip;
> > > > >  enum {
> > > > >  	PWMF_REQUESTED =3D 1 << 0,
> > > > >  	PWMF_ENABLED =3D 1 << 1,
> > > > > +	PWMF_POLARITY_INVERSE =3D 1 << 2,
> > > >=20
> > > > This should be named PWMF_POLARITY_INVERSED for consistency.
> > >=20
> > > Ok I will correct it.
> > >=20
> > > > I'm not sure that we really need this flag, though. It isn't used a=
nywhere. But
> > > > maybe you have a use-case in mind?
> > >=20
> > > It can be used to find the polarity of the PWM at runtime.
> >=20
> > Yes, but is there any use-case where this information would be required?
>=20
> It's been added as a feature enhancement. May be it can ignore?

I think it can be removed for now. It can be added back if we ever
really need it.

Thierry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQDauRAAoJEN0jrNd/PrOhwcQP/3J067EyClDkSQgxPQqma6VG
wTnFT1bIcjKoM55/PuNmrB3+mSiPaKU7S6onxAFrowz9yUFYjU46U1V3dr1lEOEj
3Y0Ho+ksbIOYeA3oHUTElHj0V4JJRtCnHcUCGJY5OCJI6UZBr6fS0/sPQEEHHfec
oe+LFz3C9VPZxE12G1L2EvaXZQPAUOXMb5rUJBVRRx0b62++i/75cisIUe9N1LKm
WZBtCzV+ayMEcP/MXr7abtxeXdyF3QzOdSycLfTr15e12w+iGEmJrJeZwXUjOHfD
J9Xvg1IRnwLIFBqJkHG0dy20ojETqvaSfpcGxlCcN0XppxFtMMc7L2qY5KE8GMm0
Qv7WC+11gjG3EqRDOHzKhJZxgJi6QGn261Aa4nEzZIKqy8qoX98XuRWlrssRgByS
C0qETcvxluTsDBPy4Tzma3aIiWzuu3OqzHpLuqNgedMBpmyqdZkB7cQdxSc6+NFx
B8d6GyWmC5A6wzM8osZAzBOJtLYKpxxPVHQBZyrwHAQNs9mIi2wMrcfNnMqSDBOZ
s5Ls2Ygy8YcuKpf2gu5J1Wv1zm/Tx6VdviKEth+z4jjrV4ZC8RI3TnjonC7wCqYa
KBOsogoIk/xupisy6fwnw1NvOzXBj6wJgKUXznGGG11L7ZWX6YWX7dHEVxUDhIzY
qKXr3lN17euyV7syE8SE
=Nolu
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
