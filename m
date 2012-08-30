From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 2/5] mfd: introduce retu-mfd driver
Date: Thu, 30 Aug 2012 18:36:54 +0300
Message-ID: <20120830153653.GG1754@arwen.pp.htv.fi>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
 <1346189667-32330-3-git-send-email-aaro.koskinen@iki.fi>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QWpDgw58+k1mSFBj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:47501 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752501Ab2H3PlP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 11:41:15 -0400
Received: by lagy9 with SMTP id y9so1644044lag.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Aug 2012 08:41:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346189667-32330-3-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com


--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2012 at 12:34:24AM +0300, Aaro Koskinen wrote:
> Retu is a multi-function device found on Nokia Internet Tablets
> implementing at least watchdog, RTC, headset detection and power button
> functionality.
>=20
> This patch implements a minimum functionality providing only register
> access functions.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: sameo@linux.intel.com
> ---
>  drivers/mfd/Kconfig      |    8 +++
>  drivers/mfd/Makefile     |    1 +
>  drivers/mfd/retu-mfd.c   |  114 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/retu.h |   20 ++++++++
>  4 files changed, 143 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/retu-mfd.c
>  create mode 100644 include/linux/mfd/retu.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b1a1462..8ca1270 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1003,6 +1003,14 @@ config MFD_PALMAS
>  	  If you say yes here you get support for the Palmas
>  	  series of PMIC chips from Texas Instruments.
> =20
> +config MFD_RETU
> +	tristate "Support for Retu multi-function device"
> +	select MFD_CORE
> +	depends on I2C
> +	help
> +	  Retu is a multi-function device found on Nokia Internet Tables
								  ^^^^^^
								  tablets



> +	  (770, N800 and N810).
> +
>  endmenu
>  endif
> =20
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 79dd22d..962ec9d 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -132,3 +132,4 @@ obj-$(CONFIG_MFD_RC5T583)	+=3D rc5t583.o rc5t583-irq.o
>  obj-$(CONFIG_MFD_SEC_CORE)	+=3D sec-core.o sec-irq.o
>  obj-$(CONFIG_MFD_ANATOP)	+=3D anatop-mfd.o
>  obj-$(CONFIG_MFD_LM3533)	+=3D lm3533-core.o lm3533-ctrlbank.o
> +obj-$(CONFIG_MFD_RETU)		+=3D retu-mfd.o
> diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
> new file mode 100644
> index 0000000..f0097d7
> --- /dev/null
> +++ b/drivers/mfd/retu-mfd.c
> @@ -0,0 +1,114 @@
> +/*
> + * Retu MFD driver
> + *
> + * Copyright (C) 2004, 2005 Nokia Corporation
> + *
> + * Based on code written by Juha Yrj=F6l=E4, David Weinehall and Mikko Y=
linen.
> + * Rewritten to MFD/I2C driver by Aaro Koskinen.
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
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/module.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/retu.h>
> +#include <linux/moduleparam.h>
> +
> +/* Registers */
> +#define RETU_REG_ASICR		0x00		/* ASIC ID and revision */
> +#define RETU_REG_ASICR_VILMA	(1 << 7)	/* Bit indicating Vilma */
> +
> +static struct mfd_cell retu_devs[] =3D {
> +	{ .name =3D "retu-wdt" },
> +};
> +
> +int retu_read(struct retu_dev *rdev, u8 reg)
> +{
> +	return i2c_smbus_read_word_data(rdev->i2c, reg);
> +}
> +EXPORT_SYMBOL_GPL(retu_read);
> +
> +int retu_write(struct retu_dev *rdev, u8 reg, u16 data)
> +{
> +	return i2c_smbus_write_word_data(rdev->i2c, reg, data);
> +}
> +EXPORT_SYMBOL_GPL(retu_write);
> +
> +static int __devinit retu_probe(struct i2c_client *i2c,
> +				const struct i2c_device_id *id)
> +{
> +	struct retu_dev *rdev;
> +	int ret;
> +
> +	rdev =3D kzalloc(sizeof(*rdev), GFP_KERNEL);
> +	if (rdev =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, rdev);
> +	rdev->dev =3D &i2c->dev;
> +	rdev->i2c =3D i2c;
> +
> +	ret =3D retu_read(rdev, RETU_REG_ASICR);
> +	if (ret < 0) {
> +		dev_err(rdev->dev, "could not read Retu revision: %d\n", ret);
> +		return -EIO;
> +	}
> +
> +	dev_info(rdev->dev, "Retu%s v%d.%d found\n",
> +		 (ret & RETU_REG_ASICR_VILMA) ? " & Vilma" : "",
> +		 (ret >> 4) & 0x7, ret & 0xf);
> +
> +	ret =3D mfd_add_devices(rdev->dev, -1, retu_devs, ARRAY_SIZE(retu_devs),
> +			      NULL, 0);
> +	if (ret < 0)
> +		goto error;
> +
> +	return ret;
> +
> +error:
> +	kfree(rdev);
> +	return ret;
> +}

