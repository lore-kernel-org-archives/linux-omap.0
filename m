From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 3/4] USB: OMAP: move omap-otg out from isp1301_omap
Date: Thu, 7 Mar 2013 16:51:59 +0200
Message-ID: <20130307145158.GE16577@arwen.pp.htv.fi>
References: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
 <1362667221-30659-4-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1362667221-30659-4-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2013 at 04:40:20PM +0200, Aaro Koskinen wrote:
> omap-otg platform device will be needed also by other transceivers.
> It's not possible to have multiple instances of the driver, so it needs
> to be moved into a separate file so that other drivers can hook into it.
>=20
> Start this change with a very simplest implementation, much of the
> OMAP OTG code in isp1301 is tightly coupled with isp1301 and cannot be
> trivially moved out, but still this provides a way for other drivers to
> register to OTG interrupt.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> ---
>  drivers/usb/otg/Kconfig        |    5 ++
>  drivers/usb/otg/Makefile       |    1 +
>  drivers/usb/otg/isp1301_omap.c |   78 ++-----------------------------
>  drivers/usb/otg/omap-otg.c     |   99 ++++++++++++++++++++++++++++++++++=
++++++

I'm getting rid of drivers/usb/otg/ directory, you'd have to rebase on
my -next branch as soon as I make that immutable.

>  include/linux/usb/omap-otg.h   |   30 ++++++++++++
>  5 files changed, 138 insertions(+), 75 deletions(-)
>  create mode 100644 drivers/usb/otg/omap-otg.c
>  create mode 100644 include/linux/usb/omap-otg.h
>=20
> diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
> index 37962c9..12af870 100644
> --- a/drivers/usb/otg/Kconfig
> +++ b/drivers/usb/otg/Kconfig
> @@ -27,9 +27,14 @@ config USB_GPIO_VBUS
>  	  optionally control of a D+ pullup GPIO as well as a VBUS
>  	  current limit regulator.
> =20
> +config OMAP_OTG
> +	tristate
> +	depends on ARCH_OMAP_OTG
> +
>  config ISP1301_OMAP
>  	tristate "Philips ISP1301 with OMAP OTG"
>  	depends on I2C && ARCH_OMAP_OTG
> +	select OMAP_OTG if USB_OTG

no selects anymore, please :-s

> diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
> index a844b8d..4e05c6a 100644
> --- a/drivers/usb/otg/Makefile
> +++ b/drivers/usb/otg/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_USB_OTG_UTILS)	+=3D otg.o
> =20
>  # transceiver drivers
>  obj-$(CONFIG_USB_GPIO_VBUS)	+=3D gpio_vbus.o
> +obj-$(CONFIG_OMAP_OTG)		+=3D omap-otg.o
>  obj-$(CONFIG_ISP1301_OMAP)	+=3D isp1301_omap.o
>  obj-$(CONFIG_TWL4030_USB)	+=3D twl4030-usb.o
>  obj-$(CONFIG_TWL6030_USB)	+=3D twl6030-usb.o
> diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_oma=
p.c
> index af9cb11..5217b7e 100644
> --- a/drivers/usb/otg/isp1301_omap.c
> +++ b/drivers/usb/otg/isp1301_omap.c

ideally isp1301_omap.c wouldn't even exist. isp1301 is a generic
transceiver which has nothing to do with OMAP at all. I'd much rather
see patches fixing up drivers/usb/phy/isp1301.c so that it can be reused
by anyone actually using this transceiver.

> @@ -28,6 +28,7 @@
>  #include <linux/gpio.h>
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
> +#include <linux/usb/omap-otg.h>
>  #include <linux/usb.h>
>  #include <linux/usb/otg.h>
>  #include <linux/i2c.h>
> @@ -74,22 +75,6 @@ struct isp1301 {
>  #		define WORK_STOP	7	/* don't resubmit */
>  };
> =20
> -
> -/* bits in OTG_CTRL */
> -
> -#define	OTG_XCEIV_OUTPUTS \
> -	(OTG_ASESSVLD|OTG_BSESSEND|OTG_BSESSVLD|OTG_VBUSVLD|OTG_ID)
> -#define	OTG_XCEIV_INPUTS \
> -	(OTG_PULLDOWN|OTG_PULLUP|OTG_DRV_VBUS|OTG_PD_VBUS|OTG_PU_VBUS|OTG_PU_ID)
> -#define	OTG_CTRL_BITS \
> -	(OTG_A_BUSREQ|OTG_A_SETB_HNPEN|OTG_B_BUSREQ|OTG_B_HNPEN|OTG_BUSDROP)
> -	/* and OTG_PULLUP is sometimes written */
> -
> -#define	OTG_CTRL_MASK	(OTG_DRIVER_SEL| \
> -	OTG_XCEIV_OUTPUTS|OTG_XCEIV_INPUTS| \
> -	OTG_CTRL_BITS)
> -
> -
>  /*----------------------------------------------------------------------=
---*/
> =20
>  /* board-specific PM hooks */
> @@ -822,15 +807,10 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
>  	return ret;
>  }
> =20
> -static struct platform_device *otg_dev;
> -
>  static int isp1301_otg_init(struct isp1301 *isp)
>  {
>  	u32 l;
> =20
> -	if (!otg_dev)
> -		return -ENODEV;
> -
>  	dump_regs(isp, __func__);
>  	/* some of these values are board-specific... */
>  	l =3D omap_readl(OTG_SYSCON_2);
> @@ -864,58 +844,6 @@ static int isp1301_otg_init(struct isp1301 *isp)
>  	return 0;
>  }
> =20
> -static int otg_probe(struct platform_device *dev)
> -{
> -	// struct omap_usb_config *config =3D dev->platform_data;
> -
> -	otg_dev =3D dev;
> -	return 0;
> -}

why is this otg_dev even needed ? Can you refresh my memory ?

--=20
balbi

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROKmOAAoJEIaOsuA1yqREJUsP/2OLzrbkfyGBp/hxqV4xLhpv
kEAXAVK4D1IyMrSPCW9KWMRmklj4x72fEpcUfexGFAiKg/c2QdSlOwvMgVRouAKj
qU4rtIat+Rok/zK2m6xpElA6m6N+cH8U9h7g4KMJejlYfYMjY9FSGXdvtIbt3LBm
QDdJr1uyk1aaJKqexd90qi33sBkXz4j5l5+1NVzoBlU7K6Vkh/EwS3eu7gpHlEDo
Y34sHeZcuNyLSESGD1Zvkme4/mJBUaEkePJpr4cply0vewwLk8eW9lakKK6JoFn4
rmh/0Z3RJbaC5fk4Upkzu8pSM86UI0jZeWuVSaU5l7qWnd4uHe7LJIBtFoarpy5r
JOWKLEctFe/Ts1Sos89QD4gHUbR7auwHLUXjcIOSKgOVnJtxcjBZhYg14q74bJka
yOg8ABg/D8x9w3nCi3uBKm/1PT96PvSgCDJX8KluEQ5KD8D+M/TkTNitE6ldkbND
MOKB1IGN3mWBttsejqLue4dv8L7OenpunqJXuKCjPUmOYVEWZgkYfIPL05pL+6VS
cCwQXoQ+XBjNnbu61268uSQQc3SodJ7qUQhgv9+CbIR3DNYXCPyDweRZJHWfjKB2
1hfUUlRd7QhlKaA66g0fqPmHq+o2JBKHhiSB3q7xhhx+4o6OO4jmokqhZq7vAOaS
0RC1VHIxFT3Ghx9Ijo1o
=w3LQ
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
