From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: provide default get_timings function for
 panels
Date: Wed, 21 Mar 2012 15:11:59 +0200
Message-ID: <1332335519.2236.19.camel@deskari>
References: <1331834424-485-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2a+ZuUqCmfQEdx6vq5pM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:52295 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932111Ab2CUNMF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 09:12:05 -0400
Received: by mail-lb0-f173.google.com with SMTP id n3so1037276lbo.18
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 06:12:02 -0700 (PDT)
In-Reply-To: <1331834424-485-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-2a+ZuUqCmfQEdx6vq5pM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-03-15 at 20:00 +0200, Grazvydas Ignotas wrote:
> With this we can eliminate some duplicate code in panel drivers.
> Also lgphilips-lb035q02, nec-nl8048hl11-01b, picodlp and
> tpo-td043mtea1 gain support of reading timings over sysfs.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  drivers/video/omap2/displays/panel-acx565akm.c   |    7 -------
>  drivers/video/omap2/displays/panel-generic-dpi.c |    7 -------
>  drivers/video/omap2/displays/panel-n8x0.c        |    8 --------
>  drivers/video/omap2/displays/panel-taal.c        |    8 --------
>  drivers/video/omap2/dss/core.c                   |    2 ++
>  drivers/video/omap2/dss/display.c                |    7 +++++++
>  drivers/video/omap2/dss/venc.c                   |    7 -------
>  include/video/omapdss.h                          |    2 ++
>  8 files changed, 11 insertions(+), 37 deletions(-)

These two patches look fine to me, I'll apply to omapdss tree. Thanks!

 Tomi


--=-2a+ZuUqCmfQEdx6vq5pM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPadOfAAoJEPo9qoy8lh71Kr4P/1x0kyB8fv1hO+xRl1jehqwF
OeYg2e+gi6Y0R/KmtFptSEh3uq4X0pggVdtZtjj7luPXl2aWYisc6iumB2WGTG15
i6VR+ps2JfFN8INFEDzDmn4Sj4vgqU/7qjdXM0acTTj3Ks9jdhAaCtg3dtB3Y+zR
EQjxXNJVSlCXyj4rIY7HgXBwCqkWVUMogijrWI3UjC5NgXmR5AqzmlCSH0GleQHQ
ea2a6ruDNdzj2bKJ5ys4vRi/jUZhkq+HicgBw9Ss4fuGUM9mHiz2cituiEo+k5DC
G8slBRhlnNc9nP2NBY7Ja6UIXtnccqH1NzJde5hqb0Q3Bw04P4aktSN6wA5GELXL
v5ZzYn4l0U0wgfOybTrGv384bkLNSo29FSox9jXnFS0rsHNLPdlVB+pynCEnfRSZ
QsxNeXsuD9yCXjzXR1FvOaBuGznQJewChJw+8gN58Gfz56pVuAoZQI1CZetbfZfQ
B/xaqxZVmTfw/hd28mzM/ajzPQF35SWEFh111bhGHVQSmc/XvzH+wmGakniZBHEU
UllDJpf4neWpbG853HAwlmeBcw90vJhMmaVMtGGjey08+fZm7daSB4xDzTosiGTy
s9txNhyjwttv456JSvTw51qxdwu34VgasXfTff7CCbY/6FPuNedhkBQ6aEd353H3
ioMAx8aLeT6cQmz0A9TB
=HzVT
-----END PGP SIGNATURE-----

--=-2a+ZuUqCmfQEdx6vq5pM--

