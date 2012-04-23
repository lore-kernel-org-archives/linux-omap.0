From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: VENC: allow switching venc type at runtime
Date: Mon, 23 Apr 2012 15:23:22 +0300
Message-ID: <1335183802.30659.17.camel@deskari>
References: <1332978312-11959-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-gn6aNvWVFyH/vdomupyE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46159 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754565Ab2DWMX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 08:23:29 -0400
Received: by laap9 with SMTP id p9so10368766laa.24
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 05:23:26 -0700 (PDT)
In-Reply-To: <1332978312-11959-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-gn6aNvWVFyH/vdomupyE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-03-29 at 02:45 +0300, Grazvydas Ignotas wrote:
> VENC type (composite/svideo) doesn't have to be fixed by board wiring,
> it is possible to provide both connectors, which is what pandora does.
> Having to recompile the kernel for users who have TV connector types
> that's don't match default board setting is very inconvenient, especially
> for users of a consumer device, so add support for switching VENC type
> at runtime over a new sysfs file venc_type.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  Documentation/arm/OMAP/DSS     |    1 +
>  drivers/video/omap2/dss/venc.c |   55 ++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 55 insertions(+), 1 deletions(-)
>=20
> diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
> index 888ae7b..18e2214 100644
> --- a/Documentation/arm/OMAP/DSS
> +++ b/Documentation/arm/OMAP/DSS
> @@ -156,6 +156,7 @@ timings		Display timings (pixclock,xres/hfp/hbp/hsw,y=
res/vfp/vbp/vsw)
>  		"pal" and "ntsc"
>  panel_name
>  tear_elim	Tearing elimination 0=3Doff, 1=3Don
> +venc_type	Output type (video encoder only): "composite" or "svideo"

I think we could have a better name here. "venc" name is quite obscure
on the user level. And it's not even quite correct, venc stays the same,
it's just the output that is changed. "output_type"? "connector"?
"connector_type"?

>  There are also some debugfs files at <debugfs>/omapdss/ which show infor=
mation
>  about clocks and registers.
> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/ven=
c.c
> index 9c3daf7..aa2e74a 100644
> --- a/drivers/video/omap2/dss/venc.c
> +++ b/drivers/video/omap2/dss/venc.c
> @@ -485,16 +485,69 @@ unsigned long venc_get_pixel_clock(void)
>  	return 13500000;
>  }
> =20
> +static ssize_t display_venc_type_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct omap_dss_device *dssdev =3D to_dss_device(dev);
> +	const char *ret;
> +
> +	switch (dssdev->phy.venc.type) {
> +	case OMAP_DSS_VENC_TYPE_COMPOSITE:
> +		ret =3D "composite";
> +		break;
> +	case OMAP_DSS_VENC_TYPE_SVIDEO:
> +		ret =3D "svideo";
> +		break;
> +	default:
> +		ret =3D "unknown";
> +		break;
> +	}

Would it be better to return an error here? It would be nice to have
matching input and output for the sysfs file. And generally speaking,
the default branch should never happen.

> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", ret);
> +}
> +
> +static ssize_t display_venc_type_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t size)
> +{
> +	struct omap_dss_device *dssdev =3D to_dss_device(dev);
> +	enum omap_dss_venc_type new_type;
> +
> +	if (strncmp("composite", buf, 9) =3D=3D 0)
> +		new_type =3D OMAP_DSS_VENC_TYPE_COMPOSITE;
> +	else if (strncmp("svideo", buf, 6) =3D=3D 0)
> +		new_type =3D OMAP_DSS_VENC_TYPE_SVIDEO;

Here you could use sysfs_streq().

 Tomi


--=-gn6aNvWVFyH/vdomupyE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPlUm6AAoJEPo9qoy8lh71y+wP/iJWpIlQ78jtrEM/IJ/g+jc5
mxNiZXz8Z7DLO/EmAfsen1wO8WA1ebWvjIulINcCTPYXp7Yml9oMPPpqI56WdUUr
3SjUu7o66o2rL5oAUGboF0Edar4vrQtaPrJEtgMnLTX4NRApJu6G/xZz1iO3POPN
1tsjLQFbVWseRzGF186aiUpJKHh8aBQ5YhC0shEqOwCbrUUDqXhNBNZEDU7D3Boq
F3Fbt7+t7lYRkijeKOaun+0MyrOvGbvdbiHr6juSq4aRsHJkg0wcXC5To1VSzl2J
0kzJe2LiY1aO7CRQfZreTuMi1BnLP0sxyn8MquP8oRh6smEGlE5cTROyQ3598o/4
QzP/tQDWAeOzxNOEX9kAty5vwQbgyEKXfhDBuwqamhcQvl+UDjICtThuMqRL/Bjb
5XrZ0RpS1Ss+sHof/zmCtGau7icwobMcAb/ie0RiAZOa/2MboI4xV35a5n2PqrDA
Vg9u4IyeRnus6Qy069gXv87dlUU61x4Ei5iSaWWdtr5AjeakuIy96wxbAMEtGwMM
1v3+5gmU3SEmHJJ4V3RlaNHXDJ7FYBdE/FrlJ14V50hImMbzcU1Fl4b6+lt/+737
pRrcTimnJXsYVaVfDeNZSFB68LD4yldQf9/SlyYENdLPSle31emhSRkhj7d9xSyp
zAgJ1bLHp0yO+yqc/8A+
=WZXH
-----END PGP SIGNATURE-----

--=-gn6aNvWVFyH/vdomupyE--

