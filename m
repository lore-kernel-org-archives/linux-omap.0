From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 2/3] OMAPDSS: HDMI: Add quantization range support
 in IP lib
Date: Thu, 05 Jan 2012 09:23:24 +0200
Message-ID: <1325748204.2045.25.camel@deskari>
References: <1325677990-16414-1-git-send-email-mythripk@ti.com>
	 <1325677990-16414-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-f7c1XGzZiEsexlZ2QT3U"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:45395 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757069Ab2AEHX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 02:23:29 -0500
Received: by lagu2 with SMTP id u2so100426lag.37
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 23:23:26 -0800 (PST)
In-Reply-To: <1325677990-16414-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-f7c1XGzZiEsexlZ2QT3U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-01-04 at 17:23 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Configure the IP to support the limited range and full range quantization
> mode. If the full range is configured HDMI transmitter will expand the ra=
nge
> of pixel data from 16-235 to full 8 bit 0-235.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/ti_hdmi.h         |    7 +++++
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   40 +++++++++++++++++++++++=
++++++
>  2 files changed, 47 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/=
ti_hdmi.h
> index 835cfb1..1b485ee 100644
> --- a/drivers/video/omap2/dss/ti_hdmi.h
> +++ b/drivers/video/omap2/dss/ti_hdmi.h
> @@ -42,6 +42,11 @@ enum hdmi_clk_refsel {
>  	HDMI_REFSEL_SYSCLK =3D 3
>  };
> =20
> +enum hdmi_range {
> +	HDMI_LIMITED_RANGE =3D 0,
> +	HDMI_FULL_RANGE =3D 1,
> +};
> +
>  /* HDMI timing structure */
>  struct hdmi_video_timings {
>  	u16 x_res;
> @@ -159,6 +164,7 @@ struct hdmi_ip_data {
>  	struct hdmi_config cfg;
>  	struct hdmi_pll_info pll_data;
>  	struct hdmi_core_infoframe_avi avi_cfg;
> +	enum hdmi_range range;
>  };
>  int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
>  void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
> @@ -172,5 +178,6 @@ void ti_hdmi_4xxx_wp_dump(struct hdmi_ip_data *ip_dat=
a, struct seq_file *s);
>  void ti_hdmi_4xxx_pll_dump(struct hdmi_ip_data *ip_data, struct seq_file=
 *s);
>  void ti_hdmi_4xxx_core_dump(struct hdmi_ip_data *ip_data, struct seq_fil=
e *s);
>  void ti_hdmi_4xxx_phy_dump(struct hdmi_ip_data *ip_data, struct seq_file=
 *s);
> +int ti_hdmi_4xxx_configure_range(struct hdmi_ip_data *ip_data);
> =20
>  #endif
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.c
> index b66d82e..a98ce8a 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> @@ -610,6 +610,46 @@ static void hdmi_core_aux_infoframe_avi_config(struc=
t hdmi_ip_data *ip_data)
>  	hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_CHSUM, checksum);
>  }
> =20
> +int ti_hdmi_4xxx_configure_range(struct hdmi_ip_data *ip_data)
> +{
> +	int var;
> +
> +	switch (ip_data->range) {
> +	/*
> +	 * Setting the AVI infroframe to respective limited range
> +	 * 0 if limited range 1 if full range
> +	 */
> +	case HDMI_LIMITED_RANGE:
> +		ip_data->avi_cfg.db3_q_range =3D HDMI_INFOFRAME_AVI_DB3Q_LR;
> +		hdmi_core_aux_infoframe_avi_config(ip_data);
> +		var =3D hdmi_read_reg(hdmi_core_sys_base(ip_data),
> +						HDMI_CORE_SYS_VID_ACEN);
> +		var =3D FLD_MOD(var, 1, 1, 1);
> +		hdmi_write_reg(hdmi_core_sys_base(ip_data),
> +						HDMI_CORE_SYS_VID_ACEN, var);
> +		break;
> +	case HDMI_FULL_RANGE:
> +	default:

I don't think you should have HDMI_FULL_RANGE and default at the same
case. If the range is not limited or full, the value is illegal and you
should give an error.

 Tomi


--=-f7c1XGzZiEsexlZ2QT3U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPBU/rAAoJEPo9qoy8lh71kOEQAJo18FGqrH4JVuQwklnCoyhi
bNvSCj3lCbv6NNHF2iAxD3Q8Q25wIge5z0nfkhPNyZfCT9N2vVagCzWvuekqjnj5
A0ora1kzCIJzwZibv3umamffjFs/iIxqP0vaHozgtrz2q/QrIuqar+ubSpybTWVD
IZQAgQ7dHBzSho2C+qHOKI4QI+1FmiFbV+hcsWk0kKv17uWp5mzXD0tWxpc88Jtq
icANgfvXlcf/jQqt3sa63VWL/XSDOX1/iJ+pEmBfgePJmK1Hk4Nmjo7IO1twy3d4
GS1LrHvJ6F7kVJmfjrdbEniboFo4a1Nh4nvbmW1K70g+Jht4xHty5ms/qJaGkK9R
KGk/8NfTRLx2fnqsV2MLTsxWxoDdM4JXVTUihlmD+xfxjeteEYOMKORPU4YSQeNS
uMjR6lgYC0HrEdg/88vJm8lLTwpzWV2prMPRCtBB5zAvZiabL3TjYSz9NWil20f1
zS2YmT1f87k/Q/zpBfpWFQFojGJvlQH9oEjXhgr86pZXnoucCDcioVBpe1XumnZu
hvRNTNPP3D7sGlLKBpikS222RdiI6xEyvcbm8rQRDHDtGUCq9Gl7QGVpgqu4kel0
70ni38BQHk4st97TqXZBGp3cqSxFwzyJJ2uTGDyB0wcY1B5VDdhodncfQqYFZZYu
J5dKs92m1ygp0lg4kr+n
=VyfN
-----END PGP SIGNATURE-----

--=-f7c1XGzZiEsexlZ2QT3U--

