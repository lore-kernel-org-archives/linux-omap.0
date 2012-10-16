From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2: UART: fix console UART mismatched runtime PM
 status
Date: Tue, 16 Oct 2012 13:25:17 +0300
Message-ID: <20121016102517.GD21801@arwen.pp.htv.fi>
References: <1350344998-16328-1-git-send-email-khilman@deeprootsystems.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44067 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789Ab2JPKa6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Oct 2012 06:30:58 -0400
Content-Disposition: inline
In-Reply-To: <1350344998-16328-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>

--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 15, 2012 at 04:49:58PM -0700, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
>=20
> The runtime PM framework assumes that the hardware state of devices
> when initialized is disabled.  For all omap_devices, we idle/disable
> device by default.  However, the console uart uses a "no idle" option
> during omap_device init in order to allow earlyprintk usage to work
> seamlessly during boot.
>=20
> Because the hardware is left partially enabled after init (whatever
> the bootloader settings were), the omap_device should later be fully
> initialized (including mux) and the runtime PM framework should be
> told that the device is active, and not disabled so that the hardware
> state is in sync with runtime PM state.
>=20
> To fix, after the device has been created/registered, call
> omap_device_enable() to finialize init and use pm_runtime_set_active()
> to tell the runtime PM core the device is enabled.
>=20
> Tested on 2420/n810, 3530/Overo, 3530/Beagle, 3730/OveroSTORM,
> 3730/Beagle-xM, 4460/PandaES.
>=20
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Applies against v3.7-rc1.
> Fix targetted for v3.7.
>=20
> I'm still not entirely sure why this has worked up to now on OMAP3/4
> but not on OMAP2.  Even so, this fix is needed for all platforms to
> ensure matching hardware state and runtime PM state.
>=20
>  arch/arm/mach-omap2/serial.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 0405c81..37b5dbe 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -327,6 +327,11 @@ void __init omap_serial_init_port(struct omap_board_=
data *bdata,
>  	if ((console_uart_id =3D=3D bdata->id) && no_console_suspend)
>  		omap_device_disable_idle_on_suspend(pdev);
> =20
> +	if (console_uart_id =3D=3D bdata->id) {
> +		omap_device_enable(pdev);
> +		pm_runtime_set_active(&pdev->dev);
> +	}
> +
>  	oh->mux =3D omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
> =20
>  	oh->dev_attr =3D uart;

looks good to me. Even took care of doing that only for the console
UART.

Reviewed-by: Felipe Balbi <balbi@ti.com>

sorry for the issues caused.

--=20
balbi

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfTYNAAoJEIaOsuA1yqREorcP/15ebEEQ/BLvH14luy7OfsP7
s80H13RODbxM6K6NrqdenNfLDTbexIutaPAUBSozzwOl6sEbUi3phG4NAq7wUfkM
gLqM0SK3aiOUezm2CKARhHh8GOr4Dfdc4wXu0B+we9kCwEP5KvqojI/R5MlmNyAj
DG70DeSnanlyVZqhPjbPWO2Vlq3Pcb0F6vaIcAvA5RNkHpUYuluka94PEYX+1OnQ
UWRmCeUZbgLk5hvz+PXgxw2Pp50L3yzK3pAQKdKfxlFTa6+lf2OXWTNTQKsgD6vm
8hvR/VU6NQOtAFWkpWcCxStrpY9+06TgtCTox/2WczSxrGChtveobFIjzSTCRQvT
fAPDwibss4FbKZPxsMw/n2IQOj2jnN41beD9YbJerqCr6u4NH4i7NwpFFc98CBVF
oibq7XRlFVKzqCOTDZ1FzJMVVg3jQS2REZ6Dx+dTlYafJMyFfpsXDTAtW51YnEj1
/deaRFSh6xO7A1yvk1vrerIXZGvJ8+NNmvCqOQFg9RIL/2TIz/aPOCx+062b+CbP
fH2tFq90MEyQwL19Wv1xLrAlCXnB4aCwuDD0mOqOfByQ8CPAWdfgKidVVtOFSR6A
FTN0+Ahjg970S3LWBWtRXc94Szm/+KxYfhkGiN1xj7t9jkwHCqLw4vMJWZsyAbvp
hGDKgpHjwoDyfQteuyfk
=h24v
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
