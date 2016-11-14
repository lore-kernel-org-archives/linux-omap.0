From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] usb: twl6030-usb: make driver DT only
Date: Mon, 14 Nov 2016 10:50:11 +0200
Message-ID: <87wpg6wim4.fsf@linux.intel.com>
References: <1478947663-19539-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478947663-19539-1-git-send-email-Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org> writes:
> All users are DT-only and it makes no sense to keep
> unused code
>
> Signed-off-by: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

I need an Acked-by from either Tony, Roger or Bin

> ---
>  drivers/usb/phy/Kconfig           |  1 +
>  drivers/usb/phy/phy-twl6030-usb.c | 23 ++++++-----------------
>  2 files changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> index b9c409a..61cef75 100644
> --- a/drivers/usb/phy/Kconfig
> +++ b/drivers/usb/phy/Kconfig
> @@ -84,6 +84,7 @@ config SAMSUNG_USBPHY
>  config TWL6030_USB
>  	tristate "TWL6030 USB Transceiver Driver"
>  	depends on TWL4030_CORE && OMAP_USB2 && USB_MUSB_OMAP2PLUS
> +	depends on OF
>  	help
>  	  Enable this to support the USB OTG transceiver on TWL6030
>  	  family chips. This TWL6030 transceiver has the VBUS and ID GND
> diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6=
030-usb.c
> index a72e8d6..628b600 100644
> --- a/drivers/usb/phy/phy-twl6030-usb.c
> +++ b/drivers/usb/phy/phy-twl6030-usb.c
> @@ -108,7 +108,6 @@ struct twl6030_usb {
>  	enum musb_vbus_id_status linkstat;
>  	u8			asleep;
>  	bool			vbus_enable;
> -	const char		*regulator;
>  };
>=20=20
>  #define	comparator_to_twl(x) container_of((x), struct twl6030_usb, compa=
rator)
> @@ -166,7 +165,7 @@ static int twl6030_usb_ldo_init(struct twl6030_usb *t=
wl)
>  	/* Program MISC2 register and set bit VUSB_IN_VBAT */
>  	twl6030_writeb(twl, TWL6030_MODULE_ID0, 0x10, TWL6030_MISC2);
>=20=20
> -	twl->usb3v3 =3D regulator_get(twl->dev, twl->regulator);
> +	twl->usb3v3 =3D regulator_get(twl->dev, "usb");
>  	if (IS_ERR(twl->usb3v3))
>  		return -ENODEV;
>=20=20
> @@ -341,7 +340,11 @@ static int twl6030_usb_probe(struct platform_device =
*pdev)
>  	int			status, err;
>  	struct device_node	*np =3D pdev->dev.of_node;
>  	struct device		*dev =3D &pdev->dev;
> -	struct twl4030_usb_data	*pdata =3D dev_get_platdata(dev);
> +
> +	if (!np) {
> +		dev_err(dev, "no DT info\n");
> +		return -EINVAL;
> +	}
>=20=20
>  	twl =3D devm_kzalloc(dev, sizeof(*twl), GFP_KERNEL);
>  	if (!twl)
> @@ -361,18 +364,6 @@ static int twl6030_usb_probe(struct platform_device =
*pdev)
>  		return -EPROBE_DEFER;
>  	}
>=20=20
> -	if (np) {
> -		twl->regulator =3D "usb";
> -	} else if (pdata) {
> -		if (pdata->features & TWL6032_SUBCLASS)
> -			twl->regulator =3D "ldousb";
> -		else
> -			twl->regulator =3D "vusb";
> -	} else {
> -		dev_err(&pdev->dev, "twl6030 initialized without pdata\n");
> -		return -EINVAL;
> -	}
> -
>  	/* init spinlock for workqueue */
>  	spin_lock_init(&twl->lock);
>=20=20
> @@ -436,13 +427,11 @@ static int twl6030_usb_remove(struct platform_devic=
e *pdev)
>  	return 0;
>  }
>=20=20
> -#ifdef CONFIG_OF
>  static const struct of_device_id twl6030_usb_id_table[] =3D {
>  	{ .compatible =3D "ti,twl6030-usb" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, twl6030_usb_id_table);
> -#endif
>=20=20
>  static struct platform_driver twl6030_usb_driver =3D {
>  	.probe		=3D twl6030_usb_probe,
> --=20
> 2.5.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlgpesMACgkQzL64meEa
mQZGiRAAgpg/G3Dm2VDrwSNXMntMdne3u8csPGd3szMTN3saq3SlqxUsEP26YCZM
RBxdpLEv+mRYMltpyxyrJv7Wzdfhrf/H2Ikt7rrVfOT/UxGcNqdkYg2CGvMfKVBH
9MAKZzMUB6HU3TkxFVBLkYQrDytd3HoedUrfXcAUu8kApWETDcMyAa8nER1uQypK
UE5hHMHy7xQMmN/7jzIrv0ZGOWU/15YNx7HxngQ4WxmJyVht5q8GA36VOKdt/MNa
tFNmy0aEx9TXTb0Y9TzN21zDP6YmuFRa97zXgqa1ZvMmh5HlchqbYs3gPMJHFutn
yqMQjFS5BnQxs51SfUSqhPRPj9PMld3E/cSsDxIGy/AACsZsOwWPIJX18VhroFeA
wbHE1GbsFIBVgSw/ZJchwt3fq0GlLnpMLcBGTp1IefOAcwYb/5JJX3dNdgH37Owu
/tyWuitpwSpqtyZvRYrefD2By7O5jzR2SKSv38sawa4WBmQmX1g8THc7Ps2hCrIp
qQsi5HeGZQItwUZPzNARrGHIbDwIU3COkzWoRkr/FXZZInC3DDHuf3rvm/IX1oWF
ODhYpI/p8w8yTCrzj2d44HBBaWqBgJo087CojG5xzci3eoi+qPM6mJMBWzbmhL6B
djEuo8YJvl7H5PWnguUxgU8hu1x6xeFizB2w5pYsYwjBkDd129k=
=kxf7
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
