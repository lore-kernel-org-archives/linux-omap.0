From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/8] omapdss/omapdrm: Misc fixes and improvements
Date: Wed, 27 Mar 2013 09:54:57 +0200
Message-ID: <5152A5D1.3010209@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1364305525-28496-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig336BBDACF5E77E45CC7D29E8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45101 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab3C0HzC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 03:55:02 -0400
In-Reply-To: <1364305525-28496-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, andy.gross@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enig336BBDACF5E77E45CC7D29E8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-26 15:45, Archit Taneja wrote:
> These are misc fixes and improvements within omapdrm and omapdss. The f=
ixes do the
> following:
>=20
> - Make omapdrm smarter to choose the right overlay managers as it's crt=
cs. This
>   makes sure that omapdrm is functional for OMAP platforms with differe=
nt
>   combinations of panels connected to it.
>=20
> - Fix certain areas in omapdrm which allow fixed resolution panels to w=
ork.
>=20
> - Fix functional and pixel clock limits for DISPC, this ensures we don'=
t try
>   to try a mode that the hardware can't support.
>=20
> - Some changes that came in OMAP5 ES2 silicon.
>=20
> Note: The branch is based on the DSS misc series and dsi video mode cal=
c series
> posted by Tomi. Reference branch:
>=20
> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git for-3=
=2E10/misc_drm_dss

Which of the fixes should go for 3.9? We need those separately, based on
the mainline.

 Tomi



--------------enig336BBDACF5E77E45CC7D29E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRUqXRAAoJEPo9qoy8lh71jZAP/3EysqOpC/oqukCJwfwhx2aO
k+S4JqHD85CKPkXWaEXQdd+I/eiCBwkUEWK8ggp74XXDfInvagqeq9s9A8hTeyEk
/YBhULCEfLy89Ew3D98VYnq0eDt72zuP/NFXriJ3nyq6zootNKad/s1wCnbNcNHX
EPIesaPsYzRcNmwJdFgXZMkzqmJNVePc0K/A+E6vA1oalIj4wJKjIFPkPeN01glK
QqLtERUeDidcKDadbPi/dfVadOBUS0weDA/vN/qxtYHvFpDLVoYWlaxyaChrn5kt
4Hgz+48kcDWWLKs0356rGM5GHXPcnwyHk9lUH6qX5jHyHFNkwzowbqbXvz3IAAd7
V6R4KVT3vXBkye0NgLLME19rwzf1L4bxP7bebr2/kK2chqNfF6BUJkslu41I4G0c
RyuvHEF3PkdVgkySihLP/6hOXEX268PzV4XWQ51S98+lKkJSvRwy+KY+wvUkEf03
VA7rLsK/VEIEgx06//WcWS72NcQnjmipft7AY4IX2suvXzGwPnskMULToPDx1MR0
XXf82wqH35rz0vKDtuTjCpFKyWA1PKDhqLrxIvlHwjEK9kJeiLS0HAZzbcm5jmXP
KF7KCO1csp7mc1nqFnyjeBr8VJ+4AInJTR8t4fWBbfPr5h03qmt941AKfenLzcUA
Ktl/TzWQZxPLV50MLWju
=fNCb
-----END PGP SIGNATURE-----

--------------enig336BBDACF5E77E45CC7D29E8--
