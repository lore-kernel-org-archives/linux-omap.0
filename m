From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3 REPOST] OMAPDSS: HDMI: Move Avi infoframe structure
 to
Date: Tue, 03 Jan 2012 12:09:41 +0200
Message-ID: <1325585381.1973.33.camel@deskari>
References: <1325494735-30160-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Ox5DlPbKixrgMpLlXPZA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:53862 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751477Ab2ACKJp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jan 2012 05:09:45 -0500
Received: by mail-lpp01m010-f53.google.com with SMTP id r15so7859239lag.26
        for <linux-omap@vger.kernel.org>; Tue, 03 Jan 2012 02:09:44 -0800 (PST)
In-Reply-To: <1325494735-30160-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-Ox5DlPbKixrgMpLlXPZA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Again the subjects are cut off in mid sentence. And the patch series
contains patch 1 two times.

Please use git-format-patch and git-send-email to send proper patches,
and please check the patches before sending.

 Tomi

On Mon, 2012-01-02 at 14:28 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> With AVI infoframe various parameters of video stream such as
> aspect ratio, quantization range, videocode etc will be indicated
> from source to sink.Thus AVI information needs to be set/accessed
> by the middle ware based on the video content.
> Thus this parameter is now moved to the ip_data structure.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/ti_hdmi.h         |   42 +++++++++++++++++++++++=
++++++
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    8 +++---
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |   40 -----------------------=
----
>  3 files changed, 46 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/=
ti_hdmi.h
> index 3cf5198..835cfb1 100644
> --- a/drivers/video/omap2/dss/ti_hdmi.h
> +++ b/drivers/video/omap2/dss/ti_hdmi.h
> @@ -108,6 +108,47 @@ struct ti_hdmi_ip_ops {
> =20
>  };
> =20
> +/*
> + * Refer to section 8.2 in HDMI 1.3 specification for
> + * details about infoframe databytes
> + */
> +struct hdmi_core_infoframe_avi {
> +	/* Y0, Y1 rgb,yCbCr */
> +	u8	db1_format;
> +	/* A0  Active information Present */
> +	u8	db1_active_info;
> +	/* B0, B1 Bar info data valid */
> +	u8	db1_bar_info_dv;
> +	/* S0, S1 scan information */
> +	u8	db1_scan_info;
> +	/* C0, C1 colorimetry */
> +	u8	db2_colorimetry;
> +	/* M0, M1 Aspect ratio (4:3, 16:9) */
> +	u8	db2_aspect_ratio;
> +	/* R0...R3 Active format aspect ratio */
> +	u8	db2_active_fmt_ar;
> +	/* ITC IT content. */
> +	u8	db3_itc;
> +	/* EC0, EC1, EC2 Extended colorimetry */
> +	u8	db3_ec;
> +	/* Q1, Q0 Quantization range */
> +	u8	db3_q_range;
> +	/* SC1, SC0 Non-uniform picture scaling */
> +	u8	db3_nup_scaling;
> +	/* VIC0..6 Video format identification */
> +	u8	db4_videocode;
> +	/* PR0..PR3 Pixel repetition factor */
> +	u8	db5_pixel_repeat;
> +	/* Line number end of top bar */
> +	u16	db6_7_line_eoftop;
> +	/* Line number start of bottom bar */
> +	u16	db8_9_line_sofbottom;
> +	/* Pixel number end of left bar */
> +	u16	db10_11_pixel_eofleft;
> +	/* Pixel number start of right bar */
> +	u16	db12_13_pixel_sofright;
> +};
> +
>  struct hdmi_ip_data {
>  	void __iomem	*base_wp;	/* HDMI wrapper */
>  	unsigned long	core_sys_offset;
> @@ -117,6 +158,7 @@ struct hdmi_ip_data {
>  	const struct ti_hdmi_ip_ops *ops;
>  	struct hdmi_config cfg;
>  	struct hdmi_pll_info pll_data;
> +	struct hdmi_core_infoframe_avi avi_cfg;
>  };
>  int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
>  void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.c
> index ccc6254..b66d82e 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> @@ -534,12 +534,12 @@ static void hdmi_core_video_config(struct hdmi_ip_d=
ata *ip_data,
>  			HDMI_CORE_SYS_TMDS_CTRL, cfg->tclk_sel_clkmult, 6, 5);
>  }
> =20
> -static void hdmi_core_aux_infoframe_avi_config(struct hdmi_ip_data *ip_d=
ata,
> -		struct hdmi_core_infoframe_avi info_avi)
> +static void hdmi_core_aux_infoframe_avi_config(struct hdmi_ip_data *ip_d=
ata)
>  {
>  	u32 val;
>  	char sum =3D 0, checksum =3D 0;
>  	void __iomem *av_base =3D hdmi_av_base(ip_data);
> +	struct hdmi_core_infoframe_avi info_avi =3D ip_data->avi_cfg;
> =20
>  	sum +=3D 0x82 + 0x002 + 0x00D;
>  	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_TYPE, 0x082);
> @@ -718,7 +718,7 @@ void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data=
 *ip_data)
