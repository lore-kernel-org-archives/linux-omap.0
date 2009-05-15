From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH][RFC] McSPI Slave and DMA,FIFO support
Date: Fri, 15 May 2009 10:35:11 -0700
Message-ID: <877i0ifewg.fsf@deeprootsystems.com>
References: <35310.10.24.255.18.1242389411.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:51570 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbZEORfP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 13:35:15 -0400
Received: by pzk13 with SMTP id 13so1176646pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 10:35:15 -0700 (PDT)
In-Reply-To: <35310.10.24.255.18.1242389411.squirrel@dbdmail.itg.ti.com> (Hemanth V.'s message of "Fri\, 15 May 2009 17\:40\:11 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org

"Hemanth V" <hemanthv@ti.com> writes:

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
>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c     |   19 +
>  arch/arm/mach-omap2/devices.c           |   16 +
>  arch/arm/mach-omap2/mux.c               |   11
>  arch/arm/plat-omap/include/mach/mcspi.h |   13 +
>  arch/arm/plat-omap/include/mach/mux.h   |    7
>  drivers/spi/omap2_mcspi.c               |  353 ++++++++++++++++++++++++++++----
>  6 files changed, 379 insertions(+), 40 deletions(-)

I think you should break this up into a series:

1) SPI driver changes (which could go upstream after review/approval)
2) mux changes
3) OMAP init changes (devices.c)
4) SDP changes, which are debug only

Where (2) and (3) could probably be combined.

> Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2009-05-14
> 12:38:50.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2009-05-14
> 19:48:35.000000000 +0530
> @@ -228,6 +228,13 @@
>  	.single_channel	= 1,	/* 0: slave, 1: master */
>  };
>
> +#ifdef CONFIG_SPI_DEBUG
> +static struct omap2_mcspi_device_config dummy_mcspi_config = {
> +	.turbo_mode	= 0,
> +	.single_channel	= 1,  /* 0: slave, 1: master */
> +};
> +#endif
> +
>  static struct spi_board_info sdp3430_spi_board_info[] __initdata = {
>  	[0] = {
>  		/*
> @@ -242,6 +249,18 @@
>  		.irq			= 0,
>  		.platform_data		= &tsc2046_config,
>  	},
> +#ifdef CONFIG_SPI_DEBUG
> +	[1] = {
> +		/* SPI test driver attached to SPI2 controller by
> +		 * default
> +		 */
> +		.modalias		= "spitst",
> +		.bus_num		= 2,
> +		.chip_select		= 0,
> +		.max_speed_hz		= 1500000,
> +		.controller_data	= &dummy_mcspi_config,
> +	},
> +#endif
>  };
>
>  static struct platform_device sdp3430_lcd_device = {
> Index: linux-omap-2.6/arch/arm/mach-omap2/devices.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/devices.c	2009-05-14
> 12:38:50.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/devices.c	2009-05-15 16:53:38.000000000
> +0530
> @@ -257,8 +257,12 @@
>  #define OMAP2_MCSPI3_BASE		0x480b8000
>  #define OMAP2_MCSPI4_BASE		0x480ba000
>
> +#define OMAP2_MCSPI_MASTER		0
> +#define OMAP2_MCSPI_SLAVE		1
> +

If these are to be 'mode' flags for 'struct
omap2_mcspi_platform_config' then they should be part of mcspi.h, not
defined here.

>  static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
>  	.num_cs		= 4,
> +	.force_cs_mode	= 1,
>  };
>
>  static struct resource omap2_mcspi1_resources[] = {
> @@ -281,6 +285,10 @@
>
>  static struct omap2_mcspi_platform_config omap2_mcspi2_config = {
>  	.num_cs		= 2,
> +	.mode		= OMAP2_MCSPI_MASTER,
> +	.dma_mode	= 1,
> +	.force_cs_mode	= 0,
> +	.fifo_depth	= 0,

Setting these init values to zero is redundant.

>  };
>
>  static struct resource omap2_mcspi2_resources[] = {
> @@ -351,6 +359,14 @@
>
>  static void omap_init_mcspi(void)
>  {
> +
> +	if (cpu_is_omap3430()) {
> +		omap_cfg_reg(AA3_3430_McSPI2_CLK);
> +		omap_cfg_reg(Y2_3430_McSPI2_SIMO);
> +		omap_cfg_reg(Y3_3430_McSPI2_SOMI);
> +		omap_cfg_reg(Y4_3430_McSPI2_CS0);
> +	}
> +
>  	platform_device_register(&omap2_mcspi1);
>  	platform_device_register(&omap2_mcspi2);
>  #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
> Index: linux-omap-2.6/arch/arm/mach-omap2/mux.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/mux.c	2009-05-14 12:38:50.000000000
> +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/mux.c	2009-05-15 16:18:41.000000000 +0530
> @@ -486,6 +486,17 @@
>  		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
>  MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
>  		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
> +
> +/* McSPI */
> +MUX_CFG_34XX("AA3_3430_McSPI2_CLK", 0x1d6,
> +	OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
> +MUX_CFG_34XX("Y2_3430_McSPI2_SIMO", 0x1d8,
> +	OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
> +MUX_CFG_34XX("Y3_3430_McSPI2_SOMI", 0x1da,
> +	OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT)
> +MUX_CFG_34XX("Y4_3430_McSPI2_CS0", 0x1dc,
> +	OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
> +
>  };
>
>  #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/mcspi.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/mcspi.h	2009-05-14
> 12:38:54.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/mcspi.h	2009-05-14
> 19:48:35.000000000 +0530
> @@ -3,6 +3,19 @@
>
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
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/mux.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/mux.h	2009-05-14
> 12:38:54.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/mux.h	2009-05-15
> 16:22:28.000000000 +0530
> @@ -853,6 +853,13 @@
>  	AE5_34XX_GPIO143,
>  	H19_34XX_GPIO164_OUT,
>  	J25_34XX_GPIO170,
> +
> +	/* McSPI */
> +	AA3_3430_McSPI2_CLK,
> +	Y2_3430_McSPI2_SIMO,
> +	Y3_3430_McSPI2_SOMI,
> +	Y4_3430_McSPI2_CS0,
> +
>  };
>
>  struct omap_mux_cfg {
> Index: linux-omap-2.6/drivers/spi/omap2_mcspi.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/spi/omap2_mcspi.c	2009-05-14 12:37:40.000000000
> +0530
> +++ linux-omap-2.6/drivers/spi/omap2_mcspi.c	2009-05-15 17:33:05.000000000 +0530
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
> @@ -93,6 +99,10 @@
>  #define OMAP2_MCSPI_CHCTRL_EN		BIT(0)
>
>  #define OMAP2_MCSPI_WAKEUPENABLE_WKEN	BIT(0)
> +#define OMAP2_MCSPI_IRQ_EOW		BIT(17)
> +
> +#define OMAP2_MCSPI_MODE_IS_MASTER	0
> +#define OMAP2_MCSPI_MODE_IS_SLAVE	1

This is the 2nd define of the master/slave mode flags.  Pick a name
and define it once in mcspi.h.

>  /* We have 2 DMA channels per CS, one for RX and one for TX */
>  struct omap2_mcspi_dma {
> @@ -125,6 +135,10 @@
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
> @@ -133,6 +147,37 @@
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
> @@ -188,6 +233,44 @@
>  	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
>  }
>
> +#ifdef CONFIG_SPI_DEBUG
> +static int
> +omap2_mcspi_dump_regs(struct spi_master *master)
> +{
> +	u32 spi_base;
> +	u32 reg;
> +	u32 bus;
> +	u32 chan;
> +	u32 channel;
> +	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
> +
> +	spi_base = mcspi->base;
> +
> +	for (reg = 0; (reg < sizeof(reg_map) / sizeof(struct reg_type));

You could use ARRAY_SIZE() here.

> +	     reg++) {
> +		struct reg_type *reg_d = &reg_map[reg];
> +		u32 base1 = spi_base + reg_d->offset;
> +		if (reg_d->name[0] == 'C') {
> +			for (channel = 0;
> +			     (channel < (sizeof(ch_reg_type) /
> +					 sizeof(struct reg_type)));
> +			     channel++) {
> +				struct reg_type *reg_c = &ch_reg_type[channel];
> +				u32 base2 = base1 + reg_c->offset;
> +				printk(KERN_DEBUG "MCSPI_%s%s [0x%08X] = 0x%08X\n",
> +				       reg_d->name, reg_c->name, base2,
> +				       __raw_readl(base2));

Use pr_debug()

> +			}
> +		} else {
> +			printk(KERN_DEBUG "%s : [0x%08X] = 0x%08X\n",
> +				reg_d->name, base1, __raw_readl(base1));

ditto

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
> @@ -205,34 +288,149 @@
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
> +
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
> +	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
> +}
> +
> +static void omap2_mcspi_set_slave_mode(struct spi_master *master)
> +{
> +	u32 l;
> +
> +	l = mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
> +	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_STEST, 0);
> +	MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_MS, 1);
>  	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
>  }
>
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
> @@ -247,19 +445,34 @@
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
> @@ -268,13 +481,16 @@
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
> @@ -283,6 +499,14 @@
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
> @@ -297,27 +521,35 @@
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
> @@ -508,8 +740,14 @@
>  	/* standard 4-wire master mode:  SCK, MOSI/out, MISO/in, nCS
>  	 * REVISIT: this controller could support SPI_3WIRE mode.
>  	 */
> -	l &= ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1);
> -	l |= OMAP2_MCSPI_CHCONF_DPE0;
> +	if (mcspi->mcspi_mode == OMAP2_MCSPI_MODE_IS_MASTER) {
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
> @@ -521,9 +759,11 @@
>  	else
>  		l &= ~OMAP2_MCSPI_CHCONF_EPOL;
>
> -	/* set clock divisor */
> -	l &= ~OMAP2_MCSPI_CHCONF_CLKD_MASK;
> -	l |= div << 2;
> +	if (mcspi->mcspi_mode == OMAP2_MCSPI_MODE_IS_MASTER) {
> +		/* set clock divisor */
> +		l &= ~OMAP2_MCSPI_CHCONF_CLKD_MASK;
> +		l |= div << 2;
> +	}
>
>  	/* set SPI mode 0..3 */
>  	if (spi->mode & SPI_CPOL)
> @@ -688,7 +928,7 @@
>  	clk_enable(mcspi->ick);
>  	clk_enable(mcspi->fck);
>
> -	/* We only enable one channel at a time -- the one whose message is
> +	/*  only enable one channel at a time -- the one whose message is

Heh, are you against first person plural comments. ;)

>  	 * at the head of the queue -- although this controller would gladly
>  	 * arbitrate among multiple channels.  This corresponds to "single
>  	 * channel" master mode.  As a side effect, we need to manage the
> @@ -728,7 +968,10 @@
>  					par_override = 0;
>  			}
>
> -			if (!cs_active) {
> +			if ((!cs_active) && (mcspi->force_cs_mode) &&
> +				(mcspi->mcspi_mode ==
> +				OMAP2_MCSPI_MODE_IS_MASTER)) {
> +
>  				omap2_mcspi_force_cs(spi, 1);
>  				cs_active = 1;
>  			}
> @@ -749,10 +992,14 @@
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
> @@ -765,7 +1012,10 @@
>  				udelay(t->delay_usecs);
>
>  			/* ignore the "leave it on after last xfer" hint */
> -			if (t->cs_change) {
> +			if ((t->cs_change) && (mcspi->force_cs_mode) &&
> +				(mcspi->mcspi_mode ==
> +				OMAP2_MCSPI_MODE_IS_MASTER)) {
> +
>  				omap2_mcspi_force_cs(spi, 0);
>  				cs_active = 0;
>  			}
> @@ -777,8 +1027,9 @@
>  			status = omap2_mcspi_setup_transfer(spi, NULL);
>  		}
>
> -		if (cs_active)
> -			omap2_mcspi_force_cs(spi, 0);
> +		if ((cs_active) && (mcspi->force_cs_mode) &&
> +			(mcspi->mcspi_mode == OMAP2_MCSPI_MODE_IS_MASTER))
> +				omap2_mcspi_force_cs(spi, 0);
>
>  		omap2_mcspi_set_enable(spi, 0);
>
> @@ -803,6 +1054,8 @@
>  	m->actual_length = 0;
>  	m->status = 0;
>
> +	mcspi = spi_master_get_devdata(spi->master);
> +
>  	/* reject invalid messages and transfers */
>  	if (list_empty(&m->transfers) || !m->complete)
>  		return -EINVAL;
> @@ -831,7 +1084,14 @@
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
> @@ -862,8 +1122,6 @@
>  		}
>  	}
>
> -	mcspi = spi_master_get_devdata(spi->master);
> -
>  	spin_lock_irqsave(&mcspi->lock, flags);
>  	list_add_tail(&m->queue, &mcspi->msg_queue);
>  	queue_work(omap2_mcspi_wq, &mcspi->work);
> @@ -894,7 +1152,10 @@
>  	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE,
>  			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
>
> -	omap2_mcspi_set_master_mode(master);
> +	if (mcspi->mcspi_mode == OMAP2_MCSPI_MODE_IS_MASTER)
> +		omap2_mcspi_set_master_mode(master);
> +	else
> +		omap2_mcspi_set_slave_mode(master);
>
>  	clk_disable(mcspi->fck);
>  	clk_disable(mcspi->ick);
> @@ -950,6 +1211,8 @@
>  static int __init omap2_mcspi_probe(struct platform_device *pdev)
>  {
>  	struct spi_master	*master;
> +	struct omap2_mcspi_platform_config *pdata =
> +		(struct omap2_mcspi_platform_config *)pdev->dev.platform_data;
>  	struct omap2_mcspi	*mcspi;
>  	struct resource		*r;
>  	int			status = 0, i;
> @@ -1003,6 +1266,16 @@
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

Would seeting to MAX_FIFODEPTH be more appropriate here, along with
a warning.

> +	}
>
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (r == NULL) {

Kevin
