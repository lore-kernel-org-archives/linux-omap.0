From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Add TI TSC2005 Touchscreen driver
Date: Mon, 8 Dec 2008 19:26:48 +0100
Message-ID: <20081208182648.GA9740@uranus.ravnborg.org>
References: <5d5443650812080949h5aff6010mb7341f581841f126@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751406AbYLHSZd@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d5443650812080949h5aff6010mb7341f581841f126@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, dmitry.torokhov@gmail.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, lauri.leukkunen@nokia.com
List-Id: linux-omap@vger.kernel.org

> Add Texas Instruments TSC2005 chip touchscreen driver.
> 
> Signed-off-by: Trilok Soni <soni.trilok@gmail.com>

Hi Trilok.
A few nitpicks below.

In general a very clean written driver with adequate comments - nice work!

	Sam


> ---
>  drivers/input/touchscreen/Kconfig   |    6 +
>  drivers/input/touchscreen/Makefile  |    1 +
>  drivers/input/touchscreen/tsc2005.c |  728 +++++++++++++++++++++++++++++++++++
>  3 files changed, 735 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/tsc2005.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig
> b/drivers/input/touchscreen/Kconfig
> index 3d1ab8f..77e6729 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -221,6 +221,12 @@ config TOUCHSCREEN_ATMEL_TSADCC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called atmel_tsadcc.
> 
> +config TOUCHSCREEN_TSC2005
> +	tristate "TSC2005 touchscreen support"
I would be good to see Texas Instruments spelled out here.
> +	depends on SPI_MASTER
> +	help
> +	  Say Y here for if you are using the touchscreen features of TSC2005.
And maybe with a bit text explaining where it is used or maybe where to find info.

> +#define TSC2005_VDD_LOWER_27
> +
> +#ifdef TSC2005_VDD_LOWER_27
> +#define TSC2005_HZ     (10000000)
> +#else
> +#define TSC2005_HZ     (25000000)
> +#endif

You define TSC2005_VDD_LOWER_27 and test for it two
lines later - looks strange.

> +
> +static void tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
> +{
> +	u16 data = TSC2005_CMD | TSC2005_CMD_12BIT | cmd;
> +	struct spi_message msg;
> +	struct spi_transfer xfer = { 0 };
> +
> +	xfer.tx_buf = &data;
> +	xfer.rx_buf = NULL;
> +	xfer.len = 1;
> +	xfer.bits_per_word = 8;
data is a 16 bit quantity yet you specify a len of 1.
Maybe len is counted from 0?

> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +	spi_sync(ts->spi, &msg);
> +}
> +
> +static void tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
> +{
> +	u32 tx;
> +	struct spi_message msg;
> +	struct spi_transfer xfer = { 0 };
> +
> +	tx = (TSC2005_REG | reg | TSC2005_REG_PND0 |
> +	       TSC2005_REG_WRITE) << 16;
> +	tx |= value;
Is this endian safe? Does spi know about LSB/MSB in the value?

> +
> +	xfer.tx_buf = &tx;
> +	xfer.rx_buf = NULL;
> +	xfer.len = 4;
> +	xfer.bits_per_word = 24;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +	spi_sync(ts->spi, &msg);
> +}

	Sam
