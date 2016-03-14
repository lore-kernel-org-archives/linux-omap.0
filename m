From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: add disable receiver detection in P3 quirk
Date: Mon, 14 Mar 2016 08:55:49 +0200
Message-ID: <87io0pblai.fsf@intel.com>
References: <1457929793-18910-1-git-send-email-rajesh.bhagat@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457929793-18910-1-git-send-email-rajesh.bhagat-3arQi8VN3Tc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sriram.dash-3arQi8VN3Tc@public.gmane.org, Rajesh Bhagat <rajesh.bhagat-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Rajesh Bhagat <rajesh.bhagat-3arQi8VN3Tc@public.gmane.org> writes:
> [ text/plain ]
> Some freescale QorIQ platforms require to disable receiver detection
> in P3 for correct detection of USB devices. If GUSB3PIPECTL(DISRXDETINP3)
> is set, Core will change PHY power state to P2 and then perform receiver=
=20
> detection. After receiver detection, Core will change PHY power state to=
=20
> P3. Same quirk would be added in dts file in future patches.=20
>
> Signed-off-by: Sriram Dash <sriram.dash-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Rajesh Bhagat <rajesh.bhagat-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/usb/dwc3/core.c          |    6 ++++++
>  drivers/usb/dwc3/core.h          |    2 ++
>  drivers/usb/dwc3/platform_data.h |    1 +
>  3 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index de5e01f..b2f2b08 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -446,6 +446,9 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>  	if (dwc->u2ss_inp3_quirk)
>  		reg |=3D DWC3_GUSB3PIPECTL_U2SSINP3OK;
>=20=20
> +	if (dwc->dis_rxdet_inp3_quirk)
> +		reg |=3D DWC3_GUSB3PIPECTL_DISRXDETINP3;
> +
>  	if (dwc->req_p1p2p3_quirk)
>  		reg |=3D DWC3_GUSB3PIPECTL_REQP1P2P3;
>=20=20
> @@ -903,6 +906,8 @@ static int dwc3_probe(struct platform_device *pdev)
>  				"snps,u2exit_lfps_quirk");
>  	dwc->u2ss_inp3_quirk =3D device_property_read_bool(dev,
>  				"snps,u2ss_inp3_quirk");
> +	dwc->dis_rxdet_inp3_quirk =3D device_property_read_bool(dev,
> +				"snps,dis_rxdet_inp3_quirk");

not documented under Documentation/devicetree/bindings/usb/dwc3.txt.

> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index e4f8b90..41cc22c 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -193,6 +193,7 @@
>  /* Global USB3 PIPE Control Register */
>  #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
>  #define DWC3_GUSB3PIPECTL_U2SSINP3OK	(1 << 29)
> +#define DWC3_GUSB3PIPECTL_DISRXDETINP3	(1 << 28)
>  #define DWC3_GUSB3PIPECTL_REQP1P2P3	(1 << 24)
>  #define DWC3_GUSB3PIPECTL_DEP1P2P3(n)	((n) << 19)
>  #define DWC3_GUSB3PIPECTL_DEP1P2P3_MASK	DWC3_GUSB3PIPECTL_DEP1P2P3(7)
> @@ -873,6 +874,7 @@ struct dwc3 {
>=20=20
>  	unsigned		tx_de_emphasis_quirk:1;
>  	unsigned		tx_de_emphasis:2;
> +	unsigned		dis_rxdet_inp3_quirk:1;

_must_ be sorted alphabetically and you _must_ update the kernel doc
above this structure.

>  };
>=20=20
>  /* ---------------------------------------------------------------------=
----- */
> diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform=
_data.h
> index 2bb4d3a..9df1dfb 100644
> --- a/drivers/usb/dwc3/platform_data.h
> +++ b/drivers/usb/dwc3/platform_data.h
> @@ -46,6 +46,7 @@ struct dwc3_platform_data {
>=20=20
>  	unsigned tx_de_emphasis_quirk:1;
>  	unsigned tx_de_emphasis:2;
> +	unsigned dis_rxdet_inp3_quirk:1;

likewise.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5mB2AAoJEIaOsuA1yqRENnYQAJf+YqC0UOWFBxMkK1+JqkHS
wHo5sTYX1uw/xqy2czzUzJ0AItnBFa8jFPlao9iPf2V7WC7i5lGMrbtzjt3jQ6Uu
pobMcOw2ePLb8wvb6T27qO1tz/QIvNtYoGmsI7ayXaq94z4tessoIsainybV7KJ1
T2NdC9M6As3vG+yeRRUM17LkmbqCHM6rAvp92b2zP1fxUzMquDBSn7S+8EdC+jtw
v/0LsJsEJrE5trqatRF3Ib4npv58QOisPo7trNw2BFsEfYfxiJVDf5d8XV+bMfJJ
EC1p5eWYODUIrA5OFARXV1HwAA80y0DvzguRjWsBVQaUDhYi7ZKKl4sLahWJOmO7
vHYTxG+DlayKNmR8vjn0XA69+RBcgwa1UMzmNcG1dj4eylosK3WqZEjW0y/x0QZp
Z7oknm5w3LOQTe+BbVDBe5ohGK8pb+vHXjFS/6iSVcK07NDbu9F5wPu9TZmRtJwH
6sbFDvqfGdws0b4UbGJA52Um/dncABtzw3XAXioxbvPMoD5cDoE1FOjvatXlmC+Y
tPxZHzrA1+sxJkw9hF5l9YAqGPbq3IoPuiJNqXsc8X0CXl+8Om9S1fNmZRwf7hjb
caj7JAl5xKfe0EsfWQUeoDFvk7UVpIC4nXTpzpck64YqJtPn8oP7s/oBif0ZOMG0
ofotCYp9znjMsL79RGFM
=zh/W
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
