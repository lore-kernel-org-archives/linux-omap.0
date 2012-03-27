From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/3] OMAPDSS: HDMI: Add support for DSS_HDMI Interrupt
Date: Tue, 27 Mar 2012 13:30:01 +0300
Message-ID: <1332844201.1867.111.camel@deskari>
References: <1332249307-26875-1-git-send-email-mythripk@ti.com>
	 <1332249307-26875-2-git-send-email-mythripk@ti.com>
	 <1332249307-26875-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-71G86YtEw5gk76LAd2iq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38261 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750956Ab2C0Kbu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 06:31:50 -0400
Received: by mail-lpp01m010-f49.google.com with SMTP id y4so5245923lag.8
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 03:31:49 -0700 (PDT)
In-Reply-To: <1332249307-26875-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-71G86YtEw5gk76LAd2iq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-03-20 at 18:45 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Add support for DSS_HDMI interrupt handling in HDMI driver
> by registering for the same. This is the path for many necessary HDMI
> interrupts such as PLL lock/unlock, PHY connect/disconnet, video frame
> done etc.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/dss_features.c    |    1 +
>  drivers/video/omap2/dss/hdmi.c            |   21 +++++++++++++++++++++
>  drivers/video/omap2/dss/ti_hdmi.h         |    3 +++
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   13 +++++++++++++
>  4 files changed, 38 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2=
/dss/dss_features.c
> index ce14aa6..29c5548 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -566,6 +566,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functio=
ns =3D {
>  	.dump_core		=3D	ti_hdmi_4xxx_core_dump,
>  	.dump_pll		=3D	ti_hdmi_4xxx_pll_dump,
>  	.dump_phy		=3D	ti_hdmi_4xxx_phy_dump,
> +	.irq_handle		=3D	ti_hdmi_4xxx_intr_handler,
>  #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
>  	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
>  	.audio_enable		=3D       ti_hdmi_4xxx_wp_audio_enable,
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdm=
i.c
> index c4b4f69..14e90b5 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -67,6 +67,8 @@ static struct {
>  	struct platform_device *pdev;
>  	struct hdmi_ip_data ip_data;
> =20
> +	int irq;
> +	spinlock_t irq_lock;
>  	struct clk *sys_clk;
>  } hdmi;
> =20
> @@ -790,6 +792,19 @@ static void hdmi_put_clocks(void)
>  		clk_put(hdmi.sys_clk);
>  }
> =20
> +static irqreturn_t hdmi_irq_handler(int irq, void *arg)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hdmi.irq_lock, flags);
> +
> +	hdmi.ip_data.ops->irq_handle(&hdmi.ip_data);
> +
> +	spin_unlock_irqrestore(&hdmi.irq_lock, flags);

So what is this spinlock supposed to protect? This is the only place you
use it.

> +
> +	return IRQ_HANDLED;
> +}

I think all this code should be in the ti_hdmi_4xxx_ip.c, as it's
dealing with on omap4 hdmi interrupt.

 Tomi


--=-71G86YtEw5gk76LAd2iq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPcZapAAoJEPo9qoy8lh71eqIP/3BmfUveHOBChjpwPGEdA48J
wxhTAeznJ+d0SYKtf01W3GIKpguk4ItvJyCFLKlumq1IzSBBJ/1Eujzq7Hk1+1kW
vbAMejFaAqzkglwmScEWVuhD0EAa8pqHiBpjhwKwgwvZrr6d4TENK25/IAOyZxfs
tI8E3M0EL3e5LiYoIq6MDl2LaqyCkwLjNX6b1Ep5Cebtl2eHY8UCN+C//m78gG0B
hyL0OEZO2YaMufzNRY47T/gJi127jqhTWSGipn2UxKz7eLHhZDPl48eOYn5KI6k0
7GPVXmldyVRZfjxTnuTmqfLLc5LN3S1bVj5sDXOweTqMb9+WVPoC3lWjpu0j87NR
5aXhGmlJzbfxXBEfG/hdZrXlp5Dt1YZt84paSWsdmUzm3OMXy17DNb3Xm+tFnUDd
cnnSayoFwdYrgDdhs7zhd7U1ufXKBcTbs/tIlarORrfxe2Fix83O/sbWQH8ZbxSe
XJcb9TUASQMQBlqGlfQz1gli4K4n93CSa5/fwBaGjFxLQoKv/RlL7IOcXSNdsDns
g3mb3RoHNldqGFrwt9qnhybx6jd2hdJzLYzlQZDwVS25s3ggjUh6HULXRxzFe/tw
Slxmee8Q+yXGmmghBBgdTY6lq7cJkiXd1jp8/VtnzcvA/SN/DeB6ePsZLBU+JMHY
jwz2cKiircMmKZqLLhYU
=jyY0
-----END PGP SIGNATURE-----

--=-71G86YtEw5gk76LAd2iq--

