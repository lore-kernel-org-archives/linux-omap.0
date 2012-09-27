From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Powering OMAP's pins
Date: Thu, 27 Sep 2012 10:18:54 +0300
Message-ID: <1348730334.5559.9.camel@lappyti>
References: <1348568474.2342.35.camel@deskari>
	 <20120925153806.GC4840@atomide.com> <1348592700.2342.49.camel@deskari>
	 <20120925190721.GD4840@atomide.com> <1348643142.2376.13.camel@deskari>
	 <20120926185912.GG4840@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-5rBXnikZASKgSzOsbqte"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:55936 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756340Ab2I0HTD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 03:19:03 -0400
Received: by bkcjk13 with SMTP id jk13so1236331bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 00:19:00 -0700 (PDT)
In-Reply-To: <20120926185912.GG4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>


--=-5rBXnikZASKgSzOsbqte
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-09-26 at 11:59 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120926 00:06]:

> > So if I want to use parallel dss output, which uses dss_data0 pin,
> > omapdss driver needs to enable vdda_dsi on omap3430, even though there'=
s
> > no other use for vdda_dsi in the parallel output case. But on omap4430
> > data0 pins seems to be powered by vdds_1p8v. On AM35xx something else.
> > So either I need to program all those into the omapdss driver, which is
> > not the right way as they are platform specific things, or I need to
> > pass some kind of pin data from platform data to omapdss driver, giving
> > the required regulator for each pin.
>=20
> Pass the device tree regulators to the DSS driver and enable the
> ones with runtime PM in the DSS driver? I guess you have the names
> for those regulatros?

Well, yes, I could create a pin->regulator mapping for dss that is
filled in the DT data.

I just feel this is something that the omapdss driver shouldn't care
about. The powers for the pins are in no way related to dss.
=20
> > And how about the uart1_cts or gpio_70 pins on 3430? Do both uart and
> > gpio drivers need to have similar kind of platform data, giving the
> > required regulator so that the pin can be enabled?
>=20
> Hmm aren't those always enabled with VIO_18?

No, 3430 datamanual (OMAP34xx_ES2.0_ES2.1_POP_DM_V_K.pdf) says some uart
and gpio pins are powered by vdds_dsi, some by vdds_sdi, some gpio pins
are powered by vdds_csi2, etc.

I could be mistaken how to HW works (but it does work like that for
dss), but sounds to me that uart and gpio drivers (and perhaps some
others, I didn't go through all the pins) need similar pin->regulator
mapping as you suggested for omapdss.

 Tomi


--=-5rBXnikZASKgSzOsbqte
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQY/3eAAoJEPo9qoy8lh71qRYQAJX6cct0ENjOX1E9UFxlCnNd
hyt4U7BwvlFfIluvDg5tvP11fhuHTnqKyT0j3OAmpYmbGJYvEJ/O7W2LhSqWZfE7
se0zw7NOClzKQMkpSHxa5yfHCbhom+f1qzb6GEhFNEIFSCyTBMGcpzAiGyPA/8Xz
3aPC/45XQSaQWK+ZYIuF/0LAWeF1JgyJkMzE2uqzfRo2mZkpbSBu7CNSwyHbpANw
n+fvvuhoNW7lw+V1J8kEt3KQLt9VXcMMFOOfKAFE/RrIo/biIqK55oqXWV56Oxto
u6E8AI1KA49pH+qSMdtZb6EAXnivjickY1/4X6G2I67GKJWAALGx4xo086JlwIfW
k2zSmDcxHg1V3XBn2KtD2xfSyyQHWr2E3kVaf6BkPrNbRVsSFunWKyVxBOkmJdpq
ku4MagFaXHUHirMiyvaUmF86pp0apI4k/aRgSH6qEgsbAeDu1ACYoyVQtCyayYgG
6S7RyUFNy7Wzs/CU7rIdGxirsXRCx83IXIiQKNoyLs1d0AQ05aTsP6wn6kK6MlZ4
l8Xk/Vlw3cACUcohUZgQaTIQRJulYKT3fXcKRLLoc08aKIcBWg+ZZgqcdjPVmy3k
6nvEAGniNMTN8SZw5SEG+58W8pT/8cjdtBz0nyJ3y/DR0kb/6qdrZGICBb7+MEe4
0O8B9IrAW0t1GWvQZhBA
=JP3R
-----END PGP SIGNATURE-----

--=-5rBXnikZASKgSzOsbqte--

