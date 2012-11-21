From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 08/16] mfd: omap-usb-host: know about number of ports
 from revision register
Date: Wed, 21 Nov 2012 15:43:00 +0200
Message-ID: <20121121134300.GJ10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-9-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKtFalx5NIx0HZ72"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42992 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083Ab2KUNtb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 08:49:31 -0500
Content-Disposition: inline
In-Reply-To: <1352990054-14680-9-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--tKtFalx5NIx0HZ72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:34:06PM +0200, Roger Quadros wrote:
> prevents getting clocks that don't exist on the platform.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c |   47 ++++++++++++++++++++++++++++++++-----=
------
>  1 files changed, 35 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 44772ae..ad89939 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -94,6 +94,7 @@ struct usbhs_port {
>  };
> =20
>  struct usbhs_hcd_omap {
> +	int				nports;
>  	struct usbhs_port		port[MAX_HS_USB_PORTS];
> =20
>  	struct clk			*xclk60mhsp1_ck;
> @@ -291,7 +292,7 @@ static int usbhs_runtime_resume(struct device *dev)
>  	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
>  		clk_enable(omap->ehci_logic_fck);
> =20
> -	for (i =3D 0; i < MAX_HS_USB_PORTS; i++) {
> +	for (i =3D 0; i < omap->nports; i++) {
>  		if (is_ehci_tll_mode(pdata->port_mode[i])) {
>  			if (omap->port[i].utmi_clk) {
>  				r =3D clk_enable(omap->port[i].utmi_clk);
> @@ -320,7 +321,7 @@ static int usbhs_runtime_suspend(struct device *dev)
> =20
>  	spin_lock_irqsave(&omap->lock, flags);
> =20
> -	for (i =3D 0; i < MAX_HS_USB_PORTS; i++) {
> +	for (i =3D 0; i < omap->nports; i++) {
>  		if (is_ehci_tll_mode(pdata->port_mode[i])) {
>  			if (omap->port[i].utmi_clk)
>  				clk_disable(omap->port[i].utmi_clk);
> @@ -360,8 +361,6 @@ static void omap_usbhs_init(struct device *dev)
> =20
>  	pm_runtime_get_sync(dev);
>  	spin_lock_irqsave(&omap->lock, flags);
> -	omap->usbhs_rev =3D usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
> -	dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_rev);
> =20
>  	reg =3D usbhs_read(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
>  	/* setup ULPI bypass and burst configurations */
> @@ -502,8 +501,32 @@ static int __devinit usbhs_omap_probe(struct platfor=
m_device *pdev)
>  	omap->pdata =3D pdata;
>  	platform_set_drvdata(pdev, omap);
> =20
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +	omap->usbhs_rev =3D usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
> +
> +	/* we need to call runtime suspend before we update omap->nports
> +	 * to prevent unbalanced clk_disable()
> +	 */

wrong comment style.

> +	pm_runtime_put_sync(dev);

does it *really* need to be a synchronous put ?

> +
> +	switch (omap->usbhs_rev) {
> +	case OMAP_USBHS_REV1:
> +		omap->nports =3D 3;
> +		break;
> +	case OMAP_USBHS_REV2:
> +		omap->nports =3D 2;
> +		break;
> +	default:
> +		omap->nports =3D MAX_HS_USB_PORTS;
> +		dev_info(dev,
> +		  "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
> +		   omap->usbhs_rev, omap->nports);

please make this dev_dbg().

> +		break;
> +	}
> +
>  	need_logic_fck =3D false;
> -	for (i =3D 0; i < MAX_HS_USB_PORTS; i++) {
> +	for (i =3D 0; i < omap->nports; i++) {
>  		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
>  			is_ehci_hsic_mode(i))
>  				need_logic_fck |=3D true;
> @@ -538,7 +561,7 @@ static int __devinit usbhs_omap_probe(struct platform=
_device *pdev)
>  		goto err_init60m;
>  	}
> =20
> -	for (i =3D 0; i < MAX_HS_USB_PORTS; i++) {
> +	for (i =3D 0; i < omap->nports; i++) {
>  		struct clk *pclk;
>  		char utmi_clk[] =3D "usb_host_hs_utmi_px_clk";
> =20
> @@ -588,8 +611,6 @@ static int __devinit usbhs_omap_probe(struct platform=
_device *pdev)
>  	}
> =20
> =20
> -	pm_runtime_enable(dev);

moving this part around isn't part of $SUBJECT aparently.

> -
>  	omap_usbhs_init(dev);
>  	ret =3D omap_usbhs_alloc_children(pdev);
>  	if (ret) {
> @@ -597,15 +618,15 @@ static int __devinit usbhs_omap_probe(struct platfo=
rm_device *pdev)
>  		goto err_alloc;
>  	}
> =20
> +	pr_info("OMAP USB HOST : revision 0x%x, ports %d\n",
> +			omap->usbhs_rev, omap->nports);

please remove this pr_info() as it doesn't add anything other than noise
to bootup, IMHO.

>  	return 0;
> =20
>  err_alloc:
>  	omap_usbhs_deinit(&pdev->dev);
> -
> -	pm_runtime_disable(dev);
>  	iounmap(omap->uhh_base);
> =20
> -	for (i =3D 0; i < MAX_HS_USB_PORTS; i++)
> +	for (i =3D 0; i < omap->nports; i++)
>  		clk_put(omap->port[i].utmi_clk);
> =20
>  	clk_put(omap->init_60m_fclk);
> @@ -619,6 +640,8 @@ err_xclk60mhsp2:
>  err_xclk60mhsp1:
>  	clk_put(omap->ehci_logic_fck);
> =20
> +	pm_runtime_disable(dev);
> +
>  err_remap:
>  	kfree(omap);
>  	return ret;
> @@ -639,7 +662,7 @@ static int __devexit usbhs_omap_remove(struct platfor=
m_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	iounmap(omap->uhh_base);
> =20
> -	for (i =3D 0; i < MAX_HS_USB_PORTS; i++)
> +	for (i =3D 0; i < omap->nports; i++)
>  		clk_put(omap->port[i].utmi_clk);
> =20
>  	clk_put(omap->init_60m_fclk);
> --=20
> 1.7.4.1
>=20

--=20
balbi

--tKtFalx5NIx0HZ72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrNpkAAoJEIaOsuA1yqREZBsQAI/tsC1jAGSf+m4LHNeSqwzm
R8Qd9EdQk1Ja/HDVooJNYp43GET33NlgAPZDyL3dBazWY/TV4rLXFwScgktwVaEo
oQHUNZcL/ecKQiM4ebxA2qvjeHz+B93MaHQ9wmWgHZ/0nJ9e6AfvXpLY7dyzTamC
11INe5KaKHs5xKEjhSAgHkl+jFVSzg4ZcyXOTZM7rhtRJH0BIbvGRHaEyZ0rsydz
dZwja81US8cFO82TmvMI2Q/IzE+UV5VxkGvYeiBjdc8+eX9BmQK91tsvW2E5SlAl
QAxQvgms9Tf4A/ujfjE9bR2Cre4v8erzXLpKZQVyB0AkbzWci+Xq4A40UQ0Lglhg
aP+UpuBXXBKImLM2ETZNWEfr0iYoODoMiVT3N1MsI8xL/FWOMoYl/kuFkQS2h17q
go/xGya7QWTXOmA7uaUaI1LnZXA3Z8TiwjpVLeAz0MmbnJ7ShHNCQ/HGlE+Bh634
ubcT1ikLfqSDJ5xSM84LEYetJWnUn4VukqE9inmaPE6IPq/HT7NTex8QNYSYbpL4
s570ZCI3NsWmyG8EpZD1unrC8qjtCO78VdhMxekZporf/KCRaf05Ib+qlKWX7dd2
/mq2NURSqt+Av0f204ikZRC3hqSbzqJmrSBU+sB85jc62PxYMfwgHoHgTNnn3v95
Pp+vOmhGESj9g10sIyPc
=UkvQ
-----END PGP SIGNATURE-----

--tKtFalx5NIx0HZ72--
