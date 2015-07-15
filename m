From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input: tsc2005 - convert to regmap
Date: Wed, 15 Jul 2015 14:48:07 -0700
Message-ID: <20150715214807.GD24393@dtor-ws>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
 <1436962408-5206-3-git-send-email-sre@kernel.org>
 <20150715212955.GA24393@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150715212955.GA24393@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-input@vger.kernel.org, Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 15, 2015 at 02:29:55PM -0700, Dmitry Torokhov wrote:
> Hi Sebastian,
> 
> On Wed, Jul 15, 2015 at 02:13:26PM +0200, Sebastian Reichel wrote:
> 
> >  	/* read the coordinates */
> > -	error = spi_sync(ts->spi, &ts->spi_read_msg);
> > +	error = regmap_bulk_read(ts->regmap, TSC2005_REG_X, &tsdata,
> > +				 TSC2005_DATA_REGS);
> >  	if (unlikely(error))
> >  		goto out;
> >  
> > -	x = ts->spi_x.spi_rx;
> > -	y = ts->spi_y.spi_rx;
> > -	z1 = ts->spi_z1.spi_rx;
> > -	z2 = ts->spi_z2.spi_rx;
> > -
> >  	/* validate position */
> > -	if (unlikely(x > MAX_12BIT || y > MAX_12BIT))
> > +	if (unlikely(tsdata.x > MAX_12BIT || tsdata.y > MAX_12BIT))
> >  		goto out;
> >  
> >  	/* Skip reading if the pressure components are out of range */
> > -	if (unlikely(z1 == 0 || z2 > MAX_12BIT || z1 >= z2))
> > +	if (unlikely(tsdata.z1 == 0 || tsdata.z2 > MAX_12BIT))
> > +		goto out;
> > +	if (unlikely(tsdata.z1 >= tsdata.z2))
> >  		goto out;
> 
> I guess that means that tsc2005 is (and was) endian-broken. We can't use
> the data off the wire directly...  So I'll drop bucnh of the changes in
> this function so we can convert to CPU endianness before using.

Ah, no, SPI transfers do convert to/from CPU endianness...

