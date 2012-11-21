From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 09/16] mfd: omap-usb-host: override number of ports from
 platform data
Date: Wed, 21 Nov 2012 15:45:16 +0200
Message-ID: <20121121134516.GK10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-10-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5LiOUhUlsRX0HDkW"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352990054-14680-10-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--5LiOUhUlsRX0HDkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:34:07PM +0200, Roger Quadros wrote:
> For some platforms e.g. OMAP5, we cannot rely on USBHOST revision
> to determine the number of ports available. In such cases we have

you need to make it clear *why* we can't. Imagine someone reading this 5
years from now... he'll be all like: "why can't I find any documentation
about this OMAP5 ? Why was it so special that its revision register
wasn't enough to figure out number of ports ?"

> to rely on platform data (or FDT) to give us the right number of
> ports.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/usb-host.c        |    1 +
>  arch/arm/plat-omap/include/plat/usb.h |    2 +
>  drivers/mfd/omap-usb-host.c           |   46 +++++++++++++++++++++++----=
------
>  3 files changed, 35 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-hos=
t.c
> index 3c43449..eb85528 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -504,6 +504,7 @@ void __init usbhs_init(const struct usbhs_omap_board_=
data *pdata)
>  	ohci_data.es2_compatibility =3D pdata->es2_compatibility;
>  	usbhs_data.ehci_data =3D &ehci_data;
>  	usbhs_data.ohci_data =3D &ohci_data;
> +	usbhs_data.nports =3D pdata->nports;
> =20
>  	if (cpu_is_omap34xx()) {
>  		setup_ehci_io_mux(pdata->port_mode);
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/i=
nclude/plat/usb.h
> index 87ee140..6b618a1 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -27,6 +27,7 @@ enum usbhs_omap_port_mode {
>  };
> =20
>  struct usbhs_omap_board_data {
> +	int				nports;
>  	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
> =20
>  	/* have to be valid if phy_reset is true and portx is in phy mode */
> @@ -59,6 +60,7 @@ struct ohci_hcd_omap_platform_data {
>  };
> =20
>  struct usbhs_omap_platform_data {
> +	int					nports;
>  	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
> =20
>  	struct ehci_hcd_omap_platform_data	*ehci_data;
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index ad89939..c20234b 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -500,8 +500,8 @@ static int __devinit usbhs_omap_probe(struct platform=
_device *pdev)
> =20
>  	omap->pdata =3D pdata;
>  	platform_set_drvdata(pdev, omap);
> -
>  	pm_runtime_enable(dev);
> +

trailing change, not part of $SUBJECT.

>  	pm_runtime_get_sync(dev);
>  	omap->usbhs_rev =3D usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
> =20
> @@ -510,19 +510,37 @@ static int __devinit usbhs_omap_probe(struct platfo=
rm_device *pdev)
>  	 */
>  	pm_runtime_put_sync(dev);
> =20
> -	switch (omap->usbhs_rev) {
> -	case OMAP_USBHS_REV1:
> -		omap->nports =3D 3;
> -		break;
> -	case OMAP_USBHS_REV2:
> -		omap->nports =3D 2;
> -		break;
> -	default:
> -		omap->nports =3D MAX_HS_USB_PORTS;
> -		dev_info(dev,
> -		  "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
> -		   omap->usbhs_rev, omap->nports);
> -		break;
> +	/*
> +	 * If platform data contains nports then use that
> +	 * else make out number of ports from USBHS revision
> +	 */
> +	if (pdata->nports) {
> +		if (omap->nports > MAX_HS_USB_PORTS) {
> +			dev_err(dev,
> +			 "Platform data says %d ports but MAX_HS_USB_PORTS is %d\n",
> +			 omap->nports, MAX_HS_USB_PORTS);
> +		} else {
> +			omap->nports =3D pdata->nports;
> +		}
> +	} else {
> +		switch (omap->usbhs_rev) {
> +		case OMAP_USBHS_REV1:
> +			omap->nports =3D 3;
> +			break;
> +		case OMAP_USBHS_REV2:
> +		/* Both OMAP4 and 5 show the same revision but they have
> +		 * different number of ports i.e. 2 and 3 respectively.
> +		 * OMAP5 platforms must supply nports via platform data.
> +		 */

comment indentation is wrong.

> +			omap->nports =3D 2;
> +			break;
> +		default:
> +			omap->nports =3D MAX_HS_USB_PORTS;
> +			dev_info(dev,
> +			"USB HOST Rev:0x%d not recognized, assuming %d ports\n",
> +				omap->usbhs_rev, omap->nports);

dev_dbg().

--=20
balbi

--5LiOUhUlsRX0HDkW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrNrsAAoJEIaOsuA1yqREJmEP/jNaemRfE79f9+kb50yRVoti
gSjTA0GLRCYYnrbdOpwivkmeRylzr4hCmGT+3RLt4H688fcR0s0Xxe3RKwy9bhbV
A2hJYV0j3GoX5HRj5Ip+tKubcLzRuNaTt7au67iHS+9o+/irHfBMpSs9ZNBrk+00
Nzf3BwLy++aj7dFRCogcSfCFq+2rvQFwhkJOBXxvukUtMmIV/WfF9Bab9CCM3V42
wP4Ka+kzkJM2yN4snlqOgTzoDYwlI9hdocPOoqxF0kc9zuNbm+tQlNVISEPgsK9v
wX5xw8Wb6S7PSrfz3zPu3RPfFjEUKyVOwnV+/fqMHZGkHArrWA25ZPp9Qt/ru9y+
lqeDHkfgAZQQCqVUxP9I1yqYIX3mPokEeR0qXuX5q2XKIzXBdrdBrEvoE/uLD0cg
KMWNmRQ3g2SguJal+HCeavLUuAFF+TCQ3gKPbVKraRqw+QskTdWRBZ8GBmd81MXv
iD+A4Oxtd09aoSteBOyCT3ygrrwQEcdYLpCOALbef+aC8KkzAsO6ZP6qBRutroQN
cMYBRsYLjhfn0vyL4DPkWHD2UnxLzoxMuaujIeZwUuzMzD3IkjAMOu5g36v2CrKo
/ehaZEgSNvQKSUMeAGFs2DWuJy5wanoGRQGkFODRl1CDdi9+Xa36IV56AqOufosU
pEJEd7cta+slTRzTk/JC
=iWb3
-----END PGP SIGNATURE-----

--5LiOUhUlsRX0HDkW--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
