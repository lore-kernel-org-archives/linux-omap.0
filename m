From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 03/12] OMAPDSS: hdmi_wp: Add function for getting hdmi_wp
 physical base address
Date: Fri, 27 Jun 2014 13:41:54 +0300
Message-ID: <53AD4A72.5050905@ti.com>
References: <cover.1403807781.git.jsarha@ti.com> <71e703f319eacd5a7196d8b34601b52e32b946d3.1403807781.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="BchNkTVd9aFBhkG5f0O8AIG0jfN0mX2kp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52640 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbaF0KmV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 06:42:21 -0400
In-Reply-To: <71e703f319eacd5a7196d8b34601b52e32b946d3.1403807781.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

--BchNkTVd9aFBhkG5f0O8AIG0jfN0mX2kp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/06/14 22:20, Jyri Sarha wrote:
> The hdmi_wp physical base address is needed for hdmi audio dma.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/video/fbdev/omap2/dss/hdmi.h    |    2 ++
>  drivers/video/fbdev/omap2/dss/hdmi_wp.c |    6 ++++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev=
/omap2/dss/hdmi.h
> index 1f01068..927cb4d 100644
> --- a/drivers/video/fbdev/omap2/dss/hdmi.h
> +++ b/drivers/video/fbdev/omap2/dss/hdmi.h
> @@ -250,6 +250,7 @@ struct hdmi_core_audio_config {
> =20
>  struct hdmi_wp_data {
>  	void __iomem *base;
> +	phys_addr_t phys_base;
>  };
> =20
>  struct hdmi_pll_data {
> @@ -317,6 +318,7 @@ void hdmi_wp_video_config_timing(struct hdmi_wp_dat=
a *wp,
>  void hdmi_wp_init_vid_fmt_timings(struct hdmi_video_format *video_fmt,=

>  		struct omap_video_timings *timings, struct hdmi_config *param);
>  int hdmi_wp_init(struct platform_device *pdev, struct hdmi_wp_data *wp=
);
> +phys_addr_t hdmi_wp_get_phys_addr(struct hdmi_wp_data *wp);
> =20
>  /* HDMI PLL funcs */
>  int hdmi_pll_enable(struct hdmi_pll_data *pll, struct hdmi_wp_data *wp=
);
> diff --git a/drivers/video/fbdev/omap2/dss/hdmi_wp.c b/drivers/video/fb=
dev/omap2/dss/hdmi_wp.c
> index 496327e..eadd4ed 100644
> --- a/drivers/video/fbdev/omap2/dss/hdmi_wp.c
> +++ b/drivers/video/fbdev/omap2/dss/hdmi_wp.c
> @@ -247,6 +247,7 @@ int hdmi_wp_init(struct platform_device *pdev, stru=
ct hdmi_wp_data *wp)
>  		DSSERR("can't get WP mem resource\n");
>  		return -EINVAL;
>  	}
> +	wp->phys_base =3D res->start;
> =20
>  	wp->base =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(wp->base)) {
> @@ -256,3 +257,8 @@ int hdmi_wp_init(struct platform_device *pdev, stru=
ct hdmi_wp_data *wp)
> =20
>  	return 0;
>  }
> +
> +phys_addr_t hdmi_wp_get_phys_addr(struct hdmi_wp_data *wp)
> +{
> +	return wp->phys_base;
> +}
>=20

Maybe it would be better to have a function which returns the phys
address for audio DMA? Only that one register is needed, right?

That makes the purpose of the function more obvious, and also if you
return the phys_base, the caller needs to know the offset to the DMA
register, and that offset should be a WP internal value.

 Tomi



--BchNkTVd9aFBhkG5f0O8AIG0jfN0mX2kp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrUp3AAoJEPo9qoy8lh71YyMP+gKL+AUAvGWlxcO4V58MNCKr
6/lLXr24pej2DN8l/RIJdUm8FvR9dBc6KtYWA9VGM6XtIjouDC0S6tOa+NsXmNkE
rLAycEB3/eIh7PVPGs28lQ2e/hrr+gWPzBDgKFxqfGBr375PRIhVWNU1YGaRAZd0
0hMztSDUXlmoVHeuFv+OUGZO0mhi/S0lWjzOZ2UDjcO4CIJN1pZk20HNXKTs66JX
dqvjEyA9c9mfaVnwZ9+NaRv1tOy5yJMmyo3r/5ZZBgptiLWUgnW3z77dOXkaHkZp
4vMtr1YOfCIVR+8mYKwlq46BMHLK2+i0PH6yVVqTqDbtkJGR/eYSqXMVXCBj+GSI
VGSUYPg5V+8+riyQvSrINeCr0fB3u3Y0HYurFc+hLTXR26FQb1b5apgwbxcTa8EM
3V82tTW2MHeMj7eZksJBXeF85SjL00V9NB/vgqQ31+tAwGshO64J1Hv07FOJwbfp
0ETVr3TVjPxEUEJYGivEETLBfNozcZPW/v6wY1XkGs4DSz+dtZ+kFGJzrSmmHEK4
Z27MqnufwomG6pun/PB3qvqo/BeMgu1wG6vYzALr24d/mJfRYBClJQyWbdxxe7ZP
Bp+Nj7HQTQTmnkAmhL37TR65OSjQKZYxs+qvbVN9TybBeK56sko+uka30bc/VyPx
PWxwi0AL/J2dTdsRDCsm
=5wW6
-----END PGP SIGNATURE-----

--BchNkTVd9aFBhkG5f0O8AIG0jfN0mX2kp--
