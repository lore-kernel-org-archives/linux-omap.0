From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv9 1/2] drivers: spi: Add qspi flash controller
Date: Tue, 13 Aug 2013 10:26:24 -0500
Message-ID: <20130813152624.GG27954@radagast>
References: <1375606690-834-1-git-send-email-sourav.poddar@ti.com>
 <1375606690-834-2-git-send-email-sourav.poddar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AZuoSAvZwvV/ife4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47152 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754339Ab3HMP0v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Aug 2013 11:26:51 -0400
Content-Disposition: inline
In-Reply-To: <1375606690-834-2-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org

--AZuoSAvZwvV/ife4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 04, 2013 at 02:28:09PM +0530, Sourav Poddar wrote:
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> new file mode 100644
> index 0000000..4328ae2
> --- /dev/null
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -0,0 +1,591 @@
> +/*
> + * TI QSPI driver
> + *
> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
> + * Author: Sourav Poddar <sourav.poddar@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GPLv2.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/omap-dma.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
> +
> +#include <linux/spi/spi.h>
> +
> +struct ti_qspi_regs {
> +	u32 clkctrl;
> +};
> +
> +struct ti_qspi {
> +	struct completion       transfer_complete;
> +
> +	/* IRQ synchronization */
> +	spinlock_t              lock;
> +
> +	/* list synchronization */
> +	struct mutex            list_lock;
> +
> +	struct spi_master	*master;
> +	void __iomem            *base;
> +	struct clk		*fclk;
> +	struct device           *dev;
> +
> +	struct ti_qspi_regs     ctx_reg;
> +
> +	u32 spi_max_frequency;
> +	u32 cmd;
> +	u32 dc;
> +	u32 stat;
> +};
> +
> +#define QSPI_PID			(0x0)
> +#define QSPI_SYSCONFIG			(0x10)
> +#define QSPI_INTR_STATUS_RAW_SET	(0x20)
> +#define QSPI_INTR_STATUS_ENABLED_CLEAR	(0x24)
> +#define QSPI_INTR_ENABLE_SET_REG	(0x28)
> +#define QSPI_INTR_ENABLE_CLEAR_REG	(0x2c)
> +#define QSPI_SPI_CLOCK_CNTRL_REG	(0x40)
> +#define QSPI_SPI_DC_REG			(0x44)
> +#define QSPI_SPI_CMD_REG		(0x48)
> +#define QSPI_SPI_STATUS_REG		(0x4c)
> +#define QSPI_SPI_DATA_REG		(0x50)
> +#define QSPI_SPI_SETUP0_REG		(0x54)
> +#define QSPI_SPI_SWITCH_REG		(0x64)
> +#define QSPI_SPI_SETUP1_REG		(0x58)
> +#define QSPI_SPI_SETUP2_REG		(0x5c)
> +#define QSPI_SPI_SETUP3_REG		(0x60)
> +#define QSPI_SPI_DATA_REG_1		(0x68)
> +#define QSPI_SPI_DATA_REG_2		(0x6c)
> +#define QSPI_SPI_DATA_REG_3		(0x70)
> +
> +#define QSPI_COMPLETION_TIMEOUT		msecs_to_jiffies(2000)
> +
> +#define QSPI_FCLK			192000000
> +
> +/* Clock Control */
> +#define QSPI_CLK_EN			(1 << 31)
> +#define QSPI_CLK_DIV_MAX		0xffff
> +
> +/* Command */
> +#define QSPI_EN_CS(n)			(n << 28)
> +#define QSPI_WLEN(n)			((n-1) << 19)

spaces around '-'

> +#define QSPI_3_PIN			(1 << 18)
> +#define QSPI_RD_SNGL			(1 << 16)
> +#define QSPI_WR_SNGL			(2 << 16)
> +#define QSPI_RD_DUAL			(3 << 16)
> +#define QSPI_RD_QUAD			(7 << 16)
> +#define QSPI_INVAL			(4 << 16)
> +#define QSPI_WC_CMD_INT_EN			(1 << 14)
> +#define QSPI_FLEN(n)			((n-1) << 0)

spaces around '-'

> +/* STATUS REGISTER */
> +#define WC				0x02
> +
> +/* INTERRUPT REGISTER */
> +#define QSPI_WC_INT_EN				(1 << 1)
> +#define QSPI_WC_INT_DISABLE			(1 << 1)
> +
> +/* Device Control */
> +#define QSPI_DD(m, n)			(m << (3 + n * 8))
> +#define QSPI_CKPHA(n)			(1 << (2 + n * 8))
> +#define QSPI_CSPOL(n)			(1 << (1 + n * 8))
> +#define QSPI_CKPOL(n)			(1 << (n*8))