> 
> I also got:
> 
>   CC [M]  drivers/input/touchscreen/tsc2005.o
>   Building modules, stage 2.
> Kernel: arch/x86/boot/bzImage is ready  (#1383)
>   MODPOST 1403 modules
> ERROR: "devm_regmap_init_spi" [drivers/input/touchscreen/tsc2005.ko]
> undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> I guess we need "select REGMAP_SPI".
> 
> Thanks.
> 
> -- 
> Dmitry
> 
> 
> Input: tsc2005 - convert to regmap
> 
> From: Sebastian Reichel <sre@kernel.org>
> 
> Convert driver, so that it uses regmap instead of directly using
> spi_transfer for all register accesses.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/Kconfig   |    9 +-
>  drivers/input/touchscreen/tsc2005.c |  149 ++++++++++++-----------------------
>  2 files changed, 55 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 9b3da52..c1acbbc 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -915,10 +915,11 @@ config TOUCHSCREEN_TSC_SERIO
>  	  module will be called tsc40.
>  
>  config TOUCHSCREEN_TSC2005
> -        tristate "TSC2005 based touchscreens"
> -        depends on SPI_MASTER
> -        help
> -          Say Y here if you have a TSC2005 based touchscreen.
> +	tristate "TSC2005 based touchscreens"
> +	depends on SPI_MASTER
> +	select REGMAP_SPI
> +	help
> +	  Say Y here if you have a TSC2005 based touchscreen.
>  
>  	  If unsure, say N.
>  
> diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
> index 2a27a1f..a04248e 100644
> --- a/drivers/input/touchscreen/tsc2005.c
> +++ b/drivers/input/touchscreen/tsc2005.c
> @@ -34,6 +34,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/tsc2005.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
>  
>  /*
>   * The touchscreen interface operates as follows:
> @@ -120,20 +121,36 @@
>  #define TSC2005_SPI_MAX_SPEED_HZ	10000000
>  #define TSC2005_PENUP_TIME_MS		40
>  
> -struct tsc2005_spi_rd {
> -	struct spi_transfer	spi_xfer;
> -	u32			spi_tx;
> -	u32			spi_rx;
> +static const struct regmap_range tsc2005_writable_ranges[] = {
> +	regmap_reg_range(TSC2005_REG_AUX_HIGH, TSC2005_REG_CFR2),
>  };
>  
> +static const struct regmap_access_table tsc2005_writable_table = {
> +	.yes_ranges = tsc2005_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(tsc2005_writable_ranges),
> +};
> +
> +static struct regmap_config tsc2005_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.reg_stride = 0x08,
> +	.max_register = 0x78,
> +	.read_flag_mask = TSC2005_REG_READ,
> +	.wr_table = &tsc2005_writable_table,
> +	.use_single_rw = true,
> +};
> +
> +struct tsc2005_data {
> +	u16 x;
> +	u16 y;
> +	u16 z1;
> +	u16 z2;
> +} __packed;
> +#define TSC2005_DATA_REGS 4
> +
>  struct tsc2005 {
>  	struct spi_device	*spi;
> -
> -	struct spi_message      spi_read_msg;
> -	struct tsc2005_spi_rd	spi_x;
> -	struct tsc2005_spi_rd	spi_y;
> -	struct tsc2005_spi_rd	spi_z1;
> -	struct tsc2005_spi_rd	spi_z2;
> +	struct regmap		*regmap;
>  
>  	struct input_dev	*idev;
>  	char			phys[32];
> @@ -190,62 +207,6 @@ static int tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
>  	return 0;
>  }
>  
> -static int tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
> -{
> -	u32 tx = ((reg | TSC2005_REG_PND0) << 16) | value;
> -	struct spi_transfer xfer = {
> -		.tx_buf		= &tx,
> -		.len		= 4,
> -		.bits_per_word	= 24,
> -	};
> -	struct spi_message msg;
> -	int error;
> -
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -
> -	error = spi_sync(ts->spi, &msg);
> -	if (error) {
> -		dev_err(&ts->spi->dev,
> -			"%s: failed, register: %x, value: %x, error: %d\n",
> -			__func__, reg, value, error);
> -		return error;
> -	}
> -
> -	return 0;
> -}
> -
> -static void tsc2005_setup_read(struct tsc2005_spi_rd *rd, u8 reg, bool last)
> -{
> -	memset(rd, 0, sizeof(*rd));
> -
> -	rd->spi_tx		   = (reg | TSC2005_REG_READ) << 16;
> -	rd->spi_xfer.tx_buf	   = &rd->spi_tx;
> -	rd->spi_xfer.rx_buf	   = &rd->spi_rx;
> -	rd->spi_xfer.len	   = 4;
> -	rd->spi_xfer.bits_per_word = 24;
> -	rd->spi_xfer.cs_change	   = !last;
> -}
> -
> -static int tsc2005_read(struct tsc2005 *ts, u8 reg, u16 *value)
> -{
> -	struct tsc2005_spi_rd spi_rd;
> -	struct spi_message msg;
> -	int error;
> -
> -	tsc2005_setup_read(&spi_rd, reg, true);
> -
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&spi_rd.spi_xfer, &msg);
> -
> -	error = spi_sync(ts->spi, &msg);
> -	if (error)
> -		return error;
> -
> -	*value = spi_rd.spi_rx;
> -	return 0;
> -}
> -
>  static void tsc2005_update_pen_state(struct tsc2005 *ts,
>  				     int x, int y, int pressure)
>  {
> @@ -276,17 +237,19 @@ static irqreturn_t tsc2005_irq_thread(int irq, void *_ts)
>  	unsigned int pressure;
>  	u32 x, y;
>  	u32 z1, z2;
> +	struct tsc2005_data tsdata;
>  	int error;
>  
>  	/* read the coordinates */
> -	error = spi_sync(ts->spi, &ts->spi_read_msg);
> +	error = regmap_bulk_read(ts->regmap, TSC2005_REG_X, &tsdata,
> +				 TSC2005_DATA_REGS);
>  	if (unlikely(error))
>  		goto out;
>  
> -	x = ts->spi_x.spi_rx;
> -	y = ts->spi_y.spi_rx;
> -	z1 = ts->spi_z1.spi_rx;
> -	z2 = ts->spi_z2.spi_rx;
> +	x = tsdata.x;
> +	y = tsdata.y;
> +	z1 = tsdata.z1;
> +	z2 = tsdata.z2;
>  
>  	/* validate position */
>  	if (unlikely(x > MAX_12BIT || y > MAX_12BIT))
> @@ -346,9 +309,9 @@ static void tsc2005_penup_timer(unsigned long data)
>  
>  static void tsc2005_start_scan(struct tsc2005 *ts)
>  {
> -	tsc2005_write(ts, TSC2005_REG_CFR0, TSC2005_CFR0_INITVALUE);
> -	tsc2005_write(ts, TSC2005_REG_CFR1, TSC2005_CFR1_INITVALUE);
> -	tsc2005_write(ts, TSC2005_REG_CFR2, TSC2005_CFR2_INITVALUE);
> +	regmap_write(ts->regmap, TSC2005_REG_CFR0, TSC2005_CFR0_INITVALUE);
> +	regmap_write(ts->regmap, TSC2005_REG_CFR1, TSC2005_CFR1_INITVALUE);
> +	regmap_write(ts->regmap, TSC2005_REG_CFR2, TSC2005_CFR2_INITVALUE);
>  	tsc2005_cmd(ts, TSC2005_CMD_NORMAL);
>  }
>  
> @@ -398,9 +361,9 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
>  {
>  	struct spi_device *spi = to_spi_device(dev);
>  	struct tsc2005 *ts = spi_get_drvdata(spi);
> -	u16 temp_high;
> -	u16 temp_high_orig;
> -	u16 temp_high_test;
> +	unsigned int temp_high;
> +	unsigned int temp_high_orig;
> +	unsigned int temp_high_test;
>  	bool success = true;
>  	int error;
>  
> @@ -411,7 +374,7 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
>  	 */
>  	__tsc2005_disable(ts);
>  
> -	error = tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high_orig);
> +	error = regmap_read(ts->regmap, TSC2005_REG_TEMP_HIGH, &temp_high_orig);
>  	if (error) {
>  		dev_warn(dev, "selftest failed: read error %d\n", error);
>  		success = false;
> @@ -420,14 +383,14 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
>  
>  	temp_high_test = (temp_high_orig - 1) & MAX_12BIT;
>  
> -	error = tsc2005_write(ts, TSC2005_REG_TEMP_HIGH, temp_high_test);
> +	error = regmap_write(ts->regmap, TSC2005_REG_TEMP_HIGH, temp_high_test);
>  	if (error) {
>  		dev_warn(dev, "selftest failed: write error %d\n", error);
>  		success = false;
>  		goto out;
>  	}
>  
> -	error = tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high);
> +	error = regmap_read(ts->regmap, TSC2005_REG_TEMP_HIGH, &temp_high);
>  	if (error) {
>  		dev_warn(dev, "selftest failed: read error %d after write\n",
>  			 error);
> @@ -450,7 +413,7 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
>  		goto out;
>  
>  	/* test that the reset really happened */
> -	error = tsc2005_read(ts, TSC2005_REG_TEMP_HIGH, &temp_high);
> +	error = regmap_read(ts->regmap, TSC2005_REG_TEMP_HIGH, &temp_high);
>  	if (error) {
>  		dev_warn(dev, "selftest failed: read error %d after reset\n",
>  			 error);
> @@ -503,7 +466,7 @@ static void tsc2005_esd_work(struct work_struct *work)
>  {
>  	struct tsc2005 *ts = container_of(work, struct tsc2005, esd_work.work);
>  	int error;
> -	u16 r;
> +	unsigned int r;
>  
>  	if (!mutex_trylock(&ts->mutex)) {
>  		/*
> @@ -519,7 +482,7 @@ static void tsc2005_esd_work(struct work_struct *work)
>  		goto out;
>  
>  	/* We should be able to read register without disabling interrupts. */
> -	error = tsc2005_read(ts, TSC2005_REG_CFR0, &r);
> +	error = regmap_read(ts->regmap, TSC2005_REG_CFR0, &r);
>  	if (!error &&
>  	    !((r ^ TSC2005_CFR0_INITVALUE) & TSC2005_CFR0_RW_MASK)) {
>  		goto out;
> @@ -583,20 +546,6 @@ static void tsc2005_close(struct input_dev *input)
>  	mutex_unlock(&ts->mutex);
>  }
>  
> -static void tsc2005_setup_spi_xfer(struct tsc2005 *ts)
> -{
> -	tsc2005_setup_read(&ts->spi_x, TSC2005_REG_X, false);
> -	tsc2005_setup_read(&ts->spi_y, TSC2005_REG_Y, false);
> -	tsc2005_setup_read(&ts->spi_z1, TSC2005_REG_Z1, false);
> -	tsc2005_setup_read(&ts->spi_z2, TSC2005_REG_Z2, true);
> -
> -	spi_message_init(&ts->spi_read_msg);
> -	spi_message_add_tail(&ts->spi_x.spi_xfer, &ts->spi_read_msg);
> -	spi_message_add_tail(&ts->spi_y.spi_xfer, &ts->spi_read_msg);
> -	spi_message_add_tail(&ts->spi_z1.spi_xfer, &ts->spi_read_msg);
> -	spi_message_add_tail(&ts->spi_z2.spi_xfer, &ts->spi_read_msg);
> -}
> -
>  static int tsc2005_probe(struct spi_device *spi)
>  {
>  	const struct tsc2005_platform_data *pdata = dev_get_platdata(&spi->dev);
> @@ -661,6 +610,10 @@ static int tsc2005_probe(struct spi_device *spi)
>  	ts->spi = spi;
>  	ts->idev = input_dev;
>  
> +	ts->regmap = devm_regmap_init_spi(spi, &tsc2005_regmap_config);
> +	if (IS_ERR(ts->regmap))
> +		return PTR_ERR(ts->regmap);
> +
>  	ts->x_plate_ohm = x_plate_ohm;
>  	ts->esd_timeout = esd_timeout;
>  
> @@ -700,8 +653,6 @@ static int tsc2005_probe(struct spi_device *spi)
>  
>  	INIT_DELAYED_WORK(&ts->esd_work, tsc2005_esd_work);
>  
> -	tsc2005_setup_spi_xfer(ts);
> -
>  	snprintf(ts->phys, sizeof(ts->phys),
>  		 "%s/input-ts", dev_name(&spi->dev));
>  

-- 
Dmitry
