From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP build failure after this merge window - caused by usb or
 phy Kconfig krap
Date: Mon, 25 Nov 2013 11:55:39 -0600
Message-ID: <20131125175539.GP18046@saruman.home>
References: <20131125140927.GP16735@n2100.arm.linux.org.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CVXKxAdNG2kQIXaJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48438 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007Ab3KYR4h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 12:56:37 -0500
Content-Disposition: inline
In-Reply-To: <20131125140927.GP16735@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

--CVXKxAdNG2kQIXaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2013 at 02:09:27PM +0000, Russell King - ARM Linux wrote:
> There's no other way to say it, and I've no idea who is responsible for
> this:
>=20
>   LD      init/built-in.o
> drivers/built-in.o: In function `omap_usb2_remove':
> powercap_sys.c:(.text+0x1c60): undefined reference to `usb_remove_phy'
> drivers/built-in.o: In function `omap_usb_power_off':
> powercap_sys.c:(.text+0x1c84): undefined reference to `omap_control_usb_p=
hy_power'
> drivers/built-in.o: In function `omap_usb_power_on':
> powercap_sys.c:(.text+0x1ca8): undefined reference to `omap_control_usb_p=
hy_power'
> drivers/built-in.o: In function `omap_usb2_probe':
> powercap_sys.c:(.text+0x1dac): undefined reference to `omap_control_usb_p=
hy_power'
> powercap_sys.c:(.text+0x1e5c): undefined reference to `usb_add_phy_dev'
> drivers/built-in.o: In function `omap_usb2_suspend':
> powercap_sys.c:(.text+0x1ec8): undefined reference to `omap_control_usb_p=
hy_power'
> powercap_sys.c:(.text+0x1f20): undefined reference to `omap_control_usb_p=
hy_power'
> drivers/built-in.o: In function `omap_usb2_set_comparator':
> powercap_sys.c:(.text+0x1f54): undefined reference to `usb_get_phy'
> arch/arm/mach-omap2/built-in.o: In function `usbhs_init_phys':
> dss-common.c:(.text+0xf824): undefined reference to `usb_bind_phy'
> make[1]: *** [vmlinux] Error 1
> make: *** [sub-make] Error 2

Kishon, can you send a patch fixing these ?

--=20
balbi

--CVXKxAdNG2kQIXaJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk48bAAoJEIaOsuA1yqREusMP/iaeNoCbMCxgFcuiWnbSlNtI
GLIZ+07vBdzC2Mq6bhC4aBBSCX+DCuOydm16nAvzIDbuk0KKQ7fk6VaYDc1ZPw4g
XpDLG3QDhIv1u32J7+z5CnUCss8jU0SiMvvtGckLFEGj+zdpQr3IzqOalS/vQbdO
o8taMM1sAxLGyCvI4wGrYEBiJYYOBVy3pNj6xOEljbdhthQ3ra1/mwGWAQi79e/P
FUu0INnHJ35zpJ3fKpR2urjk6NKlmTvj1cR0DvoAEXdRu5VNsxarze+ONIbW6YTG
XWF2nDN0Pb/ocVv1ZNfHZ0EFP6HmZBPL/U868X8FhPUIE5yhamQO1TAFtTUpomuu
OP+ushhV4VUpsn2HWKGt4+2zkJNXfIT1AmYKY08gwzMRs3zyxKxEdmmf2ok79fZp
F9LJpxtUvGpIAWauKtXmEb+smaAOsoekD4yJsE1aVdOC6lzqepp2joLMdWfLmr2Y
DXZ8ZHIq/EkKuS7AXnWIevzhFOPGeSinR/LooZD/z/IFq2uKe9vVFZ8Pc/87UHrT
QVfK5pvi5ywtKi//kkPP3upTkmjKPs+YxtZQ8p0xxkJ0yO+7ogz1yRWir2Y8mRN2
rFb/XnGKcvYSDWwf0IP2Ew6g3bvitfcIw9ENH0gOwlTE4Ly28TeXbuKAkHuV7fUQ
oCyr0BMJe92VlEJJCYlS
=XwBP
-----END PGP SIGNATURE-----

--CVXKxAdNG2kQIXaJ--
