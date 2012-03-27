From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP: fix section mismatches in usb-host.c
Date: Tue, 27 Mar 2012 11:54:27 +0300
Message-ID: <20120327085426.GI7379@arwen.pp.htv.fi>
References: <1332773470-22800-1-git-send-email-grinberg@compulab.co.il>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="svExV93C05KqedWb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:43861 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757520Ab2C0Iy5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 04:54:57 -0400
Received: by mail-lb0-f181.google.com with SMTP id k6so4997911lbo.40
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 01:54:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1332773470-22800-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--svExV93C05KqedWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2012 at 04:51:10PM +0200, Igor Grinberg wrote:
> Fix the below section mismatch warning and alike:
>=20
> WARNING: vmlinux.o(.text+0x281d4): Section mismatch in reference from
> the function setup_ehci_io_mux() to the function
> .init.text:omap_mux_init_signal()
> The function setup_ehci_io_mux() references
> the function __init omap_mux_init_signal().
> This is often because setup_ehci_io_mux lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
>=20
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/usb-host.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-hos=
t.c
> index f51348d..dde8a11 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -54,7 +54,7 @@ static struct omap_device_pm_latency omap_uhhtll_latenc=
y[] =3D {
>  /*
>   * setup_ehci_io_mux - initialize IO pad mux for USBHOST
>   */
> -static void setup_ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
> +static void __init setup_ehci_io_mux(const enum usbhs_omap_port_mode *po=
rt_mode)
>  {
>  	switch (port_mode[0]) {
>  	case OMAP_EHCI_PORT_MODE_PHY:
> @@ -197,7 +197,8 @@ static void setup_ehci_io_mux(const enum usbhs_omap_p=
ort_mode *port_mode)
>  	return;
>  }
> =20
> -static void setup_4430ehci_io_mux(const enum usbhs_omap_port_mode *port_=
mode)
> +static
> +void __init setup_4430ehci_io_mux(const enum usbhs_omap_port_mode *port_=
mode)
>  {
>  	switch (port_mode[0]) {
>  	case OMAP_EHCI_PORT_MODE_PHY:
> @@ -315,7 +316,7 @@ static void setup_4430ehci_io_mux(const enum usbhs_om=
ap_port_mode *port_mode)
>  	}
>  }
> =20
> -static void setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
> +static void __init setup_ohci_io_mux(const enum usbhs_omap_port_mode *po=
rt_mode)
>  {
>  	switch (port_mode[0]) {
>  	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
> @@ -412,7 +413,8 @@ static void setup_ohci_io_mux(const enum usbhs_omap_p=
ort_mode *port_mode)
>  	}
>  }
> =20
> -static void setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_=
mode)
> +static
> +void __init setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_=
mode)
>  {
>  	switch (port_mode[0]) {
>  	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
> --=20
> 1.7.3.4
>=20

--=20
balbi

--svExV93C05KqedWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcYBCAAoJEIaOsuA1yqREhLAP/0od3t2TkexFexEm3dQ0DsGE
km1DHlVcxSTUzAIppeWRbirZgcwL2ji+Ygog8F/vr1RwqqiSsrmYKbva/xhOR2AI
D7gidYC0y5f/apZKelgqqOSlZ4ZdQnlM4+HDJ/f5SCo1/DwbgkwRgZvQGDGLP6F/
PexeUduS1ugHXJgZZT/cP3t010gCLK/1Wz/LCIZQZ8+48919gAtNvQRZfohyMNtH
kD/ehWRfRMhCOwvvQfodG95gq5F3LscmHRH1wxtOfJH9jj1d/I0Lt6weR9xw+B7x
uRmAZ+vwt8FcVmPTTi/KmkW2ctbx+cqCABccR4+lPEyHf4VzZXxpssKJMOm4l7uG
XapQM6BOz+hw6f+eRKVT9NZ/w6YBnEp2RcgHGy4mi6R5Ngamux8CLpMqlfgidXv9
EZcvz/Lhgu4OcZi9zxdi+reMpu4jSmpMTARl9c4PFgODvNPzaRGkoOz1yx73G8qo
Q6iZiDKGVG9O4pjE7n05qKQw/laa0CCIi6x2EYs+zzBiCmanWKGQZEGZ4LJHHrbS
lAnkO5CVT0th6HPYj0E4484vRUVApUKMzgY5ehbNiY4GTwny30eUgEN6Zvz0ftfB
LMSuraCLXscrNxhr8EJw6dvu7019FlASsiMIpjXFpIJFm9R5TgNvDPu1/IrP38k5
rnTxaOoPDXtWzJMNBeG3
=V2TL
-----END PGP SIGNATURE-----

--svExV93C05KqedWb--
