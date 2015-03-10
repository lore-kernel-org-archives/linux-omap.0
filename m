From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 6/7] drm/tilcdc: Force building of DRM_TILCDC_SLAVE_COMPAT
Date: Tue, 10 Mar 2015 13:40:09 +0200
Message-ID: <54FED819.6070003@ti.com>
References: <cover.1425656120.git.jsarha@ti.com> <59153f75fc48a34c9f36ebfdf7e6efe21bd03866.1425656120.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="rQg2SmCNru0gpQ1DJfniqaCQ8UhJ36Dot"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40369 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbbCJLk3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Mar 2015 07:40:29 -0400
In-Reply-To: <59153f75fc48a34c9f36ebfdf7e6efe21bd03866.1425656120.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, rmk+kernel@arm.linux.org.uk, robdclark@gmail.com, moinejf@free.fr

--rQg2SmCNru0gpQ1DJfniqaCQ8UhJ36Dot
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/03/15 17:36, Jyri Sarha wrote:
> If I read Documentation/kbuild/makefiles.txt section 3.6 right, this
> patch should not be needed. However, without this patch the objects
> needed for DRM_TILCDC_SLAVE_COMPAT are not linked, if DRM_TILCDC is
> built as module.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/gpu/drm/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 2c239b9..ad7f10f 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_DRM_RCAR_DU) +=3D rcar-du/
>  obj-$(CONFIG_DRM_SHMOBILE) +=3Dshmobile/
>  obj-$(CONFIG_DRM_OMAP)	+=3D omapdrm/
>  obj-$(CONFIG_DRM_TILCDC)	+=3D tilcdc/
> +obj-$(CONFIG_DRM_TILCDC_SLAVE_COMPAT) +=3D tilcdc/
>  obj-$(CONFIG_DRM_QXL) +=3D qxl/
>  obj-$(CONFIG_DRM_BOCHS) +=3D bochs/
>  obj-$(CONFIG_DRM_MSM) +=3D msm/

I don't think it's a good idea to enter the directory twice. Maybe it
works fine, I don't know, but I'd suggest just using "obj-y" above.

 Tomi



--rQg2SmCNru0gpQ1DJfniqaCQ8UhJ36Dot
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/tgZAAoJEPo9qoy8lh71G60P/0wi4NS2DnGvnoevGW2IWUYi
cDP/71XhQyFaGPGS8DP2l7Re+l+6FjnyAHPBql+IRnQAWclhFMfPaMR1xnsQNbO7
CE534YvC/qCRpKIuBHSpJ27CUJAnyrNPKDKAJBB7zZ2SUPGUqihnetXhIQMeAfuX
7TzTUAIuYXv/ZyMXPNap7Ye5cNBHW0tgm0GQmNJUKZKKMBD8C7jApY64B/WjkTs/
Y3FNpqIJQlkXuxnM4RlKzEbGORBgEZQRqEK6An8lVhZ+EL5uf0lz+BHVrurMnC12
4Qz7FV015jMT4Pl8BeQ33AMTwbUJ/njRpUjhlWv4kdeuQPqB1JhL9fBsEg1iAVeG
SNqF3z+EMkvf+Fw/ogki0oqD4yltfffeds2riV9WTAwTT5406TZ41jmivOmcNNqw
CHiylaz57FLcsfNG1q5E60rS3IEj1oMwFtDDIX7C16KJETfmM+gO+TQ4Uu7Nn/li
XvDeZd+RBzo4LhdPmgAmI4FIE56ZLWch+xjM8uNefrh1OkaisWTt8FTFzXXmJPEZ
xfZFskqxjXFIbwK1Yu8Hh9x5PmjXZWG04LMqd7IYzrcQpxs+VrBMlojb6yRi9DNJ
jAXk6RNjGe1jUbZhi8FoGQKgdhXFYOQTUT9yt4S7Q2a7VisvSob3HCtszYYWGKnK
ZN2i6xmzNUkXf/gzY730
=yZRa
-----END PGP SIGNATURE-----

--rQg2SmCNru0gpQ1DJfniqaCQ8UhJ36Dot--
