From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for
 all CPU power states except off
Date: Fri, 8 Feb 2013 17:26:08 +0200
Message-ID: <20130208152607.GJ23979@arwen.pp.htv.fi>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
 <1360336306-18277-3-git-send-email-santosh.shilimkar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q5r20fdKX+PFtYHw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53474 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946070Ab3BHP0T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Feb 2013 10:26:19 -0500
Content-Disposition: inline
In-Reply-To: <1360336306-18277-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>

--q5r20fdKX+PFtYHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2013 at 08:41:46PM +0530, Santosh Shilimkar wrote:
> Current CPU PM code code make use of common cpu_suspend() path for all the
> CPU power states which is not optimal. In fact cpu_suspend() path is need=
ed
> only when we put CPU power domain to off state where the CPU context is l=
ost.
>=20
> Update the code accordingly so that the expensive cpu_suspend() path
> can be avoided for the shallow CPU power states like CPU PD INA/CSWR.
>=20
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>=20
> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

some numbers showing the benefit would be cool...

--=20
balbi

--q5r20fdKX+PFtYHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFRkPAAoJEIaOsuA1yqREOl8P/3mzeRZljefeANqUZBYoGq54
YJdtTXzYQDsWRUdt0k73MJlUo/1PE32+tx330pvmtrm4WcFeMhbO06O7ZT7Z1q7Y
U1ilHyzyUOh8MpYAjFAoPtUUxJtY7+i1HS4bkbNeXdFVBUdEXAdK+yg1aYPcMvy0
9Y+zS0TNjiHe+NooBwn70BVtb8dKp468BfBK9kXJXM+7bDqQNO6nvY2ANUVja43D
GOwThz6nhRI/e7JRDxNl02Q2IzrjKlguCzB1D3TQ+NhjqCZ6zXGJIM1pKW9g+9ti
ckfB5XPUvY/lVyyhV+0+Vai+D3NwSaGa4xkitJ75jLWMEv9huROfeK0JOLc2XVBS
kIK56bL3zRpBINIjx1YHtQyYaQyFuHRe99XDZ7/S/qz7oOZ6dSSOgWK0hhX9j5YA
rb3DssgonOcxAwq2+2I1S3PBcScJegXL4+AYXwqELr9etVjOpTz5N/kkpzHR+wdm
lVbkiIo543aTPzB6I/E1aL/LX7jL7VIv42xHUwN4P4OkTR4ORU0CUDIxcq5hjShv
CcUMtJ65zbvevZDm3McC3QMjj1BviJJBm3coUL4nrT6ZO9YlIxrW+Aqpx8mLQnDj
mu29vIIjeFR7wVB6WgfA5Ulb8+6nm8lYWI5yHoNBO6Ky49taZrt57MpFISip7KAf
meeqxjB7BcwsMymmijX+
=9QBS
-----END PGP SIGNATURE-----

--q5r20fdKX+PFtYHw--
