From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/3] OMAPDSS: HDMI: Cache EDID
Date: Thu, 28 Jun 2012 10:48:49 +0300
Message-ID: <1340869729.5037.7.camel@deskari>
References: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Xall8gRDxLZ/rd1emMqR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:58100 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755634Ab2F1Hs6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 03:48:58 -0400
Received: by lbbgj10 with SMTP id gj10so2853414lbb.9
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 00:48:55 -0700 (PDT)
In-Reply-To: <1340805944-28805-1-git-send-email-jaswinder.singh@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jaswinder.singh@linaro.org
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org


--=-Xall8gRDxLZ/rd1emMqR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-27 at 19:35 +0530, jaswinder.singh@linaro.org wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
>=20
> We can easily keep track of latest EDID from the display and hence avoid
> expensive EDID re-reads over I2C.
> This could also help some cheapo displays that provide EDID reliably only
> immediately after asserting HPD and not later.
> Even with good displays, there is something in OMAPDSS that apparantly
> messes up DDC occasionally while EDID is being read, giving the
>   "operation stopped when reading edid" error.

Btw, this is in nitpicking area, but what editor do you use? I find it
difficult to read text that is not formatted properly =3D). At least vim
formats text nicely with its formating commands.

> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/video/omap2/dss/hdmi.c            |    1 +
>  drivers/video/omap2/dss/ti_hdmi.h         |    2 ++
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   15 +++++++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
> index 0738090..9853621 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -758,6 +758,7 @@ static int __init omapdss_hdmihw_probe(struct platfor=
m_device *pdev)
>  	hdmi.ip_data.core_av_offset =3D HDMI_CORE_AV;
>  	hdmi.ip_data.pll_offset =3D HDMI_PLLCTRL;
>  	hdmi.ip_data.phy_offset =3D HDMI_PHY;
> +	hdmi.ip_data.edid_len =3D 0; /* Invalidate EDID Cache */
>  	mutex_init(&hdmi.ip_data.lock);
> =20
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
> index 04acca9..b5c3dc4 100644
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

There's a problem with this patch, which leaves a wrong EDID in the
cache: if you first have the cable connected and hdmi is enabled, you
then turn off the HDMI display device via sysfs, we do not go to
hdmi_check_hpd_state at all. The next time hdmi is enabled, we only get
the plug-in event, and thus EDID cache is never invalidated.

Perhaps the EDID cache should be invalidated always in
hdmi_check_hpd_state. In that case I think there's a chance
(theoretical, perhaps), that we get two hpd interrupts, and for both the
hpd gpio reads 1. I'm not quite sure what that would imply (perhaps we
just missed the hpd gpio =3D 0 case), but even in that case invalidating
the cache sounds ok.

 Tomi


--=-Xall8gRDxLZ/rd1emMqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7AxhAAoJEPo9qoy8lh71q1kP/iZb72hNNJOnTEH9LU608NaD
jH+9iQakn6FJWxFd2cwYbFKF/3DlOxBvtIh7MlFdNsMEwOJ2sUk1Kbnp4mFKLrSX
sFZcO2Hba4KMFxVy2gr/aN8XVZnBJCUdNVEjnPqNBtTRv1XnEfGwS7YGIYoMoIgZ
tzdE7X3vuOn790wFoiK8caePVYn7u23iFriXbKDvnfIokbPirsHdDc7YvUZ9nrTW
vOM1NaHLnOkNtSstUc5/TcsAS1cSaGnE233c1h+WiXIwwS/P+Iq8cDw4ffjS89Lb
yVGVdQMSql86I8/Lt7ka/qdE8x/UgMvIxsFABkqpylWqY1utg6wiDORm2YkEbhEL
7FdYD9/nzE6DgBr3DRBRTiqqixJjeho3AEoBQ+1/FN/c5iq4oah8iM/O7FmpMqmn
rCnZaCXpHWGzUfHNOwnXhsBsEJKT2HtvpboUsfb/thD+wrajIhqSdzuQju8LGlR1
8Ivoiyx7q3HcLjOZYMXdKv77aj2P8c2jDum9eNisTUDr25EHTPASBfG1fgKrkMzC
LpQPMD3gNacqz5aLiOsBbxYUc5U5DQVhatUShOh5PJ69aZdA39tAC2aspIHXykiJ
+masS1Mr7JMQRvqO6n2Vfo9PlqSKKt+aMhuBLk12CXareYa+2Btn5l2OrzEEnV95
0+FOSfKHyzCgyC75mI62
=mPL3
-----END PGP SIGNATURE-----

--=-Xall8gRDxLZ/rd1emMqR--

