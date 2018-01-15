From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v7 5/8] can: m_can: Add PM Support
Date: Mon, 15 Jan 2018 14:55:34 +0100
Message-ID: <a94cf10c-b40d-9e2e-a4cd-f7e5d0399530@pengutronix.de>
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
 <1515581725-29242-6-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Gtmus5PqRznLuzxlEDhhhJfGeCmPLaRZc"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1515581725-29242-6-git-send-email-faiz_abbas@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gtmus5PqRznLuzxlEDhhhJfGeCmPLaRZc
Content-Type: multipart/mixed; boundary="hNN93DZhzPuq4eJzwXu1cP3k9JiVESaBt";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com,
 fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com,
 sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org,
 b29396@freescale.com
Message-ID: <a94cf10c-b40d-9e2e-a4cd-f7e5d0399530@pengutronix.de>
Subject: Re: [PATCH v7 5/8] can: m_can: Add PM Support
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
 <1515581725-29242-6-git-send-email-faiz_abbas@ti.com>
In-Reply-To: <1515581725-29242-6-git-send-email-faiz_abbas@ti.com>

--hNN93DZhzPuq4eJzwXu1cP3k9JiVESaBt
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 11:55 AM, Faiz Abbas wrote:
> From: Franklin S Cooper Jr <fcooper@ti.com>
>=20
> Add support for CONFIG_PM which is the new way to handle managing clock=
s.
>=20
> Move the clock management to pm_runtime_resume() and pm_runtime_suspend=
()
> callbacks for the driver.
>=20
> CONFIG_PM is required by OMAP based devices to handle clock management.=

> Therefore, this allows future Texas Instruments SoCs that have the MCAN=
 IP
> to work with this driver.
>=20
> Reviewed-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> [nsekhar@ti.com: handle pm_runtime_get_sync() failure, fix some bugs]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/net/can/m_can/m_can.c | 95 ++++++++++++++++++++++++++++-------=
--------
>  1 file changed, 62 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index 07ebe7f..f5c5028 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -23,6 +23,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/iopoll.h>
>  #include <linux/can/dev.h>
> =20
> @@ -625,21 +626,16 @@ static int m_can_clk_start(struct m_can_priv *pri=
v)
>  {
>  	int err;
> =20
> -	err =3D clk_prepare_enable(priv->hclk);
> -	if (err)
> -		return err;
> -
> -	err =3D clk_prepare_enable(priv->cclk);
> +	err =3D pm_runtime_get_sync(priv->device);
>  	if (err)
> -		clk_disable_unprepare(priv->hclk);
> +		pm_runtime_put_noidle(priv->device);
> =20
>  	return err;
>  }
> =20
>  static void m_can_clk_stop(struct m_can_priv *priv)
>  {
> -	clk_disable_unprepare(priv->cclk);
> -	clk_disable_unprepare(priv->hclk);
> +	pm_runtime_put_sync(priv->device);
>  }
> =20
>  static int m_can_get_berr_counter(const struct net_device *dev,
> @@ -1561,37 +1557,26 @@ static int m_can_plat_probe(struct platform_dev=
ice *pdev)
>  		goto failed_ret;
>  	}
> =20
> -	/* Enable clocks. Necessary to read Core Release in order to determin=
e
> -	 * M_CAN version
> -	 */
> -	ret =3D clk_prepare_enable(hclk);
> -	if (ret)
> -		goto disable_hclk_ret;
> -
> -	ret =3D clk_prepare_enable(cclk);
> -	if (ret)
> -		goto disable_cclk_ret;
> -
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
>  	addr =3D devm_ioremap_resource(&pdev->dev, res);
>  	irq =3D platform_get_irq_byname(pdev, "int0");
> =20
>  	if (IS_ERR(addr) || irq < 0) {
>  		ret =3D -EINVAL;
> -		goto disable_cclk_ret;
> +		goto failed_ret;
>  	}
> =20
>  	/* message ram could be shared */
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_r=
am");
>  	if (!res) {
>  		ret =3D -ENODEV;
> -		goto disable_cclk_ret;
> +		goto failed_ret;
>  	}
> =20
>  	mram_addr =3D devm_ioremap(&pdev->dev, res->start, resource_size(res)=
);
>  	if (!mram_addr) {
>  		ret =3D -ENOMEM;
> -		goto disable_cclk_ret;
> +		goto failed_ret;
>  	}
> =20
>  	/* get message ram configuration */
> @@ -1600,7 +1585,7 @@ static int m_can_plat_probe(struct platform_devic=
e *pdev)
>  					 sizeof(mram_config_vals) / 4);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Could not get Message RAM configuration.");
> -		goto disable_cclk_ret;
> +		goto failed_ret;
>  	}
> =20
>  	/* Get TX FIFO size
> @@ -1612,13 +1597,9 @@ static int m_can_plat_probe(struct platform_devi=
ce *pdev)
>  	dev =3D alloc_candev(sizeof(*priv), tx_fifo_size);
>  	if (!dev) {
>  		ret =3D -ENOMEM;
> -		goto disable_cclk_ret;
> +		goto failed_ret;
>  	}
> =20
> -	ret =3D setup_m_can_dev(pdev, dev, addr);
> -	if (ret)
> -		goto disable_cclk_ret;
> -
>  	priv =3D netdev_priv(dev);
>  	dev->irq =3D irq;
>  	priv->device =3D &pdev->dev;
> @@ -1632,6 +1613,20 @@ static int m_can_plat_probe(struct platform_devi=
ce *pdev)
>  	platform_set_drvdata(pdev, dev);
>  	SET_NETDEV_DEV(dev, &pdev->dev);
> =20
> +	/* Enable clocks. Necessary to read Core Release in order to determin=
e
> +	 * M_CAN version
> +	 */
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D pm_runtime_get_sync(&pdev->dev);

