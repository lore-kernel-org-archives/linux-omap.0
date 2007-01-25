From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: [RFC] TSC2101 support
Date: Thu, 25 Jan 2007 05:13:16 +0200
Message-ID: <45B8204C.5060206@cc.jyu.fi>
References: <15215457.402191169687150749.JavaMail.weblogic@ep_ml23>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <15215457.402191169687150749.JavaMail.weblogic@ep_ml23>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kyungmin.park@samsung.com
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

It would replace the h2, h3, h6300 touchscreen driver in
drivers/input/touchscreen/omap/ directory. (omapts.c and ts_hx.c).
But if that can be made to work with h2 and h3, I think it would be fine.

Byteway, what about the support for the temperature, battery and aux
registers that are supported at least by some of the devices?
My understanding is that the reading of temperature, battery and aux
data values that the tsc2101 page0 must be handled in the same driver
than the reading of the touchscreen related info. (one must ask the
tsc2101 to give those values and once ready, tsc2101 sends interrupt and
we must check from the status register (01) from page1 informs whether
those values are readable or whether the interrupt was touchscreen press
related.)
I did that once by hacking the omapts.c ts_hx.c framework but the
resulting code was not pretty due to big changes in omapts.c which broke
all others ts drivers relying to omapts.c Do you have any code for doing
the read of those values with the new driver?

And if the ts is transfered to use SPI framework, maybe the same should
be done also for the omap-alsa-tsc2101. (It is currently relying on to
drivers/ssi/omap-tsc2101.c) I could volunteer in that if I manage to get
my h6300 kernel updated from 2.6.16 to latest...

Mika

