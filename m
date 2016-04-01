From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 2/2] usb:dwc3: pass arch data to xhci-hcd child
Date: Fri, 01 Apr 2016 10:58:31 +0300
Message-ID: <871t6pahg8.fsf@intel.com>
References: <1457594332-7490-1-git-send-email-tqnguyen@apm.com> <1457594332-7490-3-git-send-email-tqnguyen@apm.com> <87mvpgi02f.fsf@intel.com> <56FBDA0D.4030507@ti.com> <87egashxz8.fsf@intel.com> <CAKrQpSvgTm+OM+ffO4ZKwpb=J3ewKoWYA7ojE+WKBbiYKwdMqw@mail.gmail.com> <87k2kjgjjf.fsf@intel.com> <56FD3D2F.8070501@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FD3D2F.8070501-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
> On 03/31/2016 11:04 AM, Felipe Balbi wrote:
>> "Thang Q. Nguyen" <tqnguyen-qTEPVZfXA3Y@public.gmane.org> writes:
>>> [ text/plain ]
>>> Thanks Grygorii for information.
>>> I checked but do not see dma_init_dev_from_parent is used in
>>> linux-next repository. Can you give me more information for what
>>> branch I can checkout to use it for USB DWC3?
>>=20
>> dma_init_dev_from_parent() is still a proposal ;-)
>>=20
>
> Felipe,
>
> After some experiments I came up with below fix (not common, but fixes USB
> case on keystone 2). if you agree with proposed fix I'll send proper
> patches to fix usb_add_gadget_udc_release() and dwc3_host_init() in the s=
ame
> way.
>
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index c679f63..3fe1c65 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -17,6 +17,7 @@
>=20=20
>  #include <linux/platform_device.h>
>  #include <linux/usb/xhci_pdriver.h>
> +#include <linux/of_device.h>
>=20=20
>  #include "core.h"
>=20=20
> @@ -35,8 +36,6 @@ int dwc3_host_init(struct dwc3 *dwc)
>         dma_set_coherent_mask(&xhci->dev, dwc->dev->coherent_dma_mask);
>=20=20
>         xhci->dev.parent        =3D dwc->dev;
> -       xhci->dev.dma_mask      =3D dwc->dev->dma_mask;
> -       xhci->dev.dma_parms     =3D dwc->dev->dma_parms;
>=20=20
>         dwc->xhci =3D xhci;
>=20=20
> @@ -62,6 +61,12 @@ int dwc3_host_init(struct dwc3 *dwc)
>         phy_create_lookup(dwc->usb3_generic_phy, "usb3-phy",
>                           dev_name(&xhci->dev));
>=20=20
> +       if (!dwc->dev->of_node) {
> +               xhci->dev.dma_mask      =3D dwc->dev->dma_mask;
> +               xhci->dev.dma_parms     =3D dwc->dev->dma_parms;
> +       } else=20
> +               of_dma_configure(&xhci->dev, dwc->dev->of_node);

if of_dma_configure() does what you want, why don't you just stick it in
dwc3-keystone.c and let the driver continue to copy things for now ?
Something like below, perhaps ?

diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keyst=
one.c
index 2be268d2423d..a4bd7f16090f 100644
=2D-- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -39,8 +39,6 @@
 #define USBSS_IRQ_COREIRQ_EN	BIT(0)
 #define USBSS_IRQ_COREIRQ_CLR	BIT(0)
=20
=2Dstatic u64 kdwc3_dma_mask;
=2D
 struct dwc3_keystone {
 	struct device			*dev;
 	struct clk			*clk;
@@ -108,9 +106,7 @@ static int kdwc3_probe(struct platform_device *pdev)
 	if (IS_ERR(kdwc->usbss))
 		return PTR_ERR(kdwc->usbss);
=20
=2D	kdwc3_dma_mask =3D dma_get_mask(dev);
=2D	dev->dma_mask =3D &kdwc3_dma_mask;
=2D
+	of_dma_configure(&kdwc->dev, node);
 	kdwc->clk =3D devm_clk_get(kdwc->dev, "usb");
=20
 	error =3D clk_prepare_enable(kdwc->clk);


=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/iooAAoJEIaOsuA1yqRETZYQALZMFoH0UCrSp3Gf8r+1i2kK
NmBGHQ7j5FV4hrzoiuII5aRb4L/X/sZx8Uxblm1/9TcWflJ0X6fKe5yd6O3ug34h
M9DZ7NwiH5yE1fQTCoLX5Nh7rsyxClbOpt0uRzQHAmaUWxo8sIcCqvPEdOa0/WkN
HqtdvleWfuaO3kAQjHmrE/7dhYDKhuLKRKgzrjhzFYJa7iHuCmrroaZRkAJ+BCYw
2g2TFYBC9hnr+uN3mUrgf4wpzbAwfiJb711UyTdepdbsYJ4wzgVMBmGE6fDzrpEg
dCJwXPDCrPc768jajlYKMc/1c8IIEQUusmX84BgFsmNz9oQir+26DO0Koq12veop
zl3QoNkofeQ4CS8bq1X2Qo1mg+RGx2ITl+qVSlr2qIXOLxTHvcOz8vMebACot4Vx
SLE37o+Ft9P6WQJM1gmlNK+gBhOPlZbQD93sKT3AabmDlru0BLf1ocYLkD+iKMFi
R9tRZysVEVeCJIfyFSiO5eeRsGwMI9UBpyhUBK5H0YJtEUJpNUUSbbKjIAVBYxqQ
u5/ENLaoyoeu9XAA3RNG/STx5DRlIJJgluMxz+agWIXSuY7TukKUC/IkjsfdB8cg
Rnr/nhCaX/0oaHKnWQXDFt2d/qPjoMq7esSc1kUHJu76032VGK6TcBAmrYLbQZ84
h73mZHjrICV3v3q3CGlh
=TAE/
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
