From: Felipe Balbi <balbi@ti.com>
Subject: DSS build breakage
Date: Tue, 5 Feb 2013 23:38:54 +0200
Message-ID: <20130205213853.GB3739@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56380 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755625Ab3BEVi6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 16:38:58 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id r15Lcv2I024308
	for <linux-omap@vger.kernel.org>; Tue, 5 Feb 2013 15:38:57 -0600
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id r15LcvGe000999
	for <linux-omap@vger.kernel.org>; Tue, 5 Feb 2013 15:38:57 -0600
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tomi,

DSS doesn't build with allyesconfig:

drivers/video/omap2/dss/dss.c: In function 'dss_calc_clock_div':
drivers/video/omap2/dss/dss.c:572:20: error: 'CONFIG_OMAP2_DSS_MIN_FCK_PER_=
PCK' undeclared (first use in this function)
drivers/video/omap2/dss/dss.c:572:20: note: each undeclared identifier is r=
eported only once for each function it appears in
make[4]: *** [drivers/video/omap2/dss/dss.o] Error 1

Found when debugging another problem reported by Arnd.

--=20
balbi

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREXvtAAoJEIaOsuA1yqRE6b0P/AkV0tlYI4Asn6gdvbE7Asfi
yHt/WGe9vTwk9kYUkpnHifoAAm/FDcD203nupRI4reTewnRKPc7tvEJeGZ/VsiDJ
OuWyxtjbHoNPwI/fb1olfbBsEahOueWdVAyux+TM9Lri7pYKUzrGWdoHHL9BdMm+
+nWdbS5xbP7nL0EaMY8bAc+wy4mJtvnB8K4L73gtQZEQ/Fdkom8oud1N+OJJ3iE7
L8DmPKV8qRdXhid83KUCzEubjMf4ndiEsDSsbtKCa5znjT6243LCZ+BOucOy+igx
YhUOcMVjFDCN/8Px6pofYupkWVmhax5jOHROU8XSPAhWscYHNzkijTYWGKG2qyZz
MmXUw9zojScsAw4Ee8xzUVLU9t3NSnUTlLlNH9/etHVVZQ0ERBURllWw2I4to5W3
6kFDyH0SnM940KmO+CJuLDZuH4FdvX3hDhGjdiGMZBq91kCWxjuv5uvqRuOUOlQF
GMt2smj/MABVGe42TyzrIxRE3cB8jOGxX10jLnzS5Au9kcSP3h+6XY+Kx1P+7h6i
317utOKtFw/nIpesnSgxOXDH9hVO1nXEy82BEUhuEiX24F7gU/Vba5fNSWPQQcy5
1VWgEnqo4Wo/w8dzyG7ImRAEZUHX51C8e4V5yqpMsCx00jQ4TY9HHLyuF2hEsOhl
zGlASCRuQOcHp79vaJzA
=hnOF
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
