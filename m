From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 02/10] usb: dwc3: omap: Make the wrapper interrupt shared
Date: Mon, 11 Apr 2016 15:13:43 +0300
Message-ID: <87h9f8ny14.fsf@intel.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com> <1460374506-9779-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460374506-9779-3-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> The wrapper interrupt is shared with OTG core so mark it IRQF_SHARED.
>
> Use request_threaded_irq() to ensure that irqflags match for the
> shared interrupt handlers. If we don't use request_treaded_irq() then
> forced threaded irq will set IRQF_ONESHOT and this won't match with
> the OTG irq handler.

then it seems you need to _first_ fix the OTG IRQ handler. Why does it
defer ? At a minimum, first switch to threaded IRQ handler, then (in
another patch) switch to IRQF_SHARED

> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/dwc3/dwc3-omap.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 22e9606..51ca098 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -274,19 +274,25 @@ static irqreturn_t dwc3_omap_interrupt(int irq, voi=
d *_omap)
>  {
>  	struct dwc3_omap	*omap =3D _omap;
>  	u32			reg;
> +	int			ret =3D IRQ_NONE;
>=20=20
>  	reg =3D dwc3_omap_read_irqmisc_status(omap);
>=20=20
> +	if (reg)
> +		ret =3D IRQ_HANDLED;

you can avoid the local variable by returning early here.

	if (!reg)
        	return IRQ_NONE;

>  	if (reg & USBOTGSS_IRQMISC_DMADISABLECLR)
>  		omap->dma_status =3D false;
>=20=20
>  	dwc3_omap_write_irqmisc_status(omap, reg);
>=20=20
>  	reg =3D dwc3_omap_read_irq0_status(omap);
> +	if (reg)
> +		ret =3D IRQ_HANDLED;

and this check is probably unnecessary.

> @@ -506,8 +512,8 @@ static int dwc3_omap_probe(struct platform_device *pd=
ev)
>  	reg =3D dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
>  	omap->dma_status =3D !!(reg & USBOTGSS_SYSCONFIG_DMADISABLE);
>=20=20
> -	ret =3D devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
> -			"dwc3-omap", omap);
> +	ret =3D devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,

this switch to threaded IRQ is not part of $subject.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC5T4AAoJEIaOsuA1yqREJYcQAIljlXNVhe583nhTVtM0wddz
VjCzE/0+t5aMbcY7TgHlsoDkPUCirQha7PpDGg+RlLC2QTXTeAd8YaZq2N9oMnLO
KpFkg8WAKY92RXt7Y3DraPHLHtTOGaBwIAsbK4IreYsX5AHwirj8ItZKwznsD60K
WBzxEzc4EfIJ3lcsXMmUrdDdHmVyP65sCF3qfAsVP0qMQXxBHX6GOlTkoYVpizR2
YDrSFwDNg1IlZIzoixe7UT6i43pXjsj5XKH1afPgK2piZlL2buBGTcDflrn26Y0R
jXK0xwMO0BTUbTFli4MG1mie6d3s3023R3qB3E/IXUL+GM4y+MBGkeJ+QngmCF/x
Ll1z2OPeiSjNExmy0Eim7OfLHJs32TvFzSJpNINTe+K/jsy/e/7/nHuGBaqtJXn5
ps/XgnMXLTECKALJzOHJcNGIDAr3R9psGcgtLTEraE5NR/P+5vpyGLvuc+1ZFzq0
xAn/LujrmPtMy1QB3/Kytxif8slDDZrFqmw7SEaFoPpfwRsb+ozaFQgAm1SW9rKm
X6UcQWpXx8vef8yfO2sbWBHGbroH6bwXrGN884ckPnJNOK7T3cONtipW1q3Cqu0Z
fpUCsnzhpbsVVC5KiAxQPazf38P21WXKzOANHmUpeQzGUG+iwGkB7bIxFqzy3s8i
Urks5/mb5yK7FougONgy
=qPCU
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