Why don't you make use of m_can_clk_start() here?

> +	if (ret)  {
> +		pm_runtime_put_noidle(&pdev->dev);
> +		goto pm_runtime_fail;
> +	}
> +
> +	ret =3D setup_m_can_dev(pdev, dev, addr);
> +	if (ret)
> +		goto pm_runtime_put;
> +
>  	ret =3D register_m_can_dev(dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "registering %s failed (err=3D%d)\n",
> @@ -1650,14 +1645,15 @@ static int m_can_plat_probe(struct platform_dev=
ice *pdev)
>  	 * Stop clocks. They will be reactivated once the M_CAN device is ope=
ned
>  	 */
> =20
> -	goto disable_cclk_ret;
> +	goto pm_runtime_put;
> =20
>  failed_free_dev:
>  	free_m_can_dev(dev);
> -disable_cclk_ret:
> -	clk_disable_unprepare(cclk);
> -disable_hclk_ret:
> -	clk_disable_unprepare(hclk);
> +pm_runtime_put:
> +	pm_runtime_put_sync(&pdev->dev);
> +pm_runtime_fail:
> +	if (ret)
> +		pm_runtime_disable(&pdev->dev);
>  failed_ret:
>  	return ret;
>  }
> @@ -1715,6 +1711,9 @@ static int m_can_plat_remove(struct platform_devi=
ce *pdev)
>  	struct net_device *dev =3D platform_get_drvdata(pdev);
> =20
>  	unregister_m_can_dev(dev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
>  	platform_set_drvdata(pdev, NULL);
> =20
>  	free_m_can_dev(dev);
> @@ -1722,7 +1721,37 @@ static int m_can_plat_remove(struct platform_dev=
ice *pdev)
>  	return 0;
>  }
> =20
> +int m_can_runtime_suspend(struct device *dev)
> +{
> +	struct net_device *ndev =3D dev_get_drvdata(dev);
> +	struct m_can_priv *priv =3D netdev_priv(ndev);
> +
> +	clk_disable_unprepare(priv->cclk);
> +	clk_disable_unprepare(priv->hclk);
> +
> +	return 0;
> +}
> +
> +int m_can_runtime_resume(struct device *dev)
> +{
> +	struct net_device *ndev =3D dev_get_drvdata(dev);
> +	struct m_can_priv *priv =3D netdev_priv(ndev);
> +	int err;
> +
> +	err =3D clk_prepare_enable(priv->hclk);
> +	if (err)
> +		return err;
> +
> +	err =3D clk_prepare_enable(priv->cclk);
> +	if (err)
> +		clk_disable_unprepare(priv->hclk);
> +
> +	return err;
> +}
> +
>  static const struct dev_pm_ops m_can_pmops =3D {
> +	SET_RUNTIME_PM_OPS(m_can_runtime_suspend,
> +			   m_can_runtime_resume, NULL)
>  	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
>  };
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hNN93DZhzPuq4eJzwXu1cP3k9JiVESaBt--

--Gtmus5PqRznLuzxlEDhhhJfGeCmPLaRZc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpcstYACgkQHv7KIOw4
HPZi5Af/Rt5hdLsmWcK5JZpTxqLz9+0qZz1ExkPNb7LevhyPCmwuTMskkFqKfLYI
tV2ESisuNrWQwKxQGPUWyrHOC7OSAYogMv+6EUe0R+J19A5h9UzjxhuNBick6k19
NO2V3YJopDad+ou2efRfCN0d90LbJ8zvXHegn+7yWTR5GZX8/dP9wTaGfDSz3ys4
XGoeui++2IVNt5xbwWCj98YeFYNYm/85+8rQedADTuBQKvyRXcmI9mwSVjVz7Ia2
8/ZGvjoWh1wAJ6bK+9gDjYISD3HBpfImvQZqEQye6liyGMBocYXzCx1bIEFjTdI0
1y5kN62Oew1gUhFJfl1TusUvYkSKUA==
=gP41
-----END PGP SIGNATURE-----

--Gtmus5PqRznLuzxlEDhhhJfGeCmPLaRZc--
