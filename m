From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5] usb: dwc3: dwc3-omap: Add dwc3_omap_map_offset
 function
Date: Tue, 13 May 2014 11:02:28 -0500
Message-ID: <20140513160227.GQ1151@saruman.home>
References: <1399541587-14067-1-git-send-email-george.cherian@ti.com>
 <1399541587-14067-2-git-send-email-george.cherian@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="90KBcPA0h13nTGdQ"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399541587-14067-2-git-send-email-george.cherian-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 08, 2014 at 03:03:03PM +0530, George Cherian wrote:
> Calculate the wrapper register offsets in a seperate function.
> Improve code readability, decrease the dwc3_probe() size.
>=20
> Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/dwc3/dwc3-omap.c | 80 ++++++++++++++++++++++++--------------=
------
>  1 file changed, 44 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 1160ff4..872f065 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -383,6 +383,49 @@ static int dwc3_omap_vbus_notifier(struct notifier_b=
lock *nb,
>  	return NOTIFY_DONE;
>  }
> =20
> +static void dwc3_omap_map_offset(struct dwc3_omap *omap)
> +{
> +	u32			reg;
> +	struct device_node	*node =3D omap->dev->of_node;
> +	int			x_major;
> +
> +	reg =3D dwc3_omap_readl(omap->base, USBOTGSS_REVISION);
> +	omap->revision =3D reg;
> +	x_major =3D USBOTGSS_REVISION_XMAJOR(reg);
> +
> +	/* Differentiate between OMAP5 and AM437x */
> +	switch (x_major) {
> +	case USBOTGSS_REVISION_XMAJOR1:
> +	case USBOTGSS_REVISION_XMAJOR2:
> +		omap->irq_eoi_offset =3D 0;
> +		omap->irq0_offset =3D 0;
> +		omap->irqmisc_offset =3D 0;
> +		omap->utmi_otg_offset =3D 0;
> +		omap->debug_offset =3D 0;
> +		break;
> +	default:
> +		/* Default to the latest revision */
> +		omap->irq_eoi_offset =3D USBOTGSS_EOI_OFFSET;
> +		omap->irq0_offset =3D USBOTGSS_IRQ0_OFFSET;
> +		omap->irqmisc_offset =3D USBOTGSS_IRQMISC_OFFSET;
> +		omap->utmi_otg_offset =3D USBOTGSS_UTMI_OTG_OFFSET;
> +		omap->debug_offset =3D USBOTGSS_DEBUG_OFFSET;
> +		break;
> +	}
> +
> +	/* For OMAP5(ES2.0) and AM437x x_major is 2 even though there are
> +	 * changes in wrapper registers, Using dt compatible for aegis
> +	 */
> +
> +	if (of_device_is_compatible(node, "ti,am437x-dwc3")) {
> +		omap->irq_eoi_offset =3D USBOTGSS_EOI_OFFSET;
> +		omap->irq0_offset =3D USBOTGSS_IRQ0_OFFSET;
> +		omap->irqmisc_offset =3D USBOTGSS_IRQMISC_OFFSET;
> +		omap->utmi_otg_offset =3D USBOTGSS_UTMI_OTG_OFFSET;
> +		omap->debug_offset =3D USBOTGSS_DEBUG_OFFSET;
> +	}

can you add a patch before $subject which gets rid of the switch
statement above since it's pretty much useless now that we use
compatible strings to differentiate omap5 and am437x ?

--=20
balbi

--90KBcPA0h13nTGdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTckITAAoJEIaOsuA1yqREFxgP/jIGcH1bLZV8SbgOVrWBLQJ/
jsUej0H4qIUiQVVVdH6j3QkuG3WtygNpbWloSc/gXko2+7hFOTcl7jtRnjEKqhO6
P8/BCg/2z0I/8wGkzdAiM95oSmpaqVbbkF6nxRRlQJLe12cuOr/rQn3S1vzilDey
bLAm8t40DFZxMDl6KAUgxNGHGWPnUFSnFuk8yRDoo6Zc3T0wWpU9SmDl/1BF3FX8
aN7fUAStOzhtWoX3FArd8iReKUASqz73nRJS3Mv91nhzrOHa6gPg8dM78Uv8GrBQ
2Xwm8Vgx0MuFS/Jb+Wm0W7Iylq3b3+W9zcrnMQtHq8ShDOWgzvWab8Vy0aTVcsLt
NBXWMilEJdlg+0jjIq1/0srwjvaQtMncPwI4WqBGqlhewooSZcGi7MC7ASNeuWsf
c9RUMD6lFAWKyWdg2nuu75TgsOampo8APacWIEryqs6Ca9kuOeVB3CntB3rjuT1l
vrHvCMPAr2sksPKn7wNPWFqSluJ9j+1ygB6qgUdKTFI6GSWOt7Pymj+6syKc0/+d
GyBHGxuWwDJk+k9TnmTUmY/QrfMdoZMoxRza8yUwOubYoVRt0Re07589s7yhCbct
5Wd12T6H3bq7L3UZ0BnbEjmzUftvt3T30o9f8tkn4fUV02uLNga2cZBZBx/dm+p1
WZz605l5nhEEenHswVNx
=gxBj
-----END PGP SIGNATURE-----

--90KBcPA0h13nTGdQ--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
