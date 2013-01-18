From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: OMAP: devices: create device for usb part of
 control module
Date: Fri, 18 Jan 2013 14:00:22 +0200
Message-ID: <20130118120022.GB4672@arwen.pp.htv.fi>
References: <1358502045-27008-1-git-send-email-kishon@ti.com>
 <1358502045-27008-3-git-send-email-kishon@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1358502045-27008-3-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2013 at 03:10:43PM +0530, Kishon Vijay Abraham I wrote:
> A seperate driver has been added to handle the usb part of control
> module. A device for the above driver is created here, using the register
> address information to be used by the driver for powering on the PHY and
> for writing to the mailbox.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/devices.c |   48 +++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 5e304d0..a58b0ce 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -20,6 +20,7 @@
>  #include <linux/pinctrl/machine.h>
>  #include <linux/platform_data/omap4-keypad.h>
>  #include <linux/platform_data/omap_ocp2scp.h>
> +#include <linux/usb/omap_control_usb.h>
> =20
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
> @@ -254,6 +255,52 @@ static inline void omap_init_camera(void)
>  #endif
>  }
> =20
> +#if IS_ENABLED(CONFIG_OMAP_CONTROL_USB)
> +static struct omap_control_usb_platform_data omap4_control_usb_pdata =3D=
 {
> +	.has_mailbox =3D true,
> +};
> +
> +struct resource omap4_control_usb_res[] =3D {
> +	{
> +		.name	=3D "control_dev_conf",
> +		.start	=3D 0x4a002300,
> +		.end	=3D 0x4a002303,
> +		.flags	=3D IORESOURCE_MEM,
> +	},
> +	{
> +		.name	=3D "otghs_control",
> +		.start	=3D 0x4a00233c,
> +		.end	=3D 0x4a00233f,
> +		.flags	=3D IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct platform_device omap4_control_usb =3D {
> +	.name		=3D "omap-control-usb",
> +	.id		=3D -1,
> +	.dev =3D {
> +		.platform_data =3D &omap4_control_usb_pdata,
> +	},
> +	.num_resources =3D 2,
> +	.resource =3D omap4_control_usb_res,
> +};
> +
> +static inline void __init omap_init_control_usb(void)
> +{
> +	int ret =3D 0;
> +
> +	if (cpu_is_omap44xx()) {
> +		ret =3D platform_device_register(&omap4_control_usb);
> +		if (ret)
> +			pr_err("Error registering omap_control_usb device:%d\n",
> +			    ret);
> +	}

you can decrease indentation if you invert the check:

if (!cpu_is_omap44xx())
	return;

if (platform_device_register(.....)
--=20
balbi

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ+TlWAAoJEIaOsuA1yqREoQYP/0QuKhdniuUaJBERlGQJHaZa
J+bjdqHrLhXMCOz/3eD7o3A4WKQtAYGQSoS1UYCG+Scy4gH+Dobe9mWGM0z2Lhgt
Wo3VSq+ZIBPjYCXQjWcSuxRQy5KVvopiZPgoJ07bcwZijVECOxIVx0nMWk6fdgYm
QVTIA6XkLMuTqSzJJxU9euU/rYi4tyRgwOShLrJIuuaiUWykaarS1dGe67tFnj82
C1jwuMkxGlFQ/2UI4Flwq8nXTKRkoS/8+i6vK5sZICWr1cS3H5UPvokxenusQm4Z
K2zCkMvOF7CK7z5iU91151kLsjJ79s6cy5THGmjR7DyHdjA//cL2ed6lams/x6zt
osxJJRh1CSZtqEIgVdNu5xiDby51Pmqv1eFi+yYM30jiwiy5jum9cSSKBhvouhAq
yPVewbQ6HsAellkX8XQUC9jR3lh+/NeDqAjL6ORI2sB3zA1d8/Blr5PI6pzU25f2
pkMSMtRUUNrHfNz7eaEs+zXfQJ4InM5JwBqAQxvMhEb6GM5JxezdixLPNISxVe/2
w467ppIlPMK+EJyBuZLEH+rEHbAplj998H1/p3bFj6KrAp+oAorZpXNqmN2ApJwU
d0zxFP/HeRvMi+ms0WxJBb07/CclVyKHVeqsBonwIVRjizgAGmNHZ3wrR6J3S5zh
XJ+xDBkby/zu5SuVsgay
=5jIL
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
