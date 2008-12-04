From: "Pillai, Manikandan" <mani.pillai@ti.com>
Subject: RE: [PATCH 2/2] Putting TPS6235x into the power regulator framework
Date: Thu, 4 Dec 2008 17:05:26 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E90E7238@dbde02.ent.ti.com>
References: <20081204111909.GN10209@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57943 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680AbYLDLfn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 06:35:43 -0500
In-Reply-To: <20081204111909.GN10209@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Pls find comments inlined.

regards


-----Original Message-----
From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
Sent: Thursday, December 04, 2008 4:49 PM
To: ext y@india.ti.com
Cc: linux-omap@vger.kernel.org; Pillai, Manikandan
Subject: Re: [PATCH 2/2] Putting TPS6235x into the power regulator framework

On Thu, Dec 04, 2008 at 03:55:06PM +0530, ext y@india.ti.com wrote:
> From: Manikandan Pillai <mani.pillai@ti.com>
>
> Resending this patch with comments fixed :
> This patch moves the TPS6235x drivers from the drivers/i2c to drivers/
> regulator to put the TPS6235x drivers under the power regulator framework
>
> suffix core_pwr and mpu_pwr has been removed
> I2C bus speeds replaced with numbers again
> Camel case has been removed
> TPS moved into regulator framework and drivers/i2c/chips left untouched.
>
> Not fixed comments:
> Not clear on how to implement runtime check for PR785 and would require some
> inputs on implementing the same.

This patch should be broken into smaller pieces.
[Pillai, Manikandan] OK

The tps driver should come separated, drivers/regulator/core.c should go
to the maintainer in a separate patch, i2c-omap.c adding the i2c4
support, should be in a separate patch and Ccing Ben Dooks and Jean
Delvare.
[Pillai, Manikandan] In core.c, I am just moving the definition of a struct to
the header file.

More comments below.

> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c   |    6 +-
>  arch/arm/plat-omap/devices.c           |   78 +++++
>  arch/arm/plat-omap/i2c.c               |   21 +-
>  drivers/i2c/busses/i2c-omap.c          |  154 +++++++++-
>  drivers/i2c/chips/Kconfig              |   23 ++
>  drivers/regulator/Kconfig              |    7 +
>  drivers/regulator/Makefile             |    1 +
>  drivers/regulator/core.c               |   27 --
>  drivers/regulator/tps6235x-regulator.c |  544 ++++++++++++++++++++++++++++++++
>  include/linux/regulator/driver.h       |   23 ++-
>  10 files changed, 848 insertions(+), 36 deletions(-)
>  create mode 100644 drivers/regulator/tps6235x-regulator.c
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 22ac2e9..ab3070d 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -168,7 +168,7 @@ static struct i2c_board_info __initdata tps_6235x_i2c_board_info[] = {
>
>  static int __init omap3_evm_i2c_init(void)
>  {
> -#if defined(CONFIG_PR785)
> +#if defined(CONFIG_PR785) && defined(CONFIG_TPS6235X_I2C2)
>       omap_register_i2c_bus(1, 2600, tps_6235x_i2c_board_info,
>               ARRAY_SIZE(tps_6235x_i2c_board_info));
>  #endif
> @@ -178,6 +178,10 @@ static int __init omap3_evm_i2c_init(void)
>  #endif
>       omap_register_i2c_bus(2, 400, NULL, 0);
>       omap_register_i2c_bus(3, 400, NULL, 0);
> +#if defined(CONFIG_PR785) && defined(CONFIG_TPS6235X_I2C4)
> +     omap_register_i2c_bus(4, 2600, tps_6235x_i2c_board_info,
> +             ARRAY_SIZE(tps_6235x_i2c_board_info));
> +#endif

heh, i thought bus4 wasn't sw controllable :-s

[Pillai, Manikandan] Bus 4 can be used to write from master. It cannot be used to read.

>       return 0;
>  }
>
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index 25c6d10..4c81eaf 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -27,6 +27,7 @@
>  #include <mach/gpio.h>
>  #include <mach/dsp_common.h>
>  #include <mach/mcbsp.h>
> +#include <linux/regulator/machine.h>
>
>  #if  defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
>
> @@ -350,6 +351,83 @@ static void omap_init_rng(void)
>  static inline void omap_init_rng(void) {}
>  #endif
>
> +/*-------------------------------------------------------------------------*/
> +#if defined(CONFIG_PR785) || defined(CONFIG_PR785_MODULE)
> +
> +static struct regulator_init_data tps_regulator_data[];
> +
> +static struct resource tps6235x_resources[] = {
> +     {
> +             .flags          = IORESOURCE_MEM,
> +     },
> +};

this is not the correct place for it as only one board has this driver.
Move it to the proper board-file.

[Pillai, Manikandan] I will move it to board-omap3evm.c
> +
> +static struct platform_device omap_tps6235x_device[] = {
> +     {
> +             .name           = "tps6235x_reg",
> +             .id             = 2,
> +             .num_resources  = ARRAY_SIZE(tps6235x_resources),
> +             .resource       = tps6235x_resources,
> +             .dev =  {
> +                     .platform_data = &tps_regulator_data[0],
> +                     },
> +     },
> +     {
> +             .name           = "tps6235x_reg",
> +             .id             = 3,
> +             .num_resources  = ARRAY_SIZE(tps6235x_resources),
> +             .resource       = tps6235x_resources,
> +             .dev =  {
> +                     .platform_data = &tps_regulator_data[1],
> +                     },
> +     },
> +};
> +
> +static struct regulator_consumer_supply tps6235x_consumers[] = {
> +     {
> +             .dev    = &omap_tps6235x_device[0].dev,
> +             .supply = "tps62352",
> +     },
> +     {
> +             .dev    = &omap_tps6235x_device[1].dev,
> +             .supply = "tps62353",

supply should be Vdd, or Vbus or something more useful, not the chip's
name.
[Pillai, Manikandan] Shall make it vdd1 and vdd2 and map it exactly as in
OMAP spec.

> +     },
> +};
> +
> +static struct regulator_init_data tps_regulator_data[] = {
> +     {
> +             .constraints = {
> +                     .min_uV = 750000,
> +                     .max_uV = 1537000,
> +                     .valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
> +                             REGULATOR_CHANGE_STATUS),
> +     },
> +             .num_consumer_supplies  = 1,
> +             .consumer_supplies      = &tps6235x_consumers[0],
> +     },
> +     {
> +             .constraints = {
> +                     .min_uV = 750000,
> +                     .max_uV = 1537000,
> +                     .valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
> +                             REGULATOR_CHANGE_STATUS),
> +     },
> +             .num_consumer_supplies  = 1,
> +             .consumer_supplies      = &tps6235x_consumers[1],
> +     },
> +
> +};
> +
> +static void omap_init_pr785(void)
> +{
> +     (void) platform_device_register(&omap_tps6235x_device[0]);
> +     (void) platform_device_register(&omap_tps6235x_device[1]);
> +}
> +#else
> +static inline void omap_init_pr785(void) {}
> +#endif
> +/*-------------------------------------------------------------------------*/
> +
>  /*
>   * This gets called after board-specific INIT_MACHINE, and initializes most
>   * on-chip peripherals accessible on this board (except for few like USB):
> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
> index 89a6ab0..e0c763a 100644
> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -35,6 +35,7 @@
>  #define OMAP2_I2C_BASE3              0x48060000
>
>  static const char name[] = "i2c_omap";
> +static const char name4[] = "i2c4_omap";
>
>  #define I2C_RESOURCE_BUILDER(base, irq)                      \
>       {                                               \
> @@ -54,6 +55,7 @@ static struct resource i2c_resources[][2] = {
>  #endif
>  #if  defined(CONFIG_ARCH_OMAP34XX)
>       { I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_34XX_I2C3_IRQ) },
> +     { I2C_RESOURCE_BUILDER(0x0, 0x0) },
>  #endif
>  };
>
> @@ -68,6 +70,17 @@ static struct resource i2c_resources[][2] = {
>               },                                      \
>       }
>
> +#define I2C_DEV_BUILDER4(bus_id, res, data)          \
> +     {                                               \
> +             .id     = (bus_id),                     \
> +             .name   = name4,                        \
> +             .num_resources  = ARRAY_SIZE(res),      \
> +             .resource       = (res),                \
> +             .dev            = {                     \
> +                     .platform_data  = (data),       \
> +             },                                      \
> +     }
> +
>  static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
>  static struct platform_device omap_i2c_devices[] = {
>       I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
> @@ -76,6 +89,7 @@ static struct platform_device omap_i2c_devices[] = {
>  #endif
>  #if  defined(CONFIG_ARCH_OMAP34XX)
>       I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
> +     I2C_DEV_BUILDER4(4, i2c_resources[3], &i2c_rate[3]),
>  #endif
>  };
>
> @@ -132,7 +146,8 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
>       else if (cpu_is_omap24xx())
>               ports = 2;
>       else if (cpu_is_omap34xx())
> -             ports = 3;
> +             /* There are 4 I2C controller on OMAP3 */
> +             ports = 4;
>
>       BUG_ON(bus_id < 1 || bus_id > ports);
>
> @@ -141,7 +156,6 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
>               if (err)
>                       return err;
>       }
> -
>       pdev = &omap_i2c_devices[bus_id - 1];
>       *(u32 *)pdev->dev.platform_data = clkrate;
>
> @@ -159,6 +173,7 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
>               res[1].start = irq;
>       }
>
> -     omap_i2c_mux_pins(bus_id - 1);
> +     if (bus_id != 4)
> +             omap_i2c_mux_pins(bus_id - 1);
>       return platform_device_register(pdev);
>  }
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 96f3bed..bf8dd1e 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -157,6 +157,13 @@
>  #define SYSC_CLOCKACTIVITY_FCLK              0x2
>
>
> +/* I2C4 Programming interface register address */
> +#define      OMAP_I2C4_PRM_VC_BYPASS_VAL     (IO_ADDRESS(0x4830723C))
> +#define      OMAP_I2C4_PRM_SLAVE_ADDR_MSK    (0x7F)
> +#define      OMAP_I2C4_PRM_REG_SHIFT         (8)
> +#define      OMAP_I2C4_PRM_DATA_SHIFT        (16)
> +#define      OMAP_I2C4_PRM_VALID_MSK         (1<<24)
> +
>  struct omap_i2c_dev {
>       struct device           *dev;
>       void __iomem            *base;          /* virtual */
> @@ -524,7 +531,6 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>       return -EIO;
>  }
>
> -
>  /*
>   * Prepare controller for a transaction and call omap_i2c_xfer_msg
>   * to do the work during IRQ processing.
> @@ -561,6 +567,70 @@ omap_i2c_func(struct i2c_adapter *adap)
>       return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
>  }
>
> +/*
> + * I2C4 is a special I2C controller unlike I2C1, I2C2 and I2C3.
> + * Prepare controller for a transaction and write into appropriate
> + * registers for transferring data. Only writes are supported on I2C4.
> + */
> +static int omap_i2c4_xfer_msg(struct i2c_adapter *adap,
> +             struct i2c_msg *msg, int stop)
> +{
> +     struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
> +     unsigned int r;
> +     unsigned char *cptr;
> +     unsigned char regval, dataval;
> +
> +     dev_dbg(dev->dev, "I2C4:addr: 0x%04x, len: %d,flags: 0x%x,stop: %d\n",
> +             msg->addr, msg->len, msg->flags, stop);
> +
> +     if (msg->len == 0)
> +             return -EINVAL;
> +
> +     dev->buf_len = msg->len;
> +
> +     cptr = msg->buf;
> +     regval = *cptr;
> +     cptr++;
> +     dataval = *cptr;
> +
> +     r = (((msg->addr) & OMAP_I2C4_PRM_SLAVE_ADDR_MSK) |
> +             (regval << OMAP_I2C4_PRM_REG_SHIFT) |
> +             (dataval << OMAP_I2C4_PRM_DATA_SHIFT) |
> +             OMAP_I2C4_PRM_VALID_MSK);
> +
> +     regval = *(volatile unsigned int *)OMAP_I2C4_PRM_VC_BYPASS_VAL;
> +
> +     while (regval & OMAP_I2C4_PRM_VALID_MSK)
> +             regval = *(volatile unsigned int *)OMAP_I2C4_PRM_VC_BYPASS_VAL;
> +
> +     *(volatile unsigned int *)OMAP_I2C4_PRM_VC_BYPASS_VAL = r;
> +     return 0;
> +}
> +
> +/*
> + * I2C4 is a special I2C controller unlike I2C1, I2C2 and I2C3.
> + * Prepare controller for a transaction and call omap_i2c4_xfer_msg
> + * to do the work during IRQ processing.
> + * Only writes are supported on I2C4.
> + */
> +static int
> +omap_i2c4_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> +{
> +     int i;
> +     int r;
> +
> +     for (i = 0; i < num; i++) {
> +             r = omap_i2c4_xfer_msg(adap, &msgs[i], (i == (num - 1)));
> +             if (r != 0)
> +                     break;
> +     }
> +
> +     if (r == 0)
> +             return num;
> +     return r;
> +}
> +
> +
>  static inline void
>  omap_i2c_complete_cmd(struct omap_i2c_dev *dev, u16 err)
>  {
> @@ -761,6 +831,11 @@ omap_i2c_isr(int this_irq, void *dev_id)
>       return count ? IRQ_HANDLED : IRQ_NONE;
>  }
>
> +static const struct i2c_algorithm omap_i2c4_algo = {
> +     .master_xfer    = omap_i2c4_xfer,
> +     .functionality  = omap_i2c_func,
> +};
> +
>  static const struct i2c_algorithm omap_i2c_algo = {
>       .master_xfer    = omap_i2c_xfer,
>       .functionality  = omap_i2c_func,
> @@ -839,8 +914,8 @@ omap_i2c_probe(struct platform_device *pdev)
>                */
>               dev->fifo_size = (dev->fifo_size / 2);
>               dev->b_hw = 1; /* Enable hardware fixes */
> -     }
>
> +     }
>       /* reset ASAP, clearing any IRQs */
>       omap_i2c_init(dev);
>
> @@ -856,13 +931,14 @@ omap_i2c_probe(struct platform_device *pdev)
>                pdev->id, dev->rev >> 4, dev->rev & 0xf, dev->speed);
>
>       omap_i2c_idle(dev);
> -
>       adap = &dev->adapter;
>       i2c_set_adapdata(adap, dev);
>       adap->owner = THIS_MODULE;
>       adap->class = I2C_CLASS_HWMON;
>       strncpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
> +     /* if BusId is 1-3 then algorithm is omap_i2c_algo */
>       adap->algo = &omap_i2c_algo;
> +
>       adap->dev.parent = &pdev->dev;
>
>       /* i2c device drivers may be active on return from add_adapter() */
> @@ -911,6 +987,61 @@ omap_i2c_remove(struct platform_device *pdev)
>       return 0;
>  }
>
> +static int __init
> +omap_i2c4_probe(struct platform_device *pdev)
> +{
> +     struct omap_i2c_dev     *dev;
> +     struct i2c_adapter      *adap;
> +     int r = 0;
> +     u32 *speed = NULL;
> +
> +     dev = kzalloc(sizeof(struct omap_i2c_dev), GFP_KERNEL);
> +     if (!dev)
> +             r = -ENOMEM;
> +
> +     if (pdev->dev.platform_data != NULL)
> +             speed = (u32 *) pdev->dev.platform_data;
> +     else
> +             *speed = 100; /* Defualt speed */
> +
> +     dev->speed = *speed;
> +     dev->idle = 1;
> +     dev->dev = &pdev->dev;
> +
> +     platform_set_drvdata(pdev, dev);
> +
> +     r = omap_i2c_get_clocks(dev);
> +
> +     adap = &dev->adapter;
> +     i2c_set_adapdata(adap, dev);
> +     adap->owner = THIS_MODULE;
> +     adap->class = I2C_CLASS_HWMON;
> +     strncpy(adap->name, "OMAP I2C adapter", sizeof(adap->name));
> +     /* BusId is 4(I2C4) then algorithm is different */
> +     adap->algo = &omap_i2c4_algo;
> +
> +     adap->dev.parent = &pdev->dev;
> +
> +     /* i2c device drivers may be active on return from add_adapter() */
> +     adap->nr = pdev->id;
> +     r = i2c_add_numbered_adapter(adap);
> +     if (r)
> +             dev_err(dev->dev, "failure adding adapter\n");
> +
> +     return r;
> +}
> +
> +static int
> +omap_i2c4_remove(struct platform_device *pdev)
> +{
> +     struct omap_i2c_dev     *dev = platform_get_drvdata(pdev);
> +     platform_set_drvdata(pdev, NULL);
> +     i2c_del_adapter(&dev->adapter);
> +     kfree(dev);
> +     return 0;
> +}
> +
> +
>  static struct platform_driver omap_i2c_driver = {
>       .probe          = omap_i2c_probe,
>       .remove         = omap_i2c_remove,
> @@ -920,17 +1051,32 @@ static struct platform_driver omap_i2c_driver = {
>       },
>  };
>
> +static struct platform_driver omap_i2c4_driver = {
> +     .probe          = omap_i2c4_probe,
> +     .remove         = omap_i2c4_remove,
> +     .driver         = {
> +             .name   = "i2c4_omap",
> +             .owner  = THIS_MODULE,
> +     },
> +};
> +
> +
>  /* I2C may be needed to bring up other drivers */
>  static int __init
>  omap_i2c_init_driver(void)
>  {
> -     return platform_driver_register(&omap_i2c_driver);
> +     int ret = 0;
> +     ret = platform_driver_register(&omap_i2c_driver);
> +     ret = platform_driver_register(&omap_i2c4_driver);
> +
> +     return ret;
>  }
>  subsys_initcall(omap_i2c_init_driver);
>
>  static void __exit omap_i2c_exit_driver(void)
>  {
>       platform_driver_unregister(&omap_i2c_driver);
> +     platform_driver_unregister(&omap_i2c4_driver);
>  }
>  module_exit(omap_i2c_exit_driver);
>
> diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> index d61589b..5702520 100644
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -194,6 +194,29 @@ config SENSORS_MAX6875
>         This driver can also be built as a module.  If so, the module
>         will be called max6875.
>
> +choice
> +     prompt "TPS6235X driver support"
> +     depends on I2C=y && PR785=y
> +     default n
> +     help
> +       nothing.
> +
> +     config TPS6235X_I2C2
> +             bool "TPS6235X_I2C2"
> +             help
> +             Say yes here if you have TPS6235x devices connected to I2C Bus2
> +             on PR785 Power module. Note that while selecting this option,
> +             TPS6235X_I2C4 should not be selected.
> +
> +     config TPS6235X_I2C4
> +             bool "TPS6235X_I2C4"
> +             help
> +             Say yes here if you have TPS6235x devices connected to I2C Bus4
> +             on PR785 Power module. Note that while selecting this option,
> +             TPS6235X_I2C2 should not be selected.
> +
> +endchoice
> +
>  config SENSORS_TSL2550
>       tristate "Taos TSL2550 ambient light sensor"
>       depends on EXPERIMENTAL
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 0765389..6a827e5 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -80,4 +80,11 @@ config REGULATOR_DA903X
>         Say y here to support the BUCKs and LDOs regulators found on
>         Dialog Semiconductor DA9030/DA9034 PMIC.
>
> +config REGULATOR_TPS6235X
> +     bool "TPS6235X Power regulator for OMAP3EVM"
> +     depends on PR785
> +     help
> +       This driver supports the voltage regulators provided by TPS6235x chips.
> +       The TPS62352 and TPS62353 are mounted on PR785 Power module card for
> +       providing voltage regulator functions.
>  endif
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 0dacb18..fdc5f5b 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -12,5 +12,6 @@ obj-$(CONFIG_REGULATOR_TWL4030) += twl4030-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
>  obj-$(CONFIG_REGULATOR_DA903X)       += da903x.o
> +obj-$(CONFIG_REGULATOR_TPS6235X)+= tps6235x-regulator.o
>
>  ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 02a7744..901f402 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -30,33 +30,6 @@ static LIST_HEAD(regulator_list);
>  static LIST_HEAD(regulator_map_list);
>
>  /**
> - * struct regulator_dev
> - *
> - * Voltage / Current regulator class device. One for each regulator.
> - */
> -struct regulator_dev {
> -     struct regulator_desc *desc;
> -     int use_count;
> -
> -     /* lists we belong to */
> -     struct list_head list; /* list of all regulators */
> -     struct list_head slist; /* list of supplied regulators */
> -
> -     /* lists we own */
> -     struct list_head consumer_list; /* consumers we supply */
> -     struct list_head supply_list; /* regulators we supply */
> -
> -     struct blocking_notifier_head notifier;
> -     struct mutex mutex; /* consumer lock */
> -     struct module *owner;
> -     struct device dev;
> -     struct regulation_constraints *constraints;
> -     struct regulator_dev *supply;   /* for tree */
> -
> -     void *reg_data;         /* regulator_dev data */
> -};
> -
> -/**
>   * struct regulator_map
>   *
>   * Used to provide symbolic supply names to devices.
> diff --git a/drivers/regulator/tps6235x-regulator.c b/drivers/regulator/tps6235x-regulator.c
> new file mode 100644
> index 0000000..8a900db
> --- /dev/null
> +++ b/drivers/regulator/tps6235x-regulator.c
> @@ -0,0 +1,544 @@
> +/*
> + * tps6235x-regulator.c -- support regulators in tps6235x family chips
> + *
> + * Copyright (C) 2008 David Brownell
> + * Author : Manikandan Pillai<mani.pillai@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
> +
> +/* Minimum and Maximum dc-dc voltage supported by the TPS6235x devices
> +All voltages given in millivolts */
> +#define PR785_MIN_CORE_VOLT     750
> +#define PR785_MAX_CORE_VOLT     1537
> +#define PR785_MIN_MPU_VOLT      750
> +#define PR785_MAX_MPU_VOLT      1537
> +
> +/* Maximum number of bytes to be read in a single read */
> +#define PR785_RETRY_COUNT       0x3
> +
> +/* Register bit settings */
> +#define TPS6235X_EN_DCDC        (0x1 << 0x7)
> +#define TPS6235X_VSM_MSK        (0x3F)
> +#define TPS6235X_EN_SYN_MSK     (0x1 << 0x5)
> +#define TPS6235X_SW_VOLT_MSK    (0x1 << 0x4)
> +#define TPS6235X_PWR_OK_MSK     (0x1 << 0x5)
> +#define TPS6235X_OUT_DIS_MSK    (0x1 << 0x6)
> +#define TPS6235X_GO_MSK         (0x1 << 0x7)
> +
> +/*
> + * These chips are often used in OMAP-based systems.
> + *
> + * This driver implements software-based resource control for various
> + * voltage regulators.  This is usually augmented with state machine
> + * based control.
> + */
> +struct tps_6235x_info {
> +     unsigned int            state;
> +     unsigned int            tps_i2c_addr;
> +     struct i2c_client       *client;
> +     struct device           *i2c_dev;
> +     /* platform data holder */
> +     void                    *pdata;
> +};
> +
> +static struct tps_6235x_info    tps_6235x_infodata[2];
> +
> +
> +#ifndef REGULATOR_MODE_OFF
> +#define REGULATOR_MODE_OFF 0
> +#endif
> +
> +
> +/* LDO control registers ... offset is from the base of its register bank.
> + * The first three registers of all power resource banks help hardware to
> + * manage the various resource groups.
> + */
> +
> +#define      TPS6235X_REG_VSEL0      0
> +#define      TPS6235X_REG_VSEL1      1
> +#define      TPS6235X_REG_CTRL1      2
> +#define      TPS6235X_REG_CTRL2      3
> +#define      TPS6235X_REG_MAX        TPS6235X_REG_CTRL2
> +
> +#define      MODULE_NAME             "tps6235x_power"
> +
> +/* Debug functions */
> +#ifdef       DEBUG
> +
> +#define dump_reg(client, reg, val)                                      \
> +     do {                                                            \
> +             tps6235x_read_reg(client, reg, &val);                   \
> +             dev_dbg(&(client)->dev, "Reg(0x%.2X): 0x%.2X\n", reg, val); \
> +     } while (0)
> +
> +#endif       /* #ifdef DEBUG */
> +
> +/* Device addresses for PR785 card */
> +#define      PR785_62352_CORE_ADDR   0x4A
> +#define      PR785_62353_MPU_ADDR    0x48
> +
> +/* Minimum and Maximum dc-dc voltage supported by the TPS6235x devices
> +All voltages given in millivolts */
> +#define      PR785_MIN_CORE_VOLT     750
> +#define      PR785_MAX_CORE_VOLT     1537
> +#define      PR785_MIN_MPU_VOLT      750
> +#define      PR785_MAX_MPU_VOLT      1537
> +
> +/* Maximum number of bytes to be read in a single read */
> +#define      PR785_RETRY_COUNT       0x3
> +
> +/* Register bit settings */
> +#define      TPS6235X_EN_DCDC        (0x1 << 0x7)
> +#define      TPS6235X_VSM_MSK        (0x3F)
> +#define      TPS6235X_EN_SYN_MSK     (0x1 << 0x5)
> +#define      TPS6235X_SW_VOLT_MSK    (0x1 << 0x4)
> +#define      TPS6235X_PWR_OK_MSK     (0x1 << 0x5)
> +#define      TPS6235X_OUT_DIS_MSK    (0x1 << 0x6)
> +#define      TPS6235X_GO_MSK         (0x1 << 0x7)
> +
> +int pr785_enbl_dcdc(unsigned char tps_mod_type, unsigned int en_flag);
> +int pr785_get_dcdc_volt(unsigned char tps_mod_type, unsigned int *millivolts);
> +int pr785_set_dcdc_volt(unsigned char tps_mod_type, unsigned int millivolts);
> +
> +static int tps6235x_dcdc_is_enabled(struct regulator_dev *dev)
> +{
> +     struct  tps_6235x_info *tps_info =
> +                     (struct tps_6235x_info *)dev->reg_data;
> +     return tps_info->state;
> +}
> +
> +static int tps6235x_dcdc_enable(struct regulator_dev *dev)
> +{
> +     struct  tps_6235x_info *tps_info =
> +                     (struct tps_6235x_info *)dev->reg_data;
> +
> +     tps_info->state = 1;
> +     return pr785_enbl_dcdc(tps_info->tps_i2c_addr, 1);
> +}
> +
> +static int tps6235x_dcdc_disable(struct regulator_dev *dev)
> +{
> +     struct  tps_6235x_info *tps_info =
> +                     (struct tps_6235x_info *)dev->reg_data;
> +
> +     tps_info->state = 0;
> +     return pr785_enbl_dcdc(tps_info->tps_i2c_addr, 0);
> +}
> +
> +static int tps6235x_dcdc_get_voltage(struct regulator_dev *dev)
> +{
> +     struct  tps_6235x_info *tps_info =
> +                     (struct tps_6235x_info *)dev->reg_data;
> +     unsigned int millivolts;
> +
> +     pr785_get_dcdc_volt(tps_info->tps_i2c_addr, &millivolts);
> +     return millivolts * 1000;
> +}
> +
> +static int tps6235x_dcdc_set_voltage(struct regulator_dev *dev,
> +                             int min_uV, int max_uV)
> +{
> +     struct  tps_6235x_info *tps_info =
> +                     (struct tps_6235x_info *)dev->reg_data;
> +     unsigned int millivolts = max_uV / 1000;
> +
> +     return pr785_set_dcdc_volt(tps_info->tps_i2c_addr,  millivolts) ;
> +}
> +
> +
> +static struct regulator_ops tps62352_dcdc_ops = {
> +     .is_enabled = tps6235x_dcdc_is_enabled,
> +     .get_voltage = tps6235x_dcdc_get_voltage,
> +     .set_voltage = tps6235x_dcdc_set_voltage,
> +};
> +
> +static struct regulator_ops tps62353_dcdc_ops = {
> +     .is_enabled = tps6235x_dcdc_is_enabled,
> +     .enable = tps6235x_dcdc_enable,
> +     .disable = tps6235x_dcdc_disable,
> +     .get_voltage = tps6235x_dcdc_get_voltage,
> +     .set_voltage = tps6235x_dcdc_set_voltage,
> +};
> +
> +
> +static struct regulator_desc regulators[] = {
> +     {
> +             .name = "tps62352",
> +             .id = 2,
> +             .ops = &tps62352_dcdc_ops,
> +             .type = REGULATOR_VOLTAGE,
> +             .owner = THIS_MODULE,
> +     },
> +     {
> +             .name = "tps62353",
> +             .id = 3,
> +             .ops = &tps62353_dcdc_ops,
> +             .type = REGULATOR_VOLTAGE,
> +             .owner = THIS_MODULE,
> +     },
> +};
> +
> +static int tps6235xreg_probe(struct platform_device *pdev)
> +{
> +     struct  tps_6235x_info          *info;
> +     struct  regulator_dev           *rdev = NULL;
> +
> +     info = &tps_6235x_infodata[(pdev->id-2)];
> +
> +     rdev = regulator_register(&regulators[(pdev->id-2)], &pdev->dev, info);
> +     if (rdev == NULL)
> +             printk(KERN_ERR "err in regulator registry = %d\n", pdev->id);
> +
> +     platform_set_drvdata(pdev, rdev);
> +
> +     return 0;
> +}
> +
> +static int __devexit tps6235xreg_remove(struct platform_device *pdev)
> +{
> +     regulator_unregister(platform_get_drvdata(pdev));
> +     return 0;
> +}
> +
> +MODULE_ALIAS("platform:tps6235x_reg");
> +
> +static struct platform_driver tps6235xreg_driver = {
> +     .probe          = tps6235xreg_probe,
> +     .remove         = __devexit_p(tps6235xreg_remove),
> +     .driver.name    = "tps6235x_reg",
> +     .driver.owner   = THIS_MODULE,
> +};
> +
> +static int __init tps6235xreg_init(void)
> +{
> +     return platform_driver_register(&tps6235xreg_driver);
> +}
> +late_initcall(tps6235xreg_init);
> +
> +static void __exit tps6235xreg_exit(void)
> +{
> +     platform_driver_unregister(&tps6235xreg_driver);
> +}
> +module_exit(tps6235xreg_exit)
> +
> +MODULE_DESCRIPTION("TPS6235X regulator driver");
> +MODULE_LICENSE("GPL");
> +
> +
> +/*
> + * Get client pointer for a particular device
> + * Returns zero if successful, or non-zero otherwise.
> + */
> +static struct i2c_client *tps_6235x_get_client(unsigned char tps_i2c_addr)
> +{
> +     if (tps_i2c_addr == PR785_62352_CORE_ADDR)
> +             return tps_6235x_infodata[0].client;
> +     else if (tps_i2c_addr == PR785_62353_MPU_ADDR)
> +             return tps_6235x_infodata[1].client;
> +     else
> +             return NULL;
> +}
> +
> +/*
> + * Read a value from a register in an tps_6235x device.
> + * The value is returned in 'val'.
> + * Returns zero if successful, or non-zero otherwise.
> + */
> +static int tps_6235x_read_reg(struct i2c_client *client, u8 reg, u8 *val)
> +{
> +     u8 data;
> +
> +     if (!client->adapter)
> +             return -ENODEV;
> +
> +     data = i2c_smbus_read_byte_data(client, reg);
> +     *val = data;
> +     return 0;
> +}
> +
> +/*
> + * Write a value to a register in an tps_6235x device.
> + * Returns zero if successful, or non-zero otherwise.
> + */
> +static int tps_6235x_write_reg(struct i2c_client *client, u8 reg, u8 val)
> +{
> +     int err;
> +     int retry = 0;
> +
> +     if (!client->adapter)
> +             return -ENODEV;
> +
> +again:
> +     err = i2c_smbus_write_byte_data(client, reg, val);
> +     if (err >= 0)
> +             return 0;
> +
> +     dev_err(&client->dev,
> +             "wrote 0x%.2x to offset 0x%.2x error %d\n", val, reg, err);
> +
> +     if (retry <= PR785_RETRY_COUNT) {
> +             dev_info(&client->dev, "retry ... %d\n", retry);
> +             retry++;
> +             schedule_timeout(msecs_to_jiffies(20));
> +             goto again;
> +     }
> +     return err;
> +}
> +
> +
> +/**
> +*  pwr_i2c_read - Allows the caller to read one register from TPS device
> +*                   based on the address given. For the PR785 it reads
> +*                   only 1 byte into a specified register
> +*  tps_mod_type - Enum for the device to be read
> +*  reg          - Register to be read from(value has to be between 0-3
> +*  val          - value read from the reg
> +*  Retval       - 0 -> Success else non-zero
> +**/
> +int pwr_i2c_read(unsigned char tps_mod_type, u8 reg, u8 *val)
> +{
> +     struct i2c_client *client;
> +
> +     client = tps_6235x_get_client(tps_mod_type);
> +     /* check if register is less than <= 3 Register is 0 -3 */
> +     if (reg > TPS6235X_REG_MAX)
> +             return -1;
> +
> +     return tps_6235x_read_reg(client, reg, val);
> +}
> +EXPORT_SYMBOL(pwr_i2c_read);
> +
> +/**
> +*  pwr_i2c_write - Allows the caller to write one register from TPS device
> +*                   based on the address given. For the PR785 it writes
> +*                   only 1 byte into a specified register
> +*  tps_mod_type  - Enum for the device to be written
> +*  reg           - Register to be written to(value has to be between 0-3
> +*  val           - value to be written to reg
> +*  Retval        - 0 -> Success else non-zero
> +**/
> +int pwr_i2c_write(unsigned char tps_mod_type, u8 reg, u8 val)
> +{
> +     struct i2c_client *client;
> +
> +     client = tps_6235x_get_client(tps_mod_type);
> +
> +     /* check if register is less than <= 3 Register is 0 -3 */
> +     if (reg > TPS6235X_REG_MAX)
> +             return -1;
> +
> +     return tps_6235x_write_reg(client, reg, val);
> +}
> +EXPORT_SYMBOL(pwr_i2c_write);
> +
> +
> +/**
> +*  TPSPR785        - Specific functions
> +*  pr785_enbl_dcdc - Allows the caller to enable or disable the TPS6235x device
> +*                    on the PR785 board. The voltage for PR785 is selected by
> +*                    VSEL1 register since VSEL pin is kept high
> +*
> +*  flag            - 1 == enable 0 == disable
> +*  Retval          - 0 -> Success else non-zero
> +**/
> +int pr785_enbl_dcdc(unsigned char tps_mod_type, unsigned int en_flag)
> +{
> +     unsigned char vsel1;
> +     int ret;
> +
> +     ret = pwr_i2c_read(tps_mod_type, TPS6235X_REG_VSEL1, &vsel1);
> +     if (ret == 0) {
> +             if (en_flag)
> +                     vsel1 |= TPS6235X_EN_DCDC;
> +             else
> +                     vsel1 &= ~(TPS6235X_EN_DCDC);
> +             ret = pwr_i2c_write(tps_mod_type, TPS6235X_REG_VSEL1, vsel1);
> +     }
> +     return ret;
> +}
> +EXPORT_SYMBOL(pr785_enbl_dcdc);
> +
> +/**
> +*  TPSPR785            - Specific functions
> +*  pr785_set_dcdc_volt - Allows the caller to set a particular voltage on
> +*                        for CORE or MPU
> +*
> +*  voltage              - voltage to be set in millivolts (75--1537)
> +*  Retval          - 0 -> Success else non-zero
> +**/
> +int pr785_set_dcdc_volt(unsigned char tps_mod_type, unsigned int millivolts)
> +{
> +     unsigned char vsel1;
> +     unsigned int volt;
> +
> +     /* check if the millivolts is within range */
> +     if ((millivolts < PR785_MIN_CORE_VOLT) ||
> +             (millivolts > PR785_MAX_CORE_VOLT))
> +             return -1;
> +
> +     /* Output voltage set is = min_op_volt + ( VSM * 12.5mv) */
> +     volt = millivolts - PR785_MIN_CORE_VOLT;
> +     volt /= 25;
> +     volt *= 2;
> +     vsel1 = ((TPS6235X_EN_DCDC) | (volt & TPS6235X_VSM_MSK));
> +     return  pwr_i2c_write(tps_mod_type, TPS6235X_REG_VSEL1, vsel1);
> +}
> +EXPORT_SYMBOL(pr785_set_dcdc_volt);
> +
> +/**
> +*  TPSPR785            - Specific functions
> +*  pr785_get_dcdc_volt - Allows the caller to get the set voltage on a
> +*                        particular TPS 6235x device on PR785 card
> +*
> +*  voltage              - voltage to be set in millivolts (75--1537)
> +*  Retval          - 0 -> Success else non-zero
> +**/
> +int pr785_get_dcdc_volt(unsigned char tps_mod_type, unsigned int *millivolts)
> +{
> +     unsigned char vsel1;
> +     unsigned int volt;
> +
> +     /* Read the VSEL1 register to get VSM */
> +     pwr_i2c_read(tps_mod_type, TPS6235X_REG_VSEL1, &vsel1);
> +     /* Output voltage set is = min_op_volt + ( VSM * 12.5mv) */
> +     /* To cut out floating point operation we will multiply by 25
> +     divide by 2 */
> +     volt = (((vsel1 & TPS6235X_VSM_MSK) * 25) / 2) + PR785_MIN_CORE_VOLT;
> +     *millivolts = volt;
> +     return 0;
> +}
> +EXPORT_SYMBOL(pr785_get_dcdc_volt);
> +
> +/**
> + * tps_6235x_probe - TPS6235x driver i2c probe handler
> + * @client: i2c driver client device structure
> + *
> + * Register PR785 as an i2c client device driver
> + */
> +static struct i2c_driver tps_6235x_i2c_driver;
> +
> +static
> +int tps_6235x_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +     unsigned char reg_val;
> +
> +     printk(KERN_INFO "tps_6235x_probe:i2c_addr = %x\n", (int)client->addr);
> +
> +     /* Device probed is TPS62352 CORE pwr chip if driver_data  = 0
> +     Device probed is TPS62353 MPU pwr chip if driver_data = 1   */
> +     tps_6235x_infodata[id->driver_data].client = client;
> +     tps_6235x_infodata[id->driver_data].tps_i2c_addr = client->addr;
> +     tps_6235x_infodata[id->driver_data].state = 1;
> +     tps_6235x_infodata[id->driver_data].i2c_dev = &client->dev;
> +
> +     tps_6235x_read_reg(client, TPS6235X_REG_CTRL2, &reg_val);
> +     reg_val |= (TPS6235X_OUT_DIS_MSK | TPS6235X_GO_MSK);
> +     tps_6235x_write_reg(client, TPS6235X_REG_CTRL2, reg_val);
> +     tps_6235x_read_reg(client, TPS6235X_REG_CTRL2, &reg_val);
> +
> +     i2c_set_clientdata(client, &tps_6235x_infodata[id->driver_data]);
> +
> +     if (reg_val & TPS6235X_PWR_OK_MSK)
> +             printk(KERN_INFO "Power is OK  %x\n", reg_val);
> +     else
> +             printk(KERN_INFO "Power not within range = %x\n", reg_val);
> +     return 0;
> +}
> +
> +/**
> + * tps_6235x_remove - TPS6235x driver i2c remove handler
> + * @client: i2c driver client device structure
> + *
> + * UnregisterPR785  as an i2c client device driver
> + */
> +static int __exit tps_6235x_remove(struct i2c_client *client)
> +{
> +#ifdef DEBUG
> +     printk(KERN_INFO "tps_6235x_remove invoked\n");
> +#endif
> +
> +     if (!client->adapter)
> +             return -ENODEV; /* our client isn't attached */
> +
> +     i2c_set_clientdata(client, NULL);
> +
> +     return 0;
> +}
> +
> +
> +static const struct i2c_device_id tps_6235x_id[] = {
> +     { "tps62352", 0},
> +     { "tps62353", 1},
> +     {},
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, tps_6235x_id);
> +
> +static struct i2c_driver tps_6235x_i2c_driver = {
> +     .driver = {
> +             .name   =       MODULE_NAME,
> +             .owner  =       THIS_MODULE,
> +     },
> +     .probe = tps_6235x_probe,
> +     .remove = __exit_p(tps_6235x_remove),
> +     .id_table = tps_6235x_id,
> +};
> +
> +/**
> + * tps_6235x_init
> + *
> + * Module init function
> + */
> +static int __init tps_6235x_init(void)
> +{
> +     int err;
> +
> +#ifdef DEBUG
> +     printk(KERN_INFO "tps_6235x_init invoked\n");
> +#endif
> +
> +     err = i2c_add_driver(&tps_6235x_i2c_driver);
> +     if (err) {
> +             printk(KERN_ERR "Failed to register " MODULE_NAME ".\n");
> +             return err;
> +     } else
> +             printk(KERN_INFO "I2c driver registered\n");
> +
> +     return 0;
> +}
> +
> +/**
> + * tps_6235x_cleanup
> + *
> + * Module exit function
> + */
> +static void __exit tps_6235x_cleanup(void)
> +{
> +#ifdef DEBUG
> +     printk(KERN_INFO "tps_6235x_cleanup invoked\n");
> +#endif
> +     i2c_del_driver(&tps_6235x_i2c_driver);
> +}
> +
> +late_initcall(tps_6235x_init);
> +module_exit(tps_6235x_cleanup);
> +
> +MODULE_AUTHOR("Texas Instruments");
> +MODULE_DESCRIPTION("TPS6235x based PR785 linux driver");
> +MODULE_LICENSE("GPL");
> +
> diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
> index e37d805..9107344 100644
> --- a/include/linux/regulator/driver.h
> +++ b/include/linux/regulator/driver.h
> @@ -18,9 +18,30 @@
>  #include <linux/device.h>
>  #include <linux/regulator/consumer.h>
>
> -struct regulator_dev;
>  struct regulator_init_data;
>
> +struct regulator_dev {
> +     struct regulator_desc *desc;
> +     int use_count;
> +
> +     /* lists we belong to */
> +     struct list_head list; /* list of all regulators */
> +     struct list_head slist; /* list of supplied regulators */
> +
> +     /* lists we own */
> +     struct list_head consumer_list; /* consumers we supply */
> +     struct list_head supply_list; /* regulators we supply */
> +
> +     struct blocking_notifier_head notifier;
> +     struct mutex mutex; /* consumer lock */
> +     struct module *owner;
> +     struct device dev;
> +     struct regulation_constraints *constraints;
> +     struct regulator_dev *supply;   /* for tree */
> +
> +     void *reg_data;         /* regulator_dev data */
> +};
> +
>  /**
>   * struct regulator_ops - regulator operations.
>   *
> --
> 1.5.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
balbi

