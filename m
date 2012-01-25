From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] OMAP: DSS PM fixes
Date: Wed, 25 Jan 2012 10:04:05 +0200
Message-ID: <1327478645.1858.17.camel@deskari>
References: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-01GAiiYwBNCINR6XS67H"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36721 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104Ab2AYIEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 03:04:12 -0500
In-Reply-To: <1327320930-14550-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-fbdev@vger.kernel.org, archit@ti.com, neilb@suse.de, jean.pihet@newoldbits.com, khilman@ti.com, jw@terrafix.co.uk, linux-omap mailing list <linux-omap@vger.kernel.org>


--=-01GAiiYwBNCINR6XS67H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, 2012-01-23 at 14:15 +0200, Tomi Valkeinen wrote:
> Here are two fixes to get DSS work better with PM on OMAP3.
>=20
> The first two patches fix the missing SYSC_HAS_ENAWAKEUP flag, which remo=
ves
> the SYNC_LOST problem.
>=20
> The third patch changes omapdss to use pm_runtime_put_sync functions, whi=
ch
> fixes the system suspend.
>=20
> I've tested both only on v3.3-rc1, OMAP3 Overo. I get problems on system
> suspend from TWL and MTD drivers (also without my patches =3D), but disab=
ling MTD
> and ignoring TWL errors shows that the warning from omapdss has disappear=
ed,
> and I get an image on the screen on resume.
>=20
> The two fixes are independent, so either I can take them through dss tree=
 (with
> appropriate Acks), or the hwmod patches can go through some other tree.

Ping. Sorry to be hurrying with this, but I'd like to get these into the
next rc. Can you ack these (perhaps the first two patches?) or do you
want to take them through your tree?

 Tomi


--=-01GAiiYwBNCINR6XS67H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPH7d1AAoJEPo9qoy8lh71MOEQAJQXPDdBLkVlWCylP5DwjhKW
PsQm1vXIlPX3C04L8iyso2LSYi89Tw9bFWxKPnSYhsQn+03XGVO5g56GvpnfBDne
n7/7ndZILwGc119aZMeIbTmj8U3tz7TlMe4m1GJR3Olxj46TvFgoJe0r2Ii5j5k7
+KjBcxQUWrjdH71vJCfJ6zq2tZd8Vj1IYpA+MjC/nPpx8to7vqFeGml3rGPIjp9Q
0MuS2oY7mQbAZtYK3t79N7mI6Pd4eUY+0nYu+kVfnHAdofeMgv89xYQehsliS/Og
nOoZG2hLfYFMI7WXRZYN+uzEfDbChzOpmCp9SBUpiI1oUGY6eVtyK9YAbC6PblHs
dpNnzJRZGP8WLFvKGIPHdW8A1AkLiOft/ern0EDitVMZOc2oPyQbpcIxq2NYr8xc
1SGeQFaTD7gT01bWdjpvwu1qBLc1yaOypqvvcjCA/w9jNGHG+BbyyMgWTvgSOW1L
93Aq0aSaiDvRfZICPpBiC8NbY8j6xx2lroV5wg4bVQ7Jq/aS+Uc/r9VG8ax4SyO0
j7LRikrA+OjFP6IGmdHJOHxDz5SPjY07bxi1NYcLroJ4eAx/qCQZgFj3kZHL/hEU
1nXU/c/P0aUQYfLCnHYFXBDfuESlsCRjYsSAEg+MdpHXNUg9k56qC8iSToE/teOx
q7iDQaRs/U8HmSdiBgsS
=RNi2
-----END PGP SIGNATURE-----

--=-01GAiiYwBNCINR6XS67H--

