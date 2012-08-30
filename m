From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] i2c: introduce i2c-cbus driver
Date: Thu, 30 Aug 2012 18:34:46 +0300
Message-ID: <20120830153444.GF1754@arwen.pp.htv.fi>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
 <1346189667-32330-2-git-send-email-aaro.koskinen@iki.fi>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1346189667-32330-2-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2012 at 12:34:23AM +0300, Aaro Koskinen wrote:
> Add i2c driver to enable access to devices behind CBUS on Nokia Internet
> Tablets.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/i2c/busses/Kconfig    |   10 ++
>  drivers/i2c/busses/Makefile   |    1 +
>  drivers/i2c/busses/i2c-cbus.c |  342 +++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/i2c-cbus.h      |   27 ++++
>  4 files changed, 380 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-cbus.c
>  create mode 100644 include/linux/i2c-cbus.h
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index b4aaa1b..184ef43 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -331,6 +331,16 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
>  	help
>  	  The unit of the TWI clock is kHz.
> =20
> +config I2C_CBUS
> +	tristate "CBUS I2C driver"
> +	depends on GENERIC_GPIO
> +	help
> +	  Support for CBUS access using I2C API. Mostly relevant for Nokia
> +	  Internet Tablets (770, N800 and N810).
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-cbus.
> +
>  config I2C_CPM
>  	tristate "Freescale CPM1 or CPM2 (MPC8xx/826x)"
>  	depends on (CPM1 || CPM2) && OF_I2C
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index ce3c2be..44dbfd1 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_I2C_POWERMAC)	+=3D i2c-powermac.o
>  obj-$(CONFIG_I2C_AT91)		+=3D i2c-at91.o
>  obj-$(CONFIG_I2C_AU1550)	+=3D i2c-au1550.o
>  obj-$(CONFIG_I2C_BLACKFIN_TWI)	+=3D i2c-bfin-twi.o
> +obj-$(CONFIG_I2C_CBUS)		+=3D i2c-cbus.o
>  obj-$(CONFIG_I2C_CPM)		+=3D i2c-cpm.o
>  obj-$(CONFIG_I2C_DAVINCI)	+=3D i2c-davinci.o
>  obj-$(CONFIG_I2C_DESIGNWARE_PLATFORM)	+=3D i2c-designware-platform.o
> diff --git a/drivers/i2c/busses/i2c-cbus.c b/drivers/i2c/busses/i2c-cbus.c
> new file mode 100644
> index 0000000..3cc5be4
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-cbus.c
> @@ -0,0 +1,342 @@
> +/*
> + * CBUS I2C driver for Nokia Internet Tablets.
> + *
> + * Copyright (C) 2004-2010 Nokia Corporation
> + *
> + * Based on code written by Juha Yrj=F6l=E4, David Weinehall, Mikko Ylin=
en and
> + * Felipe Balbi. Converted to I2C driver by Aaro Koskinen.
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
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-cbus.h>
> +#include <linux/io.h>
> +
> +struct cbus_host {
> +	/* host lock */
> +	spinlock_t	lock;
> +
> +	struct device	*dev;
> +
> +	int		clk_gpio;
> +	int		dat_gpio;
> +	int		sel_gpio;
> +};
> +
> +/**
> + * cbus_send_bit - sends one bit over the bus
> + * @host: the host we're using
> + * @bit: one bit of information to send
> + * @input: whether to set data pin as input after sending
> + */
> +static int cbus_send_bit(struct cbus_host *host, unsigned bit,
> +		unsigned input)
> +{
> +	int ret =3D 0;
> +
> +	gpio_set_value(host->dat_gpio, bit ? 1 : 0);
> +	gpio_set_value(host->clk_gpio, 1);
> +
> +	/* The data bit is read on the rising edge of CLK */
> +	if (input)
> +		ret =3D gpio_direction_input(host->dat_gpio);
> +
> +	gpio_set_value(host->clk_gpio, 0);
> +
> +	return ret;
> +}
> +
> +/**
> + * cbus_send_data - sends @len amount of data over the bus
> + * @host: the host we're using
> + * @data: the data to send
> + * @len: size of the transfer
> + * @input: whether to set data pin as input after sending
> + */
> +static int cbus_send_data(struct cbus_host *host, unsigned data, unsigne=
d len,
> +		unsigned input)
> +{
> +	int ret =3D 0;
> +	int i;
> +
> +	for (i =3D len; i > 0; i--) {
> +		ret =3D cbus_send_bit(host, data & (1 << (i - 1)),
> +				input && (i =3D=3D 1));
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +/**
> + * cbus_receive_bit - receives one bit from the bus
> + * @host: the host we're using
> + */
> +static int cbus_receive_bit(struct cbus_host *host)
> +{
> +	int ret;
> +
> +	gpio_set_value(host->clk_gpio, 1);
> +	ret =3D gpio_get_value(host->dat_gpio);
> +	if (ret < 0)
> +		goto out;
> +	gpio_set_value(host->clk_gpio, 0);
> +
> +out:
> +	return ret;
> +}
> +
> +/**
> + * cbus_receive_word - receives 16-bit word from the bus
> + * @host: the host we're using
> + */
> +static int cbus_receive_word(struct cbus_host *host)
> +{
> +	int ret =3D 0;
> +	int i;
> +
> +	for (i =3D 16; i > 0; i--) {
> +		int bit =3D cbus_receive_bit(host);
> +
> +		if (bit < 0)
> +			goto out;
> +
> +		if (bit)
> +			ret |=3D 1 << (i - 1);
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +/**
> + * cbus_transfer - transfers data over the bus
> + * @host: the host we're using
> + * @rw: read/write flag
> + * @dev: device address
> + * @reg: register address
> + * @data: if @rw =3D=3D I2C_SBUS_WRITE data to send otherwise 0
> + */
> +static int cbus_transfer(struct cbus_host *host, char rw, unsigned dev,
> +			 unsigned reg, unsigned data)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	/* We don't want interrupts disturbing our transfer */
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	/* Reset state and start of transfer, SEL stays down during transfer */
> +	gpio_set_value(host->sel_gpio, 0);
> +
> +	/* Set the DAT pin to output */
> +	gpio_direction_output(host->dat_gpio, 1);
> +
> +	/* Send the device address */
> +	ret =3D cbus_send_data(host, dev, 3, 0);
> +	if (ret < 0) {
> +		dev_dbg(host->dev, "failed sending device addr\n");
> +		goto out;
> +	}
> +
> +	/* Send the rw flag */
> +	ret =3D cbus_send_bit(host, rw =3D=3D I2C_SMBUS_READ, 0);
> +	if (ret < 0) {
> +		dev_dbg(host->dev, "failed sending read/write flag\n");
> +		goto out;
> +	}
> +
> +	/* Send the device address */
> +	ret =3D cbus_send_data(host, reg, 5, rw =3D=3D I2C_SMBUS_READ);
> +	if (ret < 0) {
> +		dev_dbg(host->dev, "failed sending register addr\n");
> +		goto out;
> +	}
> +
> +	if (rw =3D=3D I2C_SMBUS_WRITE) {
> +		ret =3D cbus_send_data(host, data, 16, 0);
> +		if (ret < 0) {
> +			dev_dbg(host->dev, "failed sending data\n");
> +			goto out;
> +		}
> +	} else {
> +		gpio_set_value(host->clk_gpio, 1);
> +
> +		ret =3D cbus_receive_word(host);
> +		if (ret < 0) {
> +			dev_dbg(host->dev, "failed receiving data\n");
> +			goto out;
> +		}
> +	}
> +
> +	/* Indicate end of transfer, SEL goes up until next transfer */
> +	gpio_set_value(host->sel_gpio, 1);
> +	gpio_set_value(host->clk_gpio, 1);
> +	gpio_set_value(host->clk_gpio, 0);
> +
> +out:
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int cbus_i2c_smbus_xfer(struct i2c_adapter	*adapter,
> +			       u16			addr,
> +			       unsigned short		flags,
> +			       char			read_write,
> +			       u8			command,
> +			       int			size,
> +			       union i2c_smbus_data	*data)
> +{
> +	struct cbus_host *chost =3D i2c_get_adapdata(adapter);
> +	int ret;
> +
> +	if (size !=3D I2C_SMBUS_WORD_DATA)
> +		return -EINVAL;
> +
> +	ret =3D cbus_transfer(chost, read_write =3D=3D I2C_SMBUS_READ, addr,
> +			    command, data->word);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (read_write =3D=3D I2C_SMBUS_READ)
> +		data->word =3D ret;
> +
> +	return 0;
> +}
> +
> +static u32 cbus_i2c_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_SMBUS_READ_WORD_DATA | I2C_FUNC_SMBUS_WRITE_WORD_DATA;
> +}
> +
> +static const struct i2c_algorithm cbus_i2c_algo =3D {
> +	.smbus_xfer	=3D cbus_i2c_smbus_xfer,
> +	.functionality	=3D cbus_i2c_func,
> +};
> +
> +static int cbus_i2c_remove(struct platform_device *pdev)
> +{
> +	struct i2c_adapter *adapter =3D platform_get_drvdata(pdev);
> +	struct cbus_host *chost =3D i2c_get_adapdata(adapter);
> +	int ret;
> +
> +	ret =3D i2c_del_adapter(adapter);
> +	if (ret)
> +		return ret;
> +	gpio_free(chost->clk_gpio);
> +	gpio_free(chost->dat_gpio);
> +	gpio_free(chost->sel_gpio);
> +	kfree(chost);
> +	kfree(adapter);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static int cbus_i2c_probe(struct platform_device *pdev)
> +{
> +	struct i2c_cbus_platform_data *pdata =3D pdev->dev.platform_data;
> +	struct i2c_adapter *adapter;
> +	struct cbus_host *chost;
> +	struct gpio gpios[3];
> +	int ret;
> +
> +	adapter =3D kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
> +	if (!adapter) {
> +		ret =3D -ENOMEM;
> +		goto error;
> +	}
> +
> +	chost =3D kzalloc(sizeof(*chost), GFP_KERNEL);
> +	if (!chost) {
> +		ret =3D -ENOMEM;
> +		goto error_mem;
> +	}
> +
> +	adapter->owner		=3D THIS_MODULE;
> +	adapter->class		=3D I2C_CLASS_HWMON;
> +	adapter->dev.parent	=3D &pdev->dev;
> +	adapter->nr		=3D pdev->id;
> +	adapter->timeout	=3D HZ;
> +	adapter->algo		=3D &cbus_i2c_algo;
> +	strlcpy(adapter->name, "CBUS I2C adapter", sizeof(adapter->name));
> +
> +	spin_lock_init(&chost->lock);
> +	chost->dev =3D &pdev->dev;
> +
> +	gpios[0].gpio  =3D chost->clk_gpio =3D pdata->clk_gpio;
> +	gpios[0].flags =3D GPIOF_OUT_INIT_LOW;
> +	gpios[0].label =3D "CBUS clk";
> +
> +	gpios[1].gpio  =3D chost->dat_gpio =3D pdata->dat_gpio;
> +	gpios[1].flags =3D GPIOF_IN;
> +	gpios[1].label =3D "CBUS data";
> +
> +	gpios[2].gpio  =3D chost->sel_gpio =3D pdata->sel_gpio;
> +	gpios[2].flags =3D GPIOF_OUT_INIT_HIGH;
> +	gpios[2].label =3D "CBUS sel";
> +
> +	ret =3D gpio_request_array(gpios, ARRAY_SIZE(gpios));
> +	if (ret)
> +		goto error_gpio;
> +
> +	gpio_set_value(chost->clk_gpio, 1);
> +	gpio_set_value(chost->clk_gpio, 0);
> +
> +	i2c_set_adapdata(adapter, chost);
> +	platform_set_drvdata(pdev, adapter);
> +
> +	ret =3D i2c_add_numbered_adapter(adapter);
> +	if (ret)
> +		goto error_i2c;
> +
> +	return 0;
> +
> +error_i2c:
> +	gpio_free_array(gpios, ARRAY_SIZE(gpios));
> +error_gpio:
> +	kfree(chost);
> +error_mem:
> +	kfree(adapter);
> +error:
> +	return ret;
> +}
> +
> +static struct platform_driver cbus_i2c_driver =3D {
> +	.probe	=3D cbus_i2c_probe,
> +	.remove	=3D cbus_i2c_remove,
> +	.driver	=3D {
> +		.owner	=3D THIS_MODULE,
> +		.name	=3D "i2c-cbus",
> +	},
> +};
> +module_platform_driver(cbus_i2c_driver);
> +
> +MODULE_ALIAS("platform:i2c-cbus");
> +MODULE_DESCRIPTION("CBUS I2C driver");
> +MODULE_AUTHOR("Juha Yrj=F6l=E4");
> +MODULE_AUTHOR("David Weinehall");
> +MODULE_AUTHOR("Mikko Ylinen");
> +MODULE_AUTHOR("Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>");
> +MODULE_AUTHOR("Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/i2c-cbus.h b/include/linux/i2c-cbus.h
> new file mode 100644
> index 0000000..636d726
> --- /dev/null
> +++ b/include/linux/i2c-cbus.h
> @@ -0,0 +1,27 @@
> +/*
> + * i2c-cbus.h - CBUS I2C platform_data definition
> + *
> + * Copyright (C) 2004-2009 Nokia Corporation
> + *
> + * Written by Felipe Balbi and Aaro Koskinen.
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
> +#ifndef __INCLUDE_LINUX_I2C_CBUS_H
> +#define __INCLUDE_LINUX_I2C_CBUS_H
> +
> +struct i2c_cbus_platform_data {
> +	int dat_gpio;
> +	int clk_gpio;
> +	int sel_gpio;
> +};
> +
> +#endif /* __INCLUDE_LINUX_I2C_CBUS_H */
> --=20
> 1.7.2.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQP4gUAAoJEIaOsuA1yqREyPYQAKBZ1k4p511puEPypyd72K/d
YKlEg1znP0cLhVXXLYyxcg7SOj3/2pTv1pdKc7oFmGuicylfYTMl3lqYRdYzWg0u
ZWXpsU2ybnS1nWryovvjPChP7hsJV+UrOVKTUkLvOZ4CME9NXfO2WzNJRO6ABMVA
tXQPZd6WQGFNkeRHt7iFf6y4+k/HkHqaKj0aNCSJaN4ZNGJ+UNRnZbS3EBkT2Fkp
RrSDxDSX4//+oWADTpOflI66hR632NcgMycTn27Jljv9SSB738rL3jL7OJc7YNts
Ni+agkpzLRQ0k/04aJ4a9PZM/cU0VmdoOPkuDvqz4A0S72lnORSgvIyZM9bFrpzm
A0dqAYnsjg/obldl3H8R/cJWojF7avffSb81t/O8SLDKXNAdgdl153je5Laqr2df
A9sFQyccCGebFtQWa07fYzMI7uXH6UJprxQPq7o5kx8ZYcOCVe7WWjnC3v11HfJq
BzJlt3fKT7NqrCAbxLmn7h/Z7t5XhLOqer2KDcekFz0AHNifeXXY2pqpBiSwY24V
4nDgqQZH45o3VvFBETYXLkJMmFWtc7mUPm94jpHMCACI1DKH32cp10uhAa9vZq9o
jDwnr7iSQtaWrSxD+tCFiWCaTEIAX9fzZ2uxAy3FdakFcbURpO2mmqOrB5Ipx1Q1
8AgSBLtoLmvManq4Cc1X
=Rusn
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--
