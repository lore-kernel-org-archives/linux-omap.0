From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 3/9] usb: dwc3: dwc3-omap: Make the wrapper interrupt
 shared
Date: Wed, 2 Sep 2015 09:32:57 -0500
Message-ID: <20150902143257.GE8299@saruman.tx.rr.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-4-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441203864-15786-4-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2015 at 05:24:18PM +0300, Roger Quadros wrote:
> The wrapper interrupt is shared with OTG core so mark it IRQF_SHARED.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/dwc3/dwc3-omap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index a5a1b7c..b18f2a3 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -506,8 +506,8 @@ static int dwc3_omap_probe(struct platform_device *pd=
ev)
>  	reg =3D dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
>  	omap->dma_status =3D !!(reg & USBOTGSS_SYSCONFIG_DMADISABLE);
> =20
> -	ret =3D devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
> -			"dwc3-omap", omap);
> +	ret =3D devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, IRQF_SHAR=
ED,
> +			       "dwc3-omap", omap);

looks like only first line needs to change

>  	if (ret) {
>  		dev_err(dev, "failed to request IRQ #%d --> %d\n",
>  				omap->irq, ret);
> --=20
> 2.1.4
>=20

--=20
balbi

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5wiZAAoJEIaOsuA1yqREEeYP/RRCrVbH3VeX5M049Iwk2zXC
2BpwPrLkis2z+c5OH47R2LwApC1XkTaaJ2pe9fPqkdWZayBuogycFEdqk5+uUUKG
ntr93iT1JGne+lFngDAxSg9/wnkNzs7qNhMe/TqvLNvNXSHxgAouPJZ2Dxf+6lJ1
B+CEyzO/40v03AeE7mPN1XXw9/hwdvkmjE6MXaCnawgKe4xFgwALtYCnHJJ+8lrK
U1ljvw/Z5lZkBoUW5tiglXgBOxF3tTnhtOQYyiuDsiYe4I/+lTZhXXM+9UITs7+3
VDhQP1yB7ABMejMimPm0BVm6tApDilR7+06GPHZhq8ba+RZ5bcgefw7k7mPUdsat
lCMJWg2hg2CuNZzDxE6rSbpAjFKCaGICxcl3gDstLjYnBG0zYfpE6kHoXJGfxeP0
q7wY5d0KoFFViDqMa6tefMQTJg/qqq6VQ/6STj9+qWNBVxp6Y4YOAAGtfnz0E3TC
1ICbYH44zKhbm6pwFo4WZiGOru7heu7kS8NSPdpHFEUEc0YuuUj2i/+P/xfqq6yk
Cmn4vfFYGgVg/LZ+WhAoVHLTRDgtc2rzDG5+lJ0hth3SDwHuHkyjyfHSgVkG/+Q8
MkdJ2R9tYBypryiwqsHCVpjq4m9dxqA7B5uL5lGW1PrFC4r1i06CHAkECdc/9S86
D5/zVVo7ZM40kEUpAvxy
=iWi9
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
