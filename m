From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Powering OMAP's pins
Date: Wed, 26 Sep 2012 15:56:45 +0300
Message-ID: <1348664205.2376.34.camel@deskari>
References: <1348568474.2342.35.camel@deskari>
	 <20120925153806.GC4840@atomide.com> <1348592700.2342.49.camel@deskari>
	 <CACRpkdYdZFr=XvsZUwY6dLN6uOj7fN_7StPgCNZNKU46UtMCaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-hnb7GYAPIsmdydGtO8/B"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:60539 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751377Ab2IZM4v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Sep 2012 08:56:51 -0400
Received: by lbon3 with SMTP id n3so1615931lbo.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Sep 2012 05:56:48 -0700 (PDT)
In-Reply-To: <CACRpkdYdZFr=XvsZUwY6dLN6uOj7fN_7StPgCNZNKU46UtMCaA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>


--=-hnb7GYAPIsmdydGtO8/B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-09-26 at 13:46 +0200, Linus Walleij wrote:
> On Tue, Sep 25, 2012 at 7:05 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
>=20
> > So when I call pm_runtime_get in the omapdss driver, I imagine that the
> > runtime PM and pinctrl would together handle muxing the pins for
> > omapdss's use, and also enable the relevant regulators to make the pins
> > usable.
>=20
> So we do something like this in the recent patch to the PL022
> SPI driver by setting the pinctrl states inside the runtime suspend
> and resume callbacks:
>=20
> http://sourceforge.net/mailarchive/forum.php?thread_name=3D20120920130240=
.GR17666%40opensource.wolfsonmicro.com&forum_name=3Dspi-devel-general
>=20
> You can very well do clocks and regulators in these functions as well.

That's not really what I mean. The regulators in question are OMAP
version specific, so the driver shouldn't know which regulators are
needed.

The regulators for each pin could be passed to the driver from platform
data, and the driver could enable the regulators in the runtime resume
callback. But then each driver that may use the pins would require the
same code and the same platform data to be duplicated.

> Other platforms like shmobile will use runtime pm notifications
> to do all this orthogonally in a central place, which may be
> applicable for OMAP.

What notifications do you refer to? The PM notifiers (PM_RESTORE_PREPARE
etc) are global, so they are not of help here.

I was going through the pinctrl code to understand it better. If I read
it right, there's a default pin configuration that is set at boot time,
and if that configuration needs to be changed later, the drivers use
pinctrl_get() & pinctrl_select_state() to change it.

How I thought that it works (before going through the code) is that at
boot time a default pin configuration is set, and for many pins this
default config is disabled/safe mode. When a driver, that has been
assigned those pins, is loaded and uses pm_runtime_get() to start its
hardware, the pins would also be enabled and muxed for the proper
operation, without the driver doing any pinctrl calls. And when the
driver does pm_runtime_put(), the pins would be disabled and changed to
safe-mode.

Is there a reason the pin control cannot be automatic as I described
above? The pl022 change you linked seems to do the same, but manually.
Again, I'm not so familiar with pin control, so perhaps all this can be
implemented in platform code.

It sounds easier to me (from driver's perspective), and should preserve
some minimal power also if the pins are disabled when not in use. Of
course, "disabled" here is platform and board specific, on some boards a
pin must be kept alive and, say, pulled down even when not in use.

 Tomi


--=-hnb7GYAPIsmdydGtO8/B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQYvuNAAoJEPo9qoy8lh71ubwP/0IZrUfxIPiCBipDQprgTKjh
2GRHXzLsd+I1oKgBQjCWUer01VMYPpXTL1629qS56oYJb6Ajv7vvsCw56NGgXB73
rbSo0djthphCNiYwTR0LromkgAyWAbBeaML5OJ1PGDQ1HknhGvnDnMV2/tJ1YR63
uCrsTh7vqotJ+nZUdOqsd9Q1tNREhjwylOCCmN1XEST/H0Yo3EYY+Xbj2aaVDU7k
d8d+iL4xxymONYW/tvz4Ofwr1uCG7nZ5xF8csUxGAnnDEg6vOup+E7pOfYMalF0p
i9sctlZmnf3ZIJzXzAuaaQn/1tQtBq4Mh+BEb338rLxj3KgZ5vVU8RwhYzxTG3j7
y0pn1FDJJ6nPINS2tv7hHlu53nuNxFQCjUzM7/RNm4EGQP8i6w4q5/DeDHSzO0RM
E40D1PfdTar7r2thAyiG+3jCblHWNdyEKvbCi+IKTl6HCAR6e1vzO2FHKNDIisCl
9D06DunEkqh0APe3HMaVoN6Zid37Z+Fraz2jNBr2jHq3JCIubYPOmZMr5cxiFoaC
8mDO0nWLANTFDWGkUvltmID9SlD65+89HSsmaLCCTjMYQ255VMsMzjuiZ0Wn/rlm
SZ/BA9UMY+fKnaVuXbMKkzvUK+bGC0aI4mvmFv9LX6s49wKCPWqruAdT/20Lh9oB
+GPrXpVZW9nF7bxVAuyf
=kOLM
-----END PGP SIGNATURE-----

--=-hnb7GYAPIsmdydGtO8/B--

