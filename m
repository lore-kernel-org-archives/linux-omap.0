From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 07/16] mfd: omap_usb_host: Avoid creating copy of
 platform_data
Date: Wed, 21 Nov 2012 15:40:25 +0200
Message-ID: <20121121134025.GI10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-8-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Q2l3mYpK16UQ/iv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083Ab2KUNq4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 08:46:56 -0500
Content-Disposition: inline
In-Reply-To: <1352990054-14680-8-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--9Q2l3mYpK16UQ/iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:34:05PM +0200, Roger Quadros wrote:
> We can just hold the pointer to the platform data instead
> of creating a copy of it.
>=20
> Also get rid of the unnecessary missing platform data checks
> in runtime_suspend/resume. We are already checking for missing
> platform data in probe.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

This looks ok:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mfd/omap-usb-host.c |   34 ++++++++++------------------------
>  1 files changed, 10 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 7303c41..44772ae 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -103,7 +103,7 @@ struct usbhs_hcd_omap {
> =20
>  	void __iomem			*uhh_base;
> =20
> -	struct usbhs_omap_platform_data	platdata;
> +	struct usbhs_omap_platform_data	*pdata;
> =20
>  	u32				usbhs_rev;
>  	spinlock_t			lock;
> @@ -195,8 +195,8 @@ static int omap_usbhs_alloc_children(struct platform_=
device *pdev)
>  	int					ret;
> =20
>  	omap =3D platform_get_drvdata(pdev);
> -	ehci_data =3D omap->platdata.ehci_data;
> -	ohci_data =3D omap->platdata.ohci_data;
> +	ehci_data =3D omap->pdata->ehci_data;
> +	ohci_data =3D omap->pdata->ohci_data;
> =20
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ehci");
>  	if (!res) {
> @@ -279,17 +279,12 @@ static bool is_ohci_port(enum usbhs_omap_port_mode =
pmode)
>  static int usbhs_runtime_resume(struct device *dev)
>  {
>  	struct usbhs_hcd_omap		*omap =3D dev_get_drvdata(dev);
> -	struct usbhs_omap_platform_data	*pdata =3D &omap->platdata;
>  	unsigned long			flags;
> +	struct usbhs_omap_platform_data *pdata =3D omap->pdata;
>  	int i, r;
> =20
>  	dev_dbg(dev, "usbhs_runtime_resume\n");
> =20
> -	if (!pdata) {
> -		dev_dbg(dev, "missing platform_data\n");
> -		return  -ENODEV;
> -	}
> -
>  	omap_tll_enable();
>  	spin_lock_irqsave(&omap->lock, flags);
> =20
> @@ -317,17 +312,12 @@ static int usbhs_runtime_resume(struct device *dev)
>  static int usbhs_runtime_suspend(struct device *dev)
>  {
>  	struct usbhs_hcd_omap		*omap =3D dev_get_drvdata(dev);
> -	struct usbhs_omap_platform_data	*pdata =3D &omap->platdata;
>  	unsigned long			flags;
> +	struct usbhs_omap_platform_data *pdata =3D omap->pdata;
>  	int i;
> =20
>  	dev_dbg(dev, "usbhs_runtime_suspend\n");
> =20
> -	if (!pdata) {
> -		dev_dbg(dev, "missing platform_data\n");
> -		return  -ENODEV;
> -	}
> -
>  	spin_lock_irqsave(&omap->lock, flags);
> =20
>  	for (i =3D 0; i < MAX_HS_USB_PORTS; i++) {
> @@ -349,7 +339,7 @@ static int usbhs_runtime_suspend(struct device *dev)
>  static void omap_usbhs_init(struct device *dev)
>  {
>  	struct usbhs_hcd_omap		*omap =3D dev_get_drvdata(dev);
> -	struct usbhs_omap_platform_data	*pdata =3D &omap->platdata;
> +	struct usbhs_omap_platform_data	*pdata =3D omap->pdata;
>  	unsigned long			flags;
>  	unsigned			reg;
> =20
> @@ -456,7 +446,7 @@ static void omap_usbhs_init(struct device *dev)
>  static void omap_usbhs_deinit(struct device *dev)
>  {
>  	struct usbhs_hcd_omap		*omap =3D dev_get_drvdata(dev);
> -	struct usbhs_omap_platform_data	*pdata =3D &omap->platdata;
> +	struct usbhs_omap_platform_data	*pdata =3D omap->pdata;
> =20
>  	if (pdata->ehci_data->phy_reset) {
>  		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
> @@ -509,19 +499,16 @@ static int __devinit usbhs_omap_probe(struct platfo=
rm_device *pdev)
> =20
>  	spin_lock_init(&omap->lock);
> =20
> +	omap->pdata =3D pdata;
> +	platform_set_drvdata(pdev, omap);
> +
>  	need_logic_fck =3D false;
>  	for (i =3D 0; i < MAX_HS_USB_PORTS; i++) {
> -		omap->platdata.port_mode[i] =3D pdata->port_mode[i];
> -
>  		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
>  			is_ehci_hsic_mode(i))
>  				need_logic_fck |=3D true;
>  	}
> =20
> -	omap->platdata.ehci_data =3D pdata->ehci_data;
> -	omap->platdata.ohci_data =3D pdata->ohci_data;
> -
> -
>  	if (need_logic_fck) {
>  		omap->ehci_logic_fck =3D clk_get(dev, "ehci_logic_fck");
>  		if (IS_ERR(omap->ehci_logic_fck)) {
> @@ -600,7 +587,6 @@ static int __devinit usbhs_omap_probe(struct platform=
_device *pdev)
>  				"failed error:%d\n", ret);
>  	}
> =20
> -	platform_set_drvdata(pdev, omap);
> =20
>  	pm_runtime_enable(dev);
> =20
> --=20
> 1.7.4.1
>=20

--=20
balbi

--9Q2l3mYpK16UQ/iv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrNnJAAoJEIaOsuA1yqRE/RgP/AkyzhhdxnV3UmZrABs72gLt
PLRgC24lOP/gV8KLWE86AudG+8wA38dKx/hmpXVgdbrLcPHHFJLtgwMFIcVrLfhr
W6jIIUZLgAF50NZpTA/SJSW66TauiixG02sPT3NvCl7fLtprumJ7sSNPLl1jxEoI
VLLWCSN+OSSM6Plvm4e7rwEY1NRiJHlU5Rt0JwTUxwmLpuqLUukIq6wbHFJp+d5I
dBf80cV3kGFu2tWQ0MAoep8OfsOnEs6nG71sa9Va5i/KheVrd/kel/0IvFRqZOqd
/yA6PW55PHaBj9ETUeb3wHH31wzLsNpfzfs5DOG7GCYlrYVCpeOFA8EYmBy8s7aV
VULlLTlaeSGZJ0Y74G1P7/wrinO9sDnN3YmW8uELr8dmf8J68nQYRM9DEsofSkXZ
ifUXCYXzD+yMHoKXKv9cD+yDLsWIB88VX99sdSSloMoVFJHt98IEdjlgrhEVhbxb
5DBFGJT8tGH4XNyGMEsDcKUBjHkrifKH3ZhuR8TFCQSSdlTan3taJL3Bwgr1njag
k+EV6DL+r7UgnvvTKbm6tIVR08gAqwDeGgyHdiSIYYZJB9EgW6vR5GMNCF6FkMv5
iWemTjGD1lFJH/6x81MWrY/cdPu3H4hXP747BMgqi8LVUg+abRvqMoy15DmfSANl
QkMWB6JgKsn4vJlXQAZM
=Eajd
-----END PGP SIGNATURE-----

--9Q2l3mYpK16UQ/iv--
