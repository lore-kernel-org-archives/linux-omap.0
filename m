From: "Komal Shah" <komal.shah802003@gmail.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: TSC2046 touchscreen support for 2430
Date: Sat, 5 May 2007 13:58:39 +0530
Message-ID: <3a5b1be00705050128m7de63c62hc5f1c34eb1f91613@mail.gmail.com>
References: <20070504214028.649198901@mvista.com>
	<20070504214039.632228613@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070504214039.632228613@mvista.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kevin,

On 5/5/07, Kevin Hilman <khilman@mvista.com> wrote:
> This is a rework of the tsc2046 driver from TI's tree, based
> on the tsc2301 driver and using the new SPI framework.
>
> Signed-off-by: Kevin Hilman <khilman@mvista.com>

Very small changes required in order to confirm CodingStyle.

...

> +
> +static struct omap2_mcspi_device_config tsc2046_mcspi_config = {
> +       .turbo_mode     = 0,
> +       .single_channel = 0,  /* 0: slave, 1: master */
> +};
> +
> +static struct spi_board_info sdp2430_spi_board_info[] __initdata = {
> +       [0] = {
> +               /* TSC2046 operates at a max freqency of 2MHz, so
> +                * operate slightly below at 1.5MHz */

multi-line comments block should be like this:
/*
 * TSC2046 operates at a max freqency of 2MHz, so
 * operate slightly below at 1.5MHz
 */

> +               .modalias       = "tsc2046",
> +               .bus_num        = 1,
> +               .chip_select    = 0,
> +               .max_speed_hz   = 1500000,
> +               .controller_data= &tsc2046_mcspi_config,

Space before "=".

> +               .platform_data  = &tsc2046_config,
> +       },
> +};
> +

....

> +/*
> + * This procedure is called by the SPI framework after the coordinates
> + * have been read from TSC2046
> + */
> +static void tsc2046_ts_rx(void *arg)
> +{
> +       struct tsc2046 *tsc = arg;
> +       struct tsc2046_ts *ts = tsc->ts;
> +       unsigned int x, y, z1, z2, pressure;
> +
> +       x  = CONV_DATA(ts->data[2], ts->data[3]);
> +       y  = CONV_DATA(ts->data[1], ts->data[2]);
> +       z1 = CONV_DATA(ts->data[3], ts->data[4]);
> +       z2 = CONV_DATA(ts->data[4], 0);
> +
> +       if (z1) {
> +               pressure = ts->x_plate_ohm * x;
> +               pressure /= 4096;
> +               pressure *= z2 - z1;
> +               pressure /= z1;
> +       } else
> +               pressure = 0;
> +
> +       /* If pressure value is above a preset limit (pen is barely
> +        * touching the screen) we can't trust the coordinate values.
> +        */

same here for multi-line comment block style.

> +       if (pressure < ts->pressure_limit && x < MAX_12BIT && y < MAX_12BIT) {
> +               ts->pressure_limit = ts->max_pressure;
> +               if (ts->ignore_last) {
> +                       if (ts->sample_cnt)
> +                               update_pen_state(tsc, ts->x, ts->y, ts->p);
> +                       ts->x = x;
> +                       ts->y = y;
> +                       ts->p = pressure;
> +               } else
> +                       update_pen_state(tsc, x, y, pressure);
> +               ts->sample_cnt++;
> +       }
> +
> +       mod_timer(&ts->timer,
> +                 jiffies + msecs_to_jiffies(TSC2046_TS_SCAN_TIME));
> +}
> +

....

