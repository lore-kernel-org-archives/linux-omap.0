From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 03/10] usb: dwc3: omap: Pass VBUS and ID events transparently
Date: Mon, 11 Apr 2016 15:18:08 +0300
Message-ID: <87egacnxtr.fsf@intel.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com> <1460374506-9779-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460374506-9779-4-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> Don't make any decisions regarding VBUS session based on ID
> status. That is best left to the OTG core.

what about builds who don't want OTG and/or dual-role ?

> Pass ID and VBUS events independent of each other so that OTG
> core knows exactly what to do.
>
> This makes dual-role with extcon work with OTG irq on OMAP platforms.
>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/dwc3/dwc3-omap.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 51ca098..c9b918d 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -233,19 +233,14 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap =
*omap,
>  		}
>=20=20
>  		val =3D dwc3_omap_read_utmi_ctrl(omap);
> -		val &=3D ~(USBOTGSS_UTMI_OTG_CTRL_IDDIG
> -				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
> -				| USBOTGSS_UTMI_OTG_CTRL_SESSEND);
> -		val |=3D USBOTGSS_UTMI_OTG_CTRL_SESSVALID
> -				| USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT;
> +		val &=3D ~USBOTGSS_UTMI_OTG_CTRL_IDDIG;

this creates the possibility of having a USB peripheral with VBUS_VALID,
right=20

>  		dwc3_omap_write_utmi_ctrl(omap, val);
>  		break;
>=20=20
>  	case OMAP_DWC3_VBUS_VALID:
>  		val =3D dwc3_omap_read_utmi_ctrl(omap);
>  		val &=3D ~USBOTGSS_UTMI_OTG_CTRL_SESSEND;
> -		val |=3D USBOTGSS_UTMI_OTG_CTRL_IDDIG
> -				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
> +		val |=3D USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
>  				| USBOTGSS_UTMI_OTG_CTRL_SESSVALID
>  				| USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT;

I remember discussing this with TI's IP owner back in OMAP5 days. This
code was a result of talking to that guy and was, back then, tested by
Silicon Validation team. I would strongly advise that before changing
these bits you check with whoever's currently handling this IP inside TI
to make sure your changes are still within the expectations of the
wrapper block.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC5YAAAoJEIaOsuA1yqRERJsP/jHf6nlbCpq9s2+KU7EAPURA
4QPxTGVtACYygpxojb7t4Qt/pLkEpD7FUexmm05h8EGPkbAMaab/yRQ7LZ6654BS
us7vqQdA1xRa90irKQ8l+e4OXhG6oZOnkvz2DdynvBFdD2Evfut3m7Idz0+gt3Xk
tWIqZthKj8RKPxAvLUzkch+Mdz4/arCTZBaSm8ofzgT1zUZPq+QoEsaaPyleYnth
TrGieYPG8IH45TdxcdLvs8oYO7LgiS36JvcqY7wBoZsT2wyf4YFIxLBoXQr60N7x
eDroTXlmm7r9QYLk5XADwxjg0FAqcg4jiqVzS0dfBj36S1gY8JM0zx1kFSD2GNgt
fARKqAImpMUBpxWsljS5dCdz1EyftSyj55/KqUBO2FJRNRmXvrKAGUfAdfdkCiD2
QbKMD6gRlPRU+odTwlXhzQ0XpEdDLi4LgY/fUzwcMeQtSGHm1EkettLq1rHcuRc2
VPqgC+qBUsCfc/EvBbO8DZ21ILv3i3/NM0nEWZKrHtzW5Fkzp52UDHtSY2QgbJNL
hPct6coYkd1JtzRk+hYd3SoWdPmjMDQPuSzQsFtV0m3nOjd+3w2ShVmOK7grOkia
vbcZbAnJRbcyRN2OVSZPnfsDGtQqLlfXJyf03qpxQ5JsVq43RGFRZoUrTZpv+Vxe
6CmIWExjbiFHjOFqobmz
=rGgp
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
