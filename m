From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 01/11] usb: musb: add musb->id to identify core instance
Date: Wed, 25 Jul 2012 10:45:35 +0300
Message-ID: <20120725074534.GQ3630@arwen.pp.htv.fi>
References: <1342698367-12978-1-git-send-email-ajay.gupta@ti.com>
 <1342698367-12978-2-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4834618234899432431=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1342698367-12978-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============4834618234899432431==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LW0Rr0Uq98qh6Rv"
Content-Disposition: inline


--1LW0Rr0Uq98qh6Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 19, 2012 at 05:15:57PM +0530, Ajay Kumar Gupta wrote:
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 89d1871..3e09984 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -99,6 +99,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> +#include <linux/idr.h>
> =20
>  #include "musb_core.h"
> =20
> @@ -114,6 +115,7 @@
> =20
>  #define MUSB_DRIVER_NAME "musb-hdrc"
>  const char musb_driver_name[] =3D MUSB_DRIVER_NAME;
> +static DEFINE_IDA(musb_ida);
> =20
>  MODULE_DESCRIPTION(DRIVER_INFO);
>  MODULE_AUTHOR(DRIVER_AUTHOR);
> @@ -130,6 +132,33 @@ static inline struct musb *dev_to_musb(struct device=
 *dev)
> =20
>  /*----------------------------------------------------------------------=
---*/
> =20
> +int musb_get_id(struct device *dev, gfp_t gfp_mask)
> +{
> +	int ret;
> +	int id;
> +
> +	ret =3D ida_pre_get(&musb_ida, gfp_mask);
> +	if (!ret) {
> +		dev_err(dev, "failed to reserve resource for id\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret =3D ida_get_new(&musb_ida, &id);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to allocate a new id\n");
> +		return ret;
> +	}
> +
> +	return id;
> +}
> +
> +void musb_put_id(struct device *dev, int id)
> +{
> +
> +	dev_dbg(dev, "removing id %d\n", id);
> +	ida_remove(&musb_ida, id);
> +}

both of these should be EXPORT_SYMBOL_GPL() for cases when musb and glue
are compiled as modules.

--=20
balbi

--1LW0Rr0Uq98qh6Rv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD6QeAAoJEIaOsuA1yqREQ/IP/jcCpOHPG3KmsiPtTS8fCTjt
iuq1Oyxy1gWqB+zTV/M/2Cv7O5bjxQS9wzzK5/X8EHXGQaTfONfo4VTYzTA0j7g8
a/BS+xAraFoPfPWl4EII02p7t2fpJaOKH4uqISIpy1wv5iZxBApc/ZChilCzP5CA
6h9UB6SrGm6cpq75CBWFIYH8dVfn+mdQp7FV44PD2eBpv4q4dcz4nWdL8AA0unBj
aug+jkVbDEXE3Ifhw+GSffHY4gd7pnwUu/bshqJ0u7aylo1fIn8EeSPf7QtX3sLx
GXt1xtc0Q5iVm/ty7Y1ebwLIEGHn6z8bp6Si/DzeQOZ1kwjOstqh1/h1PK1FJxND
TG2f65R1szzEzZe8uFjJxVkgYt4vdZG6xHZJUtAyndDdMKEk3sfZ1Z5xtqdaZZgb
pPxoRjzw5ZNg5BDxJcw7dbMOkp7Ml81CVOfCX37CeczUi0a68tmRqPRMDtXL0BXN
PwIibZKrfw9QCqY/y/W29Giies5EfznI5QY7waT7M3VsTA24vIoGFlOfnkcoJwCe
BbPsG9HGLY6u5horKusLG+lOgBEb0lGlNa0K/msxxdGl8LZpx+HA5gYYFHZStemK
kbxkMtyLZB+pgMD1S2LyCxTWtZOJUg0vKdYdvaQaUQStAwO7VaMMOwipggxxLi6Q
Mpved82G/+zi/lutAcdx
=xZ5q
-----END PGP SIGNATURE-----

--1LW0Rr0Uq98qh6Rv--

--===============4834618234899432431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4834618234899432431==--
