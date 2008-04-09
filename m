From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 3/5] INPUT: TOUCHSCREEN: Introduce tsc2005 driver
Date: Wed, 9 Apr 2008 14:17:48 +0300
Message-ID: <a0580c510804090417t34bdbe66ge7a83c7e58b7c8f7@mail.gmail.com>
References: <1207735452-989-1-git-send-email-felipe.balbi@nokia.com>
	 <1207735452-989-2-git-send-email-felipe.balbi@nokia.com>
	 <1207735452-989-3-git-send-email-felipe.balbi@nokia.com>
	 <1207735452-989-4-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:18973 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbYDILRv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 07:17:51 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2103070wra.1
        for <linux-omap@vger.kernel.org>; Wed, 09 Apr 2008 04:17:49 -0700 (PDT)
In-Reply-To: <1207735452-989-4-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Lauri Leukkunen <lauri.leukkunen@nokia.com>

Hi Balbi and Lauri,

Again, a few style problems from checkpatch.
ERROR: spaces required around that '=' (ctx:VxW)
#131: FILE: arch/arm/mach-omap2/board-n800.c:418:
+               .controller_data= &mipid_mcspi_config,
                                ^

ERROR: spaces required around that '=' (ctx:VxW)
#139: FILE: arch/arm/mach-omap2/board-n800.c:426:
+               .controller_data= &cx3110x_mcspi_config,
                                ^

ERROR: spaces required around that '=' (ctx:VxW)
#146: FILE: arch/arm/mach-omap2/board-n800.c:433:
+               .controller_data= &tsc2005_mcspi_config,
                                ^

ERROR: spaces required around that '=' (ctx:VxW)
#162: FILE: arch/arm/mach-omap2/board-n800.c:449:
+                       tsc2005_config.ts_touch_pressure= 1500;
                                                        ^

ERROR: spaces required around that '=' (ctx:VxW)
#165: FILE: arch/arm/mach-omap2/board-n800.c:452:
+                       tsc2005_config.ts_pressure_fudge= 2;
                                                        ^

ERROR: spaces required around that '=' (ctx:VxW)
#174: FILE: arch/arm/mach-omap2/board-n800.c:461:
+                       tsc2005_config.ts_touch_pressure= 1500;
                                                        ^

ERROR: spaces required around that '=' (ctx:VxW)
#177: FILE: arch/arm/mach-omap2/board-n800.c:464:
+                       tsc2005_config.ts_pressure_fudge= 2;
                                                        ^

WARNING: braces {} are not necessary for single statement blocks
#531: FILE: drivers/input/touchscreen/tsc2005.c:274:
+               if (ts->pen_down) {
+                       input_report_key(ts->idev, BTN_TOUCH, 0);
+               }

ERROR: trailing statements should be on next line
#644: FILE: drivers/input/touchscreen/tsc2005.c:387:
+       if (ts->spi_active) return IRQ_HANDLED;