Kyungmin Park wrote:
> Hi,
>
> A few days ago, Nokia released the their N800 source code. and I found the TSC2301 source code. it's similar with TSC2101 except keypad, and some registers.
>
> Now the TSC2101 chip is used in H4 and apollon. So I modified the TSC2301 source code to run TSC2101 chip for quick enabling test.
> However the TSC2101 use 32-bit spi protocol instead of 16-bit in TSC2301. So we have to modify spi part for 32-bit. but it's main strutures are same.
>
> In my opinion, the TSC2301 is not merged in omap tree. So if you don't mind we commit TSC2101 first, and after TSC2301 is merged. we  make one driver to support both.
>
> I want to listen your opinions what is better approache
>
> Thank you,
> Kyungmin Park
>
> P.S., Sorry. It's not full patch. It's just for reference :)
>
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index b8d0ec0..e3bdbfa 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -471,7 +473,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
>  
>  	conf = (struct omap2_mcspi_device_config *) spi->controller_data;
>  
> -	if (conf->single_channel == 1)
> +	if (conf && conf->single_channel == 1)
>  		omap2_mcspi_set_master_mode(spi, 1);
>  	else
>  		omap2_mcspi_set_master_mode(spi, 0);
> diff --git a/drivers/spi/tsc2101-ts.c b/drivers/spi/tsc2101-ts.c
> new file mode 100644
> index 0000000..83b1959
> --- /dev/null
> +++ b/drivers/spi/tsc2101-ts.c
> @@ -0,0 +1,712 @@
> +/*
> + * TSC2101 touchscreen driver
> + *
> + * Copyright (C) 2005-2006 Nokia Corporation
> + *
> + * Modified for 32-bit SPI bus by Kyungmin Park
> + *
> + * Derived from TSC2301 written by Jarkko Oikarinen, Imre Deak and Juha Yrjola
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/spi/spi.h>
> +
> +#ifdef CONFIG_ARCH_OMAP
> +#include <asm/arch/gpio.h>
> +#endif
> +
> +#include <linux/spi/tsc2101.h>
> +
> +/**
> + * The touchscreen interface operates as follows:
> + *
> + * Initialize:
> + *    Request access to GPIO (DAV)
> + *    tsc2101_dav_irq_handler will trigger when DAV line goes down
> + *
> + *  1) Pen is pressed against touchscreeen
> + *  2) TSC2101 performs AD conversion
> + *  3) After the conversion is done TSC2101 drives DAV line down
> + *  4) GPIO IRQ is received and tsc2101_dav_irq_handler is called
> + *  5) tsc2101_dav_irq_handler sets up tsc2101_ts_timer in TSC2101_TS_SCAN_TIME
> + *  6) tsc2101_ts_timer disables the irq and requests spi driver
> + *     to read X, Y, Z1 and Z2
> + *  7) SPI framework calls tsc2101_ts_rx after the coordinates are read
> + *  8) tsc2101_ts_rx reports coordinates to input layer and
> + *     sets up tsc2101_ts_timer to be called after TSC2101_TS_SCAN_TIME
> + *  9) if tsc2101_tx_timer notices that the pen has been lifted, the lift event
> + *     is sent, and irq is again enabled.
> + */
> +
> +
> +#define TSC2101_TS_SCAN_TIME		     		1
> +
> +#define TSC2101_ADCREG_CONVERSION_CTRL_BY_TSC2101	0x8000
> +#define TSC2101_ADCREG_CONVERSION_CTRL_BY_HOST		0x0000
> +
> +#define TSC2101_ADCREG_FUNCTION_NONE			0x0000
> +#define TSC2101_ADCREG_FUNCTION_XY			0x0400
> +#define TSC2101_ADCREG_FUNCTION_XYZ			0x0800
> +#define TSC2101_ADCREG_FUNCTION_X			0x0C00
> +#define TSC2101_ADCREG_FUNCTION_Y			0x1000
> +#define TSC2101_ADCREG_FUNCTION_Z			0x1400
> +#define TSC2101_ADCREG_FUNCTION_DAT1			0x1800
> +#define TSC2101_ADCREG_FUNCTION_DAT2			0x1C00
> +#define TSC2101_ADCREG_FUNCTION_AUX1			0x2000
> +#define TSC2101_ADCREG_FUNCTION_AUX2			0x2400
> +#define TSC2101_ADCREG_FUNCTION_TEMP			0x2800
> +
> +#define TSC2101_ADCREG_RESOLUTION_8BIT			0x0100
> +#define TSC2101_ADCREG_RESOLUTION_10BIT			0x0200
> +#define TSC2101_ADCREG_RESOLUTION_12BIT			0x0300
> +
> +#define TSC2101_ADCREG_AVERAGING_NONE			0x0000
> +#define TSC2101_ADCREG_AVERAGING_4AVG			0x0040
> +#define TSC2101_ADCREG_AVERAGING_8AVG			0x0080
> +#define TSC2101_ADCREG_AVERAGING_16AVG			0x00C0
> +
> +#define TSC2101_ADCREG_CLOCK_8MHZ			0x0000
> +#define TSC2101_ADCREG_CLOCK_4MHZ			0x0010
> +#define TSC2101_ADCREG_CLOCK_2MHZ			0x0020
> +#define TSC2101_ADCREG_CLOCK_1MHZ			0x0030
> +
> +#define TSC2101_ADCREG_VOLTAGE_STAB_0US			0x0000
> +#define TSC2101_ADCREG_VOLTAGE_STAB_100US		0x0002
> +#define TSC2101_ADCREG_VOLTAGE_STAB_500US		0x0004
> +#define TSC2101_ADCREG_VOLTAGE_STAB_1MS			0x0006
> +#define TSC2101_ADCREG_VOLTAGE_STAB_5MS			0x0008
> +#define TSC2101_ADCREG_VOLTAGE_STAB_10MS		0x000A
> +#define TSC2101_ADCREG_VOLTAGE_STAB_50MS		0x000C
> +#define TSC2101_ADCREG_VOLTAGE_STAB_100MS		0x000E
> +
> +#define TSC2101_ADCREG_STOP_CONVERSION			0x4000
> +
> +#define TSC2101_STATUSREG_DAV				0x4000
> +#define TSC2101_PROGREG_DELAY				0x0900
> +
> +#define MAX_12BIT					((1 << 12) - 1)
> +
> +struct tsc2101_ts {
> +	struct input_dev	*idev;
> +	char			phys[32];
> +	struct timer_list	timer;
> +	spinlock_t		lock;
> +
> +	struct spi_transfer	read_xfer[2];
> +	struct spi_message	read_msg;
> +	u32			address[4];
> +	u32                     data[4];
> +
> +	int			hw_avg_max;
> +	u16			x;
> +	u16			y;
> +	u16			p;
> +	int			sample_cnt;
> +
> +	int			ignore_last : 1;
> +	u16			x_plate_ohm;
> +	int			stab_time;
> +	int			max_pressure;
> +	int			touch_pressure;
> +	int			pressure_limit;
> +
> +	u16			irq_enabled:1;
> +	u16			pen_down:1;
> +	u16			disabled:1;
> +	u16			pending:1;
> +
> +	int			hw_flags;
> +
> +	s16			dav_gpio;
> +	int			irq;
> +};
> +
> +
> +static const u32 tsc2101_ts_read_data = ((0x8000 | TSC2101_REG_X) << 16) ;
> +
> +static int tsc2101_ts_check_config(struct tsc2101_ts *ts, int *hw_flags)
> +{
> +	int flags;
> +
> +	flags = 0;
> +	switch (ts->hw_avg_max) {
> +	case 0:
> +		flags |= TSC2101_ADCREG_AVERAGING_NONE;
> +		break;
> +	case 4:
> +		flags |= TSC2101_ADCREG_AVERAGING_4AVG;
> +		break;
> +	case 8:
> +		flags |= TSC2101_ADCREG_AVERAGING_8AVG;
> +		break;
> +	case 16:
> +		flags |= TSC2101_ADCREG_AVERAGING_16AVG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (ts->stab_time) {
> +	case 0:
> +		flags |= TSC2101_ADCREG_VOLTAGE_STAB_0US;
> +		break;
> +	case 100:
> +		flags |= TSC2101_ADCREG_VOLTAGE_STAB_100US;
> +		break;
> +	case 500:
> +		flags |= TSC2101_ADCREG_VOLTAGE_STAB_500US;
> +		break;
> +	case 1000:
> +		flags |= TSC2101_ADCREG_VOLTAGE_STAB_1MS;
> +		break;
> +	case 5000:
> +		flags |= TSC2101_ADCREG_VOLTAGE_STAB_5MS;
> +		break;
> +	case 10000:
> +		flags |= TSC2101_ADCREG_VOLTAGE_STAB_10MS;
> +		break;
> +	case 50000:
> +		flags |= TSC2101_ADCREG_VOLTAGE_STAB_50MS;
> +		break;
> +	case 100000:
> +		flags |= TSC2101_ADCREG_VOLTAGE_STAB_100MS;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	*hw_flags = flags;
> +	return 0;
> +}
> +
> +static int tsc2101_ts_configure(struct tsc2101 *tsc, int flags)
> +{
> +	struct spi_transfer xfer[6];
> +	struct spi_transfer *x;
> +	struct spi_message m;
> +	int reg;
> +	u32 val, adc_val;
> +	u32 data[6];
> +
> +	/*
> +	 * TSC2101-controlled conversions
> +	 * 12-bit samples
> +	 * continuous X,Y,Z1,Z2 scan mode
> +	 * average (mean) 16 samples per coordinate
> +	 * 1 MHz internal conversion clock
> +	 * 500 usec panel voltage stabilization delay
> +	 * => 0x8bf4
> +	 */
> +	/* Averaging and voltage stabilization settings in flags */
> +	adc_val = TSC2101_ADCREG_CONVERSION_CTRL_BY_TSC2101 |
> +		TSC2101_ADCREG_FUNCTION_XYZ |
> +		TSC2101_ADCREG_RESOLUTION_12BIT |
> +		TSC2101_ADCREG_CLOCK_1MHZ |
> +		flags;
> +
> +	/* Now we prepare the command for transferring */
> +	/* Use internal reference clock */
> +	reg = TSC2101_REG_REF;
> +	val = 0x0016;
> +	data[0] = (reg << 16) | val;
> +
> +	reg = TSC2101_REG_CONFIG;
> +	val = 0x0008;
> +	data[1] = (reg << 16) | val;
> +
> +	reg = TSC2101_REG_BUFFER;
> +	val = 0x0;
> +	data[2] = (reg << 16) | val;
> +
> +	reg = TSC2101_REG_PROG_DELAY;
> +	val = 0x0900;
> +	data[3] = (reg << 16) | val;
> +
> +	reg = TSC2101_REG_STATUS;
> +	val = TSC2101_STATUSREG_DAV;
> +	data[4] = (reg << 16) | val;
> +
> +	reg = TSC2101_REG_ADC;
> +	data[5] = (reg << 16) | adc_val;
> +
> +	spi_message_init(&m);
> +	m.spi = tsc->spi;
> +
> +	memset(xfer, 0, sizeof(xfer));
> +	x = &xfer[0];
> +
> +	x->tx_buf = &data[0];
> +	x->len = 4;
> +	x->cs_change = 1;
> +	spi_message_add_tail(x, &m);
> +
> +	x++;
> +	x->tx_buf = &data[1];
> +	x->len = 4;
> +	x->cs_change = 1;
> +	spi_message_add_tail(x, &m);
> +
> +	x++;
> +	x->tx_buf = &data[2];
> +	x->len = 4;
> +	spi_message_add_tail(x, &m);
> +
> +	x++;
> +	x->tx_buf = &data[3];
> +	x->len = 4;
> +	spi_message_add_tail(x, &m);
> +
> +	x++;
> +	x->tx_buf = &data[4];
> +	x->len = 4;
> +	spi_message_add_tail(x, &m);
> +
> +	x++;
> +	x->tx_buf = &data[5];
> +	x->len = 4;
> +	spi_message_add_tail(x, &m);
> +
> +	spi_sync(m.spi, &m);
> +
> +	return 0;
> +}
> +
> +static void tsc2101_ts_start_scan(struct tsc2101 *tsc)
> +{
> +	tsc2101_ts_configure(tsc, tsc->ts->hw_flags);
> +}
> +
> +static void tsc2101_ts_stop_scan(struct tsc2101 *tsc)
> +{
> +	tsc2101_ts_configure(tsc, TSC2101_ADCREG_STOP_CONVERSION);
> +}
> +
> +static int device_suspended(struct device *dev)
> +{
> +	struct tsc2101 *tsc = dev_get_drvdata(dev);
> +	return dev->power.power_state.event != PM_EVENT_ON || tsc->ts->disabled;
> +}
> +
> +static void update_pen_state(struct tsc2101_ts *ts, int x, int y, int pressure)
> +{
> +	int sync = 0;
> +
> +	if (pressure) {
> +		input_report_abs(ts->idev, ABS_X, x);
> +		input_report_abs(ts->idev, ABS_Y, y);
> +		input_report_abs(ts->idev, ABS_PRESSURE, pressure);
> +		if (!ts->pen_down)
> +			input_report_key(ts->idev, BTN_TOUCH, 1);
> +		sync = 1;
> +	} else if (ts->pen_down) {
> +		input_report_abs(ts->idev, ABS_PRESSURE, 0);
> +		input_report_key(ts->idev, BTN_TOUCH, 0);
> +		sync = 1;
> +	}
> +
> +	if (sync)
> +		input_sync(ts->idev);
> +
> +	ts->pen_down = pressure ? 1 : 0;
> +#ifdef VERBOSE
> +	dev_dbg(&tsc->spi->dev, "x %4d y %4d p %4d\n", x, y, pressure);
> +#endif
> +}
> +
> +/*
> + * This procedure is called by the SPI framework after the coordinates
> + * have been read from TSC2101
> + */
> +static void tsc2101_ts_rx(void *arg)
> +{
> +	struct tsc2101 *tsc = arg;
> +	struct tsc2101_ts *ts = tsc->ts;
> +	unsigned int x, y, z1, z2, pressure;
> +
> +	x  = ts->data[0] & 0xffff;
> +	y  = ts->data[1] & 0xffff;
> +	z1 = ts->data[2] & 0xffff;
> +	z2 = ts->data[3] & 0xffff;
> +
> +	if (z1) {
> +		pressure = ts->x_plate_ohm * x;
> +		pressure /= 4096;
> +		pressure *= z2 - z1;
> +		pressure /= z1;
> +	} else
> +		pressure = 0;
> +
> +	/* If pressure value is above a preset limit (pen is barely
> +	 * touching the screen) we can't trust the coordinate values.
> +	 */
> +	if (pressure < ts->pressure_limit && x < MAX_12BIT && y < MAX_12BIT) {
> +		ts->pressure_limit = ts->max_pressure;
> +		if (ts->ignore_last) {
> +			if (ts->sample_cnt)
> +				update_pen_state(ts, ts->x, ts->y, ts->p);
> +			ts->x = x;
> +			ts->y = y;
> +			ts->p = pressure;
> +		} else
> +			update_pen_state(ts, x, y, pressure);
> +		ts->sample_cnt++;
> +	}
> +
> +	mod_timer(&ts->timer,
> +		  jiffies + msecs_to_jiffies(TSC2101_TS_SCAN_TIME));
> +}
> +
> +static int is_pen_down(struct tsc2101_ts *ts)
> +{
> +	return ts->pen_down;
> +}
> +
> +/*
> + * Timer is called every TSC2101_TS_SCAN_TIME when the pen is down
> + */
> +static void tsc2101_ts_timer(unsigned long arg)
> +{
> +	struct tsc2101 *tsc = (void *) arg;
> +	struct tsc2101_ts *ts = tsc->ts;
> +	unsigned long flags;
> +	int ndav;
> +	int r;
> +
> +	spin_lock_irqsave(&ts->lock, flags);
> +	ndav = omap_get_gpio_datain(ts->dav_gpio);
> +	if (ndav || device_suspended(&tsc->spi->dev)) {
> +		/* Pen has been lifted */
> +		if (!device_suspended(&tsc->spi->dev)) {
> +			ts->irq_enabled = 1;
> +			enable_irq(ts->irq);
> +		}
> +		update_pen_state(ts, 0, 0, 0);
> +		ts->pending = 0;
> +		spin_unlock_irqrestore(&ts->lock, flags);
> +
> +	} else {
> +		ts->pen_down = 1;
> +		spin_unlock_irqrestore(&ts->lock, flags);
> +
> +		r = spi_async(tsc->spi, &ts->read_msg);
> +		if (r)
> +			dev_err(&tsc->spi->dev, "ts: spi_async() failed");
> +	}
> +}
> +
> +/*
> + * This interrupt is called when pen is down and first coordinates are
> + * available. That is indicated by a falling edge on DEV line.  IRQ is
> + * disabled here because while the pen is down the coordinates are
> + * read by a timer.
> + */
> +static irqreturn_t tsc2101_ts_irq_handler(int irq, void *dev_id)
> +{
> +	struct tsc2101 *tsc = dev_id;
> +	struct tsc2101_ts *ts = tsc->ts;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ts->lock, flags);
> +	if (ts->irq_enabled) {
> +		ts->irq_enabled = 0;
> +		disable_irq(ts->irq);
> +		ts->pending = 1;
> +		ts->pressure_limit = ts->touch_pressure;
> +		ts->sample_cnt = 0;
> +		mod_timer(&ts->timer,
> +			  jiffies + msecs_to_jiffies(TSC2101_TS_SCAN_TIME));
> +	}
> +	spin_unlock_irqrestore(&ts->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Must be called with ts->lock held */
> +static void tsc2101_ts_disable(struct tsc2101 *tsc)
> +{
> +	struct tsc2101_ts *ts = tsc->ts;
> +
> +	if (ts->disabled)
> +		return;
> +
> +	ts->disabled = 1;
> +	if (!ts->pending) {
> +		ts->irq_enabled = 0;
> +		disable_irq(ts->irq);
> +	} else {
> +		while (ts->pending) {
> +			spin_unlock_irq(&ts->lock);
> +			msleep(1);
> +			spin_lock_irq(&ts->lock);
> +		}
> +	}
> +
> +	spin_unlock_irq(&ts->lock);
> +	tsc2101_ts_stop_scan(tsc);
> +	spin_lock_irq(&ts->lock);
> +}
> +
> +static void tsc2101_ts_enable(struct tsc2101 *tsc)
> +{
> +	struct tsc2101_ts *ts = tsc->ts;
> +
> +	if (!ts->disabled)
> +		return;
> +
> +	ts->disabled = 0;
> +	ts->irq_enabled = 1;
> +	enable_irq(ts->irq);
> +
> +	spin_unlock_irq(&ts->lock);
> +	tsc2101_ts_start_scan(tsc);
> +	spin_lock_irq(&ts->lock);
> +}
> +
> +#ifdef CONFIG_PM
> +int tsc2101_ts_suspend(struct tsc2101 *tsc)
> +{
> +	struct tsc2101_ts *ts = tsc->ts;
> +
> +	spin_lock_irq(&ts->lock);
> +	tsc2101_ts_disable(tsc);
> +	spin_unlock_irq(&ts->lock);
> +
> +	return 0;
> +}
> +
> +void tsc2101_ts_resume(struct tsc2101 *tsc)
> +{
> +	struct tsc2101_ts *ts = tsc->ts;
> +
> +	spin_lock_irq(&ts->lock);
> +	tsc2101_ts_enable(tsc);
> +	spin_unlock_irq(&ts->lock);
> +}
> +#endif
> +
> +void tsc2101_ts_prep_for_clk_stop(struct tsc2101 *tsc)
> +{
> +}
> +
> +void tsc2101_ts_cont_after_clk_stop(struct tsc2101 *tsc)
> +{
> +}
> +
> +static void tsc2101_ts_setup_spi_xfer(struct tsc2101 *tsc)
> +{
> +	struct tsc2101_ts *ts = tsc->ts;
> +	struct spi_message *m = &ts->read_msg;
> +	struct spi_transfer *x = &ts->read_xfer[0];
> +
> +	ts->address[0] = (0x8000 | TSC2101_REG_X) << 16;
> +	ts->address[1] = (0x8000 | TSC2101_REG_Y) << 16;
> +	ts->address[2] = (0x8000 | TSC2101_REG_Z1) << 16;
> +	ts->address[3] = (0x8000 | TSC2101_REG_Z2) << 16;
> +
> +	spi_message_init(m);
> +
> +	x->tx_buf = &ts->address;
> +	x->rx_buf = &ts->data;
> +	x->len = 16;
> +	spi_message_add_tail(x, m);
> +
> +	m->complete = tsc2101_ts_rx;
> +	m->context = tsc;
> +}
> +
> +static ssize_t tsc2101_ts_pen_down_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct tsc2101 *tsc = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", is_pen_down(tsc->ts));
> +}
> +
> +static DEVICE_ATTR(pen_down, S_IRUGO, tsc2101_ts_pen_down_show, NULL);
> +
> +static ssize_t tsc2101_ts_disable_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct tsc2101		*tsc = dev_get_drvdata(dev);
> +	struct tsc2101_ts	*ts = tsc->ts;
> +
> +	return sprintf(buf, "%u\n", ts->disabled);
> +}
> +
> +static ssize_t tsc2101_ts_disable_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct tsc2101		*tsc = dev_get_drvdata(dev);
> +	struct tsc2101_ts	*ts = tsc->ts;
> +	char *endp;
> +	int i;
> +
> +	i = simple_strtoul(buf, &endp, 10);
> +	spin_lock_irq(&ts->lock);
> +
> +	if (i)
> +		tsc2101_ts_disable(tsc);
> +	else
> +		tsc2101_ts_enable(tsc);
> +
> +	spin_unlock_irq(&ts->lock);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(disable_ts, 0664, tsc2101_ts_disable_show,
> +		   tsc2101_ts_disable_store);
> +
> +int __devinit tsc2101_ts_init(struct tsc2101 *tsc,
> +			      struct tsc2101_platform_data *pdata)
> +{
> +	struct tsc2101_ts *ts;
> +	struct input_dev *idev;
> +	int dav_gpio, r;
> +
> +	if (pdata->dav_gpio < 0) {
> +		dev_err(&tsc->spi->dev, "need DAV GPIO");
> +		return -EINVAL;
> +	}
> +	dav_gpio = pdata->dav_gpio;
> +
> +	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
> +	if (ts == NULL)
> +		return -ENOMEM;
> +	tsc->ts = ts;
> +
> +	ts->dav_gpio = dav_gpio;
> +#ifdef CONFIG_ARCH_OMAP
> +	r = omap_request_gpio(dav_gpio);
> +	if (r < 0) {
> +		dev_err(&tsc->spi->dev, "unable to get DAV GPIO");
> +		goto err1;
> +	}
> +	omap_set_gpio_direction(dav_gpio, 1);
> +	ts->irq = OMAP_GPIO_IRQ(dav_gpio);
> +#endif
> +	init_timer(&ts->timer);
> +	ts->timer.data = (unsigned long) tsc;
> +	ts->timer.function = tsc2101_ts_timer;
> +
> +	spin_lock_init(&ts->lock);
> +
> +	ts->x_plate_ohm	= pdata->ts_x_plate_ohm ? : 280;
> +	ts->hw_avg_max	= pdata->ts_hw_avg;
> +	ts->max_pressure= pdata->ts_max_pressure ? : MAX_12BIT;
> +	ts->touch_pressure = pdata->ts_touch_pressure ? : ts->max_pressure;
> +	ts->ignore_last	= pdata->ts_ignore_last;
> +	ts->stab_time	= pdata->ts_stab_time;
> +
> +	if ((r = tsc2101_ts_check_config(ts, &ts->hw_flags))) {
> +		dev_err(&tsc->spi->dev, "invalid configuration\n");
> +		goto err2;
> +	}
> +
> +	idev = input_allocate_device();
> +	if (idev == NULL) {
> +		r = -ENOMEM;
> +		goto err2;
> +	}
> +	idev->cdev.dev = &tsc->spi->dev;
> +	idev->name = "TSC2101 touchscreen";
> +	snprintf(ts->phys, sizeof(ts->phys),
> +		 "%s/input-ts", tsc->spi->dev.bus_id);
> +	idev->phys = ts->phys;
> +
> +	idev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
> +	idev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
> +	ts->idev = idev;
> +
> +	tsc2101_ts_setup_spi_xfer(tsc);
> +
> +	/* These parameters should perhaps be configurable? */
> +	input_set_abs_params(idev, ABS_X, 0, 4096, 0, 0);
> +	input_set_abs_params(idev, ABS_Y, 0, 4096, 0, 0);
> +	input_set_abs_params(idev, ABS_PRESSURE, 0, 1024, 0, 0);
> +
> +	tsc2101_ts_start_scan(tsc);
> +
> +	ts->irq_enabled = 1;
> +	r = request_irq(ts->irq, tsc2101_ts_irq_handler,
> +			IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_FALLING,
> +			"tsc2101-ts", tsc);
> +	if (r < 0) {
> +		dev_err(&tsc->spi->dev, "unable to get DAV IRQ");
> +		goto err3;
> +	}
> +	set_irq_wake(ts->irq, 1);
> +
> +	r = device_create_file(&tsc->spi->dev, &dev_attr_pen_down);
> +	r |= device_create_file(&tsc->spi->dev, &dev_attr_disable_ts);
> +	if (r)
> +		goto err4;
> +
> +	r = input_register_device(idev);
> +	if (r < 0) {
> +		dev_err(&tsc->spi->dev, "can't register touchscreen device\n");
> +		goto err5;
> +	}
> +
> +	return 0;
> +err5:
> +	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
> +	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
> +err4:
> +	free_irq(ts->irq, tsc);
> +err3:
> +	tsc2101_ts_stop_scan(tsc);
> +	input_free_device(idev);
> +err2:
> +#ifdef CONFIG_ARCH_OMAP
> +	omap_free_gpio(dav_gpio);
> +#endif
> +err1:
> +	kfree(ts);
> +	return r;
> +}
> +
> +void __devexit tsc2101_ts_exit(struct tsc2101 *tsc)
> +{
> +	struct tsc2101_ts *ts = tsc->ts;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ts->lock, flags);
> +	tsc2101_ts_disable(tsc);
> +	spin_unlock_irqrestore(&ts->lock, flags);
> +
> +	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
> +	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
> +
> +	free_irq(ts->irq, tsc);
> +	input_unregister_device(ts->idev);
> +
> +#ifdef CONFIG_ARCH_OMAP
> +	omap_free_gpio(ts->dav_gpio);
> +#endif
> +	kfree(ts);
> +}
> +MODULE_AUTHOR("Kyungmin Park <kyungmin.park@samsung.com>");
> +MODULE_DESCRIPTION("TSC2101 driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/spi/tsc2101.h b/include/linux/spi/tsc2101.h
> new file mode 100644
> index 0000000..70da08a
> --- /dev/null
> +++ b/include/linux/spi/tsc2101.h
> @@ -0,0 +1,62 @@
> +#ifndef _LINUX_SPI_TSC2101_H
> +#define _LINUX_SPI_TSC2101_H
> +
> +struct tsc2101_platform_data {
> +	/*
> +	 * Touchscreen
> +	 */
> +	s16	dav_gpio;
> +	s16	pen_int_gpio;
> +	u16	ts_x_plate_ohm;
> +	u32	ts_stab_time;	/* voltage settling time */
> +	u8	ts_hw_avg;	/* HW assiseted averaging. Can be
> +				   0, 4, 8, 16 samples per reading */
> +	u32	ts_max_pressure;/* Samples with bigger pressure value will
> +				   be ignored, since the corresponding X, Y
> +				   values are unreliable */
> +	u32	ts_touch_pressure;	/* Pressure limit until we report a
> +					   touch event. After that we switch
> +					   to ts_max_pressure. */
> +	unsigned ts_ignore_last : 1;
> +};
> +
> +struct ts2101_ts;
> +
> +struct tsc2101 {
> +	struct spi_device	*spi;
> +
> +	struct tsc2101_ts	*ts;
> +};
> +
> +#define TSC2101_REG(page, addr)		(((page) << 11) | ((addr) << 5))
> +
> +/* Page 0, Touchscreen data registers */
> +#define TSC2101_REG_X		TSC2101_REG(0, 0)
> +#define TSC2101_REG_Y		TSC2101_REG(0, 1)
> +#define TSC2101_REG_Z1		TSC2101_REG(0, 2)
> +#define TSC2101_REG_Z2		TSC2101_REG(0, 3)
> +#define TSC2101_REG_TEMP1	TSC2101_REG(0, 9)
> +#define TSC2101_REG_TEMP2	TSC2101_REG(0, 10)
> +
> +/* Page 1, Tochscreen control registers */
> +#define TSC2101_REG_ADC		TSC2101_REG(1, 0)
> +#define TSC2101_REG_STATUS	TSC2101_REG(1, 1)
> +#define TSC2101_REG_BUFFER	TSC2101_REG(1, 2)
> +#define TSC2101_REG_REF		TSC2101_REG(1, 3)
> +#define TSC2101_REG_CONFIG	TSC2101_REG(1, 5)
> +#define TSC2101_REG_PROG_DELAY	TSC2101_REG(1, 13)
> +
> +/* Page 2, Audio control registers */
> +#define TSC2101_REG_AUDIO1	TSC2101_REG(2, 0)
> +#define TSC2101_REG_DAC_GAIN	TSC2101_REG(2, 2)
> +#define TSC2101_REG_AUDIO2	TSC2101_REG(2, 4)
> +#define TSC2101_REG_DAC_POWER	TSC2101_REG(2, 5)
> +#define TSC2101_REG_AUDIO3	TSC2101_REG(2, 6)
> +#define TSC2101_REG_PLL1	TSC2101_REG(2, 27)
> +#define TSC2101_REG_PLL2	TSC2101_REG(2, 28)
> +#define TSC2101_REG_AUDIO4	TSC2101_REG(2, 29)
> +
> +int tsc2101_ts_init(struct tsc2101 *, struct tsc2101_platform_data *);
> +void tsc2101_ts_exit(struct tsc2101 *);
> +
> +#endif
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>   
