From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Mon, 15 Oct 2012 15:09:43 +0300
Message-ID: <20121015120943.GG24333@arwen.pp.htv.fi>
References: <1350133825-24181-1-git-send-email-vikas.sajjan@linaro.org>
 <1350133825-24181-2-git-send-email-vikas.sajjan@linaro.org>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1350133825-24181-2-git-send-email-vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vikas Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2012 at 06:40:23PM +0530, Vikas Sajjan wrote:
> Adding the suspend and resume funtionality to DWC3 core.

typo -> functionality.

Also this is quite lame as a commit log. I'm sure you can do better than
this.

> Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Vikas C Sajjan <vikas.sajjan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/usb/dwc3/core.c |   54 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 54 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index b415c0c..0699061 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -622,11 +622,65 @@ static int __devexit dwc3_remove(struct platform_de=
vice *pdev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM
> +static int dwc3_resume(struct device *dev)
> +{
> +	struct dwc3	*dwc =3D dev_get_drvdata(dev);
> +	int	ret;
> +
> +	usb_phy_init(dwc->usb2_phy);
> +	usb_phy_init(dwc->usb3_phy);
> +
> +	ret =3D dwc3_event_buffers_setup(dwc);
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

this is wrong. You should be calling dwc3_core_init(). Databook is very
clear that we _must_ use a softreset to make sure PHY and DWC3 are in
sync, otherwise some rather difficult-to-debug bugs might show up.

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
> +	struct dwc3	*dwc =3D dev_get_drvdata(dev);
> +
> +	dwc3_event_buffers_cleanup(dwc);
> +
> +	usb_phy_shutdown(dwc->usb2_phy);
> +	usb_phy_shutdown(dwc->usb3_phy);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops dwc3_pm_ops =3D {
> +	.suspend		=3D dwc3_suspend,
> +	.resume			=3D dwc3_resume,
> +};
> +#define DWC3_PM_OPS     &(dwc3_pm_ops)
> +#else
> +#define DWC3_PM_OPS     NULL
> +#endif /* CONFIG_PM */
> +
>  static struct platform_driver dwc3_driver =3D {
>  	.probe		=3D dwc3_probe,
>  	.remove		=3D __devexit_p(dwc3_remove),
>  	.driver		=3D {
>  		.name	=3D "dwc3",
> +		.pm =3D DWC3_PM_OPS,
>  	},
>  };
> =20
> --=20
> 1.7.6.5
>=20

--=20
balbi

--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQe/0HAAoJEIaOsuA1yqRET24P/2YLuZruuf4FA/Yz3SKJ7GSn
4FyCIUOdJ7JhftDwtzEGuTG2+j+G2s25+2Ns1VQTtNlrnbjzWdTNUj1uqyoENl8q
+8IH8Vgve2+LLuTHbEgqBSle3nSVESABFDHYtAD4O/Me6VRev5Rqr8M3E1Z1HXsS
fU4FuroNzAb+lzXmNv5VC7rB/xjXWtUJxtazTcXIyXe2F6ZTA8Wxo9ZCqjNqPw2l
t0b0E0xO+s79EEUK+yTgFsZZvjZT2MO3s4RVIV132OnZfa+LJBBh7XhbdW/Knpac
gb4VEN/zENAKXQ0s/kSaUF9LTti13ZexFD8eMi5JHwffq7XdD8NMLJdmD/D6dmRZ
ZZcWRoQAzKRHQwcb1pEPjZYQfkvIDyaJoYoI7j+xau3X+ruB66kT3RQOeoj+3SlT
tUm0D5NrsvO3ZkJB+gXQvi7IL/RLgQ6qmZ7w983UK/HhbIrwd+iqLSeAtlDoLRc/
5LjBUh3tCMbhH/oKWlG3gvGURt5hJQPR8sbTg+4LyKPdNDqgVsUxj/nJ5MRddZN4
WRaiUUDLzi6BDW1MzP8IUOcuU3nhyeBan3ie8mG60hBipno1QBevYVQml7EKERq4
9afw3PrssHxMrLDF2CZ9dw4R52WCkPLCwt/kzwkF9fGnyA7h5FnB+ikG2DgPQo14
c180zz+3QRn0AL1LYx6X
=qRc3
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
