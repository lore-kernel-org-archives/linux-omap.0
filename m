From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
Date: Mon, 20 Aug 2012 21:07:15 +0100
Message-ID: <20120820200715.GT26991@opensource.wolfsonmicro.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
 <20120815125338.GA13544@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
 <20120815165431.GF15365@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13D18@DBDE01.ent.ti.com>
 <20120816140056.GK15365@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA19A81@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5tINJiUS2/Dn5Rhr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54015 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751691Ab2HTUHR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 16:07:17 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA19A81@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


--5tINJiUS2/Dn5Rhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 20, 2012 at 06:27:01AM +0000, AnilKumar, Chimata wrote:
> On Thu, Aug 16, 2012 at 19:30:56, Mark Brown wrote:

> > Why does this mean you need multiple regulators?  A single regulator can
> > of course supply multiple devices.

> I got your point but tps65910 driver is failing if we add single fixed
> regulator. Solution is driver needs to change or add multiple fixed
> regulators.

No, really.  One regulator can supply many things, not being a.

> vrtc:
> tps65910 0-002d: Failed to find supply vcc7
> tps65910 0-002d: failed to register tps65910-pmic regulator

So you've specified a whole bunch of supplies and this one individual
supply is not matching (and it's not the first...).  You should
investigate what's gone wrong there rather than bodging around the
problem.  I can't immediately say anything much based on the information
you've given.

--5tINJiUS2/Dn5Rhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQMpjsAAoJEFJkBDiqVpZ4tw4QAIY/lyBEQDDyMB6MNozX5AM0
gJkyY6AhFeZQ6BqHpUpY7H2zFN3IhWsHXGJqzFdfGRSx2RuHOe7D+sbJ6tDNk5j2
Wl4VSclfyGKM2AZ8BKe8YH6kKECrqlPCQ4sHRCuaX0VMzHljWKZuHbkTgc4Duvq1
je2Q4pLXuQkJTddsIXDFIsSGlaKfJ6+8xHro7+m1ZJS4ALAKx1Bmp8iDmXC2QSsy
aLIxvaQoYcHkPtCSYMV0nFj4/CsJAvGuk9OlAmdWgwXnNLu/e8XRed/qxqN5s1ce
eT3aEoXDgM1sRXrHYL3IlFkD0I4wdXdF2X8y347+zYUBbvbNv+ANwNIS9dQXXkpX
EYFx5n65NioOdH6GgO1R28W9Z2IhOeZMLWk42ZNof0/7z14+mfQ92B91h+a78zbV
B263ZK8mCuj5gVUEW84IgPmpMNTiDoEX9+lZ5y+LgUXm6jvyCBMqGEQCLQdgJBe8
HE2SVeip7qbgb/vSZ9RQvxgaYNkTVrCop8IpqlsJdjDOe7mVH9BeSo2V++qK/jPZ
Sz/cVkzwJhX8EDwsARhN10/wg9FZ9u//PiGfLhLvt5nBu8fijfMMX4DXppF/VbHV
BiJN9XuMWzDw56BBiosMO4ysY3hZ43Yjypl/ErBz+tRmCUWHUEnn+lYyfYkwEXX1
66JCkLULUHrGpWEjtuYX
=dLfo
-----END PGP SIGNATURE-----

--5tINJiUS2/Dn5Rhr--
