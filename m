From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 12 May 2014 12:40:22 +0300
Message-ID: <53709706.10501@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>	<1398815562-24113-4-git-send-email-tony@atomide.com>	<5369EAE7.3030705@ti.com>	<20140507150343.GA9502@atomide.com>	<536A5920.1020908@ti.com>	<20140507175919.GH9502@atomide.com>	<20140508233300.GI2198@atomide.com>	<536C8293.4070506@ti.com>	<20140509155504.GE17814@atomide.com>	<53707A64.2060203@ti.com> <CABxcv=kwhodeFTHoVpn1nHeh9+kV5fwMN9s3Kbk6h7_xJp4UYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="B77jMwTjDgeeDIgOtOXIwR2iTDVdjs3qx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46257 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218AbaELJku (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 05:40:50 -0400
In-Reply-To: <CABxcv=kwhodeFTHoVpn1nHeh9+kV5fwMN9s3Kbk6h7_xJp4UYA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--B77jMwTjDgeeDIgOtOXIwR2iTDVdjs3qx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/05/14 12:34, Javier Martinez Canillas wrote:

> Maybe we can remove this hackery by relying on the fact that a
> compatible string can have a set of values that goes from more
> specific to more general. So you can have something like:
>=20
> compatible =3D "sony,panel-foobar", "omapdss,panel-foobar"
>=20
> So right now only "omapdss,panel-foobar" will be matched and later
> when we have common panel drivers then that driver could handle the
> "sony,panel-foobar" compatible string.
>=20
> Other platforms could do something similar and have
>=20
> compatible =3D "sony,panel-foobar", "baz,panel-foobar"
>=20
> That way you won't break DT backward compatible but still not require
> hacks on arch/arm/mach-omap2/display.c.
>=20
> We do the same for OMAP boards, we now have the following compatible st=
ring:
>=20
> compatible =3D "isee,omap3-igep0020", "ti,omap36xx", "ti,omap3";
>=20
> There isn't a struct machine_desc that matches "isee,omap3-igep0020"
> but later if we find that we need some board specific initialization
> we could add one without breaking existing DTS. In fact it used to be
> a single machine_desc that matched "ti,omap3" for both omap36xx and
> omap34xx but later when some DT clocks changes were introduced we
> needed to split both SoC families.

I think that's a different thing. "isee,omap3-igep0020" is a proper
compatible string, if the board is "isee,...".  No matter what software
you run, that's correct and fine.

The omapdss case is different, there the "omapdss" points to a sw thing,
it does not describe the hardware. It's only needed as we don't have
proper sw drivers for the devices.

That said, I think what you describe would work. But I would rather keep
the .dts files clean and correct, and keep that hacks hidden inside the
kernel.

 Tomi



--B77jMwTjDgeeDIgOtOXIwR2iTDVdjs3qx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcJcGAAoJEPo9qoy8lh71I00P/RSdSmIp5KOhliweqhoRtXRS
BB5UqjeeBBc6j1ubbZ0SiBJRDtg5NHSyYr+IClW6So6YKeR+uWSJcc4oJ7GWXuzE
NuXDp0D12ulnAMBDejKTnziQay0TZGKp9SuuRcSZLrgemysq5SVjLA3WyHM+hHtR
G8QGPxpTBhzV106zWTtXlqr0h5NVPeIFTRMn6S7SKGR4f9F+ZEUiCnKdh85hR5mX
VjSkDkJY6tgaR1j22mIYzOk2ax8Eq+RuAwKu/gIFTTCJwGs8wLawl92kqQFYAipd
NYqB2wpBoBabx0NtHXDZT1OjDeOGlNDs7p1cokcOxU5tGJdznFqX46S8kwm5kqkW
FRWT0bXYs5af/+ND5OvFfFlLKdxIaSiDfAng7nkOEbSssi9eCMUim4SP5Cemr+r0
fHAGPmhI/QfNSUFXPaVX05AdUQRkwsiNU1rK/hoh7/juFM9TdUOwsJJ8I42Sq1Bg
HQAZ5K1c216a2GhRggBo5dVyStrujo24fcPoRnqj6w8jkY7bCGT8VQU8YS1Levtp
PWpdR/v8TcReJuZxu4WAkbmcAmOln+H5m0+PQtPYRkCzkABiNKNNO2YS4Cki5FfR
CeUcYODfbmSMr6XxuIc3hPNtdxVK7VDjSTIGpYk+FIjFMqz+IJPEKjmO9pA6Z+4i
lSm7/Sn6Lg1SUY/+r1v2
=9irh
-----END PGP SIGNATURE-----

--B77jMwTjDgeeDIgOtOXIwR2iTDVdjs3qx--
