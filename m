From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Tue, 16 Oct 2012 13:06:56 +0300
Message-ID: <20121016100656.GB17416@arwen.pp.htv.fi>
References: <1350380738-32473-1-git-send-email-vikas.sajjan@linaro.org>
 <1350380738-32473-2-git-send-email-vikas.sajjan@linaro.org>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1350380738-32473-2-git-send-email-vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vikas Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 16, 2012 at 03:15:36PM +0530, Vikas Sajjan wrote:
> Adds suspend and resume callbacks as part of the power management
> support to DWC3 controller Driver.
> This patch facilitates transition of DWC3 controller between D0 and D3
> power states during suspend/resume cycles.
>=20
> Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Vikas C Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/usb/dwc3/core.c |   44 +++++++++++++++++++++++++++++++++++++++++=
+++
>  1 files changed, 44 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 5db4c76..9f35cf8 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -621,11 +621,55 @@ static int __devexit dwc3_remove(struct platform_de=
vice *pdev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM_SLEEP
> +static int dwc3_resume(struct device *dev)
> +{
> +	struct dwc3 *dwc =3D dev_get_drvdata(dev);
> +	int	ret;
> +
> +	ret =3D dwc3_core_init(dwc);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (dwc->mode) {
> +	case DWC3_MODE_DEVICE:
> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +		break;
> +	case DWC3_MODE_HOST:
> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
> +		break;
> +	case DWC3_MODE_DRD:
> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
> +	}
> +
> +	/* runtime set active to reflect active state. */
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +
> +static int dwc3_suspend(struct device *dev)
> +{
> +	struct dwc3 *dwc =3D dev_get_drvdata(dev);
> +

there is one check you need to do here. If you are playing the
peripheral role, you can't allow suspend unless link is in U3 or you're
not enumerated.

Have you tested running 'echo mem > /sys/power/state' on your device
while you're transferring data in a USB session with the Host ?

I'll ask again, how was this tested ? What did you actually run (which
commands, which use cases have you validated) ? I'm not asking only
which platform you used, I need to know how you exercised this feature,
how did you trigger suspend/resume, in which conditions (enumerated ?
bus suspended ? no cable attached ?), etc.

cheers

--=20
balbi

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfTHAAAoJEIaOsuA1yqREsH4P/AxL+lnDBDhCQYfnwtVNoka7
U7TUsD/hGx/liqnXJo9Xb2oI4fypt3JToG6dRYhKwT8Jwz5zpdGqTiDxL6xcn7gy
Q5l0O3+NkeMMhyzGmthTI9T/S4AzJHd9hg7IRhiG5cwtVwfaRQGBXQMgdzuo+Rg/
mCADsyZH6xunt7FuYyss0rtvGFHUW6YLaDVx4r9CrMpajFNZNaR1K2YakXYF/QWb
zn18uOMfstcShgao3QRuO4yhefUs1DMWyLMDIUfnOJekohR2gCZcR8Kl+Q7WP2hH
OTj4bTg9M72ybETdvGbgu9PAsUjTpiSMpUwRhMoEPOlidH3ViE/eJsM1RKmzfXbR
lTxgomTVXLlm0Imiq9Yt7MgY/kEOKSpY3xaL4Vc3QvhfRHmB34a+GTuKmc0JjopF
6IJ+7VygjcTwTfR8Y2HSKqMbgkTz+4jjuKj7ecdah24kUOv2EmTUiVcoNDezkIt6
2Xe5p2P1yuyL2+lcpFCKmlHegWaHuSNOBthi5Nx74YKWzZjSQ85kY8YGKSUiZFW8
AXWifSpV2ABPk8HcfJQvf+WfHZDCvXAZ+i2CPrYG0AdWbwkZ3Acopc0Algp4KPd4
3KDSOOYVIg8XQYOVX0IS1ei6t8JTpsGbX5rbUCK6ca5nevwTHuJkE7y9k2/0uP4t
LvtqvcSNSv8KTKnnsgsQ
=d6YJ
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
