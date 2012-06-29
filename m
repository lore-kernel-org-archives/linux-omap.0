From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] staging: drm/omap: add rotation properties
Date: Fri, 29 Jun 2012 13:46:03 +0300
Message-ID: <1340966763.2767.8.camel@deskari>
References: <1340805986-10670-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-TKsBjq9ilEo3nBot3v0F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:46569 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754211Ab2F2KqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 06:46:09 -0400
Received: by lbbgm6 with SMTP id gm6so5405873lbb.33
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 03:46:06 -0700 (PDT)
In-Reply-To: <1340805986-10670-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>, cmahapatra@ti.com, s-guiriec@ti.com, archit@ti.com, Rob Clark <rob@ti.com>


--=-TKsBjq9ilEo3nBot3v0F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-27 at 09:06 -0500, Rob Clark wrote:
> From: Rob Clark <rob@ti.com>
>=20
> Use tiled buffers for rotated/reflected scanout, with CRTC and plane
> properties as the interface for userspace to configure rotation.
>=20
> Signed-off-by: Rob Clark <rob@ti.com>

> +/* this should probably be in drm-core to standardize amongst drivers */
> +#define DRM_ROTATE_0	0
> +#define DRM_ROTATE_90	1
> +#define DRM_ROTATE_180	2
> +#define DRM_ROTATE_270	3
> +#define DRM_REFLECT_X	4
> +#define DRM_REFLECT_Y	5

Are both reflect X and Y needed? You can get all the possible
orientations with just one of the reflects.

And I think the word "mirror" represents nicely what the reflect does,
i.e. if you look at the mirror, the image you see is flipped
horizontally.

 Tomi


--=-TKsBjq9ilEo3nBot3v0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7YdrAAoJEPo9qoy8lh71HqwP/jDVtLsWSFEEw4lxQNF/mTp2
amokWhiEYge3e+4eMPitk33E7VudxsknsSwxtzD046fBmPAF20GX9NrCmaZ8jFnO
zD2rneyEyt5j46OHX2pmidf2Vzu/AoB62dTsmJ2wNNLDkL2egWAiCMPMbutx1DXW
jodYmjaSQi/lg1Gp7on3zu/VbVHCb/p5OqM4eFFdATyIR4xWCEOhImoh0BaIVvLI
s/MwK7YIDkD8WjiAg6oOX1ckF6olj3aBv66oB0vV+U8J1pdAliTgHOCREX1Ir0cl
Zz6Ju3DD9LF3NIWaeJ16tfFNXig6DFioXuCvqGZ9fQEqk0XAZ0EGLlw4J/WgVc3N
Sp3/pDG1tHnkIc6M4+/U9c4/3Rp+/Kufby13dAVNaCThae/MM4Y7tCupS+jXrLtw
IK8BIuiphTzmEafiwFpG9qsWmrENbvrgRkC8/wLblTeAxkWbjIde1wSJVStuSFTZ
xkkBrXPwN3hAeOreBNnZ4lwj5iuEQN+nV97/5ElkOGRb7MERDpk7PKitdupamV7x
+OXgafQ2fro/V29xUk1LawSlC1WaImVWMVpc5TVbYwtzcsIBbuObU+tgYOgMm1cB
HtSL9ZDP4c/ykgOg0ebI+4zO8+AHbTt2Ok2b8P7kUoamq/ZEh3ejze+IcBt4DV/g
cSg1r0881rlo/PG2BKMm
=wdHw
-----END PGP SIGNATURE-----

--=-TKsBjq9ilEo3nBot3v0F--

