From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 3/3] OMAPDSS: HDMI: Sysfs support to configure
 quantization range
Date: Mon, 09 Jan 2012 09:09:40 +0200
Message-ID: <1326092980.1900.20.camel@deskari>
References: <1325852929-5609-1-git-send-email-mythripk@ti.com>
	 <1325852929-5609-2-git-send-email-mythripk@ti.com>
	 <1325852929-5609-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-YIgnMC9WtdwrisAUQAbm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:42039 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753475Ab2AIHJp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 02:09:45 -0500
Received: by lagv3 with SMTP id v3so1479065lag.0
        for <linux-omap@vger.kernel.org>; Sun, 08 Jan 2012 23:09:42 -0800 (PST)
In-Reply-To: <1325852929-5609-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-YIgnMC9WtdwrisAUQAbm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-01-06 at 17:58 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Add sysfs support for the uset space to configure limited range or full r=
ange

"User" typoed.

> quantization for HDMI.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/dss.h          |    2 +
>  drivers/video/omap2/dss/dss_features.c |    1 +
>  drivers/video/omap2/dss/hdmi.c         |   28 +++++++++++++++++++++++
>  drivers/video/omap2/dss/hdmi_panel.c   |   39 ++++++++++++++++++++++++++=
+++++-
>  drivers/video/omap2/dss/ti_hdmi.h      |    2 +
>  5 files changed, 71 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.=
h
> index 3cf99a9..0b1b6f2 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -518,6 +518,8 @@ int omapdss_hdmi_display_check_timing(struct omap_dss=
_device *dssdev,
>  					struct omap_video_timings *timings);
>  int omapdss_hdmi_read_edid(u8 *buf, int len);
>  bool omapdss_hdmi_detect(void);
> +int omapdss_hdmi_get_range(void);
> +int omapdss_hdmi_set_range(enum hdmi_range range);
>  int hdmi_panel_init(void);
>  void hdmi_panel_exit(void);
> =20
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2=
/dss/dss_features.c
> index afcb593..544b172 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -476,6 +476,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functio=
ns =3D {
>  	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
>  	.audio_enable		=3D       ti_hdmi_4xxx_wp_audio_enable,
>  #endif
> +	.configure_range	=3D	ti_hdmi_4xxx_configure_range,
> =20
>  };
> =20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
> index 92a6679..65397f7 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -384,6 +384,34 @@ static void hdmi_power_off(struct omap_dss_device *d=
ssdev)
>  	hdmi_runtime_put();
>  }
> =20
> +int omapdss_hdmi_set_range(enum hdmi_range range)
> +{
> +	int r =3D 0;
> +	enum hdmi_range old_range;
> +
> +	old_range =3D hdmi.ip_data.range;
> +	hdmi.ip_data.range =3D range;
> +
> +	/* HDMI 1.3 section 6.6 VGA (640x480) format requires Full Range */
> +	if ((range =3D=3D HDMI_LIMITED_RANGE) &&
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

The error handling here doesn't look valid. The VGA case doesn't restore
the old_range, and generally speaking, storing the old value and
restoring it in the error case is not very nice.

You should first do the argument checks, and then call the
configure_range(), and if both succeed, only then set the
hdmi.ip_data.range. For this you need to pass the range parameter to
configure_range().

> +int omapdss_hdmi_get_range(void)

hdmi_range is an enum, not an int.

> +{
> +	return hdmi.ip_data.range;
> +}
> +
>  int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
>  					struct omap_video_timings *timings)
>  {
> diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/d=
ss/hdmi_panel.c
> index 533d5dc..3166602 100644
> --- a/drivers/video/omap2/dss/hdmi_panel.c
> +++ b/drivers/video/omap2/dss/hdmi_panel.c
> @@ -33,6 +33,37 @@ static struct {
>  	struct mutex hdmi_lock;
>  } hdmi;
> =20
> +static ssize_t hdmi_range_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	int r;
> +
> +	r =3D omapdss_hdmi_get_range();

hdmi_range is an enum, not an int.

> +	return snprintf(buf, PAGE_SIZE, "%d\n", r);
> +}
> +
> +static ssize_t hdmi_range_store(struct device *dev,
> +	struct device_attribute *attr,
> +	const char *buf, size_t size)
> +{
> +	unsigned long range;
> +	int r ;
> +
> +	if (strncmp("limited", buf, 7) =3D=3D 0)
> +		range =3D 0;
> +	else if (strncmp("full", buf, 4) =3D=3D 0)
> +		range =3D 1;
> +	else
> +		return -EINVAL;
> +
> +	r =3D omapdss_hdmi_set_range(range);

hdmi_range is an enum, not an unsigned long.

 Tomi


--=-YIgnMC9WtdwrisAUQAbm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPCpK0AAoJEPo9qoy8lh712JUP/1LxplsBPqTE2J2fuvH9JXQU
xXFqdCxXdm4xQc20xmQ9MRJMwa8YZ8sUo5Owagni+hqJPFEcqSNX+d2bLWXBh5j7
OsFKe4X9Be7ASeRdqS84ScmylAxthP8PI+awHYa+XRp2QnC6F9WoCqSxt48H2G9T
5fzr5NKz2eMaqF0HRkYuDV9Ju35hzNq92auSkshIxu2F+SlezDPn4g0Hj3AIFkPZ
T+R5/WMl3MjPvMEaU7YRfNAdrKE9qq1PgXoO7P0BmVLQmYOrZNHgVGcO8FL5mb0X
LpX/pZSvMaEclSxTmxvxO4cgG5dToZc1TAIH/zifCXotmzUenFEdwTx93bPSdvRk
fbXC9RyT0BHIVBVlmzN/oM5U6Vi0cNxIozDEGtaoBrxSURGu64qYaUo/FjG92YGL
SAjOYOndRHQJwdcCRs+8hWnYo9IaEC4QRLRRgDrnrNSGosD0dXWlRvFQoihT5eBB
1zmKbdNFF2VwxtxJQQxW1heZZKSEMNL9lD6DC/I6iCNmssEFRz7l1TuwBZDqh9pj
kGO7mJWU0zSz12hAndJA8bMHVghu5MJQzmWukzErnAyTIEZhMApbByxMxGbr3wis
r3N67e7+Zd9KCWse2VtHdRg5OsW3xYy4hdXvE2GQeS0KTG6yZVzsOnTfKtaDwkX6
fW8NdR9UOymYJEmmmcTj
=wGp5
-----END PGP SIGNATURE-----

--=-YIgnMC9WtdwrisAUQAbm--

