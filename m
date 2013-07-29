From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 2/2] driver: spi: Add quad spi read support
Date: Mon, 29 Jul 2013 12:32:58 +0300
Message-ID: <20130729093258.GF23710@radagast>
References: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com>
 <1375082550-30544-3-git-send-email-sourav.poddar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oxV4ZoPwBLqAyY+a"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51247 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955Ab3G2JdT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 05:33:19 -0400
Content-Disposition: inline
In-Reply-To: <1375082550-30544-3-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com, balbi@ti.com

--oxV4ZoPwBLqAyY+a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2013 at 12:52:30PM +0530, Sourav Poddar wrote:
> Since, qspi controller uses quad read.
>=20
> Configuring the command register, if the transfer of data needs
> dual or quad lines.
>=20
> This patch has been done on top of the following patch[1], which is just =
the
> basic idea of adding dual/quad support in spi framework.
> $subject patch will undergo changes with the ongoing discussion in the
> community.
>=20
> This patch is posted to demonstrate how patch 1 of the series will support
> quad read.
>=20
> [1]: http://comments.gmane.org/gmane.linux.kernel.spi.devel/14047
>=20
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  drivers/spi/spi-ti-qspi.c |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 51fe95f..8a32b1c 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -86,6 +86,7 @@ struct ti_qspi {
>  #define QSPI_3_PIN			(1 << 18)
>  #define QSPI_RD_SNGL			(1 << 16)
>  #define QSPI_WR_SNGL			(2 << 16)
> +#define	QSPI_RD_DUAL			(3 << 16)
>  #define QSPI_RD_QUAD			(7 << 16)

so RD_QUAD is defined in previous patch but not RD_DUAL ? What gives ?

IMHO, just merge this patch with previous and make the entire driver
depend on the other patch.

--=20
balbi

--oxV4ZoPwBLqAyY+a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR9jbKAAoJEIaOsuA1yqREyqkP/0Hlz02fH1NExj8nI7xfEyVt
uhoWRa80zjZKFXmKymHkkA2XYt/M2vAAAU2YBLifA7g3R/v0UdgBfm0ZG1QKJEin
gbxAiwxelGifJx5VOzh+SyJ/TrnU0o9TUC3QFJ5E9bImpDE73dboB/xxiQ+r4pov
BPieUV6gCVXxN39H0lo9dzC4MKZfzzeUQ7gPr08qndcpsG4UuQgU6hdqNWcacJBh
ba5XZWn6yWBRDLXkarTeYZboYoXPGBfx5vE2tETFQgqq6gncFIFuBwl/Il+g5GgT
AMA2/INgb/ZisgiXBFDXCxHQMZYCUoQ9BWLFpQaJCcHnIXDjhldsP4u1FAGQJZz9
Jw7fMC2qtEZ//7TqALks1/uxA/x/ubi9OYA/N8bkj1IExev9ohRNtQptJyJY/nE1
ApDwucW0RQaO7o1fXwECd0rh/WMgHM+W9Haeo2/gaYHJv9NcFUgBTfbxCxNjE8X8
kc2HFnbP1A9oHazWDaPgHHjw4E7KGe7nisN0tv9RdMtcJPgdJxJTNEK7MjJ0gG8k
Z+gS/B/1BhW324QJRvO9BZTNTutHsNxADn4aSlpvjw8BQscMicR3gdzXaIqWnnn6
zW3CmFTDVIGVXJNNp0aNAco/DKszqizhQBgqEtsX/e7tYdY/jeuRY4yWRuWUs48/
kxjDsWG0SoH5/n53j30F
=TQey
-----END PGP SIGNATURE-----

--oxV4ZoPwBLqAyY+a--
