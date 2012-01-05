From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 3/3] OMAPDSS: HDMI: Sysfs support to configure
 quantization
Date: Thu, 05 Jan 2012 09:21:31 +0200
Message-ID: <1325748091.2045.22.camel@deskari>
References: <1325677990-16414-1-git-send-email-mythripk@ti.com>
	 <1325677990-16414-2-git-send-email-mythripk@ti.com>
	 <1325677990-16414-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-UpnERhxqMEKw3N1wtf4/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:53993 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752132Ab2AEHVf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 02:21:35 -0500
Received: by mail-lpp01m010-f48.google.com with SMTP id m7so90741laa.35
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 23:21:34 -0800 (PST)
In-Reply-To: <1325677990-16414-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-UpnERhxqMEKw3N1wtf4/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-01-04 at 17:23 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Add sysfs support for the uset space to configure limited range or full r=
ange
> quantization for HDMI.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/dss.h          |    2 +
>  drivers/video/omap2/dss/dss_features.c |    1 +
>  drivers/video/omap2/dss/hdmi.c         |   28 +++++++++++++++++++++++++
>  drivers/video/omap2/dss/hdmi_panel.c   |   35 ++++++++++++++++++++++++++=
+++++-
>  drivers/video/omap2/dss/ti_hdmi.h      |    2 +
>  5 files changed, 67 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.=
h
> index 6308fc5..cf1f0f9 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -498,6 +498,8 @@ int omapdss_hdmi_display_check_timing(struct omap_dss=
_device *dssdev,
>  					struct omap_video_timings *timings);
>  int omapdss_hdmi_read_edid(u8 *buf, int len);
>  bool omapdss_hdmi_detect(void);
> +int omapdss_hdmi_get_range(void);
> +int omapdss_hdmi_set_range(int range);
>  int hdmi_panel_init(void);
>  void hdmi_panel_exit(void);
> =20
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2=
/dss/dss_features.c
> index b402699..c7e71b9 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -465,6 +465,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functio=
ns =3D {
>  	.dump_core		=3D	ti_hdmi_4xxx_core_dump,
>  	.dump_pll		=3D	ti_hdmi_4xxx_pll_dump,
>  	.dump_phy		=3D	ti_hdmi_4xxx_phy_dump,
> +	.configure_range	=3D	ti_hdmi_4xxx_configure_range,
> =20
>  };
> =20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
> index 4bb7678..ae7918e 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -378,6 +378,34 @@ static void hdmi_power_off(struct omap_dss_device *d=
ssdev)
>  	hdmi_runtime_put();
>  }
> =20
> +int omapdss_hdmi_set_range(int range)

Range is an enum, not an int.

> +{
> +	int r =3D 0;
> +	enum hdmi_range old_range;
> +
> +	old_range =3D hdmi.ip_data.range;
> +	hdmi.ip_data.range =3D range;
> +
> +	/* HDMI 1.3 section 6.6 VGA (640x480) format requires Full Range */
> +	if ((range =3D=3D 0) &&

Range is an enum, not an int.

> +		((hdmi.ip_data.cfg.cm.code =3D=3D 4 &&
> +		hdmi.ip_data.cfg.cm.mode =3D=3D HDMI_DVI) ||
> +		(hdmi.ip_data.cfg.cm.code =3D=3D 1 &&
> +		hdmi.ip_data.cfg.cm.mode =3D=3D HDMI_HDMI)))
> +			return -EINVAL;
> +
> +	r =3D hdmi.ip_data.ops->configure_range(&hdmi.ip_data);
> +	if (r)
> +		hdmi.ip_data.range =3D old_range;
> +
> +	return r;
> +}
> +
> +int omapdss_hdmi_get_range(void)

Range is an enum, not an int... I won't comment on any more of these
cases, please check all uses of range.

> +{
> +	return hdmi.ip_data.range;
> +}
> +
>  int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
>  					struct omap_video_timings *timings)
>  {
> diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/d=
ss/hdmi_panel.c
> index 533d5dc..c0aa922 100644
> --- a/drivers/video/omap2/dss/hdmi_panel.c
> +++ b/drivers/video/omap2/dss/hdmi_panel.c
> @@ -33,6 +33,33 @@ static struct {
>  	struct mutex hdmi_lock;
>  } hdmi;
> =20
> +static ssize_t hdmi_range_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	int r;
> +
> +	r =3D omapdss_hdmi_get_range();
> +	return snprintf(buf, PAGE_SIZE, "%d\n", r);
> +}
> +
> +static ssize_t hdmi_range_store(struct device *dev,
> +	struct device_attribute *attr,
> +	const char *buf, size_t size)
> +{
> +	unsigned long range;
> +	int r =3D kstrtoul(buf, 0, &range);
> +
> +	if (r || range > 1)
> +		return -EINVAL;
> +
> +	r =3D omapdss_hdmi_set_range(range);
> +	if (r)
> +		return r;
> +
> +	return size;
> +}

I don't like to add a new custom userspace API, but I guess we don't
have much choice.

However, I don't think using 0 and 1 in the API is very good. The
choices with range should probably be "full" and "limited".

Btw, I tried to apply this patch set on top of dss master with and
without the "improve the timings..." patch set, and failed both. What
are these patches based on?

 Tomi


--=-UpnERhxqMEKw3N1wtf4/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPBU92AAoJEPo9qoy8lh71VYMQAKk4n3eWWy8IrruM/BCJvaCh
sVeI1WLGtwuz81ABtH+5lNEGRHYtoZTgCMJZqNSnpuYgBxQ7y38vzN8RTTtLKyua
y1O90u+0i2AEel3+BdFOp83ZS5Jbcugydohx1qKMSvxAv7ZvayfcpsTqYJwSE60P
7Ee41qdJztWto/zqmDJ0HOm4DnVOYpogwNx9nJYZNSV3jdBEhQmy2pQfQw0SXbDh
Mhh1U86DuASaMsKbVYDT64dFlisv1jZQ4k6a94sGDZLYB+K7q9nqljMi0gzxI6T8
NoijtPxKi9uDFUrJGKnDb0jHTyxJooVkplplZjdQf6dtkFVXsEEirYQWdv5wtLuT
29UzmUAsFWiqCyBeQsf6NP2vZCskJhXgpgWGOTyGzJJb1IYDEG2pPLGv8zAZ5+XZ
lpZmuAAl8hf75RGAEIIEIYx8GD3Ly04oZIaUMJAaJQsP4wLI/3BCIjq+b9NvCa5M
XA6oAKC05uSL6BJfGdn+GIiqbRi/GJNrNwrbEfnDXIPXIOZdUkkmAXIfH60NFY8h
0P1sLym7MhBjgp585Z/ENUafWI7sR9q0qytrMb5fAHyOS0I+VFwSb5XOaOp1Wow5
NTVWR0qwNadaVw5xOLBItNImWQo0fFHvryRqGf1QkjyVaWZL0y+Ua2oLm8j/NooN
+KoFiLAwJK58/0NWYnrI
=j6vp
-----END PGP SIGNATURE-----

--=-UpnERhxqMEKw3N1wtf4/--

