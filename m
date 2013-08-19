From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv9 1/2] drivers: spi: Add qspi flash controller
Date: Mon, 19 Aug 2013 21:46:28 +0530
Message-ID: <521244DC.9080600@ti.com>
References: <1375606690-834-1-git-send-email-sourav.poddar@ti.com>
	<1375606690-834-2-git-send-email-sourav.poddar@ti.com>
	<20130813152624.GG27954@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130813152624.GG27954@radagast>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Hi Felipe,

> Hi,
>
> On Sun, Aug 04, 2013 at 02:28:09PM +0530, Sourav Poddar wrote:
>> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
>> new file mode 100644
>> index 0000000..4328ae2
>> --- /dev/null
>> +++ b/drivers/spi/spi-ti-qspi.c
>> @@ -0,0 +1,591 @@
>> +/*
>> + * TI QSPI driver
>> + *
>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
>> + * Author: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GPLv2.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include<linux/kernel.h>
>> +#include<linux/init.h>
>> +#include<linux/interrupt.h>
>> +#include<linux/module.h>
>> +#include<linux/device.h>
>> +#include<linux/delay.h>
>> +#include<linux/dma-mapping.h>
>> +#include<linux/dmaengine.h>
>> +#include<linux/omap-dma.h>
>> +#include<linux/platform_device.h>
>> +#include<linux/err.h>
>> +#include<linux/clk.h>
>> +#include<linux/io.h>
>> +#include<linux/slab.h>
>> +#include<linux/pm_runtime.h>
>> +#include<linux/of.h>
>> +#include<linux/of_device.h>
>> +#include<linux/pinctrl/consumer.h>
>> +
>> +#include<linux/spi/spi.h>
>> +
>> +struct ti_qspi_regs {
>> +	u32 clkctrl;
>> +};
>> +
>> +struct ti_qspi {
>> +	struct completion       transfer_complete;
>> +
>> +	/* IRQ synchronization */
>> +	spinlock_t              lock;
>> +
>> +	/* list synchronization */
>> +	struct mutex            list_lock;
>> +
>> +	struct spi_master	*master;
>> +	void __iomem            *base;
>> +	struct clk		*fclk;
>> +	struct device           *dev;
>> +
>> +	struct ti_qspi_regs     ctx_reg;
>> +
>> +	u32 spi_max_frequency;
>> +	u32 cmd;
>> +	u32 dc;
>> +	u32 stat;
>> +};
>> +
>> +#define QSPI_PID			(0x0)
>> +#define QSPI_SYSCONFIG			(0x10)
>> +#define QSPI_INTR_STATUS_RAW_SET	(0x20)
>> +#define QSPI_INTR_STATUS_ENABLED_CLEAR	(0x24)
>> +#define QSPI_INTR_ENABLE_SET_REG	(0x28)
>> +#define QSPI_INTR_ENABLE_CLEAR_REG	(0x2c)
>> +#define QSPI_SPI_CLOCK_CNTRL_REG	(0x40)
>> +#define QSPI_SPI_DC_REG			(0x44)
>> +#define QSPI_SPI_CMD_REG		(0x48)
>> +#define QSPI_SPI_STATUS_REG		(0x4c)
>> +#define QSPI_SPI_DATA_REG		(0x50)
>> +#define QSPI_SPI_SETUP0_REG		(0x54)
>> +#define QSPI_SPI_SWITCH_REG		(0x64)
>> +#define QSPI_SPI_SETUP1_REG		(0x58)
>> +#define QSPI_SPI_SETUP2_REG		(0x5c)
>> +#define QSPI_SPI_SETUP3_REG		(0x60)
>> +#define QSPI_SPI_DATA_REG_1		(0x68)
>> +#define QSPI_SPI_DATA_REG_2		(0x6c)
>> +#define QSPI_SPI_DATA_REG_3		(0x70)
>> +
>> +#define QSPI_COMPLETION_TIMEOUT		msecs_to_jiffies(2000)
>> +
>> +#define QSPI_FCLK			192000000
>> +
>> +/* Clock Control */
>> +#define QSPI_CLK_EN			(1<<  31)
>> +#define QSPI_CLK_DIV_MAX		0xffff
>> +
>> +/* Command */
>> +#define QSPI_EN_CS(n)			(n<<  28)
>> +#define QSPI_WLEN(n)			((n-1)<<  19)
> spaces around '-'
>
>> +#define QSPI_3_PIN			(1<<  18)
>> +#define QSPI_RD_SNGL			(1<<  16)
>> +#define QSPI_WR_SNGL			(2<<  16)
>> +#define QSPI_RD_DUAL			(3<<  16)
>> +#define QSPI_RD_QUAD			(7<<  16)
>> +#define QSPI_INVAL			(4<<  16)
>> +#define QSPI_WC_CMD_INT_EN			(1<<  14)
>> +#define QSPI_FLEN(n)			((n-1)<<  0)
> spaces around '-'
>
Ok.
>> +/* STATUS REGISTER */
>> +#define WC				0x02
>> +
>> +/* INTERRUPT REGISTER */
>> +#define QSPI_WC_INT_EN				(1<<  1)
>> +#define QSPI_WC_INT_DISABLE			(1<<  1)
>> +
>> +/* Device Control */
>> +#define QSPI_DD(m, n)			(m<<  (3 + n * 8))
>> +#define QSPI_CKPHA(n)			(1<<  (2 + n * 8))
>> +#define QSPI_CSPOL(n)			(1<<  (1 + n * 8))
>> +#define QSPI_CKPOL(n)			(1<<  (n*8))
> spaces around '*'
>
Ok.
>> +#define	QSPI_FRAME			4096
>> +
>> +#define QSPI_AUTOSUSPEND_TIMEOUT         2000
>> +
>> +static inline unsigned long ti_qspi_read(struct ti_qspi *qspi,
>> +		unsigned long reg)
>> +{
>> +	return readl(qspi->base + reg);
>> +}
>> +
>> +static inline void ti_qspi_write(struct ti_qspi *qspi,
>> +		unsigned long val, unsigned long reg)
>> +{
>> +	writel(val, qspi->base + reg);
>> +}
>> +
>> +static int ti_qspi_setup(struct spi_device *spi)
>> +{
>> +	struct ti_qspi	*qspi = spi_master_get_devdata(spi->master);
>> +	struct ti_qspi_regs *ctx_reg =&qspi->ctx_reg;
>> +	int clk_div = 0, ret;
>> +	u32 clk_ctrl_reg, clk_rate, clk_mask;
>> +
>> +	if (spi->master->busy) {
>> +		dev_dbg(qspi->dev, "master busy doing other trasnfers\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	if (!qspi->spi_max_frequency) {
>> +		dev_err(qspi->dev, "spi max frequency not defined\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	clk_rate = clk_get_rate(qspi->fclk);
>> +
>> +	clk_div = DIV_ROUND_UP(clk_rate, qspi->spi_max_frequency) - 1;
>> +
>> +	if (clk_div<  0) {
>> +		dev_dbg(qspi->dev, "%s: clock divider<  0, using /1 divider\n",
>> +			__func__);
> do you really need to print the function name ?
>
Actually, no, was just useful for initial debug purpose.
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (clk_div>  QSPI_CLK_DIV_MAX) {
>> +		dev_dbg(qspi->dev, "%s: clock divider>%d , using /%d divider\n",
>> +			__func__, QSPI_CLK_DIV_MAX, QSPI_CLK_DIV_MAX + 1);
> do you really need to print the function name ?
>
Same as above.
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(qspi->dev, "%s: hz: %d, clock divider %d\n", __func__,
> do you really need to print the function name ?
>
no.
>> +			qspi->spi_max_frequency, clk_div);
>> +
>> +	ret = pm_runtime_get_sync(qspi->dev);
>> +	if (ret) {
>> +		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
>> +		return ret;
>> +	}
>> +
>> +	clk_ctrl_reg = ti_qspi_read(qspi, QSPI_SPI_CLOCK_CNTRL_REG);
>> +
>> +	clk_ctrl_reg&= ~QSPI_CLK_EN;
>> +
>> +	/* disable SCLK */
>> +	ti_qspi_write(qspi, clk_ctrl_reg, QSPI_SPI_CLOCK_CNTRL_REG);
>> +
>> +	/* enable SCLK */
>> +	clk_mask = QSPI_CLK_EN | clk_div;
>> +	ti_qspi_write(qspi, clk_mask, QSPI_SPI_CLOCK_CNTRL_REG);
>> +	ctx_reg->clkctrl = clk_mask;
>> +
>> +	pm_runtime_mark_last_busy(qspi->dev);
>> +	ret = pm_runtime_put_autosuspend(qspi->dev);
>> +	if (ret<  0) {
>> +		dev_err(qspi->dev, "pm_runtime_put_autosuspend() failed\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
>> +{
>> +	struct ti_qspi_regs *ctx_reg =&qspi->ctx_reg;
>> +
>> +	ti_qspi_write(qspi, ctx_reg->clkctrl, QSPI_SPI_CLOCK_CNTRL_REG);
>> +}
>> +
>> +static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
>> +{
>> +	int wlen, count, ret;
>> +
>> +	count = t->len;
>> +	wlen = t->bits_per_word;
>> +
>> +	if (wlen == 8) {
>> +		const u8 *txbuf;
>> +		txbuf = t->tx_buf;
>> +		do {
>> +			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %02x\n",
>> +				qspi->cmd | QSPI_WR_SNGL, qspi->dc, *txbuf);
> create a local 'cmd' variable so  you don't have to repeat:
>
> 	qspi->cmd | QSPI_WR_SNGL
>
> all the time
>
Ok.
>> +			writeb(*txbuf++, qspi->base + QSPI_SPI_DATA_REG);
>> +			ti_qspi_write(qspi, qspi->cmd | QSPI_WR_SNGL,
>> +				QSPI_SPI_CMD_REG);
>> +			ret = wait_for_completion_timeout(&qspi->transfer_complete,
>> +				QSPI_COMPLETION_TIMEOUT);
>> +			if (ret == 0) {
>> +				dev_err(qspi->dev, "write timed out\n");
>> +				return -ETIMEDOUT;
>> +			}
>> +			count -= 1;
>> +		} while (count);
>> +	} else if (wlen == 16) {
>> +		const u16 *txbuf;
>> +		txbuf = t->tx_buf;
>> +		do {
>> +			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %04x\n",
>> +				qspi->cmd | QSPI_WR_SNGL, qspi->dc, *txbuf);
>> +			writew(*txbuf++, qspi->base + QSPI_SPI_DATA_REG);
>> +			ti_qspi_write(qspi, qspi->cmd | QSPI_WR_SNGL,
>> +				QSPI_SPI_CMD_REG);
>> +			ret = wait_for_completion_timeout(&qspi->transfer_complete,
>> +				QSPI_COMPLETION_TIMEOUT);
>> +			if (ret == 0) {
>> +				dev_err(qspi->dev, "write timed out\n");
>> +				return -ETIMEDOUT;
>> +			}
>> +			count -= 2;
>> +		} while (count>= 2);
> while (count) is enough here too.
>
Ok.
>> +	} else if (wlen == 32) {
> if else if else if else if .... this looks like a switch to me. I know
> someone else commented that switch wasn't the best construct, but to my
> eyes, switch looks a lot cleaner.
>
My previous switch implementation was implemented as a seperate
function, as a result of which there was the need to pass pointers, other
variables, then collect it as a double pointer, making things a bit untidy.

What I can do is to convert these portion into switch here itself, which 
will
make the code a lot more cleaner. ?
>> +		const u32 *txbuf;
>> +		txbuf = t->tx_buf;
>> +		do {
>> +			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %08x\n",
>> +				qspi->cmd | QSPI_WR_SNGL, qspi->dc, *txbuf);
>> +			writel(*txbuf++, qspi->base + QSPI_SPI_DATA_REG);
>> +			ti_qspi_write(qspi, qspi->cmd | QSPI_WR_SNGL,
>> +				QSPI_SPI_CMD_REG);
>> +			ret = wait_for_completion_timeout(&qspi->transfer_complete,
>> +				QSPI_COMPLETION_TIMEOUT);
>> +			if (ret == 0) {
>> +				dev_err(qspi->dev, "write timed out\n");
>> +				return -ETIMEDOUT;
>> +			}
>> +			count -= 4;
>> +		} while (count>= 4);
> and here.
>
> these coments apply to qspi_read_msg() too
>
>> +static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *t)
>> +{
>> +	int ret;
>> +
>> +	if (t->tx_buf) {
>> +		ret = qspi_write_msg(qspi, t);
>> +		if (ret) {
>> +			dev_dbg(qspi->dev, "Error while writing\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (t->rx_buf) {
>> +		ret = qspi_read_msg(qspi, t);
>> +		if (ret) {
>> +			dev_dbg(qspi->dev, "Error while writing\n");
> error while "READING" ??
>
My bad. Will chnage this.


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
