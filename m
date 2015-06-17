From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] i2c: omap: improve duty cycle on SCL
Date: Wed, 17 Jun 2015 13:00:52 -0500
Message-ID: <20150617180052.GF18421@saruman.tx.rr.com>
References: <1434482445-1818-1-git-send-email-balbi@ti.com>
 <55813BA0.3010001@nokia.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53142 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754538AbbFQSDx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 14:03:53 -0400
Content-Disposition: inline
In-Reply-To: <55813BA0.3010001@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: ext Felipe Balbi <balbi@ti.com>, wsa@the-dreams.de, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 17, 2015 at 11:19:28AM +0200, Alexander Sverdlin wrote:
> > With this patch we try to be as close to 50%
> > duty cycle as possible. The reason for this
> > is that some devices present an erratic behavior
> > with certain duty cycles.
> >=20
> > One such example is TPS65218 PMIC which fails
> > to change voltages when running @ 400kHz and
> > duty cycle is lower than 34%.
> >=20
> > The idea of the patch is simple:
> >=20
> > calculate desired scl_period from requested scl
> > and use 50% for tLow and 50% for tHigh.
> >=20
> > tLow is calculated with a DIV_ROUND_UP() to make
> > sure it's slightly higher than tHigh and to make
> > sure that we end up within I2C specifications.
> >=20
> > Kudos to Nishanth Menon and Dave Gerlach for helping
> > debugging the TPS65218 problem found on AM437x SK.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> NAK.
> This is a direct violation of PHILIPS I2C-bus Specification v.2.1,
> section 15.
> Namely, you will have LOW period of SCL clock shorter than required
> 1.3uS.

how is this out of spec ?

http://i.imgur.com/jEDlZT7.png

-Width =3D 1.4us, frequency 373.1kHz, duty cycle of 47.76%

In any case, I have to send v2 anyway (found a bug which would show up
on frequencies above 400kHz), so I'll resend this patch.

--=20
balbi

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgbXUAAoJEIaOsuA1yqREDnAP/ibE31ymkjmebNvWrMNEFJNO
KjpGFO31XdQTrhxhMn6rHX20flv7hkCvZegcRBHa0gcNDhc084Ult+sYAyLh8xxZ
ZrR6+hA8VjNUmJJmlv4/7J4FAN1TJx9Wg6Edwyh8MdhE7Po0W7qyrWvbrtvie1sX
k8Ay7g2UddBqbj9ubh6op5YzHoscC2ONoHQiTfBoGA7O5HyPrE7Ap2SepB5bjJqB
T32Q+95QBjCADDbRBcTrLZ2gdyY0gfzV3S8BwEEW04SzE2Mhpme+gGfLNybrQDzF
7l3BWRzuPcexQcTHnPfbcPNc+gsQeSyNr2uzBFeAJYJ9ZieD1Xbkcx7SI4P2YPXT
8ts4idF3LMDWZ3VQWQbpePgSc7JaYZpP1ZuRrZdpdk9P8HfIxJUHHVWn1RAfJmCx
r2LQmxtnHNNc9BH2r9NQZ6prJq0sReCgDuXXAFIqVK8WQWMur5zVw0RPAXj8fcRJ
DMmR83AvmDHwzS4az3vEQbGnyR/9bpCyqlyTX0fI5e547KWuylTr1NNyomGv5ItV
md16Fp8Pt8MYEVihbW+s730OeUGpogeBJDxjTHyEiQIhFu2PJ5/YPqnTqoz+Qx7V
FCl1CE/2q6TKPrYSdiEPr47rX+Ojwr9y0b8cM5G5QGztH20EUC3Gq0T5MkxsORx3
2S4ifbsMacukmVSG3zbr
=eoos
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