looks like this misses the entire irq_chip... maybe on later patches (?)

> +static int __devexit retu_remove(struct i2c_client *i2c)
> +{
> +	struct retu_dev *rdev =3D i2c_get_clientdata(i2c);
> +
> +	mfd_remove_devices(rdev->dev);
> +	kfree(rdev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id retu_id[] =3D {
> +	{ "retu-mfd", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, retu_id);
> +
> +static struct i2c_driver retu_driver =3D {
> +	.driver		=3D {
> +		.name =3D "retu-mfd",
> +		.owner =3D THIS_MODULE,
> +	},
> +	.probe		=3D retu_probe,
> +	.remove		=3D retu_remove,
> +	.id_table	=3D retu_id,
> +};
> +module_i2c_driver(retu_driver);
> +
> +MODULE_DESCRIPTION("Retu MFD driver");
> +MODULE_AUTHOR("Aaro Koskinen <aaro.koskinen@iki.fi>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/retu.h b/include/linux/mfd/retu.h
> new file mode 100644
> index 0000000..e1b3600
> --- /dev/null
> +++ b/include/linux/mfd/retu.h
> @@ -0,0 +1,20 @@
> +/*
> + * Retu MFD driver interface
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + */
> +
> +#ifndef __LINUX_MFD_RETU_H
> +#define __LINUX_MFD_RETU_H
> +
> +struct retu_dev {
> +	struct device *dev;
> +	struct i2c_client *i2c;
> +};
> +
> +int retu_read(struct retu_dev *, u8);
> +int retu_write(struct retu_dev *, u8, u16);
> +
> +#endif /* __LINUX_MFD_RETU_H */
> --=20
> 1.7.2.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--QWpDgw58+k1mSFBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQP4iVAAoJEIaOsuA1yqRECRMP/2SngpTJLgsmoIp7pMbBIIS6
EZSh1YJq1Xr1tixRuWZJoi8dUANyr+lCjMVsrJkfBEmWYKcZgHM35bmnU+z5cINf
Iuz6jqk92uiNHq18mjSQT4z55yxLm9Mb5UrEp4DjTX5X+gMHeyxSH3tfEbc/gxbG
VIBFH4nnIj7E02KeiAJWwkWvw2Kh1wOOjX/UH5T73nGlw2wJdck1Jt3EiN4Rcf5E
DIl4Yx1WGoqoYTvdI6Gxs2xk8Brj0oBh1XCHk1t83HK+DoER1399V1z9x9DvuWqb
FITyUT7S4h58FqeAE3m0BUqyp9YrojG1AnqmNNeLzlXPQBDRyI3hEDLaNbwL/+qm
l3csvIe7IpLLdAaEHolkMUMyytm5UZM4pi7laC6eH3FN6ESoLVn9+EMBOfjPhD1Z
vv8vwpFdmGStHo72YShDWVNG8tEFr0AUYTFNS4GmPlkYEOpmDmTTmWR+ptpAVq9s
TkCOTgUSIywRzzvofa5OV+xEgK2vgk459xumdbCOEthSajlnekdzdkjtFHxXrrl8
imkFrYzR6z8TBKVXs16ixqPfGU9AhIfuXlmzvLddzuDhFy3hakp5p1TI6Ss1REcT
4NLmxyc12+zLwf3aXEleSqj26H/TAHf5KiQOtid5W7rR3WsTgz7BDpPWjufc2B/Y
L1bQfeauIlvzSvsdqC8t
=VPty
-----END PGP SIGNATURE-----

--QWpDgw58+k1mSFBj--
