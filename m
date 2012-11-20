From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/2] OMAPDSS: DISPC: Update manager size limits for OMAP5
Date: Tue, 20 Nov 2012 16:54:47 +0200
Message-ID: <50AB99B7.9030102@ti.com>
References: <1352881216-7490-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig337D83812C2F7D9AC34E2467"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55695 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab2KTOyu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Nov 2012 09:54:50 -0500
In-Reply-To: <1352881216-7490-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--------------enig337D83812C2F7D9AC34E2467
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-14 10:20, Archit Taneja wrote:
> Manager width and height can go up to 4K on OMAP5. Make manager width a=
nd height
> register field offsets and maximum limits as dispc_features. Create a n=
ew
> dispc_feature struct for OMAP5 which highlights this difference.
>=20
> Archit Taneja (2):
>   OMAPDSS: Add overlay manager width and height limits as a dispc
>     feature
>   OMAPDSS: Add a dispc_features struct for OMAP5
>=20
>  drivers/video/omap2/dss/dispc.c        |   47 ++++++++++++++++++++++++=
+++++---
>  drivers/video/omap2/dss/dss_features.c |    8 ------
>  drivers/video/omap2/dss/dss_features.h |    2 --
>  3 files changed, 43 insertions(+), 14 deletions(-)
>=20

Thanks, looks fine. I'll apply to omapdss tree.

 Tomi



--------------enig337D83812C2F7D9AC34E2467
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQq5m3AAoJEPo9qoy8lh71a5AP/0dNcTBYMmcn08keB/2c+qHq
xuOZDgzVKOucxv7C3uMQ2HTJ9T6QzzmSqrtuPLh++6556OrrlCqgwEetCGNA8ui8
KBnxxQs9/1PWh5ymh+w/758kdCuemnOdvlDk6s0r94rGA+nprO0x1Zu5gc0bsaCT
zEV7bkGu9Vxcl13jtaguTA6Cye1ttVVRiGbrXg+znScB+cj9FZPLKf7MDaugNegm
K7oueByapiZ4n5MqCt4Sf5WS4T/Fmuj5hdRu/PY7riop9cfrI+KgFHv6PLORvZrS
3G3puFo/3RFuB8+/bbQal50bBkIwHjgkniwuKWLCXwK+SVwVEUid9wp0oFDO/sW4
SR7bnZ0nfg8vzazpdaHjpIEqGTexc4XR2szDlBiuzcp1TgaZ6Luu5iGfaj6c4AIy
3EFpzKQO5/8gwbRJHEgkT09MVTRng8Q4RjdqEy2AYCDu820NWnvGKmEvZFZAw3/A
1LB0l5kXM6/uhpr8Ei+mgzEMzjmC+qvyxYIXrwWe7o3cPL0aERZAvG6jLU9l9qMt
tzhTZX2Om/JmN1cQTOb1Dq6DetbTLpKwfrrqiaF0xHB9OEMXHo2uDQBO0YaNcOFx
0G/RqTMWLNbeDlEUx6H/W+LfavaD3bxpglepN/53CsZwqD7CqM9JZBiBmOTo6zg9
WFWaI2nv0flu6Nuz2Fo0
=5mNO
-----END PGP SIGNATURE-----

--------------enig337D83812C2F7D9AC34E2467--