spaces around '*'

> +#define	QSPI_FRAME			4096
> +
> +#define QSPI_AUTOSUSPEND_TIMEOUT         2000
> +
> +static inline unsigned long ti_qspi_read(struct ti_qspi *qspi,
> +		unsigned long reg)
> +{
> +	return readl(qspi->base + reg);
> +}
> +
> +static inline void ti_qspi_write(struct ti_qspi *qspi,
> +		unsigned long val, unsigned long reg)
> +{
> +	writel(val, qspi->base + reg);
> +}
> +
> +static int ti_qspi_setup(struct spi_device *spi)
> +{
> +	struct ti_qspi	*qspi =3D spi_master_get_devdata(spi->master);
> +	struct ti_qspi_regs *ctx_reg =3D &qspi->ctx_reg;
> +	int clk_div =3D 0, ret;
> +	u32 clk_ctrl_reg, clk_rate, clk_mask;
> +
> +	if (spi->master->busy) {
> +		dev_dbg(qspi->dev, "master busy doing other trasnfers\n");
> +		return -EBUSY;
> +	}
> +
> +	if (!qspi->spi_max_frequency) {
> +		dev_err(qspi->dev, "spi max frequency not defined\n");
> +		return -EINVAL;
> +	}
> +
> +	clk_rate =3D clk_get_rate(qspi->fclk);
> +
> +	clk_div =3D DIV_ROUND_UP(clk_rate, qspi->spi_max_frequency) - 1;
> +
> +	if (clk_div < 0) {
> +		dev_dbg(qspi->dev, "%s: clock divider < 0, using /1 divider\n",
> +			__func__);

do you really need to print the function name ?

> +		return -EINVAL;
> +	}
> +
> +	if (clk_div > QSPI_CLK_DIV_MAX) {
> +		dev_dbg(qspi->dev, "%s: clock divider >%d , using /%d divider\n",
> +			__func__, QSPI_CLK_DIV_MAX, QSPI_CLK_DIV_MAX + 1);

do you really need to print the function name ?

> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(qspi->dev, "%s: hz: %d, clock divider %d\n", __func__,

do you really need to print the function name ?

> +			qspi->spi_max_frequency, clk_div);
> +
> +	ret =3D pm_runtime_get_sync(qspi->dev);
> +	if (ret) {
> +		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
> +		return ret;
> +	}
> +
> +	clk_ctrl_reg =3D ti_qspi_read(qspi, QSPI_SPI_CLOCK_CNTRL_REG);
> +
> +	clk_ctrl_reg &=3D ~QSPI_CLK_EN;
> +
> +	/* disable SCLK */
> +	ti_qspi_write(qspi, clk_ctrl_reg, QSPI_SPI_CLOCK_CNTRL_REG);
> +
> +	/* enable SCLK */
> +	clk_mask =3D QSPI_CLK_EN | clk_div;
> +	ti_qspi_write(qspi, clk_mask, QSPI_SPI_CLOCK_CNTRL_REG);
> +	ctx_reg->clkctrl =3D clk_mask;
> +
> +	pm_runtime_mark_last_busy(qspi->dev);
> +	ret =3D pm_runtime_put_autosuspend(qspi->dev);
> +	if (ret < 0) {
> +		dev_err(qspi->dev, "pm_runtime_put_autosuspend() failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
> +{
> +	struct ti_qspi_regs *ctx_reg =3D &qspi->ctx_reg;
> +
> +	ti_qspi_write(qspi, ctx_reg->clkctrl, QSPI_SPI_CLOCK_CNTRL_REG);
> +}
> +
> +static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
> +{
> +	int wlen, count, ret;
> +
> +	count =3D t->len;
> +	wlen =3D t->bits_per_word;
> +
> +	if (wlen =3D=3D 8) {
> +		const u8 *txbuf;
> +		txbuf =3D t->tx_buf;
> +		do {
> +			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %02x\n",
> +				qspi->cmd | QSPI_WR_SNGL, qspi->dc, *txbuf);

create a local 'cmd' variable so  you don't have to repeat:

	qspi->cmd | QSPI_WR_SNGL

all the time

> +			writeb(*txbuf++, qspi->base + QSPI_SPI_DATA_REG);
> +			ti_qspi_write(qspi, qspi->cmd | QSPI_WR_SNGL,
> +				QSPI_SPI_CMD_REG);
> +			ret =3D wait_for_completion_timeout(&qspi->transfer_complete,
> +				QSPI_COMPLETION_TIMEOUT);
> +			if (ret =3D=3D 0) {
> +				dev_err(qspi->dev, "write timed out\n");
> +				return -ETIMEDOUT;
> +			}
> +			count -=3D 1;
> +		} while (count);
> +	} else if (wlen =3D=3D 16) {
> +		const u16 *txbuf;
> +		txbuf =3D t->tx_buf;
> +		do {
> +			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %04x\n",
> +				qspi->cmd | QSPI_WR_SNGL, qspi->dc, *txbuf);
> +			writew(*txbuf++, qspi->base + QSPI_SPI_DATA_REG);
> +			ti_qspi_write(qspi, qspi->cmd | QSPI_WR_SNGL,
> +				QSPI_SPI_CMD_REG);
> +			ret =3D wait_for_completion_timeout(&qspi->transfer_complete,
> +				QSPI_COMPLETION_TIMEOUT);
> +			if (ret =3D=3D 0) {
> +				dev_err(qspi->dev, "write timed out\n");
> +				return -ETIMEDOUT;
> +			}
> +			count -=3D 2;
> +		} while (count >=3D 2);

while (count) is enough here too.

> +	} else if (wlen =3D=3D 32) {

if else if else if else if .... this looks like a switch to me. I know
someone else commented that switch wasn't the best construct, but to my
eyes, switch looks a lot cleaner.

> +		const u32 *txbuf;
> +		txbuf =3D t->tx_buf;
> +		do {
> +			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %08x\n",
> +				qspi->cmd | QSPI_WR_SNGL, qspi->dc, *txbuf);
> +			writel(*txbuf++, qspi->base + QSPI_SPI_DATA_REG);
> +			ti_qspi_write(qspi, qspi->cmd | QSPI_WR_SNGL,
> +				QSPI_SPI_CMD_REG);
> +			ret =3D wait_for_completion_timeout(&qspi->transfer_complete,
> +				QSPI_COMPLETION_TIMEOUT);
> +			if (ret =3D=3D 0) {
> +				dev_err(qspi->dev, "write timed out\n");
> +				return -ETIMEDOUT;
> +			}
> +			count -=3D 4;
> +		} while (count >=3D 4);

and here.

these coments apply to qspi_read_msg() too

> +static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *=
t)
> +{
> +	int ret;
> +
> +	if (t->tx_buf) {
> +		ret =3D qspi_write_msg(qspi, t);
> +		if (ret) {
> +			dev_dbg(qspi->dev, "Error while writing\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (t->rx_buf) {
> +		ret =3D qspi_read_msg(qspi, t);
> +		if (ret) {
> +			dev_dbg(qspi->dev, "Error while writing\n");

error while "READING" ??

--=20
balbi

--AZuoSAvZwvV/ife4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSClAgAAoJEIaOsuA1yqRE4SwP/0K5Ihbec+B9i8H5qUKvhMcL
SuEAVVSswR3rwQW8VjSXoxjfGGF4vDZhmbETFh3cQSBU/G0w1QHoIfDpxoGyh8y9
OJIUtdhdvPvQO7IweadMLb/E1pxLpwgsh4qaNrWS1oTZiJfclSRpfqkkognqZZVQ
0Mjgdnxz1hD62yUF++xm1gjzQFdj0QFnxVceU1jczHo4OtDUjtK55f4BnOchBvRA
jo8ksK0H6vCnSKPyKloPSR/yuibAZkIjxlXEzYZ+YcL9YVOr3XrSk1FEHoRdSu2Z
OQaXNzjzkuQNiojI8Z5lgsvAXSAeGGrdXK0YJs/oSFJHc2j35AyyB3LoT0AII9TI
A+7HQyNW7zhS9Qb6e90ggIsog5lpV50/nw7m+Syi61xdEdU95ERtxRMcFt9ApMlQ
WC1ODlEZD+U9YiROu6MTGLAZWRu1lxcyDZ2a04b1Ux3YbKg+KLejPrXA2U396iC7
voBj9Gbt2s6wUUVzoMSDCLagyrI4anHY7bzTHEr6tiXe3T6EtqN0ZhaP1EWSSK8H
gyDn+L0Q+glO6jMawysqL/2ODk6/Wb8cwWUNMdkd4JDJb41u99vzVUn0RhAVwMC4
rYrQiBYK6J9ipC1IJd9Vkn4MEZYOrzdM9Z5ofH01aNay+9NnciX4t+CNOdm9VKtp
z3KkcEzxlguoT4p6Z1lD
=1ZH0
-----END PGP SIGNATURE-----

--AZuoSAvZwvV/ife4--
