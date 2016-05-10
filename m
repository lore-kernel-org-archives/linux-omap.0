From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 1/5] usb: dwc3: omap: use request_threaded_irq()
Date: Tue, 10 May 2016 12:58:02 +0300
Message-ID: <87a8jyi6ad.fsf@linux.intel.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com> <1462873919-20532-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462873919-20532-2-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> We intend to share this interrupt with the OTG driver an to ensure
> that irqflags match for the shared interrupt handlers we use
> request_threaded_irq()
>
> If we don't use request_treaded_irq() then forced threaded irq will
> set IRQF_ONESHOT and this won't match with the OTG IRQ handler's
> IRQ flags.
>
> NOTE: OTG IRQ handler is yet to be added. This is a preparatory step.
>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/dwc3/dwc3-omap.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 59ea35f..6504e94 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -272,16 +272,22 @@ static irqreturn_t dwc3_omap_interrupt(int irq, voi=
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
> +
>  	dwc3_omap_write_irqmisc_status(omap, reg);
>=20=20
>  	reg =3D dwc3_omap_read_irq0_status(omap);
> +	if (reg)
> +		ret =3D IRQ_HANDLED;
>=20=20
>  	dwc3_omap_write_irq0_status(omap, reg);
>=20=20
> -	return IRQ_HANDLED;
> +	return ret;
>  }
>=20=20
>  static void dwc3_omap_enable_irqs(struct dwc3_omap *omap)
> @@ -497,8 +503,8 @@ static int dwc3_omap_probe(struct platform_device *pd=
ev)
>  	/* check the DMA Status */
>  	reg =3D dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
>=20=20
> -	ret =3D devm_request_irq(dev, omap->irq, dwc3_omap_interrupt, 0,
> -			"dwc3-omap", omap);
> +	ret =3D devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
> +					NULL, 0, "dwc3-omap", omap);

if you're using threaded_irq, it's better to have a NULL top half and
valid bottom half.

In fact, since this will be shared, you could do a proper preparation
and on top half check if $this device generated the IRQ and
conditionally schedule the bottom half. Don't forget to mask device's
interrupts from top half so you can run without IRQF_ONESHOT.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbCqAAoJEIaOsuA1yqREa3gQAJflOIO4LOB5o51dNEXxJDgf
uNExaMQS2BMB1ogXb/SR2Me0yWRdbI+GuPbiuQrPrn/KCLEUTD2DXeo84AfkGpSz
3iJjMyzKl9y72K7z+fvbJSZkoHL8B23LDxePWj4O3MTJR0ZL2mivhMm+iv6nped6
XQaTtA82clO2lQqCHBm0EptIid4THZ/USqlH/h2z1ClbuYjXQK8VbajFPKM27TjI
7SsS/yrcoG5Knsgy7f2v10S9tT9SvNZtd29zdgqYfW9rU8Lz1nFRlq0GJytmVTAj
Kv1z/iWFhu7ZU2+4l7zOwogMoPzCNuioLicRiQjZGJgjfZDze8FBnazl/+4kgh3D
ZyWASJfYtKYNXqvV1F7pKHWOe6B+h6EWYL6M3J7dGL1a5sB6eZgdmsXODsc0aCcb
VoUE8Pt0looh5dWjztiYImnUIOaFX8ZMeaWclEUvBQMqcWIQ7AvZcd7xEntEuXm9
dw+gL3RG/2rbyVAZY242U3wQ6UgpLdaDX1Z9qazVRENkUJxRY7WgJbUw5n7VTZ48
Jt4xPi7+vwmNbRYCNKgRHt0Wy/yRJxhTYYyDQfi9Gx19uZfvxwCmlXC/lqYYbvCC
FzhL89ZncAq5wF9TeAEt3Xaoj/hw25PbjowfCwOm6vGg/usV56Ut5tHn6lOq2y/5
YSqyEIt2GNL1GEOG2cUS
=2neD
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
