From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 06/16] mfd: omap-usb-host: cleanup clock management code
Date: Wed, 21 Nov 2012 15:39:13 +0200
Message-ID: <20121121133913.GH10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-7-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352990054-14680-7-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 15, 2012 at 04:34:04PM +0200, Roger Quadros wrote:
> All ports have similarly named port clocks so we can
> bunch them into a port data structure and use for loop
> to enable/disable the clocks.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mfd/omap-usb-host.c |  208 +++++++++++++++++++++----------------=
------
>  1 files changed, 101 insertions(+), 107 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 23cec57..7303c41 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -76,6 +76,8 @@
> =20
>  #define	OMAP_UHH_DEBUG_CSR				(0x44)
> =20
> +#define MAX_HS_USB_PORTS	3	/* Increase this if any chip has more */
> +
>  /* Values of UHH_REVISION - Note: these are not given in the TRM */
>  #define OMAP_USBHS_REV1		0x00000010	/* OMAP3 */
>  #define OMAP_USBHS_REV2		0x50700100	/* OMAP4 */
> @@ -87,14 +89,15 @@
>  #define is_ehci_tll_mode(x)	(x =3D=3D OMAP_EHCI_PORT_MODE_TLL)
>  #define is_ehci_hsic_mode(x)	(x =3D=3D OMAP_EHCI_PORT_MODE_HSIC)
> =20
> +struct usbhs_port {
> +	struct clk	*utmi_clk;
> +};

I rather not since this will make it a lot more difficult to use
pm_clk_add() :-s Also, this sort of thing should be dynamically
allocated anyway ;-)

--=20
balbi

--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrNmAAAoJEIaOsuA1yqRE5lcP/1CMpjoSXf3+ZtrLxVtmZKnQ
5HGihWcm0AfNL5YSqi70MlGW4w1wCRxSQwDDq6LaXDro89pBx3jNJ+k6rfzl1dVS
Kqt6VQ1f02npL5CPHctG5uNRO/6T3GQiscyIEFfRoNSPpGby0tQGQt9JgofmeAk7
z4MZr0Nc2KdI2uL8dc8bIjf+WIGmfGF68C/KCh7OkOuRc6z+vWnEMeObJqWg8HXd
ek15O/oTa9ZmqbnRwsrMVNcxiBJZm2EUc3bjQGw8tRzXNWdh57e84dUpZbPqFAzl
AEQRnbvLcNpZOm/QqT3gJVyrExc0084si3xKF7Hg88wh7AZb2IjFGqYg4iDkJ34m
1nf7Cl/3OPhkba1l36/lytzSaW3ackXMTFOKxrx5PX/v3Df45+ik6AKUW7Qn5yOs
QcYDsuLHWXrenapYDauzbLygp2CSZi4K4WN3mqhL9rc9/yqRWIyq09H0MuhnGr0c
vbyeu8rGOLymMyY0cgfLAULEiBarDP+r1ighGD6M21Gm+uX7fD+mNabzuBJKyYIR
RTmP4GQ+gcfT2Nd06fwbXIVJNz7LdmpCvXtLI3WlI+hSrM/AJq3lG1iP/RW2/Qr1
JA0Qx56DN+zjlJ6CA16KJ5CYCG3KDjdxOm7yzAV2aFACwHKdJ2f+Kdjvj2SKk34M
aE8wxmOHSq4cBlSIBrgf
=kdjL
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
