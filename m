From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: wait for RXDET before putting phy in
 TX_ON
Date: Thu, 01 Mar 2012 13:31:02 +0200
Message-ID: <1330601462.2586.32.camel@deskari>
References: <1330589664-15755-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-RB0x4crzrtFtdK7EOSPV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:48762 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751201Ab2CALbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 06:31:07 -0500
Received: by mail-bk0-f44.google.com with SMTP id w5so355088bku.3
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 03:31:04 -0800 (PST)
In-Reply-To: <1330589664-15755-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-RB0x4crzrtFtdK7EOSPV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2012-03-01 at 13:44 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Currently TX_PHY is put to TX_ON(transmission state) on receiving HPD.
> It just ensures that the TV is connected but does not guarantee
> that TMDS data lines and clock lines are up and ready for transmission.
> Which although is very rare scenario has a potential to  damage the HDMI
> port.(A use case where TV is connected to board but it is in different
> channel would still trigger a HPD but TMDS lines will be down).

When/how does the damaging happen? When the HDMI cable is disconnected
in the case above? Or does the damage just happen by having the cable
connected, but the TV on different channel?

> Thus this patch adds a rxdet check on getting a HPD which ensures that
> TMDS lines are UP before changing the PHY state from LDO_ON to TX_ON.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   37 +++++++++++++++++++++++=
++++-
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    2 +
>  2 files changed, 37 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/om=
ap2/dss/ti_hdmi_4xxx_ip.c
> index bb784d2..bc55528 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> @@ -224,6 +224,30 @@ void ti_hdmi_4xxx_pll_disable(struct hdmi_ip_data *i=
p_data)
>  	hdmi_set_pll_pwr(ip_data, HDMI_PLLPWRCMD_ALLOFF);
>  }
> =20
> +int hdmi_ti_4xxx_rxdet(struct hdmi_ip_data *ip_data)
> +{
> +	int loop =3D 0, tmds_data0, tmds_data1, tmds_data2, tmds_clk;
> +
> +	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_WP_DEBUG_CFG, 4);
> +
> +	do {
> +		tmds_data0 =3D hdmi_read_reg(hdmi_wp_base(ip_data),
> +					HDMI_WP_WP_DEBUG_DATA);
> +		tmds_data1 =3D hdmi_read_reg(hdmi_wp_base(ip_data),
> +					HDMI_WP_WP_DEBUG_DATA);
> +		tmds_data2 =3D hdmi_read_reg(hdmi_wp_base(ip_data),
> +					HDMI_WP_WP_DEBUG_DATA);
> +		tmds_clk =3D hdmi_read_reg(hdmi_wp_base(ip_data),
> +					HDMI_WP_WP_DEBUG_DATA);
> +		udelay(15);

This code doesn't make any sense, or the HDMI TRM is wrong. You read the
same register, HDMI_WP_WP_DEBUG_DATA, four times, assigning the value to
data0-2/clk. The TRM I have doesn't talk about anything like that. What
is the code supposed to do?

The register HDMI_TXPHY_PAD_CONFIG_CONTROL also has bits for RXDET_LINE.
Is that something different?

> +	} while ((tmds_data0 !=3D tmds_data1 || tmds_data1 !=3D tmds_data2
> +			|| tmds_data1 !=3D tmds_clk) && (loop < 500));

This is a rather confusing way to do the loop. Why not just use for-loop
with the timeout, and check the tmds variables inside the loop. Much
easier to read.

In the worst case the above causes a 7.5ms busy loop in an interrupt
handler. That's not very good thing. Why is there a need for the loop?

> +	hdmi_write_reg(hdmi_wp_base(ip_data), HDMI_WP_WP_DEBUG_CFG, 0);
> +
> +	return ((loop =3D=3D 500) ? -1 : (tmds_data0 & 1)) ;

This is also confusing. And you should return a proper error value, not
-1. Perhaps:

if (loop =3D=3D 500)
	return -ETIMEDOUT;

return tmds_data0 & 1;

> +}
> +
>  static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
>  {
>  	unsigned long flags;
> @@ -241,10 +265,19 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data=
 *ip_data)
>  		return 0;
>  	}
> =20
> -	if (hpd)
> +	if (hpd) {
> +		/* before putting the phy in TX_ON,ensure that TMDS lanes
> +		 * are pulled up .
> +		 */
> +		r =3D hdmi_ti_4xxx_rxdet(ip_data);
> +		if (r <=3D 0) {
> +			DSSERR("rxdet not set\n");
> +			return r;
> +		}

Does this mean that if the user connects a TV which is in a different
channel than HDMI, the only way for the user to get an image is to
disconnect the cable and connect it again?

 Tomi


--=-RB0x4crzrtFtdK7EOSPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPT132AAoJEPo9qoy8lh71thsQAIMGuvWzr5p/vYjjomHuC+Fp
UVefgNwDNEEJ2lAUX8dF9wpWMLlLaLpwwzA7ERApHyNO7m1zEIqtmah/9cqbQ19w
rcy3LjMFrQCcN5h61BBmhrgHY7iFt4ArjTcUn5n4IWxdZcvCC1KVG7Q3c9n7WrlZ
OI1r4ai/9JPxOJSuJgaDB8yhMxXJqsBPrhHkKmsZ52yP+QuKa+URAa7FJJWjnVrq
93Ty2Iuf1z8+fOlhN5l1BNA+1wzpL9MqEmLgNA/VOa9DthsbIfyD9Ogglo6FbsXG
w++K2VfUQGuTEg4oN0j6s7S49UeqYNTrhY9qxGhW0cbNXS7hdAvjRcuyCeF3KbCz
Haxie/jZ8rgfbITzxVd9uCEnhfaWUu3a2508uzWgemD5I2onx8qFpuRvn2YuqziE
kAu7Ot//ID8oVldeLgNmNFmC8lJDvYomMS8PSxnhaL4dBsCbkd3XIXDymguD8hFP
UHxDZgYXDJGPeZhNS7QATfn+eLJ1FKL0C+YJnIdSCfTUCfxAf7lU5911Gt+IpSiz
ZG3ndU555IuYPuCgiTHPkKcu7uGk9fqMKfan4bO+xGX/jsiKOvRi87IzBdx2gYm5
KBbsR/HpgEXq1X+V8srFjVPkUmpbyfNlArqDNobUTfpD3ysSd1XlhUywEcoODRTd
x3pXjH6cL0l4qIuY7dku
=yGJW
-----END PGP SIGNATURE-----

--=-RB0x4crzrtFtdK7EOSPV--

