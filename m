From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 42/65] OMAPDSS: DSI: call mgr_enable/disable for cmd
 mode displays
Date: Wed, 23 Nov 2011 13:27:32 +0200
Message-ID: <1322047652.28917.64.camel@deskari>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
	 <1321953724-6350-43-git-send-email-tomi.valkeinen@ti.com>
	 <4ECCC68C.7070106@ti.com> <1322044977.28917.57.camel@deskari>
	 <4ECCD44A.2070008@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-NDIi1yov3qex39kokdAd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:54462 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752177Ab1KWL1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 06:27:42 -0500
In-Reply-To: <4ECCD44A.2070008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com


--=-NDIi1yov3qex39kokdAd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-11-23 at 16:38 +0530, Archit Taneja wrote:
>=20
> I think it would be best to stuff the 'video mode enabling and
> manager=20
> enabling' functionality in omapdss_dsi_display_enable() itself, the=20
> panel driver shouldn't need to call a function separately to enable=20
> video mode for the panel. This way we would be more along the lines
> of=20
> the dpi driver, where dpi_display_enable() enables the manager in the
> end.=20

But we need to configure the panel between enabling the DSI interface
and enabling the video output, so we can't combine those two functions.

For DPI things are simpler, as enabling the interface and the video
output are more or less the same thing.

 Tomi


--=-NDIi1yov3qex39kokdAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOzNikAAoJEPo9qoy8lh7163QP/3C6YxsFWkZNB3e5HhmC4+po
qYNNBnOzeoF/zWv1vZ8W8tgw5pt9s0BPbosjKsB0j8bqtO+1YzI9FfUstpMM74xX
gNVY8EA1t+/cjUeGL/QHqRckXMOdogkLsYxZCmAqwLxt5B6xQffGuhUU8jdq0LSG
jCBJ5RYzD8CPigVdvGiexi4khSzuHhWaP33q69WRi5B6Z2E6QghB94M1GvRjlzTr
0XzgZvxSsMVgjadqRky6k0LMXrguuw0acv6QAkx/pyW8B/x/HoddgKNvJJyVe00e
qQ6EDZk7i2YolCCxodic2RnJJRu00cKGSDym3oqIqlKZZDqZXv097XtdT3TXoCjJ
LvTeUMRq/X6OmObsIusQKeCzHADVvxfWUM6upmHoz2fJ0g41GDiO2LhViaJhdKCb
bOYvuUlXYPpnPH0yJni/RZWKNdNrjoxIhsN+Af30qlC/+JonypQYAeSKK9rrlmAt
ARtXtcbvkjEUkM0ajk0wcH6x47Uk3xprkYx0H0JWfdzEudb0wuawJMw4d4tvAAdb
oOV3bhyeM5N9kdJBST7ijlOYMg1ay8xWe6673xx8AOdcTVx6s4d/IDOO9UXQPCKP
y0uebV///XXgplmLEvMl6KyN1FXs7R7aKaeb2kK1g992M0rBYdblpr1O2wK9f06n
N2hMaULbpbRlLbRuZ2uO
=iPz9
-----END PGP SIGNATURE-----

--=-NDIi1yov3qex39kokdAd--

