From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: omap2plus_defconfig: enable TFP410 chip
 support
Date: Wed, 19 Dec 2012 17:26:13 +0200
Message-ID: <50D1DC95.8090003@ti.com>
References: <1355920420-20852-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF26A9FA42DC0BF9F390A60BB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39431 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab2LSP00 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 10:26:26 -0500
In-Reply-To: <1355920420-20852-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--------------enigF26A9FA42DC0BF9F390A60BB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-19 14:33, Javier Martinez Canillas wrote:
> Many OMAP3 based boards such as Beagle, Overo and IGEP use
> the TFP410 DPI-to-DVI chip. So, it's good to have it built
> as a module by default on OMAP2+ config.

Also on OMAP4 boards, like Panda.

> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.u=
k>
> ---
>  arch/arm/configs/omap2plus_defconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/om=
ap2plus_defconfig
> index a1dc5c0..da530a0 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -146,6 +146,7 @@ CONFIG_OMAP2_DSS_SDI=3Dy
>  CONFIG_OMAP2_DSS_DSI=3Dy
>  CONFIG_FB_OMAP2=3Dm
>  CONFIG_PANEL_GENERIC_DPI=3Dm
> +CONFIG_PANEL_TFP410=3Dm
>  CONFIG_PANEL_SHARP_LS037V7DW01=3Dm
>  CONFIG_PANEL_NEC_NL8048HL11_01B=3Dm
>  CONFIG_PANEL_TAAL=3Dm
>=20

For both patches:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--------------enigF26A9FA42DC0BF9F390A60BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQ0dyVAAoJEPo9qoy8lh71CTYQAIOO/J+9lmx8JUFEyUOBA1aC
yKn7T6cJo+OAcT/5zJGIjBrnbM+4vSXSMAhvAYIU/xRTIO91pwy0u7rPVrzvW5nV
zNHf8vJHZs2sUwBcvJwG/xEjHZ0dC5QFsm8H3bkrVPRw08ZsttyN11rCXuGWsA+w
O7c8SCPHRxjS2r6spO8+LV6cLyAuKhavSBkRFULBrUq6AeBc4vUIzbLo0PCTbSO5
l9AhinwZEhZ/Mavvr7BuVQxVBZAgpYCEVgJ1fLKFPgZnut77AkrKVpss21cJvNaJ
vCvEBLIRkcCDTiUxTB07t8agPjj2XP4fvah9n+RjA0i3U/lZh3N5YteKcHB6DB4e
/4rtJD4RYo/Acb9tWQ/9z++D7huQylcxxJoQzQTvpyVcUK3ZGP5hNEn1nposRToZ
Hlx3D3o6hz6zkXSz5zeTN2hYH5wqW6Ue5Kl7xP6x/zGXHqfIkBX/tg7U1iW+aFnO
CYkQYQb88T2XHrSOH1SgOL2rVVox8LwanGp6AIPZGN6MJDS36MqkjumaEJv8ir/K
zqgkqjRPezyuCaXJiXVaBOid6lGAXEwd8hgx5y2T96xwgf8A1IrMlln/J0etLM/8
RxZZICDcyg7bHWOMPzMfnQzOSYiD8DSemXbzaVZagtwH4DDEhtQeITg1dG+utPff
smUb0dhORMHRs+M353PS
=vbld
-----END PGP SIGNATURE-----

--------------enigF26A9FA42DC0BF9F390A60BB--
