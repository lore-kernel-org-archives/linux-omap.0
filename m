From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Cache EDID
Date: Mon, 25 Jun 2012 09:35:54 +0300
Message-ID: <1340606154.12683.34.camel@lappyti>
References: <1340438806-25622-1-git-send-email-jaswinder.singh@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-HnVXlx8MqKZDflkqCivl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:52862 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753820Ab2FYGgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 02:36:00 -0400
Received: by lbbgo11 with SMTP id go11so5905559lbb.3
        for <linux-omap@vger.kernel.org>; Sun, 24 Jun 2012 23:35:57 -0700 (PDT)
In-Reply-To: <1340438806-25622-1-git-send-email-jaswinder.singh@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jaswinder.singh@linaro.org
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-HnVXlx8MqKZDflkqCivl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-06-23 at 13:36 +0530, jaswinder.singh@linaro.org wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
>=20
> We can easily keep track of latest EDID from the display and hence avoid
> expensive EDID re-reads over I2C.
> This could also help some cheapo displays that provide EDID reliably only
> immediately after asserting HPD and not later.
> Even with good displays, there is something in OMAPDSS that apparantly
> messes up DDC occasionally while EDID is being read, giving the
>   "operation stopped when reading edid" error.
>=20
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/video/omap2/dss/hdmi.c            |    1 +
>  drivers/video/omap2/dss/ti_hdmi.h         |    2 ++
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   23 ++++++++++++++++++++---
>  3 files changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
> index 900e621..0a8c825 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -764,6 +764,7 @@ static int __init omapdss_hdmihw_probe(struct platfor=
m_device *pdev)
>  	hdmi.ip_data.core_av_offset =3D HDMI_CORE_AV;
>  	hdmi.ip_data.pll_offset =3D HDMI_PLLCTRL;
>  	hdmi.ip_data.phy_offset =3D HDMI_PHY;
> +	hdmi.ip_data.edid_len =3D 0; /* Invalidate EDID Cache */
>  	mutex_init(&hdmi.ip_data.lock);

Your HDMI patches seem to depend on each other. Please post them as a
proper patch series, instead of each one separately.

>  	hdmi_panel_init();
> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/=
ti_hdmi.h
> index cc292b8..4735860 100644
> --- a/drivers/video/omap2/dss/ti_hdmi.h
> +++ b/drivers/video/omap2/dss/ti_hdmi.h
> @@ -178,6 +178,8 @@ struct hdmi_ip_data {
>  	/* ti_hdmi_4xxx_ip private data. These should be in a separate struct *=
/
>  	int hpd_gpio;
>  	struct mutex lock;
> +	u8 edid_cached[256];
> +	unsigned edid_len;
>  };
>  int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
>  void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.c
> index 04acca9..2633ade 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> @@ -243,10 +243,13 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data=
 *ip_data)
> =20
>  	hpd =3D gpio_get_value(ip_data->hpd_gpio);
> =20
> -	if (hpd)
> +	if (hpd) {
>  		r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
> -	else
> +	} else {
> +		/* Invalidate EDID Cache */
> +		ip_data->edid_len =3D 0;
>  		r =3D hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_LDOON);
> +	}
> =20
>  	if (r) {
>  		DSSERR("Failed to %s PHY TX power\n",
> @@ -454,6 +457,11 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_d=
ata,
>  {
>  	int r, l;
> =20
> +	if (ip_data->edid_len) {
> +		memcpy(edid, ip_data->edid_cached, ip_data->edid_len);
> +		return ip_data->edid_len;
> +	}
> +
>  	if (len < 128)
>  		return -EINVAL;
> =20
> @@ -474,12 +482,21 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_=
data,
>  		l +=3D 128;
>  	}
> =20
> +	ip_data->edid_len =3D l;
> +	memcpy(ip_data->edid_cached, edid, l);
> +
>  	return l;
>  }
> =20
>  bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
>  {
> -	return gpio_get_value(ip_data->hpd_gpio);
> +	if (gpio_get_value(ip_data->hpd_gpio))
> +		return true;
> +
> +	/* Invalidate EDID Cache */
> +	ip_data->edid_len =3D 0;
> +
> +	return false;

Why is this needed? The HPD interrupt should handle this already. And if
the HPD interrupt doesn't work for some reason, this won't work either,
as the user can plug and unplug his HDMI monitors a thousand times
between two detect calls.

 Tomi


--=-HnVXlx8MqKZDflkqCivl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6AbKAAoJEPo9qoy8lh710WYP/1XIl4DxjTd3ONtR0SA12yo/
FhmGX/s7Sn0AyT4XTJIV3X6VHMn5cloZmqcLJL+WzkDnH1ept0I7G5QhFtd4P71S
mNShyB607mhkKG8sRLNdvt5qpUgWfbD08RWBQPppfE6V1vU8E5FyuinrqrrgpADw
m/SwT5SDe2Ib2VE5E23Kp9Om2yvFfbqhYIMInCWtXpZRugUxTJ4zNfdTio6aQ9dS
7jrupyWCT/8g5RFHFQB3i3JulIBLGsHirW5guVuN8OUAVnQ+RAyHxEeZP6+eQOHK
+on8o2L6HC4XBuzTQ/h1mE87TYlgbTfuAEJjeoh5EoGAz29RDh63obHWBki+JSHb
iHbbY6wSdgDmtPIPivwHVLiOajlIlAzN+DRn4B4RIiC4iELwlLaO6tMYPh9XnaW7
7c+b8w/Q5ADnevCbSPdezDMx7geUayGqYkFbv+J6TVjjk2ycKKF4xV/OuzGEzu2u
gOYyQcNIvtsj+mhXw9u7/22Cf943bW0lVGlYh9Y8UUgPnxw9sW9Mjc5kkiRy+TI5
05uDt0AsJhRrxUDDCQlrUW3ZJH4Jy+psR94GrXBqg4BNx7BtVxrEZAPPJSTgN60A
MUoUzW3gM3vZBgjEdMhrjyJSlr93wIyDP2y5iNnD+jdpTVK6dJzy6nKbJv1vI6k/
tO3gI8PpYyBcs06U1iyE
=c9ZP
-----END PGP SIGNATURE-----

--=-HnVXlx8MqKZDflkqCivl--

