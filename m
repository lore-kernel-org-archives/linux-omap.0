From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 10/16] mfd: omap-usb-host: Intialize all available ports
Date: Wed, 21 Nov 2012 15:52:46 +0200
Message-ID: <20121121135246.GL10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-11-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I4g3zIzscEHdx6fd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44430 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab2KUN7R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 08:59:17 -0500
Content-Disposition: inline
In-Reply-To: <1352990054-14680-11-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--I4g3zIzscEHdx6fd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:34:08PM +0200, Roger Quadros wrote:
> OMAPs till date can have upto 3 ports. We need to initialize

s/upto/up to/

> the port mode in HOSTCONFIG register for all of them.

why *all* of them ? Isn't it enough to initialize only the ones we're
going to use ? If not, why ?

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c |   31 ++++++++++++-------------------
>  1 files changed, 12 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index c20234b..0d39bd7 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -67,12 +67,9 @@
>  #define OMAP4_UHH_SYSCONFIG_NOSTDBY			(1 << 4)
>  #define OMAP4_UHH_SYSCONFIG_SOFTRESET			(1 << 0)
> =20
> -#define OMAP4_P1_MODE_CLEAR				(3 << 16)
> +#define OMAP4_P1_MODE_MASK				(3 << 16)

changing this name isn't part of $SUBJECT.

>  #define OMAP4_P1_MODE_TLL				(1 << 16)
>  #define OMAP4_P1_MODE_HSIC				(3 << 16)
> -#define OMAP4_P2_MODE_CLEAR				(3 << 18)
> -#define OMAP4_P2_MODE_TLL				(1 << 18)
> -#define OMAP4_P2_MODE_HSIC				(3 << 18)

why do you delete these ? Also not part of $SUBJECT.

> =20
>  #define	OMAP_UHH_DEBUG_CSR				(0x44)
> =20
> @@ -343,6 +340,7 @@ static void omap_usbhs_init(struct device *dev)
>  	struct usbhs_omap_platform_data	*pdata =3D omap->pdata;
>  	unsigned long			flags;
>  	unsigned			reg;
> +	int i;
> =20
>  	dev_dbg(dev, "starting TI HSUSB Controller\n");
> =20
> @@ -403,21 +401,16 @@ static void omap_usbhs_init(struct device *dev)
>  				reg |=3D OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
>  		}
>  	} else if (is_omap_usbhs_rev2(omap)) {
> -		/* Clear port mode fields for PHY mode*/
> -		reg &=3D ~OMAP4_P1_MODE_CLEAR;
> -		reg &=3D ~OMAP4_P2_MODE_CLEAR;
> -
> -		if (is_ehci_tll_mode(pdata->port_mode[0]) ||
> -			(is_ohci_port(pdata->port_mode[0])))
> -			reg |=3D OMAP4_P1_MODE_TLL;
> -		else if (is_ehci_hsic_mode(pdata->port_mode[0]))
> -			reg |=3D OMAP4_P1_MODE_HSIC;
> -
> -		if (is_ehci_tll_mode(pdata->port_mode[1]) ||
> -			(is_ohci_port(pdata->port_mode[1])))
> -			reg |=3D OMAP4_P2_MODE_TLL;
> -		else if (is_ehci_hsic_mode(pdata->port_mode[1]))
> -			reg |=3D OMAP4_P2_MODE_HSIC;
> +		for (i =3D 0; i < omap->nports; i++) {
> +			/* Clear port mode fields for PHY mode*/
> +			reg &=3D ~(OMAP4_P1_MODE_MASK << 2*i);

add spaces around '*' operator.

> +			if (is_ehci_tll_mode(pdata->port_mode[i]) ||
> +				(is_ohci_port(pdata->port_mode[i])))
> +				reg |=3D OMAP4_P1_MODE_TLL << 2*i;

ditto

> +			else if (is_ehci_hsic_mode(pdata->port_mode[i]))
> +				reg |=3D OMAP4_P1_MODE_HSIC << 2*i;

ditto

in fact, I would convert this construct into a switch which would look
like:

reg &=3D ~(OMAP4_P1_MODE_MASK << i * 2);

switch (port_mode[i]) {
case OMAP4_P1_MODE_TLL:
	reg |=3D OMAP4_P1_MODE_TLL << i * 2;
	break;
case OMAP_P1_MODE_HSIC:
	reg |=3D OMAP4_P1_MODE_HSIC << i * 2;
	break;
}

Also, it looks like the whoel for loop with port mode settings could be
re-factored to a separate function to aid readability.

--=20
balbi

--I4g3zIzscEHdx6fd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrNyuAAoJEIaOsuA1yqRE2g8P/21ITC8wJBMQMt+cu7ekTk4t
nbfSgFSxa4jeA42ValRqGeFjvMpoPsfk8v4v8Ez2Rd3NJgIPzKFqF4yWYiVA1QNB
g3zdcf+PSeSOKfIdc7ISQ1oP+3ImSLpGAdNtqAAvDg/LJatP/R4c668IVDufCqse
uo+bmQ2j/p8MKnICzRBUgWMoLbX0C/lWCq+hzinIHk5uqP45uNdeyMzIZszYqaBP
N8hWODoDwFLeU1xpANEhk1J5OTwIXjWNw+pUhAKUxTmqU3eu/lqenXlYcS8uZtq9
dcZ6cRXdEFkMMbytvkT+uWSG42DzJfClzrtr8jRuo9M2XLh3gTNhiGbQnUowwcIx
te+sNZFTcXtHkQJ5TBtZCP94NnTKr71t3OBlzhNvW+bESS+qaq6v/S+ar6un8m0q
Yt+y58QxFyBjDlHL9XgYaleOCeTOQL1kzAV1j9fd3e2nmgbfaogXkLfsNZ4a6ZPT
0GqaDH6PF4WJ0eyZi3FIdKTXfs/bWonvuyZnu6XmTiuunJUlgndnRV52/kO+vd1g
YIZDzzg7oRYoj4elDhEk+NTBxbjozeKTuKogWu+POaHvNcoiaVg0anPahQX3LW5g
ezt329OvJdYFkawqvgBZ0BoEXFqhY89ODYfPt2Mon+o6ILWNFJu5PwcTY2m4Aw7H
YJShEgtu4M6ZvGAhHFdT
=HJOL
-----END PGP SIGNATURE-----

--I4g3zIzscEHdx6fd--
