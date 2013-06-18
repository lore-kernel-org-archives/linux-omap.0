From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/5] USB: OMAP1: OTG controller driver
Date: Tue, 18 Jun 2013 11:21:43 +0300
Message-ID: <20130618082143.GE5461@arwen.pp.htv.fi>
References: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
 <1371389712-29516-4-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52574 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183Ab3FRIXi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jun 2013 04:23:38 -0400
Content-Disposition: inline
In-Reply-To: <1371389712-29516-4-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2013 at 04:35:10PM +0300, Aaro Koskinen wrote:
> Transceivers need to manage OTG controller state on OMAP1 to enable
> switching between peripheral and host modes. Provide a driver for that.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/usb/phy/Kconfig        |  10 +++
>  drivers/usb/phy/Makefile       |   1 +
>  drivers/usb/phy/phy-omap-otg.c | 171 +++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 182 insertions(+)
>  create mode 100644 drivers/usb/phy/phy-omap-otg.c
>=20
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index 7ef3eb8..14a50bd 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -135,6 +135,16 @@ config USB_GPIO_VBUS
>  	  optionally control of a D+ pullup GPIO as well as a VBUS
>  	  current limit regulator.
> =20
> +config OMAP_OTG
> +	tristate "OMAP USB OTG controller driver"
> +	depends on ARCH_OMAP_OTG && EXTCON
> +	help
> +	  Enable this to support some transceivers on OMAP1 platforms. OTG
> +	  controller is needed to switch between host and peripheral modes.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called omap-otg.
> +
>  config USB_ISP1301
>  	tristate "NXP ISP1301 USB transceiver support"
>  	depends on USB || USB_GADGET
> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
> index a9169cb..c7f391b 100644
> --- a/drivers/usb/phy/Makefile
> +++ b/drivers/usb/phy/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ISP1301_OMAP)		+=3D phy-isp1301-omap.o
>  obj-$(CONFIG_MV_U3D_PHY)		+=3D phy-mv-u3d-usb.o
>  obj-$(CONFIG_NOP_USB_XCEIV)		+=3D phy-nop.o
>  obj-$(CONFIG_OMAP_CONTROL_USB)		+=3D phy-omap-control.o
> +obj-$(CONFIG_OMAP_OTG)			+=3D phy-omap-otg.o
>  obj-$(CONFIG_OMAP_USB2)			+=3D phy-omap-usb2.o
>  obj-$(CONFIG_OMAP_USB3)			+=3D phy-omap-usb3.o
>  obj-$(CONFIG_SAMSUNG_USBPHY)		+=3D phy-samsung-usb.o
> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-ot=
g.c
> new file mode 100644
> index 0000000..2a8c674
> --- /dev/null
> +++ b/drivers/usb/phy/phy-omap-otg.c
> @@ -0,0 +1,171 @@
> +/*
> + * OMAP OTG controller driver
> + *
> + * Based on code from tahvo-usb.c and isp1301_omap.c drivers.
> + *
> + * Copyright (C) 2005-2006 Nokia Corporation
> + * Copyright (C) 2004 Texas Instruments
> + * Copyright (C) 2004 David Brownell
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/extcon.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/usb-omap1.h>
> +
> +#include <mach/usb.h>

no mach/* includes under drivers/usb, sorry. It's a pain to fix those up
later.

--=20
balbi

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwBiXAAoJEIaOsuA1yqREwNQP/08bH03JMN3h0P4MZpB5cPU0
E8mzTIcUPL7MpHpO95jB9Xh+ZXzaMG8RABFH9z4Zo1RjVtHF2WZW4NAn/HwJtBpy
Pw7vkX1AW3+YewdhEJ1BFhVOrORfTdhQC/pc2CcwFjezG0mGZenHxIyHdNeKVzuZ
RJpPKKkr8Yf40RNofeY1i9TeF+DtahHXKsxthTVSnEqJE2620ZjcN9hkzq0o7iEn
uQNLH50aVwYkrP5S844ErdCG6gIebTCyw4F4syAQwqCRf2Eq5d5bR8rxQ1qrPgJr
pj+hxy6H07XZN8rixXToYG5dxTGjSk7zNvPMynzPGpn7LOWL0YDzNXqmBcCHNzFl
o04piNDvulB01re+nyx9eVAP8uAgiMfoooYRzAgPxa1Q7P/S56+NBjjN6HGPbB1I
rHfGEa3pa/VtwY9Cqz2mhrbn1DBvGGfXLL4OxJgxmGdaToO4rEu4Xm9qB9T7L8FE
9b5nkdfQncXq9dsZfZwLw4ohaHk9HuM575L/iHhli/EGrGmmRSb7OOMmXx38MMpA
G17mUBgd1GO9Ar2Xt+nP2uycMqhEgACdgGUjgNsO9BUhlPkYgYuRbKXmALBEm5Pm
Q7qkDSBtI8FJOS/3QXsfTzw3GCuqrNx9oAP87p3IxUU9Q/xVcKXgBA+ltGZQlxlp
Ra0gVz8/JnXHVZ9baVVR
=Lv8W
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
