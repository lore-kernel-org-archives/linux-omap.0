From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN
 controller
Date: Mon, 20 Aug 2012 12:41:16 +0200
Message-ID: <5032144C.2090007@pengutronix.de>
References: <1345452359-1137-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig079661ED6B9131F98E7F447A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54373 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab2HTKl1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Aug 2012 06:41:27 -0400
In-Reply-To: <1345452359-1137-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig079661ED6B9131F98E7F447A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/20/2012 10:45 AM, AnilKumar Ch wrote:
> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> register of C_CAN/D_CAN IP when clock is turned off.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> This patch has been tested on AM335X EVM. Due to lack of hardware
> I am not able to test c_can functionality. I appreciate if anyone
> can test c_can functionality with this patch.
>=20
> This patch is based on "can-next/master"=20
>=20
> Changes from v7:
> 	- Incorporated Marc's commets on v7
> 	  * changed device pointer to c_can_priv pointer

looks good.

[...]

> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -32,6 +32,7 @@
>  #include <linux/clk.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> =20
>  #include <linux/can/dev.h>
> =20
> @@ -177,8 +178,11 @@ static int __devinit c_can_plat_probe(struct platf=
orm_device *pdev)
>  		goto exit_free_device;
                     ^^^^^^^^^^^^^^^^
>  	}
> =20
> +	pm_runtime_enable(&pdev->dev);
> +
>  	dev->irq =3D irq;
>  	priv->base =3D addr;
> +	priv->device =3D &pdev->dev;
>  	priv->can.clock.freq =3D clk_get_rate(clk);
>  	priv->priv =3D clk;
> =20
> @@ -198,6 +202,7 @@ static int __devinit c_can_plat_probe(struct platfo=
rm_device *pdev)
> =20
>  exit_free_device:
>  	platform_set_drvdata(pdev, NULL);
> +	pm_runtime_disable(&pdev->dev);

I think this will end up in a NULL pointer deferf.

>  	free_c_can_dev(dev);
>  exit_iounmap:
>  	iounmap(addr);
> @@ -226,6 +231,7 @@ static int __devexit c_can_plat_remove(struct platf=
orm_device *pdev)
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(mem->start, resource_size(mem));
> =20
> +	pm_runtime_disable(&pdev->dev);
>  	clk_put(priv->priv);
> =20
>  	return 0;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig079661ED6B9131F98E7F447A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAyFE8ACgkQjTAFq1RaXHMPoACfS2zGSSP+Bimg/p3obYXwxJE1
scEAn1sok7IKH74um3fr6pvHVq5TLXqj
=dn3g
-----END PGP SIGNATURE-----

--------------enig079661ED6B9131F98E7F447A--