> +
> +int __devinit tsc2046_ts_init(struct tsc2046 *tsc,
> +                             struct tsc2046_platform_data *pdata)
> +{
> +       struct tsc2046_ts *ts;
> +       struct input_dev *idev;
> +       int dav_gpio, r;
> +
> +       if (pdata->dav_gpio < 0) {
> +               dev_err(&tsc->spi->dev, "need DAV GPIO");
> +               return -EINVAL;
> +       }
> +       dav_gpio = pdata->dav_gpio;
> +
> +       ts = kzalloc(sizeof(*ts), GFP_KERNEL);
> +       if (ts == NULL)
> +               return -ENOMEM;
> +       tsc->ts = ts;
> +
> +       ts->dav_gpio = dav_gpio;
> +#ifdef CONFIG_ARCH_OMAP
> +       r = omap_request_gpio(dav_gpio);
> +       if (r < 0) {
> +               dev_err(&tsc->spi->dev, "unable to get DAV GPIO");
> +               goto err1;
> +       }
> +       omap_set_gpio_direction(dav_gpio, 1);
> +       if (pdata->gpio_debounce) {
> +               omap_set_gpio_debounce(tsc->gpio, 1);
> +               omap_set_gpio_debounce_time(tsc->gpio, pdata->gpio_debounce);
> +       }
> +
> +       ts->irq = OMAP_GPIO_IRQ(dav_gpio);
> +#endif
> +       init_timer(&ts->timer);
> +       ts->timer.data = (unsigned long) tsc;
> +       ts->timer.function = tsc2046_ts_timer;

setup_timer ?

> +
> +       spin_lock_init(&ts->lock);
> +
> +       ts->x_plate_ohm = pdata->ts_x_plate_ohm ? : 280;
> +       ts->max_pressure= pdata->ts_max_pressure ? : MAX_12BIT;

space before "=".

> +       ts->touch_pressure = pdata->ts_touch_pressure ? : ts->max_pressure;
> +       ts->ignore_last = pdata->ts_ignore_last;
> +
> +       idev = input_allocate_device();
> +       if (idev == NULL) {
> +               r = -ENOMEM;
> +               goto err2;
> +       }
> +       idev->name = "TSC2046 touchscreen";
> +       snprintf(ts->phys, sizeof(ts->phys),
> +                "%s/input-ts", tsc->spi->dev.bus_id);
> +       idev->phys = ts->phys;
> +
> +       idev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
> +       idev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
> +       ts->idev = idev;
> +
> +       tsc2046_ts_setup_spi_xfer(tsc);
> +
> +       /* These parameters should perhaps be configurable? */
> +       input_set_abs_params(idev, ABS_X, 0, 4096, 0, 0);
> +       input_set_abs_params(idev, ABS_Y, 0, 4096, 0, 0);
> +       input_set_abs_params(idev, ABS_PRESSURE, 0, 1024, 0, 0);
> +
> +       ts->irq_enabled = 1;
> +       r = request_irq(ts->irq, tsc2046_ts_irq_handler,
> +                       SA_SAMPLE_RANDOM | SA_TRIGGER_FALLING,
> +                       "tsc2046-ts", tsc);

deprecated SA_* flags.

> +       if (r < 0) {
> +               dev_err(&tsc->spi->dev, "unable to get DAV IRQ");
> +               goto err3;
> +       }
> +       set_irq_wake(ts->irq, 1);
> +
> +       if (device_create_file(&tsc->spi->dev, &dev_attr_pen_down) < 0)
> +               goto err4;
> +       if (device_create_file(&tsc->spi->dev, &dev_attr_disable_ts) < 0)
> +               goto err5;
> +
> +       r = input_register_device(idev);
> +       if (r < 0) {
> +               dev_err(&tsc->spi->dev, "can't register touchscreen device\n");
> +               goto err6;
> +       }
> +
> +       /* kick off a transaction to enable pen interrupts */
> +       spi_async(tsc->spi, &ts->read_msg);
> +
> +       return 0;
> +err6:
> +       device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
> +err5:
> +       device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
> +err4:
> +       free_irq(ts->irq, tsc);
> +err3:
> +       input_free_device(idev);
> +err2:
> +#ifdef CONFIG_ARCH_OMAP
> +       omap_free_gpio(dav_gpio);
> +#endif
> + err1:
> +       kfree(ts);
> +       return r;
> +}
> +EXPORT_SYMBOL(tsc2046_ts_init);
> +
> +void __devexit tsc2046_ts_exit(struct tsc2046 *tsc)
> +{
> +       struct tsc2046_ts *ts = tsc->ts;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&ts->lock, flags);
> +       tsc2046_ts_disable(tsc);
> +       spin_unlock_irqrestore(&ts->lock, flags);
> +
> +       device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
> +       device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
> +
> +       free_irq(ts->irq, tsc);
> +       input_unregister_device(ts->idev);
> +
> +#ifdef CONFIG_ARCH_OMAP
> +       omap_free_gpio(ts->dav_gpio);
> +#endif
> +       kfree(ts);
> +}
> +EXPORT_SYMBOL(tsc2046_ts_exit);
> +
> +
> +static int __devinit tsc2046_probe(struct spi_device *spi)
> +{
> +       struct tsc2046                  *tsc;
> +       struct tsc2046_platform_data    *pdata = spi->dev.platform_data;
> +       int r = -ENODEV;
> +
> +       dev_dbg(&spi->dev, "%s\n", __FUNCTION__);
> +
> +       if (!pdata) {
> +               dev_dbg(&spi->dev, "no platform data?\n");
> +               return -ENODEV;
> +       }
> +
> +       tsc = kzalloc(sizeof(*tsc), GFP_KERNEL);
> +       if (tsc == NULL)
> +               return -ENOMEM;
> +
> +       dev_set_drvdata(&spi->dev, tsc);
> +       tsc->spi = spi;
> +       spi->dev.power.power_state = PMSG_ON;
> +
> +       spi->mode = SPI_MODE_1;
> +       spi->bits_per_word = 16;
> +
> +       /* The max speed might've been defined by the board-specific
> +        * struct */

same comment for multi-line comments style as pointed earlier.

> +       if (!spi->max_speed_hz)
> +               spi->max_speed_hz = TSC2046_HZ;
> +       spi_setup(spi);
> +
> +       r = tsc2046_ts_init(tsc, pdata);
> +       if (r)
> +               goto err1;
> +
> +       return 0;
> + err1:
> +       kfree(tsc);
> +       return r;
> +}
> +
> +static int __devexit tsc2046_remove(struct spi_device *spi)
> +{
> +       struct tsc2046 *tsc = dev_get_drvdata(&spi->dev);
> +
> +       dev_dbg(&tsc->spi->dev, "%s\n", __FUNCTION__);
> +
> +        tsc2046_ts_exit(tsc);

This doesn't look to me a tab.

> +       kfree(tsc);
> +
> +       return 0;
> +}

-- 
---Komal Shah
http://komalshah.blogspot.com
