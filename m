From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB Ethernet gadget on Nokia n900
Date: Sun, 19 Oct 2014 10:24:14 -0500
Message-ID: <20141019152414.GB5189@saruman>
References: <20141019090107.GA19132@amd>
 <20141019100739.GA2547@amd>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141019100739.GA2547@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, balbi@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 19, 2014 at 12:07:39PM +0200, Pavel Machek wrote:
> On Sun 2014-10-19 11:01:07, Pavel Machek wrote:
> > Hi!
> >=20
> > From 3.6 to 3.10, USB networking works on Nokia N900. With 3.11, it
> > fails with messages on the host. I also tried to get it to work on
> > 3.14 and 3.17, with no luck.
> >=20
> > Any ideas? Does it work for you? Any config options to watch for?
>=20
> With 3.17, I get
>=20
> omap_musb_mailbox: musb core is not yet ready
>=20
> message. It looks related...?

is musbmhdrc.ko loaded ? Do you have a gadget driver loaded ?

+ Aaro

--=20
balbi

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUQ9edAAoJEIaOsuA1yqREI6kP/06GBgb3/0MUxfCFxcoaPEVP
JHkAtUhbayh5oilurv+16VD9TnKxIeTCsAW/bRUUNgVJW7qSMLbgX5H3rinymP3j
04ig08cML7yDns2RH8ChtwsyVFvLGmXgI+pYerTigZ5qmunYdvkz6Q1Hxc2vqaN7
XMgLtDHrnUWj8RsJZYrI3q7GFedViQbJF2DR96ItUL67mLQWKykrr87Vt8bZxMem
SUFESYkb01dcze/npgtFfqWeMbmx0cmkGMdWAIHbrQnsHx9G9WYV4pWxsKqo09Hl
PUAZm9mcKy+t9norUG1k4rK0HEhytMyX+Oc06P8CXHXerTm+lvwU765WHtsooKs5
cQBH4Mayq64d4me3gZWBW4BoLKY+itptwARgAUoTWadHZEH4f0v62PpSweGtbSkN
r97r+9vxDvM6TBwdnBC5/n1dREHkfS0gh5Hk+lwlzMj2SwL43kICsJ0rxddXlZyR
TErFC8AW7Acmj90/YnvJ0MBIqX8orAiniaGZJrWLdG0Ve/FzwfP6L4hqIPKkpd4C
xB0b1NBc+qfrdEmuYTqR6sZOQeHtdu1+jFEgG4ilglVB/otp1/CkzPHxnZMrYZYG
tl6z/kIqpOgzXWdyjc1yoGzOJnL+V1EBoy52tMeWTc1h4ZcutVNjjzcqQbj48omt
352a7PsS3+8NjIiknYWn
=JRre
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
