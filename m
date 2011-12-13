From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] OMAPDSS: Miscellaneous Fixes
Date: Tue, 13 Dec 2011 13:32:59 +0200
Message-ID: <1323775979.1877.59.camel@deskari>
References: <1323670663-17793-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-o7A5diaIFMLpaomJXcCS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:50189 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751634Ab1LMLdG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 06:33:06 -0500
Received: by lahj13 with SMTP id j13so422080lah.25
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 03:33:03 -0800 (PST)
In-Reply-To: <1323670663-17793-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org


--=-o7A5diaIFMLpaomJXcCS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-12-12 at 11:47 +0530, Archit Taneja wrote:
> These are some minor fixes for DSS2.
>=20
> Based on Tomi's master branch in:
>=20
> git://gitorious.org/linux-omap-dss2/linux.git
>=20
> Archit Taneja (3):
>   OMAPDSS: DSI: Fix HSDIV related PLL info in dsi_dump_clocks()
>   OMAPDSS: Panel NEC: Set omap_dss_device states correctly
>   OMAPDSS: Displays: Make PICODLP driver depend on DPI
>=20
>  drivers/video/omap2/displays/Kconfig               |    2 +-
>  .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   61 ++++++++++++++=
+++---
>  drivers/video/omap2/dss/dsi.c                      |   14 +++--
>  3 files changed, 61 insertions(+), 16 deletions(-)

I think these are fine. Applying to DSS tree. Thanks!

 Tomi


--=-o7A5diaIFMLpaomJXcCS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO5zfrAAoJEPo9qoy8lh71KqYQAJJu3O+nDvceHNujbRVI9CFE
EkvfC0xIBVVEqXKeYNC8R7VFejk2UaYjn9AuyQaRZI2ZN7nhCxC0aXmH0Hkhlp+u
QyEZa/GtELZVy5y389yUr7HJi2aKzrSwNsDm3jeI4W5/q5KO1h16o2jhdrYQGE/T
lgVxufOZZVBxiPCBq3IUkEy3cXArnBh2RagjlkCTy3DKfR6t9yz8NYX7dkn9ZktX
JKdraOf32wSXYyvju8l+DuLYem7fJQU1g88DpA/uvii/nf3z+xkTZ6W55baisHso
c00v/SoD4nxiSsBVkQZp4U9pB9SRIW7KkpRY8tQlchRopR3NPW1AWVkK6yP+gMb8
Yno7efOlYdEiGCUrRYj4lI78T9SB1iJI+kBOX3xLbF9aca/Gbwwtv02g8b3/XBan
1maVhuBKE6sus2omerF5CgSMwuhJnybCfZ/5vraz6lFUVUWCc+iqOIwa5HhApndN
DT60uiIMaAyUl41jqJf+61YLDYwbwN9Dh1rZ/YJn1ENw4DZ/anf9dysXiyYXpwKL
07NHA9Jair4Hw061hQLoYaRfG8dB8m4qcc1cFu+uRnpPgLg0dVdWdPBpNGFved7O
KecBsXHX/fOHPXV8+MvZsRO2J3kNtoukETrdeb4N9tLD77DjRfFOBcA0te6i1pgQ
hjxR9qU4Aj60vBYbwyEe
=yymA
-----END PGP SIGNATURE-----

--=-o7A5diaIFMLpaomJXcCS--

