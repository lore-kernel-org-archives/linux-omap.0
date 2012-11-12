From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] OMAPDSS: DISPC: Writeback fixes
Date: Mon, 12 Nov 2012 14:00:08 +0200
Message-ID: <50A0E4C8.1070902@ti.com>
References: <1352268905-31093-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3988900EB0C543D261D29443"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37874 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649Ab2KLMAM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 07:00:12 -0500
In-Reply-To: <1352268905-31093-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--------------enig3988900EB0C543D261D29443
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-07 08:15, Archit Taneja wrote:
> Some issues were found in the DISPC driver when performing scaling with=

> writeback pipeline. This series fixes those issues.
>=20
> Reference tree:
> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 3.8/w=
riteback_fixes_dispc
>=20
> Archit Taneja (3):
>   OMAPDSS: DISPC: Fix calc_scaling_44xx() bugs for writeback pipeline
>   OMAPDSS: DISPC: Don't allow predecimation for writeback
>   OMAPDSS: DISPC: Use output width and height to calculate row/pix inc
>     for writeback
>=20
>  drivers/video/omap2/dss/dispc.c |   39 +++++++++++++++++++++++++++----=
--------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>=20

Thanks, looks ok. I'll apply to omapdss tree.

 Tomi



--------------enig3988900EB0C543D261D29443
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQoOTIAAoJEPo9qoy8lh71aU0P/0QCbTt0uQxTDXYOAUpgNPYC
2uoStaZEPvAlM9wJ86s3vMN5DdwKT/oc3IQInmX5xXf9XaNJePYw6vwhl0I6DKCl
iO9s9PwA26NAHZEYAB9LLLWyYkfHHOO0YkBdyO19OTMb84fDqaamPhxrgvsvHTfp
jL3Af/674gAwefUm8OSDqLRdpygF170jSJaVDpLEsgbSLszxOFBG8o1Dip9HDDEU
1w/n7AQXM7xhOHwuu0je9fc4fno+S6/DrRsZtwSkuKniEH25fe2gPios3zGQk+Ei
QOP2WNSKbclh6XsFQEer6lJDsOrJ3gLXw6K4IgiJQKAnZl8OJ3/IXzca4a4B0cZm
ppG62b2++Pd+s5lgAXoUUxUqvQG+5mDo+9rh0RDYEqoBSfnhSHkhMDXhPDxhfnXj
Un0b+NPPaoFyvMHFifp0dX1QphK7Du5oK0OomVIFUehw4lxZ/LFCQ5Z0qbDthf/r
cxpISr+fNHBHUiuBkCl6mKIC62johepc2IUnRZ5hGQAgOmWhgvs3wW5hbH6SMEPR
Vadi7cYpisvIwWVLbsDp9drwn8WpOvhk6rpldXOE6pGXmSTS/a7Ax+KISsP7+fdT
yZbWTGz7hIwSWW3QraTbI1ao19yobA60YLG5ailDdzfE5JP4C29g5jhZZylcEKkr
0zlASXdo6+qWuJsH/SUl
=a7mf
-----END PGP SIGNATURE-----

--------------enig3988900EB0C543D261D29443--
