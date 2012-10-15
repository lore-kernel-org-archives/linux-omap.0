From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 2/3] usb: xhci: Add the suspend/resume functionality
Date: Mon, 15 Oct 2012 15:10:40 +0300
Message-ID: <20121015121040.GH24333@arwen.pp.htv.fi>
References: <1350133825-24181-1-git-send-email-vikas.sajjan@linaro.org>
 <1350133825-24181-3-git-send-email-vikas.sajjan@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q6STzHxy03qt/hK9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60267 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab2JOMQK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 08:16:10 -0400
Content-Disposition: inline
In-Reply-To: <1350133825-24181-3-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikas Sajjan <vikas.sajjan@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

--Q6STzHxy03qt/hK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2012 at 06:40:24PM +0530, Vikas Sajjan wrote:
> Adding the suspend and resume functionality for the XHCI driver

please do better on your commit log.

> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
> CC: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/usb/host/xhci-plat.c |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index df90fe5..15c7c89 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -185,11 +185,44 @@ static int xhci_plat_remove(struct platform_device =
*dev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM
> +static int xhci_plat_suspend(struct device *dev)
> +{
> +	struct usb_hcd	*hcd	=3D dev_get_drvdata(dev);
> +	struct xhci_hcd	*xhci	=3D hcd_to_xhci(hcd);
> +
> +	/* Make sure that the HCD Core has set state to HC_STATE_SUSPENDED */
> +	if (hcd->state !=3D HC_STATE_SUSPENDED ||
> +		xhci->shared_hcd->state !=3D HC_STATE_SUSPENDED)
> +		return -EINVAL;
> +
> +	return xhci_suspend(xhci);
> +}
> +
> +static int xhci_plat_resume(struct device *dev)
> +{
> +	struct usb_hcd	*hcdi	=3D dev_get_drvdata(dev);
> +	struct xhci_hcd	*xhci	=3D hcd_to_xhci(hcd);
> +
> +	return xhci_resume(xhci, 0);
> +}
> +
> +static const struct dev_pm_ops xhci_plat_pm_ops =3D {
> +	.suspend		=3D xhci_plat_suspend,
> +	.resume			=3D xhci_plat_resume,

I believe you should be using SET_SYSTEM_PM_SLEEP_PM_OPS()

> +};
> +
> +#define XHCI_PLAT_PM_OPS        (&xhci_plat_pm_ops)
> +#else
> +#define XHCI_PLAT_PM_OPS        NULL
> +#endif
> +
>  static struct platform_driver usb_xhci_driver =3D {
>  	.probe	=3D xhci_plat_probe,
>  	.remove	=3D xhci_plat_remove,
>  	.driver	=3D {
>  		.name =3D "xhci-hcd",
> +		.pm =3D XHCI_PLAT_PM_OPS,
>  	},
>  };
>  MODULE_ALIAS("platform:xhci-hcd");
> --=20
> 1.7.6.5
>=20

--=20
balbi

--Q6STzHxy03qt/hK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQe/1AAAoJEIaOsuA1yqREJeoP/3h4DFsBEI//sFRQ44ixd2IZ
7DTAHE/vvO+XVT4Z+CRE8agsG3rQSPqqXNt6yOtUMIrbx2HtWwnvHF8kAdoWjx0t
Ar6I7ZyrWgNKeyO1cVCPksMiaEvqbS79DvBfEkvsK1jXefTHVoos8YdGQ96uRw3Q
ZkjSToZ3MeZptGFftqIWIA05MaJwKdxa6F7VvZoQIhrErJtAlDyJV6PkJXHqEB8h
ezmw3m9E6XXDCD6EObwyQ54BPUVS4ESbFFCZf85kPGLPmMDz3jU76q0TJwRLNLVY
LtuXhwwI1MVlHya3KKRmJizXcNzQJ3aGO/q8quYTMJ7aZdAHX+MG0wZhahYzsNGB
ls4Bz7ENaNtrT3fQIzbz4azL41qpzFjT7xnF92ExD7nYLRaDmd2lxehmxMhFFvKw
qr5yYyGn3YwwjzYdKx3Ygqn07Ic0ENPLMcDGK77Pg/Dy9HjkPYQ9MuBIyc/cecJq
yWJTm2jP9jD39DWyH7ZgPLSuB5Nrik4P8TNgVbfJcu+Rxo03OdfomlbcM1pkwcoz
cSGuOlx+1AbX6SKYq7CwzguyydHsE+IcILn5BnI0BqBpi4a/h2WOQQDPkVUsSrQb
7hxe2vCjfEwM3DkYZt2ee294KxmhQFksj95U66n4DpesDeYdcwBdEsOi2VE7RlMC
XZElTU9VCP6242qeEfJT
=xCRH
-----END PGP SIGNATURE-----

--Q6STzHxy03qt/hK9--
