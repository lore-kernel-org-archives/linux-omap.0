From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/6] net: cpsw: Use cpsw-ctrl-macid driver
Date: Thu, 13 Feb 2014 20:37:02 +0100
Message-ID: <20140213193702.GE17650@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <1387385242-1161-5-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44427 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbaBMThG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 14:37:06 -0500
Content-Disposition: inline
In-Reply-To: <1387385242-1161-5-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hello Markus,

On Wed, Dec 18, 2013 at 05:47:20PM +0100, Markus Pargmann wrote:
> Use ctrl-macid driver to obtain the macids stored in the processor. T=
his
> is only done when defined in DT.
>=20
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/cpsw.txt |  5 +++++
>  drivers/net/ethernet/ti/cpsw.c                 | 18 ++++++++++++++--=
--
>  drivers/net/ethernet/ti/cpsw.h                 |  2 ++
>  3 files changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documen=
tation/devicetree/bindings/net/cpsw.txt
> index c39f077..b95c38b 100644
> --- a/Documentation/devicetree/bindings/net/cpsw.txt
> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> @@ -34,6 +34,11 @@ Required properties:
>  Optional properties:
>  - dual_emac_res_vlan	: Specifies VID to be used to segregate the por=
ts
>  - mac-address		: Specifies slave MAC address
> +- ti,mac-address-ctrl	: When cpsw-ctrl-macid support is compiledin, =
this can
> +			  be set to a phandle with one argument, see
> +			  cpsw-ctrl-macid.txt. If this method fails, cpsw falls
> +			  back to mac-address or random mac-address.
> +
> =20
>  Note: "ti,hwmods" field is used to fetch the base address and irq
>  resources from TI, omap hwmod data base during device registration.
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti=
/cpsw.c
> index 5120d9c..382d793 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -1804,9 +1804,16 @@ static int cpsw_probe_dt(struct cpsw_platform_=
data *data,
>  		snprintf(slave_data->phy_id, sizeof(slave_data->phy_id),
>  			 PHY_ID_FMT, mdio->name, phyid);
> =20
> -		mac_addr =3D of_get_mac_address(slave_node);
> -		if (mac_addr)
> -			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> +		ret =3D cpsw_ctrl_macid_read(slave_node, slave_data->mac_addr);
> +		if (ret) {
> +			if (ret =3D=3D -EPROBE_DEFER)
> +				return ret;
> +
> +			mac_addr =3D of_get_mac_address(slave_node);
> +			if (mac_addr)
> +				memcpy(slave_data->mac_addr, mac_addr,
> +						ETH_ALEN);
> +		}
I'd do it the other way round: Use the contents from an explicit
"mac-address" or "local-mac-address" property (i.e. of_get_mac_address)
and if that doesn't return anything use the mac-address-ctrl as
fallback.

> =20
>  		slave_data->phy_if =3D of_get_phy_mode(slave_node);
> =20
> @@ -1946,10 +1953,13 @@ static int cpsw_probe(struct platform_device =
*pdev)
>  	/* Select default pin state */
>  	pinctrl_pm_select_default_state(&pdev->dev);
> =20
> -	if (cpsw_probe_dt(&priv->data, pdev)) {
> +	ret =3D cpsw_probe_dt(&priv->data, pdev);
> +	if (ret =3D=3D -EINVAL) {
>  		pr_err("cpsw: platform data missing\n");
>  		ret =3D -ENODEV;
>  		goto clean_runtime_disable_ret;
> +	} else if (ret) {
> +		goto clean_runtime_disable_ret;
>  	}
>  	data =3D &priv->data;
> =20
> diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti=
/cpsw.h
> index 1b71067..222eebe 100644
> --- a/drivers/net/ethernet/ti/cpsw.h
> +++ b/drivers/net/ethernet/ti/cpsw.h
> @@ -42,4 +42,6 @@ struct cpsw_platform_data {
> =20
>  void cpsw_phy_sel(struct device *dev, phy_interface_t phy_mode, int =
slave);
> =20
> +int cpsw_ctrl_macid_read(struct device_node *np, u8 *mac_addr);
> +
>  #endif /* __CPSW_H__ */
> --=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
