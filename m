From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/3] OMAPDSS: HDMI: Replace spinlock with mutex in
 hdmi_check_hpd_state
Date: Fri, 29 Jun 2012 09:45:50 +0300
Message-ID: <1340952350.1866.12.camel@lappyti>
References: <1340805896-28731-1-git-send-email-jaswinder.singh@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-q9+iV6oC9kBqc0/w5uzm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:37551 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751210Ab2F2Gp4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 02:45:56 -0400
Received: by lbbgj10 with SMTP id gj10so5167587lbb.23
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 23:45:53 -0700 (PDT)
In-Reply-To: <1340805896-28731-1-git-send-email-jaswinder.singh@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jaswinder.singh@linaro.org
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com, patches@linaro.org


--=-q9+iV6oC9kBqc0/w5uzm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-27 at 19:34 +0530, jaswinder.singh@linaro.org wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
>=20
> State change of HDMI PHY could potentially take many millisecs, we can do
> better by protecting things in hdmi_set_phy_pwr() with a mutex rather tha=
n
> a spin_lock_irqsave.
>=20
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/video/omap2/dss/hdmi.c            |    1 +
>  drivers/video/omap2/dss/ti_hdmi.h         |    1 +
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    6 ++----
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
> index 8195c71..0738090 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -758,6 +758,7 @@ static int __init omapdss_hdmihw_probe(struct platfor=
m_device *pdev)
>  	hdmi.ip_data.core_av_offset =3D HDMI_CORE_AV;
>  	hdmi.ip_data.pll_offset =3D HDMI_PLLCTRL;
>  	hdmi.ip_data.phy_offset =3D HDMI_PHY;
> +	mutex_init(&hdmi.ip_data.lock);
> =20
>  	hdmi_panel_init();
> =20
> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/=
ti_hdmi.h
> index d174ca1..cc292b8 100644
> --- a/drivers/video/omap2/dss/ti_hdmi.h
> +++ b/drivers/video/omap2/dss/ti_hdmi.h
> @@ -177,6 +177,7 @@ struct hdmi_ip_data {
> =20
>  	/* ti_hdmi_4xxx_ip private data. These should be in a separate struct *=
/
>  	int hpd_gpio;
> +	struct mutex lock;
>  };
>  int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
>  void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.c
> index 3fa3d98..04acca9 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> @@ -238,10 +238,8 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data =
*ip_data)
>  	unsigned long flags;
>  	bool hpd;
>  	int r;
> -	/* this should be in ti_hdmi_4xxx_ip private data */
> -	static DEFINE_SPINLOCK(phy_tx_lock);
> =20
> -	spin_lock_irqsave(&phy_tx_lock, flags);
> +	mutex_lock(&ip_data->lock);
> =20
>  	hpd =3D gpio_get_value(ip_data->hpd_gpio);
> =20
> @@ -257,7 +255,7 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *=
ip_data)
>  	}
> =20
>  err:
> -	spin_unlock_irqrestore(&phy_tx_lock, flags);
> +	mutex_unlock(&ip_data->lock);
>  	return r;

This introduced a new warning:

drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c: In function 'hdmi_check_hpd_stat=
e':
drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c:238:16: warning: unused variable =
'flags'

I fixed that.

I'll apply this and the first patch, as I don't think there are any
questions about these.

 Tomi


--=-q9+iV6oC9kBqc0/w5uzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP7U8eAAoJEPo9qoy8lh71Yf4P/2M77pNAmpvqYpbTx4hfT0Qo
ps/MFWDP0/fKTId8Pb4fIV06/2gahaRvXXf4Ya1Ef0Cgl3oW0x5W2Zueysfz43M7
knGK9ZUZVHE00cLke6diOKDJa3mlQQtSwbJAbA/xFvkKDkHpAeXN2PQk4qBGGowa
0DcbZLp0UHgklJmjIcVqRqe8LbZJlMvtEz7nRnHQgMM1jixUk9LMMoGiqq5JAo07
3p4xO0l+EtZ4+62xYqAHgFienPC9eaoQvEkkTRyWtHCAYxfkCRsQoXRyiiM8IPf2
bqnkszLBBTccmfaSOQiCKxwdPAZDSkfmo70MQlVD/Ou9WBwBAPAGZAxMSQ3BX5Vn
hJYjRgYPhqCDUxgZxCxj3FmnB3fxqxCFcT0EUoSfMkBipmnyGfaqfRp3TydQUUdA
Puu9nqsXijWkklFm84bbLc7qW8KvFj3I7TGKIEl4JnshFcDIOdD/Li2LRfZnetr6
arxboW1InM7sMesGiX71VE/1cwKAyehhAoCZ+I+CV1Ee6QMTbAyI8vABIDMIWkng
yNbVUX77BjbCrp9ZcgJgNDNboDXbk+hNrp5mfbvWUoMSWNhnZE8glUa/B9ervokA
2+0kGLS4xNKxpGz1GBf7I1gOpY500OZtnUKCx1AlLETfm7hgrLSxl7+8UCOz+WA/
7NZ2ma4aiFTfg78j5LxE
=mBCE
-----END PGP SIGNATURE-----

--=-q9+iV6oC9kBqc0/w5uzm--