>  	struct omap_video_timings video_timing;
>  	struct hdmi_video_format video_format;
>  	/* HDMI core */
> -	struct hdmi_core_infoframe_avi avi_cfg;
> +	struct hdmi_core_infoframe_avi avi_cfg =3D ip_data->avi_cfg;
>  	struct hdmi_core_video_config v_core_cfg;
>  	struct hdmi_core_packet_enable_repeat repeat_cfg;
>  	struct hdmi_config *cfg =3D &ip_data->cfg;
> @@ -780,7 +780,7 @@ void ti_hdmi_4xxx_basic_configure(struct hdmi_ip_data=
 *ip_data)
>  	avi_cfg.db10_11_pixel_eofleft =3D 0;
>  	avi_cfg.db12_13_pixel_sofright =3D 0;
> =20
> -	hdmi_core_aux_infoframe_avi_config(ip_data, avi_cfg);
> +	hdmi_core_aux_infoframe_avi_config(ip_data);
> =20
>  	/* enable/repeat the infoframe */
>  	repeat_cfg.avi_infoframe =3D HDMI_PACKETENABLE;
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.h
> index 914bec6..21f1d82 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
> @@ -450,46 +450,6 @@ struct hdmi_core_video_config {
>   * Refer to section 8.2 in HDMI 1.3 specification for
>   * details about infoframe databytes
>   */
> -struct hdmi_core_infoframe_avi {
> -	/* Y0, Y1 rgb,yCbCr */
> -	u8	db1_format;
> -	/* A0  Active information Present */
> -	u8	db1_active_info;
> -	/* B0, B1 Bar info data valid */
> -	u8	db1_bar_info_dv;
> -	/* S0, S1 scan information */
> -	u8	db1_scan_info;
> -	/* C0, C1 colorimetry */
> -	u8	db2_colorimetry;
> -	/* M0, M1 Aspect ratio (4:3, 16:9) */
> -	u8	db2_aspect_ratio;
> -	/* R0...R3 Active format aspect ratio */
> -	u8	db2_active_fmt_ar;
> -	/* ITC IT content. */
> -	u8	db3_itc;
> -	/* EC0, EC1, EC2 Extended colorimetry */
> -	u8	db3_ec;
> -	/* Q1, Q0 Quantization range */
> -	u8	db3_q_range;
> -	/* SC1, SC0 Non-uniform picture scaling */
> -	u8	db3_nup_scaling;
> -	/* VIC0..6 Video format identification */
> -	u8	db4_videocode;
> -	/* PR0..PR3 Pixel repetition factor */
> -	u8	db5_pixel_repeat;
> -	/* Line number end of top bar */
> -	u16	db6_7_line_eoftop;
> -	/* Line number start of bottom bar */
> -	u16	db8_9_line_sofbottom;
> -	/* Pixel number end of left bar */
> -	u16	db10_11_pixel_eofleft;
> -	/* Pixel number start of right bar */
> -	u16	db12_13_pixel_sofright;
> -};
> -/*
> - * Refer to section 8.2 in HDMI 1.3 specification for
> - * details about infoframe databytes
> - */
>  struct hdmi_core_infoframe_audio {
>  	u8 db1_coding_type;
>  	u8 db1_channel_count;


--=-Ox5DlPbKixrgMpLlXPZA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPAtPlAAoJEPo9qoy8lh71HBoP/jynGioIQyMGdSDPP/h5WWBi
t/9rIz0RKHP9cHmGAHO8/FH4FHyKaup5y/Ilo7IbWQ376WaI1kuBDrVhRGWg2ikp
9n9N0zVIiEISR/P/DgrzJOl1kQboWEc8AOyw7cFm5C2ccvMylsQlanaj8jJe+I3N
ftraAudiQtc7L4t0ZS+eQrs54q18nJRplGQZzlXarDYsVpyHYdDOFT1dJG6vNuRs
vv6fGRqa89dKU8jOEtSw8tOZ0VVnRQvEhFP1wbkZRhdmrVP3N0MO8/RBzWwK7Tds
6kNi03+Oat2L9yue/X22KO2pn3xFPD3bczDcQw9rRB15rLPeIu7cgo07b+S0G0Ir
oh8RVBxS4Meb2iaE5LIQrt7pfZTfwvprZFF9rGj0Bo0S9yJ7WhJiIF7Ncl2Bm3Gv
0Zu0jvBNE0ex7+vwtaxgEJS3BjmQ8VEcj7SsaY0cS99wAx3a+G+PCk+giearg46F
nzp+qmsKGOMs5DJoP8ZpYZKpDeGlkZn1/mlblsWH9J6X96bjQ91A8hdtawwix/hj
lt5ifP4rh680rHpTcc1R542G52EDlO4YYVnc35fWUEjTvkKQpS56gkW679bIFQz6
L2yEK5EoN0qM556Qw4mCS6c9qsseR7936g12SWnUTyKMw3N4DTXc68zmWYqmGwqM
UqoFLewh3NG/1jOMNduV
=Gpps
-----END PGP SIGNATURE-----

--=-Ox5DlPbKixrgMpLlXPZA--

