From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] fbdev: omap2: improve usage of gpiod API
Date: Fri, 29 May 2015 09:07:27 +0300
Message-ID: <5568021F.8000706@ti.com>
References: <1432800315-25972-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cxKfNEMCKDBLMjxpKingOc40isanCIpLq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51256 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145AbbE2GHl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2015 02:07:41 -0400
In-Reply-To: <1432800315-25972-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, kernel@pengutronix.de

--cxKfNEMCKDBLMjxpKingOc40isanCIpLq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 28/05/15 11:05, Uwe Kleine-K=C3=B6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)=

> which appeared in v3.17-rc1, the gpiod_get* functions take an additiona=
l
> parameter that allows to specify direction and initial value for output=
=2E
>=20
> Also make use of gpiod_get*_optional where applicable.
>=20
> Apart from simplification of the affected drivers this is another step
> towards making the flags argument to gpiod_get*() mandatory.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/fbdev/omap2/displays-new/encoder-opa362.c     | 12 +++--=
-------
>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c          | 13 +++--=
--------
>  .../fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c     |  7 +++--=
--
>  .../fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c      |  9 ++---=
----
>  4 files changed, 11 insertions(+), 30 deletions(-)

Thanks, this cleans up nicely those optional cases. Queued for 4.2.

 Tomi


--cxKfNEMCKDBLMjxpKingOc40isanCIpLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVaAIfAAoJEPo9qoy8lh71BJsP/RSbRNqLAC89Dd/qliqe+qOn
CKA7jiDXwgcoIhYvtfH0mR7pcJQ/WeB3tD/BaqwrRKQ8KD/H00eFFQj70z8/5TD0
U/FT770fjJ2thVN/xHWS1vwg5bAjE9cMmT0hLMKH1wo/iYkIxQn1YGjSk4fVvdBI
8Oxw4pq6iqdJw0fc6yDv6KSB1WgSEKmJpcg/x49LdXnBWDUsa7d+R80L1KQ9i9NE
4CJRDpE6OVaGO0cxGgTgZpeLVxBbOQNMmodsRjyD6O8fn4XVtkjzTl0fh/LDjeBj
liDcimgmFmuLiIZ5R6DrxFQKtmWKpCUPrbVsS92uL6YCDhyndfygzFUPBJWEw2Rr
62vU0xYGFL/301/AHr9LEcVAWXE947kZ04CSOofaM1kRpMPKYGT14/O+tcmMy8N5
ANEOcD1eh8t3qOczIXj/TulUMDm7tEFrNfovHl9T+H1WXCu0kYXjo70tulR2YJIj
Hub/2y+TuV5fXDc9ScyeyCrRV4UvHjj7M/JY7KikRj4HsVnURdmylTSMu1lhAIGS
QSzvjze+PG2U26W3GLQJ1JCJPJNZciDGKa5TAYH7VkmM8FNz5Se/ONrMcpHSJeZd
sBwqEpRMfWkCGzg9hjvb7kEWEwA/OD6S4y61jS14TB9zFqRga4PlqcUi6ASLjg4d
adzxdHOxWlxx9BlJpyKZ
=nCME
-----END PGP SIGNATURE-----

--cxKfNEMCKDBLMjxpKingOc40isanCIpLq--
