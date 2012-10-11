From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] usb: xhci: Add the suspend/resume functionality
Date: Thu, 11 Oct 2012 10:52:41 +0300
Message-ID: <20121011075241.GK10030@arwen.pp.htv.fi>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
 <1349877949-18872-3-git-send-email-vikas.sajjan@linaro.org>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1349877949-18872-3-git-send-email-vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vikas C Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2012 at 07:35:48PM +0530, Vikas C Sajjan wrote:
> From: Vikas Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> Adding the suspend and resume functionality for the XHCI driver
>=20
> Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Vikas C Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/usb/host/xhci-plat.c |   44 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 44 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index df90fe5..384cf4d 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -185,11 +185,55 @@ static int xhci_plat_remove(struct platform_device =
*dev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM
> +static int xhci_plat_suspend(struct device *dev)
> +{
> +	struct usb_hcd		*hcd;
> +	struct xhci_hcd		*xhci;
> +
> +	hcd =3D dev_get_drvdata(dev);

make it a single line, together with declaration.

> +	if (!hcd)
> +		return -EINVAL;

remove this.

> +	xhci =3D hcd_to_xhci(hcd);

make it a single line, together with declaration.

> +	/* Make sure that the HCD Core as set state HC_STATE_SUSPENDED */

HCD Core *HAS* set ??? I think this also deserves a "to" after "state":

	/* Make sure HCD Core has set state to HC_STATE_SUSPENDED */

> +	if (hcd->state !=3D HC_STATE_SUSPENDED ||
> +		xhci->shared_hcd->state !=3D HC_STATE_SUSPENDED)
> +		return -EINVAL;
> +
> +	return xhci_suspend(xhci);
> +}
> +
> +static int xhci_plat_resume(struct device *dev)
> +{
> +	struct usb_hcd		*hcd;
> +	struct xhci_hcd		*xhci;
> +
> +	hcd =3D dev_get_drvdata(dev);

make it a single line, together with declaration.


> +	if (!hcd)
> +		return -EINVAL;

remove this.

> +
> +	xhci =3D hcd_to_xhci(hcd);

make it a single line, together with declaration.

> +	return xhci_resume(xhci, 0);
> +}

this should look like:

static int xhci_plat_resume(struct device *dev)
{
	struct usb_hcd		*hcd =3D dev_get_drvdata(dev);
	struct xhci_hcd		*xhci =3D hcd_to_xhci(hcd);

	return xhci_resume(xhci, 0);
}

> +static const struct dev_pm_ops xhci_plat_pm_ops =3D {
> +	.suspend		=3D xhci_plat_suspend,
> +	.resume			=3D xhci_plat_resume,
> +};

#define XHCI_PLAT_PM_OPS	(&xhci_plat_pm_ops)
#else
#define XHCI_PLAT_PM_OPS	NULL
#endif

> +#endif
> +
>  static struct platform_driver usb_xhci_driver =3D {
>  	.probe	=3D xhci_plat_probe,
>  	.remove	=3D xhci_plat_remove,
>  	.driver	=3D {
>  		.name =3D "xhci-hcd",
> +#ifdef CONFIG_PM
> +		.pm =3D &xhci_plat_pm_ops,
> +#endif

		.pm =3D XHCI_PLAT_PM_OPS,

--=20
balbi

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQdnrJAAoJEIaOsuA1yqREfyUP/0+sj9JmQcjVpYS65WvqmLu2
1rUU86vJL3dE4z47uHCM0Ac0yUh2M0mjFfUPiXYqx3QVne9DfVZ6vCmnWDX1WUI1
XgCzjQ7znm8IhoohufcZmjLK3Fdre1iGCevCpCcf46pJ757mc2Jul7VQJx/fqccd
0U+bTwwEyD7zbewV4g+q6J6vlW1UfQl2J81HJW4ITs4JAPv7ID0lqR5PTwGs7FUd
KdkTLpydgcWS3JB1DEmpt3zhJqHUTG/IZiK6xVE8BEWu325psTlVpA7WRw6z0lg5
Kw0EWxk07w4UAL7fCqqkFLNKhEeCjk35/aeZ3eMuIFB0RZ5zydRLt5HbQ8aLY77W
ba4Xc1W2kClUcpEmdSkTixMugqmgJEsSN46ha8raub4J9dU/NmkZd6FY5nF4iHT7
w/Jpr+J2CpVaPR6m0UFXBaQl5olqBP3EM6gtJo2V/zs+1H4LhH1pro8UxLY64wKd
qeIRn+QUhBt9IOp8GE+SiEIgEATcgLKVPzCVLZGPbGltNdmvazTWdgpJvrzM4ueE
A+Dc17Qh8JiTbJ5Omk2GVQHCxsBPbCJP+wshGailzXMWkLkyMm9S1x9LFxqQwqrK
I0w9k1RFmrPVfGs6L780+mjNMCDXcMSSN9bE3kxkAeKXbo96POBZuLQJgTKfDxLS
vKDqKjsQI2E/PJoZRTXK
=c3Lp
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
