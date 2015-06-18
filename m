From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3] i2c: omap: improve duty cycle on SCL
Date: Thu, 18 Jun 2015 12:25:58 -0500
Message-ID: <20150618172558.GC27790@saruman.tx.rr.com>
References: <1434569475-17378-1-git-send-email-balbi@ti.com>
 <55827CD7.7030207@nokia.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47064 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653AbbFRR25 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Jun 2015 13:28:57 -0400
Content-Disposition: inline
In-Reply-To: <55827CD7.7030207@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: ext Felipe Balbi <balbi@ti.com>, wsa@the-dreams.de, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 10:09:59AM +0200, Alexander Sverdlin wrote:
> Hello Felipe,
>=20
> On 17/06/15 21:31, ext Felipe Balbi wrote:
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
>=20
> if you refuse to change the calculations to achieve maximum possible
> bus rate (as I've shown you with SCLL=3D9 and SCLH=3D9), maybe you want to
> change the description? Because you are doing something else than is
> written here. You are only in spec because you are not doing 50% duty
> cycle. And you didn't mention here that you lower the bus speed below
> 400kHz to achieve this.

and there's a comment where the calculation goes which states "as close
to 50% as possible but we make sure tLow is higher than tHigh so we're
still within spec".

--=20
balbi

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgv8lAAoJEIaOsuA1yqREa3EQAJLH+CQ9fQ7cwb4o+PihHsRk
WzmeTKb3sXyfn+diF2KgFDdf/qicEBRvWEMD7I/lQNUn8b0VNO2VySXSH8P2dbCu
3a+wvZrjjQI/QdhOw9WUD9pgPI5JdZIDR3o8nfuaLupWaDoRKXPcCtE43EDnGlBD
ITilIsHL0siVrZPyyE38yThGYDKal5cZpMeeV0joQAxU6xN2Vlni5/u0SYku8Uiz
8dkJ7HDxAcyr0oAd35PM73OyZKBX1fH+lK3Xe2eTUjjwW/uaxKvVgA4mrwEBRWSn
VuIIc1MfQTszqwhzsiFq5TUv1/dlSZ7buqdTUW83E2ABn8raMQJ84Ja+GZH7I0VQ
yEHPaEPdrVdPtS1lVYQeRzAZ1CAkV7iDm2vI+LQK92ZyrRiY8u06ZRkCIVBrdtaK
ecCl5aIFY7oDAlo6E78XkQcK+HB4YF2r+3GBpaR586tKqaDpa/AnFrIRAdKHEf5y
wJEyRuUB1two8k6wCaXTQCnlASWy0XDOtq8DzG7NMJnPYklEnLSwgfAt8NVjgIQj
k6gvohh7Htojr6wNejCxhT9Rqgpq8B3QP1aPbfgs94puEkviOAfDR7ymOQ1GggwI
6Vh0OhCqW57xie4GHh6nnC0U4uI16md8aR5Z4gbpbfwXkqCBu7nuvegMZr7KUlxd
QNb4D+u2BOUo3rUUD3o/
=l2WW
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
