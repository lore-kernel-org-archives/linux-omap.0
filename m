From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] i2c: omap: improve duty cycle on SCL
Date: Thu, 18 Jun 2015 12:24:28 -0500
Message-ID: <20150618172428.GB27790@saruman.tx.rr.com>
References: <1434482276-1210-1-git-send-email-balbi@ti.com>
 <55815581.80807@gmx.de>
 <20150617153812.GB18421@saruman.tx.rr.com>
 <5582678F.4010505@gmx.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32965 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754679AbbFRR1a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Jun 2015 13:27:30 -0400
Content-Disposition: inline
In-Reply-To: <5582678F.4010505@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Lawnick <ml.lawnick@gmx.de>
Cc: balbi@ti.com, wsa@the-dreams.de, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--32u276st3Jlj2kUU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 08:39:11AM +0200, Michael Lawnick wrote:
> Am 17.06.2015 um 17:38 schrieb Felipe Balbi:
> >Hi,
> >
> >On Wed, Jun 17, 2015 at 01:09:53PM +0200, Michael Lawnick wrote:
> >>Am 16.06.2015 um 21:17 schrieb Felipe Balbi:
> >>>With this patch we try to be as close to 50%
> >>>duty cycle as possible. The reason for this
> >>>is that some devices present an erratic behavior
> >>>with certain duty cycles.
> >>>
> >>>One such example is TPS65218 PMIC which fails
> >>>to change voltages when running @ 400kHz and
> >>>duty cycle is lower than 34%.
> >>>
> >>>The idea of the patch is simple:
> >>>
> >>>calculate desired scl_period from requested scl
> >>>and use 50% for tLow and 50% for tHigh.
> >>...
> >>Hmm, and what's about  Philips I2C specification 2.1, Jan 2000, Table 5?
> >>
> >>>PARAMETER                       SYMBOL  STANDARD-MODE   FAST-MODE     =
UNIT
> >>>                                          MIN. MAX.     MIN. MAX.
> >>>LOW period of the SCL clock     tLOW      4.7   =E2=80=93       1.3   =
=E2=80=93       =C2=B5s
> >>>HIGH period of the SCL clock    tHIGH     4.0   =E2=80=93       0.6   =
=E2=80=93       =C2=B5s
> >>
> >>Your signal is in spec (0.85 =C2=B5s high, 1,65 low).
> >>Maybe your TPS65218 is just buggy or signals are bad?
> >
> >yes, tps is buggy, it's written in the commit log itself.
> >
>=20
> So I think it is unacceptable to change the adapters code violating
> specification because some buggy device doesn't work properly.

read the other thread and you'll see that it's not violating jack

> This change for your device has chance to blow up many correctly
> working ones.

How ?

--=20
balbi

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgv7MAAoJEIaOsuA1yqREHTMP/2MVCa56nikZatPn+6+D9RGJ
YdCXDehifA0jjHWfv6CLivqFmHR2gK6Ohx/XhZv5cJXhtgr14nc321kZEy1UrpRX
8Fn4V0zN0kPvKKF8iznWkBdLdjTBEceRjERSSaXiYMlj3seK3CFoQ3oSmifCn3Uo
cq3JrRRxDNxbfyJmyu0tWyIXgP6L7/bSLOFo6XdyUL5M9fAj2/ChaES9RkiPx48r
dCOnhN0Zzz89uWhIKqseh3knRirGHyIbK2Xl2kHXpbeNLK86hKw0VI6XyKJcuxnG
4JVH7afkXkRFp9x8nHHnJQ/vVFWS74Q7avDK7JqT1Km9BSAhsD042qF4I7VSwoAx
Jzr8oobAlN2C/ZhZG1QKtSklq1He7y1zqp6m81aCt9m4QEWuQdqowR2q4qOHL/4n
fN3+vDQXx8M5z2bQd+xWqc6EdELu4xThvLUvI34Gb3dCTpi/1zo39LMAoujuG2+i
cV9FXCwwg/4/JfhBK+F9zPOIAkug6vWpSGC4XMGsWC2oqMZqA22kof7ZuKCJ8P2O
vW2x78ufk05WNnrbHct4Ucxb6lb3z2/Ypc1DigCkkh8kaJ4rCVRBP62gMJ6AvCxr
ZP7HJiWD+ETaFuyaZlkvmr6HIXAdwoBSmWV6BtpA/choijf2K6BOgQMBC0tKHYv0
gSr0i+96o3lpiEPUVGtv
=KshA
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
