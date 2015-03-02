From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 09/21] drm/omap: handle mismatching color format and buffer
 width
Date: Mon, 2 Mar 2015 12:32:40 +0200
Message-ID: <54F43C48.3080806@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>	<1424956829-22892-10-git-send-email-tomi.valkeinen@ti.com>	<20150227130158.GX24485@phenom.ffwll.local>	<CAPj87rP4675D9WY8eGUPCePcx7Oi+faYs5K4B_BGtyh1H4RmJA@mail.gmail.com>	<54F4326B.6040209@ti.com> <CAPj87rOranF8WA=cPiHv=XwLSRscBLfNi+BemUhObys2nb8YKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aMUt4b5hiMrejc7HJeocu4RLOL5AD72jW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50510 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052AbbCBKct (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Mar 2015 05:32:49 -0500
In-Reply-To: <CAPj87rOranF8WA=cPiHv=XwLSRscBLfNi+BemUhObys2nb8YKQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Stone <daniel@fooishbar.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>

--aMUt4b5hiMrejc7HJeocu4RLOL5AD72jW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/15 12:22, Daniel Stone wrote:

>> I don't know why Rob named it like that. "The bpp of the stride"? Shru=
g.
>=20
> It's just the bpp of the pixel format; it's not at all associated with
> the stride?

The comment says "this times width is stride", so I thought the naming co=
mes
from that train of thought. But I agree, it's just bpp.

Here's updated patch:

=46rom af0db526ae274d47488ec49577365909eb8f629d Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 25 Sep 2014 19:24:28 +0000
Subject: [PATCH] drm/omap: handle incompatible buffer stride and pixel si=
ze

omapdrm doesn't check if the pitch of the framebuffer and the color
format's bits-per-pixel are compatible. omapdss requires that the stride
of a buffer is an integer number of pixels

For example, when using modetest with a display that has x resolution of
1280, and using packed 24 RGB mode (3 bytes per pixel), modetest
allocates a buffer with a byte stride of 4 * 1280 =3D 5120. But 5120 / 3 =
=3D
1706.666... pixels, which causes wrong colors and a tilt on the screen.

Add a check into omapdrm to return an error if the user tries to use
such a combination.

Note: this is not a HW requirement at least for non-rotation use cases,
but a SW driver requirement. In the future we should study if also
rotation use cases are fine with any stride size, and if so, change the
driver to allow these strides.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_fb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/=
omap_fb.c
index 2975096abdf5..e123b4dee670 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -463,6 +463,14 @@ struct drm_framebuffer *omap_framebuffer_init(struct=
 drm_device *dev,
 			goto fail;
 		}
=20
+		if (pitch % format->planes[i].stride_bpp !=3D 0) {
+			dev_err(dev->dev,
+				"buffer pitch (%d bytes) is not a multiple of pixel size (%d bytes)\=
n",
+				pitch, format->planes[i].stride_bpp);
+			ret =3D -EINVAL;
+			goto fail;
+		}
+
 		size =3D pitch * mode_cmd->height / format->planes[i].sub_y;
=20
 		if (size > (omap_gem_mmap_size(bos[i]) - mode_cmd->offsets[i])) {
--=20
2.3.1




--aMUt4b5hiMrejc7HJeocu4RLOL5AD72jW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9DxIAAoJEPo9qoy8lh71ph0P/0yXQvrt4cMNkOoEHcnlqSX6
tF6wXuv/iU80NXTvPU1RX6oj94hDu3Bc8cK0kP4LTATdfcVgEHrcSee7kkzk/prU
ideWv6eWJkRhYZM48aVILtrY4vshKPjpYwTc4s+TtOVhI4ARn3Tua5NX1zUT83Ra
T7LODkHK0XnQxyghFZeKXm/vMEzeHX10vjuLa8NsgS3nM+d6DZu6DHztYEfzp+/u
1/B119YzEyq22WJuK7+BV6S12YLY7jfXXsC5f214uprpZMoNfbvKnx0dekKGlPwR
Q7tAUoj2UauxnSpVIrKntXCoAYQ/EBf6/ogzoc3lUQ+wBLpeRkozL32tq3hDKWqb
zrFnJH+wrhwts0nn2jkKYiqB5WNq06Zp+2CU2toZ3pU240V5Thw4+MUvmZYdTP7w
P+xzC+/aYhy22mC/w5JIKuiGV2TdlHuJUZtd1rmYmWYPGHg809dG2yryNGcXEaTN
of4JepJwFB/+PiM8MikzO2qCTSsgLlwvv/btxTSlvH9HmoPQ8RiOsQwQGx5f36Io
hCeLGg6ddbL2e0KXLJM2CTFH6VWz6E7t/u9YzkxVrHc4nx8ltSmMSangaI1ullrx
4UgmA3EL4gJgv8z50/NoGW6IQymp5kGHUjKl4xbeWdgeW/hJ3Fo5RRIimuesULsn
DEh0rfqb8MJiogIWy/wh
=FbLt
-----END PGP SIGNATURE-----

--aMUt4b5hiMrejc7HJeocu4RLOL5AD72jW--
