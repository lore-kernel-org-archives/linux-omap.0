From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] McSPI Slave and DMA,FIFO support
Date: Tue, 2 Jun 2009 11:06:01 -0700
Message-ID: <20090602180600.GI27332@atomide.com>
References: <54322.10.24.255.18.1242799009.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55469 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446AbZFBSGC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 14:06:02 -0400
Content-Disposition: inline
In-Reply-To: <54322.10.24.255.18.1242799009.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

Sorry for the delay in replying, few comments below.

* Hemanth V <hemanthv@ti.com> [090519 22:57]:
> This patch adds support for McSPI slave and FIFO. DMA and FIFO
> could be enabled together for better throughput. Platform config
> parameters have been added to enable these features on any particular
> McSPI controller.
> 
> FIFO can be enabled by defining fifo_depth parameter. fifo_depth needs
> to be a multiple of buffer size that is used for read/write.
> 
> These features are useful when you have high throughput devices
> like WLAN or Modem connected over SPI.
> 
> Signed-off-by: Hemanth V <hemanthv@ti.com>
>  arch/arm/mach-omap2/devices.c           |    5
>  arch/arm/plat-omap/include/mach/mcspi.h |   16 +
>  drivers/spi/omap2_mcspi.c               |  343 ++++++++++++++++++++++++++++----
>  3 files changed, 325 insertions(+), 39 deletions(-)

As this is mostly drivers/spi/omap2_mcspi.c, this patch should get
merged via:

$ grep -A7 "SPI SUBSYSTEM" MAINTAINERS 
SPI SUBSYSTEM
P:      David Brownell
M:      dbrownell@users.sourceforge.net
L:      spi-devel-general@lists.sourceforge.net
S:      Maintained
F:      Documentation/spi/
F:      drivers/spi/
F:      include/linux/spi/

Please keep linux-omap list Cc'd too so everybody can follow
the progress.

