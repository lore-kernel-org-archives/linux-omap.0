From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/4] ARM: OMAP4: Remove un-used control module headers
 and defines.
Date: Wed, 25 Jul 2012 14:06:35 +0300
Message-ID: <20120725110635.GE16794@arwen.pp.htv.fi>
References: <500FD2E9.8050408@dev.rtsoft.ru>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:55284 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756395Ab2GYLJr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jul 2012 07:09:47 -0400
Received: by lbol5 with SMTP id l5so476145lbo.6
        for <linux-omap@vger.kernel.org>; Wed, 25 Jul 2012 04:09:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500FD2E9.8050408@dev.rtsoft.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 25, 2012 at 03:05:13PM +0400, Konstantin Baydarov wrote:
> Most of the OMAP4 control module register defines are not used and
> can be removed. Keep only needed defines and move them to common
> control module header just like other OMAP versions.
>=20
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>

Wasn't this one authored by Santosh ?? Where's his From: Santosh
Shilimkar ???

--=20
balbi

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD9M6AAoJEIaOsuA1yqREdU4QAKD8PE479fprwd9isSStPHpN
OTVB6c4de7+yiuygxY0Y1yVQmqmK2jdaimwn0w55bkINdVNFleTmx/DLmMsaLfA3
V3xl4hkTq8YZBC+PHTyI+lBm/PaCBlzdPKUVTmB7tIVdHSo0YtzbqAld2lo4uGDt
q6EQ6pZOLoinmd0spPkTjNbU3XNYSFo8p6TCRimoIrZRLU93A5zfupBECJGTE6ZU
BMXsyDGKQoMUbPzzO4eDPH+XUB37Lf3DHAG7qZuKWKy96l3xbKB9fqDwFvYIA5n3
iqI6FRGnok2CnLt50FAKBBPNYvTdSiBUZpFsqTpljK2xYRUkOLGRkmW5pLkqpXpt
scTivW98HYaQdDzOrgPG64kBMSpAFxzsn2yQZDO2WzVC6NWKsor98EkTwWFXEvkg
R6Hgdyg1oLG6UkJB3kopAe7Pza2oQwt7fJKy8Q5I9X+c88uo+phOTRBVndX3EJ2o
NtzB9nxAM9WlNOpzLowle9G6rD5wnzL2kR/98NoVxOo01OOJF2iSA+CwPihLJ9oJ
y7Lf4uXYFYW+L35IzAV3ZoDSR87uPg63l/4c4SGBy9YAyQVTgKVh3yhx+dhHb8jd
Qv5VwQFG//4Ssak3SCGKNCsqk1HxaFpypg65WWmw3ILIs96eMKJ7HlulRT3Rd8d7
oEY6FurutwzO3aheDg9P
=dkyI
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