ERROR: space prohibited before that close parenthesis ')'
#667: FILE: drivers/input/touchscreen/tsc2005.c:410:
+       for (i = 0; i < NUM_READ_REGS; i++, x++ ) {

WARNING: braces {} are not necessary for single statement blocks
#714: FILE: drivers/input/touchscreen/tsc2005.c:457:
+       if (ts->disable_depth++ != 0) {
+               return;
+       }

WARNING: braces {} are not necessary for single statement blocks
#729: FILE: drivers/input/touchscreen/tsc2005.c:472:
+       if (--ts->disable_depth != 0) {
+               return;
+       }

WARNING: consider using strict_strtoul in preference to simple_strtoul
#753: FILE: drivers/input/touchscreen/tsc2005.c:496:
+       i = simple_strtoul(buf, &endp, 10);

ERROR: trailing statements should be on next line
#757: FILE: drivers/input/touchscreen/tsc2005.c:500:
+       if (i == tsc->disabled) goto out;

WARNING: printk() should include KERN_ facility level
#980: FILE: drivers/input/touchscreen/tsc2005.c:723:
+       printk("TSC2005 driver initializing\n");

total: 10 errors, 5 warnings, 924 lines checked

lauri.diff has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.


On Wed, Apr 9, 2008 at 1:04 PM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> From: Lauri Leukkunen <lauri.leukkunen@nokia.com>

<snip>
>   static struct spi_board_info n800_spi_board_info[] __initdata = {
>  -       [0] = {
>  +       {
>                 .modalias       = "lcd_mipid",
>                 .bus_num        = 1,
>                 .chip_select    = 1,
>                 .max_speed_hz   = 4000000,
>                 .controller_data= &mipid_mcspi_config,
>                 .platform_data  = &n800_mipid_platform_data,
>  -       }, [1] = {
>  +       }, {
>                 .modalias       = "cx3110x",
>                 .bus_num        = 2,
>                 .chip_select    = 0,
>                 .max_speed_hz   = 48000000,
>                 .controller_data= &cx3110x_mcspi_config,
>  -       }, [2] = {
>  +       },
>  +       {
>                 .modalias       = "tsc2301",
>                 .bus_num        = 1,
>                 .chip_select    = 0,
>  @@ -395,6 +409,73 @@ static struct spi_board_info n800_spi_board_info[] __initdata = {
>         },
>   };
>
>  +static struct spi_board_info n810_spi_board_info[] __initdata = {
>  +       {
>  +               .modalias       = "lcd_mipid",
>  +               .bus_num        = 1,
>  +               .chip_select    = 1,
>  +               .max_speed_hz   = 4000000,
>  +               .controller_data= &mipid_mcspi_config,
>  +               .platform_data  = &n800_mipid_platform_data,
>  +       },
>  +       {
>  +               .modalias       = "cx3110x",
>  +               .bus_num        = 2,
>  +               .chip_select    = 0,
>  +               .max_speed_hz   = 48000000,
>  +               .controller_data= &cx3110x_mcspi_config,
>  +       },
>  +       {
>  +               .modalias       = "tsc2005",
>  +               .bus_num        = 1,
>  +               .chip_select    = 0,
>  +               .max_speed_hz   = 6000000,
>  +               .controller_data= &tsc2005_mcspi_config,
>  +               .platform_data  = &tsc2005_config,
>  +       },
>  +};
>  +

What does the above changes have to do with tsc2005 driver?

>  +static void __init tsc2005_set_config(void)

<snip>

>  +
>  +#ifdef CONFIG_ARCH_OMAP
>  +       r = omap_request_gpio(dav_gpio);
>  +       if (r < 0) {
>  +               dev_err(&ts->spi->dev, "unable to get DAV GPIO");
>  +               goto err1;
>  +       }
>  +       omap_set_gpio_direction(dav_gpio, 1);
>  +       ts->irq = OMAP_GPIO_IRQ(dav_gpio);
>  +       dev_dbg(&ts->spi->dev, "TSC2005: DAV IRQ = %d\n", ts->irq);
>  +#endif

Shouldn't this go to board files?

>  +       init_timer(&ts->penup_timer);
>  +       setup_timer(&ts->penup_timer, tsc2005_ts_penup_timer_handler,
>  +                       (unsigned long)ts);
>  +
>  +       spin_lock_init(&ts->lock);
>  +       mutex_init(&ts->mutex);
>  +
>  +       ts->x_plate_ohm         = pdata->ts_x_plate_ohm ? : 280;
>  +       ts->hw_avg_max          = pdata->ts_hw_avg;
>  +       ts->stab_time           = pdata->ts_stab_time;
>  +       x_max                   = pdata->ts_x_max ? : 4096;
>  +       x_fudge                 = pdata->ts_x_fudge ? : 4;
>  +       y_max                   = pdata->ts_y_max ? : 4096;
>  +       y_fudge                 = pdata->ts_y_fudge ? : 8;
>  +       ts->p_max               = pdata->ts_pressure_max ? : MAX_12BIT;
>  +       ts->touch_pressure      = pdata->ts_touch_pressure ? : ts->p_max;
>  +       p_fudge                 = pdata->ts_pressure_fudge ? : 2;
>  +
>  +       idev = input_allocate_device();
>  +       if (idev == NULL) {
>  +               r = -ENOMEM;
>  +               goto err2;
>  +       }
>  +
>  +       /*
>  +        * TODO: should be "TSC2005 touchscreen", but X has hardcoded these
>  +        * strings and doesn't accept TSC2005 yet...
>  +        */
>  +       idev->name = "TSC2301 touchscreen";
>  +       snprintf(ts->phys, sizeof(ts->phys), "%s/input-ts",
>  +                ts->spi->dev.bus_id);
>  +       idev->phys = ts->phys;
>  +
>  +       idev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
>  +       idev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
>  +       ts->idev = idev;
>  +
>  +       tsc2005_ts_setup_spi_xfer(ts);
>  +
>  +       input_set_abs_params(idev, ABS_X, 0, x_max, x_fudge, 0);
>  +       input_set_abs_params(idev, ABS_Y, 0, y_max, y_fudge, 0);
>  +       input_set_abs_params(idev, ABS_PRESSURE, 0, ts->p_max, p_fudge, 0);
>  +
>  +       tsc2005_start_scan(ts);
>  +
>  +       r = request_irq(ts->irq, tsc2005_ts_irq_handler,
>  +                       IRQF_TRIGGER_FALLING | IRQF_DISABLED |
>  +                       IRQF_SAMPLE_RANDOM, "tsc2005", ts);
>  +       if (r < 0) {
>  +               dev_err(&ts->spi->dev, "unable to get DAV IRQ");
>  +               goto err3;
>  +       }
>  +
>  +       set_irq_wake(ts->irq, 1);
>  +
>  +       r = input_register_device(idev);
>  +       if (r < 0) {
>  +               dev_err(&ts->spi->dev, "can't register touchscreen device\n");
>  +               goto err4;
>  +       }
>  +
>  +       /* We can tolerate these failing */
>  +       if (device_create_file(&ts->spi->dev, &dev_attr_pen_down));
>  +       if (device_create_file(&ts->spi->dev, &dev_attr_disable_ts));
>  +
>  +       return 0;
>  +err4:
>  +       free_irq(ts->irq, ts);
>  +err3:
>  +       tsc2005_stop_scan(ts);
>  +       input_free_device(idev);
>  +err2:
>  +#ifdef CONFIG_ARCH_OMAP
>  +       omap_free_gpio(dav_gpio);
>  +#endif
>  +err1:
>  +       return r;
>  +}
>  +
>  +static int __devinit tsc2005_probe(struct spi_device *spi)
>  +{
>  +       struct tsc2005                  *tsc;
>  +       struct tsc2005_platform_data    *pdata = spi->dev.platform_data;
>  +       int r;
>  +
>  +       if (!pdata) {
>  +               dev_dbg(&spi->dev, "no platform data?\n");
>  +               return -ENODEV;
>  +       }
>  +
>  +       tsc = kzalloc(sizeof(*tsc), GFP_KERNEL);
>  +       if (tsc == NULL)
>  +               return -ENOMEM;
>  +
>  +       dev_set_drvdata(&spi->dev, tsc);
>  +       tsc->spi = spi;
>  +       spi->dev.power.power_state = PMSG_ON;
>  +
>  +       spi->mode = SPI_MODE_0;
>  +       spi->bits_per_word = 8;
>  +       /* The max speed might've been defined by the board-specific
>  +        * struct */
>  +       if (!spi->max_speed_hz)
>  +               spi->max_speed_hz = TSC2005_HZ;
>  +
>  +       spi_setup(spi);
>  +
>  +       r = tsc2005_ts_init(tsc, pdata);
>  +       if (r)
>  +               goto err1;
>  +
>  +       return 0;
>  +
>  +err1:
>  +       kfree(tsc);
>  +       return r;
>  +}
>  +
>  +static int __devexit tsc2005_remove(struct spi_device *spi)
>  +{
>  +       struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
>  +       unsigned long flags;
>  +
>  +       spin_lock_irqsave(&ts->lock, flags);
>  +       tsc2005_disable(ts);
>  +       spin_unlock_irqrestore(&ts->lock, flags);
>  +
>  +       device_remove_file(&ts->spi->dev, &dev_attr_disable_ts);
>  +       device_remove_file(&ts->spi->dev, &dev_attr_pen_down);
>  +
>  +       free_irq(ts->irq, ts);
>  +       input_unregister_device(ts->idev);
>  +
>  +#ifdef CONFIG_ARCH_OMAP
>  +       omap_free_gpio(ts->dav_gpio);
>  +#endif
>  +       kfree(ts);
>  +
>  +       return 0;
>  +}
>  +
>  +#ifdef CONFIG_PM
>  +static int tsc2005_suspend(struct spi_device *spi, pm_message_t mesg)
>  +{
>  +       struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
>  +
>  +       mutex_lock(&ts->mutex);
>  +       tsc2005_disable(ts);
>  +       mutex_unlock(&ts->mutex);
>  +
>  +       return 0;
>  +}
>  +
>  +static int tsc2005_resume(struct spi_device *spi)
>  +{
>  +       struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
>  +
>  +       mutex_lock(&ts->mutex);
>  +       tsc2005_enable(ts);
>  +       mutex_unlock(&ts->mutex);
>  +
>  +       return 0;
>  +}
>  +#endif
>  +
>  +static struct spi_driver tsc2005_driver = {
>  +       .driver = {
>  +               .name = "tsc2005",
>  +               .bus = &spi_bus_type,
>  +               .owner = THIS_MODULE,
>  +       },
>  +#ifdef CONFIG_PM
>  +       .suspend = tsc2005_suspend,
>  +       .resume = tsc2005_resume,
>  +#endif
>  +       .probe = tsc2005_probe,
>  +       .remove = __devexit_p(tsc2005_remove),
>  +};
>  +
>  +static int __init tsc2005_init(void)
>  +{
>  +       printk("TSC2005 driver initializing\n");
>  +
>  +       return spi_register_driver(&tsc2005_driver);
>  +}
>  +module_init(tsc2005_init);
>  +
>  +static void __exit tsc2005_exit(void)
>  +{
>  +       spi_unregister_driver(&tsc2005_driver);
>  +}
>  +module_exit(tsc2005_exit);
>  +
>  +MODULE_AUTHOR("Lauri Leukkunen <lauri.leukkunen@nokia.com>");
>  +MODULE_LICENSE("GPL");
>  +
>  diff --git a/include/linux/spi/tsc2005.h b/include/linux/spi/tsc2005.h
>  new file mode 100644
>  index 0000000..dbc01f7
>  --- /dev/null
>  +++ b/include/linux/spi/tsc2005.h
>  @@ -0,0 +1,29 @@
>  +#ifndef _LINUX_SPI_TSC2005_H
>  +#define _LINUX_SPI_TSC2005_H
>  +
>  +#include <linux/types.h>
>  +
>  +struct tsc2005_platform_data {
>  +       s16     reset_gpio;
>  +       s16     dav_gpio;
>  +       s16     pen_int_gpio;
>  +       u16     ts_x_plate_ohm;
>  +       u32     ts_stab_time;   /* voltage settling time */
>  +       u8      ts_hw_avg;      /* HW assiseted averaging. Can be
>  +                                  0, 4, 8, 16 samples per reading */
>  +       u32     ts_touch_pressure;      /* Pressure limit until we report a
>  +                                          touch event. After that we switch
>  +                                          to ts_max_pressure. */
>  +       u32     ts_pressure_max;/* Samples with bigger pressure value will
>  +                                  be ignored, since the corresponding X, Y
>  +                                  values are unreliable */
>  +       u32     ts_pressure_fudge;
>  +       u32     ts_x_max;
>  +       u32     ts_x_fudge;
>  +       u32     ts_y_max;
>  +       u32     ts_y_fudge;
>  +
>  +       unsigned ts_ignore_last : 1;
>  +};
>  +
>  +#endif
>  --
>  1.5.5.rc3
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Eduardo Bezerra Valentin