> 
> ---
> Index: linux-omap-2.6/arch/arm/mach-omap2/devices.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/devices.c	2009-05-19
> 17:00:21.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/devices.c	2009-05-20 11:02:41.000000000
> +0530
> @@ -259,6 +259,7 @@
> 
>  static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
>  	.num_cs		= 4,
> +	.force_cs_mode	= 1,
>  };
> 
>  static struct resource omap2_mcspi1_resources[] = {
> @@ -281,6 +282,10 @@
> 
>  static struct omap2_mcspi_platform_config omap2_mcspi2_config = {
>  	.num_cs		= 2,
> +	.mode		= OMAP2_MCSPI_MASTER,
> +	.dma_mode	= 1,
> +	.force_cs_mode	= 0,
> +	.fifo_depth	= 0,
>  };
> 
>  static struct resource omap2_mcspi2_resources[] = {
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/mcspi.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/mcspi.h	2009-05-19
> 17:00:21.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/mcspi.h	2009-05-20
> 11:02:41.000000000 +0530
> @@ -1,8 +1,24 @@
>  #ifndef _OMAP2_MCSPI_H
>  #define _OMAP2_MCSPI_H
> 
> +#define OMAP2_MCSPI_MASTER		0
> +#define OMAP2_MCSPI_SLAVE		1
> +
>  struct omap2_mcspi_platform_config {
>  	unsigned short	num_cs;
> +
> +	/* SPI is master or slave */
> +	unsigned short	mode;
> +
> +	/* Use only DMA for data transfers */
> +	unsigned short	dma_mode;
> +
> +	/* Force chip select mode */
> +	unsigned short	force_cs_mode;
> +
> +	/* FIFO depth in bytes, max value 64 */
> +	unsigned short fifo_depth;
> +
>  };
> 
>  struct omap2_mcspi_device_config {
> Index: linux-omap-2.6/drivers/spi/omap2_mcspi.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/spi/omap2_mcspi.c	2009-05-19 17:00:21.000000000
> +0530
> +++ linux-omap-2.6/drivers/spi/omap2_mcspi.c	2009-05-20 11:02:41.000000000 +0530
> @@ -37,9 +37,11 @@
> 
>  #include <mach/dma.h>
>  #include <mach/clock.h>
> +#include <mach/mcspi.h>
> 
> 
>  #define OMAP2_MCSPI_MAX_FREQ		48000000
> +#define OMAP2_MCSPI_MAX_FIFODEPTH	64
> 
>  #define OMAP2_MCSPI_REVISION		0x00
>  #define OMAP2_MCSPI_SYSCONFIG		0x10
> @@ -49,6 +51,7 @@
>  #define OMAP2_MCSPI_WAKEUPENABLE	0x20
>  #define OMAP2_MCSPI_SYST		0x24
>  #define OMAP2_MCSPI_MODULCTRL		0x28
> +#define OMAP2_MCSPI_XFERLEVEL		0x7c
> 
>  /* per-channel banks, 0x14 bytes each, first is: */
>  #define OMAP2_MCSPI_CHCONF0		0x2c
> @@ -85,6 +88,9 @@
>  #define OMAP2_MCSPI_CHCONF_IS		BIT(18)
>  #define OMAP2_MCSPI_CHCONF_TURBO	BIT(19)
>  #define OMAP2_MCSPI_CHCONF_FORCE	BIT(20)
> +#define OMAP2_MCSPI_CHCONF_FFER 	BIT(28)
> +#define OMAP2_MCSPI_CHCONF_FFET 	BIT(27)
> +
> 
>  #define OMAP2_MCSPI_CHSTAT_RXS		BIT(0)
>  #define OMAP2_MCSPI_CHSTAT_TXS		BIT(1)
> @@ -93,6 +99,7 @@

Please swap BIT(27) to be before BIT(28) to keep them sorted above.



>  #define OMAP2_MCSPI_CHCTRL_EN		BIT(0)
> 
>  #define OMAP2_MCSPI_WAKEUPENABLE_WKEN	BIT(0)
> +#define OMAP2_MCSPI_IRQ_EOW		BIT(17)
> 
>  /* We have 2 DMA channels per CS, one for RX and one for TX */
>  struct omap2_mcspi_dma {
> @@ -125,6 +132,10 @@
>  	unsigned long		phys;
>  	/* SPI1 has 4 channels, while SPI2 has 2 */
>  	struct omap2_mcspi_dma	*dma_channels;
> +	unsigned short		mcspi_mode;
> +	unsigned short		dma_mode;
> +	unsigned short		force_cs_mode;
> +	unsigned short		fifo_depth;
>  };
> 
>  struct omap2_mcspi_cs {
> @@ -133,6 +144,37 @@
>  	int			word_len;
>  };
> 
> +#ifdef CONFIG_SPI_DEBUG
> +struct reg_type {
> +	char name[40];
> +	int offset;
> +};
> +
> +static struct reg_type reg_map[] = {
> +	{"MCSPI_REV", 0x0},
> +	{"MCSPI_SYSCONFIG", 0x10},
> +	{"MCSPI_SYSSTATUS", 0x14},
> +	{"MCSPI_IRQSTATUS", 0x18},
> +	{"MCSPI_IRQENABLE", 0x1C},
> +	{"MCSPI_WAKEUPENABLE", 0x20},
> +	{"MCSPI_SYST", 0x24},
> +	{"MCSPI_MODULCTRL", 0x28},
> +	{"MCSPI_XFERLEVEL", 0x7c},
> +	{"CH0", 0x2C},
> +	{"CH1", 0x40},
> +	{"CH2", 0x54},
> +	{"CH3", 0x68}
> +};
> +
> +static struct reg_type ch_reg_type[] = {
> +	{"CONF", 0x00},
> +	{"STAT", 0x04},
> +	{"CTRL", 0x08},
> +	{"TX", 0x0C},
> +	{"RX", 0x10},
> +};
> +#endif
> +
>  static struct workqueue_struct *omap2_mcspi_wq;
> 
>  #define MOD_REG_BIT(val, mask, set) do { \
> @@ -188,6 +230,39 @@
>  	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
>  }
> 
> +#ifdef CONFIG_SPI_DEBUG
> +static int
> +omap2_mcspi_dump_regs(struct spi_master *master)
> +{
> +	u32 spi_base;
> +	u32 reg;
> +	u32 channel;
> +	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
> +
> +	spi_base = (u32)mcspi->base;
> +
> +	for (reg = 0; (reg < ARRAY_SIZE(reg_map)); reg++) {
> +		struct reg_type *reg_d = &reg_map[reg];
> +		u32 base1 = spi_base + reg_d->offset;
> +		if (reg_d->name[0] == 'C') {
> +			for (channel = 0; (channel < (ARRAY_SIZE(ch_reg_type)));
> +			    channel++) {
> +				struct reg_type *reg_c = &ch_reg_type[channel];
> +				u32 base2 = base1 + reg_c->offset;
> +				pr_debug("MCSPI_%s%s [0x%08X] = 0x%08X\n",
> +				       reg_d->name, reg_c->name, base2,
> +				       __raw_readl(base2));
> +			}
> +		} else {
> +			pr_debug("%s : [0x%08X] = 0x%08X\n",
> +				reg_d->name, base1, __raw_readl(base1));
> +		}
> +
> +	}
> +	return 0;
> +}
> +#endif
> +
>  static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
>  {
>  	u32 l;
> @@ -205,34 +280,149 @@
>  	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
>  }
> 
> +static int omap2_mcspi_set_txfifo(const struct spi_device *spi, int buf_size,
> +					int enable)
> +{
> +	u32 l, rw, s;
> +	unsigned short revert = 0;
> +	struct spi_master *master = spi->master;
> +	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
> +
> +	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
> +	s = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCTRL0);
> +
> +	if (enable == 1) {
> +		if (l & OMAP2_MCSPI_CHCONF_FFER)
> +			return -1;

Use err.h here to return something useful?


> +		if (s & OMAP2_MCSPI_CHCTRL_EN) {
> +			omap2_mcspi_set_enable(spi, 0);
> +			revert = 1;
> +		}
> +
> +		if (buf_size < mcspi->fifo_depth)
> +			mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL,
> +						((buf_size << 16) |
> +						(buf_size - 1) << 0));
> +		else
> +			mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL,
> +						((buf_size << 16) |
> +						(mcspi->fifo_depth - 1) << 0));
> +	}
> +
> +	rw = OMAP2_MCSPI_CHCONF_FFET;
> +	MOD_REG_BIT(l, rw, enable);
> +	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
> +
> +	if (revert)
> +		omap2_mcspi_set_enable(spi, 1);
> +
> +	return 0;
> +
> +}
> +
> +static int omap2_mcspi_set_rxfifo(const struct spi_device *spi, int buf_size,
> +					int enable)
> +{
> +	u32 l, rw, s;
> +	unsigned short revert = 0;
> +	struct spi_master *master = spi->master;
> +	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
> +
> +	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
> +	s = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCTRL0);
> +
> +	if (enable == 1) {
> +		if (l & OMAP2_MCSPI_CHCONF_FFET)
> +			return -1;
> +

Here too.


> +		/* Channel needs to be disabled and enabled
> +		 * again for FIFO setting to take affect
> +		 */
> +		if (s & OMAP2_MCSPI_CHCTRL_EN) {
> +			omap2_mcspi_set_enable(spi, 0);
> +			revert = 1;
> +		}
> +
> +		if (buf_size < mcspi->fifo_depth)
> +			mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL,
> +						((buf_size << 16) |
> +						(buf_size - 1) << 8));
> +		else
> +			mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL,
> +						((buf_size << 16) |
> +						(mcspi->fifo_depth - 1) << 8));
> +	}
> +
> +	rw = OMAP2_MCSPI_CHCONF_FFER;
> +	MOD_REG_BIT(l, rw, enable);
> +	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
> +
> +	if (revert)
> +		omap2_mcspi_set_enable(spi, 1);
> +
> +	return 0;
> +
> +}
> +
>  static void omap2_mcspi_set_master_mode(struct spi_master *master)
>  {
>  	u32 l;
> +	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
> 
>  	/* setup when switching from (reset default) slave mode
> -	 * to single-channel master mode
> +	 * to single-channel master mode based on config value
>  	 */
>  	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
>  	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_STEST, 0);
>  	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_MS, 0);
> -	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, 1);
> +
> +	if (mcspi->force_cs_mode)
> +		MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, 1);
> +
>  	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
>  }
> 
> +static void omap2_mcspi_set_slave_mode(struct spi_master *master)
> +{
> +	u32 l;
> +
> +	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
> +	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_STEST, 0);
> +	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_MS, 1);
> +	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
> +}
> +
> +static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
> +{
> +	unsigned long timeout;
> +
> +	timeout = jiffies + msecs_to_jiffies(1000);
> +	while (!(__raw_readl(reg) & bit)) {
> +		if (time_after(jiffies, timeout))
> +			return -1;
> +		cpu_relax();
> +	}
> +	return 0;
> +}
> +
>  static unsigned
>  omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>  {
>  	struct omap2_mcspi	*mcspi;
>  	struct omap2_mcspi_cs	*cs = spi->controller_state;
>  	struct omap2_mcspi_dma  *mcspi_dma;
> -	unsigned int		count, c;
> +	unsigned int		count, c, bytes_per_transfer;
>  	unsigned long		base, tx_reg, rx_reg;
> -	int			word_len, data_type, element_count;
> -	u8			* rx;
> -	const u8		* tx;
> +	int			word_len, data_type, element_count, frame_count,
> +				sync_type;
> +	u8			*rx;
> +	const u8		*tx;
> +	void __iomem            *irqstat_reg;
> 
>  	mcspi = spi_master_get_devdata(spi->master);
>  	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
> +	irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
> 
>  	count = xfer->len;
>  	c = count;
> @@ -247,19 +437,34 @@
>  	if (word_len <= 8) {
>  		data_type = OMAP_DMA_DATA_TYPE_S8;
>  		element_count = count;
> +		bytes_per_transfer = 1;
>  	} else if (word_len <= 16) {
>  		data_type = OMAP_DMA_DATA_TYPE_S16;
>  		element_count = count >> 1;
> +		bytes_per_transfer = 2;
>  	} else /* word_len <= 32 */ {
>  		data_type = OMAP_DMA_DATA_TYPE_S32;
>  		element_count = count >> 2;
> +		bytes_per_transfer = 4;
> +	}
> +
> +	if ((mcspi->fifo_depth != 0) && (count > mcspi->fifo_depth)) {
> +		sync_type = OMAP_DMA_SYNC_FRAME;
> +		element_count = mcspi->fifo_depth/bytes_per_transfer;
> +		frame_count = count/mcspi->fifo_depth;
> +	} else if ((mcspi->fifo_depth != 0) && (count <=  mcspi->fifo_depth)) {
> +		sync_type = OMAP_DMA_SYNC_FRAME;
> +		frame_count = 1;
> +	} else {
> +		sync_type = OMAP_DMA_SYNC_ELEMENT;
> +		frame_count = 1;
>  	}
> 
>  	if (tx != NULL) {
> +
>  		omap_set_dma_transfer_params(mcspi_dma->dma_tx_channel,
> -				data_type, element_count, 1,
> -				OMAP_DMA_SYNC_ELEMENT,
> -				mcspi_dma->dma_tx_sync_dev, 0);
> +				data_type, element_count, frame_count,
> +				sync_type, mcspi_dma->dma_tx_sync_dev, 0);
> 
>  		omap_set_dma_dest_params(mcspi_dma->dma_tx_channel, 0,
>  				OMAP_DMA_AMODE_CONSTANT,
> @@ -268,13 +473,16 @@
>  		omap_set_dma_src_params(mcspi_dma->dma_tx_channel, 0,
>  				OMAP_DMA_AMODE_POST_INC,
>  				xfer->tx_dma, 0, 0);
> +
> +		if (mcspi->fifo_depth != 0)
> +			omap2_mcspi_set_txfifo(spi, count, 1);
>  	}
> 
>  	if (rx != NULL) {
> +
>  		omap_set_dma_transfer_params(mcspi_dma->dma_rx_channel,
> -				data_type, element_count, 1,
> -				OMAP_DMA_SYNC_ELEMENT,
> -				mcspi_dma->dma_rx_sync_dev, 1);
> +				data_type, element_count, frame_count,
> +				sync_type, mcspi_dma->dma_rx_sync_dev, 1);
> 
>  		omap_set_dma_src_params(mcspi_dma->dma_rx_channel, 0,
>  				OMAP_DMA_AMODE_CONSTANT,
> @@ -283,6 +491,14 @@
>  		omap_set_dma_dest_params(mcspi_dma->dma_rx_channel, 0,
>  				OMAP_DMA_AMODE_POST_INC,
>  				xfer->rx_dma, 0, 0);
> +
> +		if (mcspi->fifo_depth != 0) {
> +			omap2_mcspi_set_rxfifo(spi, count, 1);
> +
> +			/* Dummy write required for RX only mode */
> +			if (tx == NULL)
> +				mcspi_write_cs_reg(spi, OMAP2_MCSPI_TX0, 0);
> +		}
>  	}
> 
>  	if (tx != NULL) {
> @@ -297,27 +513,35 @@
> 
>  	if (tx != NULL) {
>  		wait_for_completion(&mcspi_dma->dma_tx_completion);
> +
> +		if (mcspi->fifo_depth != 0) {
> +			if (mcspi_wait_for_reg_bit(irqstat_reg,
> +				OMAP2_MCSPI_IRQ_EOW) < 0)
> +					dev_err(&spi->dev, "TXS timed out\n");
> +
> +		mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS,
> +				OMAP2_MCSPI_IRQ_EOW);
> +
> +		omap2_mcspi_set_txfifo(spi, count, 0);
> +		}
> +
>  		dma_unmap_single(NULL, xfer->tx_dma, count, DMA_TO_DEVICE);
>  	}
> 
>  	if (rx != NULL) {
>  		wait_for_completion(&mcspi_dma->dma_rx_completion);
> -		dma_unmap_single(NULL, xfer->rx_dma, count, DMA_FROM_DEVICE);
> -	}
> -	return count;
> -}
> 
> -static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
> -{
> -	unsigned long timeout;
> +		if (mcspi->fifo_depth != 0) {
> +			omap2_mcspi_set_rxfifo(spi, count, 0);
> 
> -	timeout = jiffies + msecs_to_jiffies(1000);
> -	while (!(__raw_readl(reg) & bit)) {
> -		if (time_after(jiffies, timeout))
> -			return -1;
> -		cpu_relax();
> +		mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS,
> +				OMAP2_MCSPI_IRQ_EOW);
> +
> +		}
> +
> +		dma_unmap_single(NULL, xfer->rx_dma, count, DMA_FROM_DEVICE);
>  	}
> -	return 0;
> +	return count;
>  }
> 
>  static unsigned
> @@ -508,8 +732,14 @@
>  	/* standard 4-wire master mode:  SCK, MOSI/out, MISO/in, nCS
>  	 * REVISIT: this controller could support SPI_3WIRE mode.
>  	 */
> -	l &= ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1);
> -	l |= OMAP2_MCSPI_CHCONF_DPE0;
> +	if (mcspi->mcspi_mode == OMAP2_MCSPI_MASTER) {
> +		l &= ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1);
> +		l |= OMAP2_MCSPI_CHCONF_DPE0;
> +	} else {
> +		l |= OMAP2_MCSPI_CHCONF_IS;
> +		l |= OMAP2_MCSPI_CHCONF_DPE1;
> +		l &= ~OMAP2_MCSPI_CHCONF_DPE0;
> +	}
> 
>  	/* wordlength */
>  	l &= ~OMAP2_MCSPI_CHCONF_WL_MASK;
> @@ -521,9 +751,11 @@
>  	else
>  		l &= ~OMAP2_MCSPI_CHCONF_EPOL;
> 
> -	/* set clock divisor */
> -	l &= ~OMAP2_MCSPI_CHCONF_CLKD_MASK;
> -	l |= div << 2;
> +	if (mcspi->mcspi_mode == OMAP2_MCSPI_MASTER) {
> +		/* set clock divisor */
> +		l &= ~OMAP2_MCSPI_CHCONF_CLKD_MASK;
> +		l |= div << 2;
> +	}
> 
>  	/* set SPI mode 0..3 */
>  	if (spi->mode & SPI_CPOL)
> @@ -728,7 +960,10 @@
>  					par_override = 0;
>  			}
> 
> -			if (!cs_active) {
> +			if ((!cs_active) && (mcspi->force_cs_mode) &&
> +				(mcspi->mcspi_mode ==
> +				OMAP2_MCSPI_MASTER)) {
> +
>  				omap2_mcspi_force_cs(spi, 1);
>  				cs_active = 1;
>  			}
> @@ -749,10 +984,14 @@
>  					__raw_writel(0, cs->base
>  							+ OMAP2_MCSPI_TX0);
> 
> -				if (m->is_dma_mapped || t->len >= DMA_MIN_BYTES)
> +				if (m->is_dma_mapped ||
> +					t->len >= DMA_MIN_BYTES ||
> +					mcspi->dma_mode)
> +
>  					count = omap2_mcspi_txrx_dma(spi, t);
>  				else
>  					count = omap2_mcspi_txrx_pio(spi, t);
> +
>  				m->actual_length += count;
> 
>  				if (count != t->len) {
> @@ -765,7 +1004,10 @@
>  				udelay(t->delay_usecs);
> 
>  			/* ignore the "leave it on after last xfer" hint */
> -			if (t->cs_change) {
> +			if ((t->cs_change) && (mcspi->force_cs_mode) &&
> +				(mcspi->mcspi_mode ==
> +				OMAP2_MCSPI_MASTER)) {
> +
>  				omap2_mcspi_force_cs(spi, 0);
>  				cs_active = 0;
>  			}
> @@ -777,8 +1019,9 @@
>  			status = omap2_mcspi_setup_transfer(spi, NULL);
>  		}
> 
> -		if (cs_active)
> -			omap2_mcspi_force_cs(spi, 0);
> +		if ((cs_active) && (mcspi->force_cs_mode) &&
> +			(mcspi->mcspi_mode == OMAP2_MCSPI_MASTER))
> +				omap2_mcspi_force_cs(spi, 0);
> 
>  		omap2_mcspi_set_enable(spi, 0);
> 
> @@ -803,6 +1046,8 @@
>  	m->actual_length = 0;
>  	m->status = 0;
> 
> +	mcspi = spi_master_get_devdata(spi->master);
> +
>  	/* reject invalid messages and transfers */
>  	if (list_empty(&m->transfers) || !m->complete)
>  		return -EINVAL;
> @@ -831,7 +1076,14 @@
>  			return -EINVAL;
>  		}
> 
> -		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
> +		if (mcspi->fifo_depth != 0) {
> +			if ((len % mcspi->fifo_depth) != 0)
> +				return -EINVAL;
> +		}
> +
> +		/* Ignore DMA_MIN_BYTES check if dma only mode is set */
> +		if (m->is_dma_mapped || ((len < DMA_MIN_BYTES) &&
> +						(!mcspi->dma_mode)))
>  			continue;
> 
>  		/* Do DMA mapping "early" for better error reporting and
> @@ -862,8 +1114,6 @@
>  		}
>  	}
> 
> -	mcspi = spi_master_get_devdata(spi->master);
> -
>  	spin_lock_irqsave(&mcspi->lock, flags);
>  	list_add_tail(&m->queue, &mcspi->msg_queue);
>  	queue_work(omap2_mcspi_wq, &mcspi->work);
> @@ -894,7 +1144,10 @@
>  	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE,
>  			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
> 
> -	omap2_mcspi_set_master_mode(master);
> +	if (mcspi->mcspi_mode == OMAP2_MCSPI_MASTER)
> +		omap2_mcspi_set_master_mode(master);
> +	else
> +		omap2_mcspi_set_slave_mode(master);
> 
>  	clk_disable(mcspi->fck);
>  	clk_disable(mcspi->ick);
> @@ -950,6 +1203,8 @@
>  static int __init omap2_mcspi_probe(struct platform_device *pdev)
>  {
>  	struct spi_master	*master;
> +	struct omap2_mcspi_platform_config *pdata =
> +		(struct omap2_mcspi_platform_config *)pdev->dev.platform_data;
>  	struct omap2_mcspi	*mcspi;
>  	struct resource		*r;
>  	int			status = 0, i;
> @@ -1003,6 +1258,16 @@
> 
>  	mcspi = spi_master_get_devdata(master);
>  	mcspi->master = master;
> +	mcspi->mcspi_mode = pdata->mode;
> +	mcspi->dma_mode = pdata->dma_mode;
> +	mcspi->force_cs_mode = pdata->force_cs_mode;
> +
> +	if (pdata->fifo_depth <= OMAP2_MCSPI_MAX_FIFODEPTH)
> +		mcspi->fifo_depth = pdata->fifo_depth;
> +	else {
> +		mcspi->fifo_depth = 0;
> +		dev_dbg(&pdev->dev, "Invalid fifo depth specified\n");
> +	}
> 
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (r == NULL) {
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
