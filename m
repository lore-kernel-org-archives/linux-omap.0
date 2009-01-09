From: "Pillai, Manikandan" <mani.pillai@ti.com>
Subject: RE: [PATCH 1/1] OMAP3 EVM MMC1 support for TPS based PR785 power
	modules
Date: Fri, 9 Jan 2009 08:57:12 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECEDDA84@dbde02.ent.ti.com>
References: <1229513610-17386-1-git-send-email-mani.pillai@ti.com>
 <19F8576C6E063C45BE387C64729E739403ECEDD316@dbde02.ent.ti.com>
 <20090108152659.GS27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59738 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbZAID10 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 22:27:26 -0500
In-Reply-To: <20090108152659.GS27566@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Pls see my responses inline.

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, January 08, 2009 8:57 PM
> To: Pillai, Manikandan
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/1] OMAP3 EVM MMC1 support for TPS based PR785 power
> modules
>
> Hi,
>
> * Pillai, Manikandan <mani.pillai@ti.com> [090106 06:39]:
> > Hi,
> >
> > I believe I didn't receive any comments on this patch. Pls let me know if
> > any comments are there for this patch.
>
> Few comments below.
>
> > Regards
> > Manikandan
> >
> > -----Original Message-----
> > From: Pillai, Manikandan
> > Sent: Wednesday, December 17, 2008 5:04 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Pillai, Manikandan
> > Subject: [PATCH 1/1] OMAP3 EVM MMC1 support for TPS based PR785 power
> modules
> >
> > Resending patches after fixing comments
> > This patch allows the MMC1 support on OMAP2 EVM board with
> > TPS6235x based PR785 boards. Files mmc-pr785.* contain the
> > drivers. Card detect interrupt level issue has been fixed.
> >
> > Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
> > ---
> >  arch/arm/mach-omap2/Makefile         |    9 +-
> >  arch/arm/mach-omap2/board-omap3evm.c |   39 ++++
> >  arch/arm/mach-omap2/mmc-pr785.c      |  318
> ++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/mmc-pr785.h      |   38 ++++
> >  drivers/mmc/host/omap_hsmmc.c        |    2 +-
> >  5 files changed, 404 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/mmc-pr785.c
> >  create mode 100644 arch/arm/mach-omap2/mmc-pr785.h
> >
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > index 3897347..f47ed1d 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -56,10 +56,17 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)         += board-3430sdp.o
> \
> >                                        usb-ehci.o \
> >                                        board-3430sdp-flash.o
> >  obj-$(CONFIG_MACH_OMAP3EVM)                += board-omap3evm.o \
> > -                                      mmc-twl4030.o \
> >                                        usb-musb.o usb-ehci.o \
> >                                        board-omap3evm-flash.o \
> >                                        twl4030-generic-scripts.o
> > +ifeq ($(CONFIG_OMAP3EVM_PR785),y)
> > +obj-$(CONFIG_MACH_OMAP3EVM)             += mmc-pr785.o
> > +endif
> > +ifeq ($(CONFIG_TWL4030_CORE),y)
> > +obj-$(CONFIG_MACH_OMAP3EVM)             += mmc-twl4030.o
> > +endif
> > +
> > +
> >  obj-$(CONFIG_MACH_OMAP3_BEAGLE)            += board-omap3beagle.o \
> >                                        usb-musb.o usb-ehci.o \
> >                                        mmc-twl4030.o \
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> > index 1aababc..db8e69e 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -36,10 +36,16 @@
> >  #include <mach/usb-ehci.h>
> >  #include <mach/common.h>
> >  #include <mach/mcspi.h>
> > +#include <mach/mux.h>
> >
> >  #include "sdram-micron-mt46h32m32lf-6.h"
> >  #include "twl4030-generic-scripts.h"
> > +#if defined(CONFIG_TWL4030_CORE)
> >  #include "mmc-twl4030.h"
> > +#endif
> > +#if defined(CONFIG_OMAP3EVM_PR785)
> > +#include "mmc-pr785.h"
> > +#endif
> >  #include <linux/regulator/machine.h>
> >  #include <linux/regulator/driver.h>
> >
> > @@ -351,6 +357,19 @@ static struct platform_device *omap3_evm_devices[]
> __initdata = {
> >     &omap3evm_smc911x_device,
> >  };
> >
> > +#if defined(CONFIG_OMAP3EVM_PR785)
> > +static struct pr785_hsmmc_info mmc[] __initdata = {
> > +   {
> > +           .mmc            = 1,
> > +           .wires          = 4,
> > +           .gpio_cd        = 140,
> > +           .gpio_wp        = -EINVAL,
> > +   },
> > +   {}      /* Terminator */
> > +};
> > +#endif
> > +
> > +#if defined(CONFIG_TWL4030_CORE)
> >  static struct twl4030_hsmmc_info mmc[] __initdata = {
> >     {
> >             .mmc            = 1,
> > @@ -360,6 +379,20 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
> >     },
> >     {}      /* Terminator */
> >  };
> > +#endif
> > +
> > +static void omap_init_pr785(void)
> > +{
> > +   /* Initialize the mux settings for PR785 power module board */
> > +   if (cpu_is_omap343x()) {
> > +           omap_cfg_reg(AF26_34XX_GPIO0);
> > +           omap_cfg_reg(AF22_34XX_GPIO9);
> > +           omap_cfg_reg(AF6_34XX_GPIO140_UP);
> > +           omap_cfg_reg(AE6_34XX_GPIO141);
> > +           omap_cfg_reg(AF5_34XX_GPIO142);
> > +           omap_cfg_reg(AE5_34XX_GPIO143);
> > +   }
> > +}
> >
> >  static void __init omap3_evm_init(void)
> >  {
> > @@ -373,7 +406,13 @@ static void __init omap3_evm_init(void)
> >                             ARRAY_SIZE(omap3evm_spi_board_info));
> >
> >     omap_serial_init();
> > +#if defined(CONFIG_TWL4030_CORE)
> >     twl4030_mmc_init(mmc);
> > +#endif
> > +#if defined(CONFIG_OMAP3EVM_PR785)
> > +   omap_init_pr785();
> > +   pr785_hsmmc_init(mmc);
> > +#endif
> >     usb_musb_init();
> >     usb_ehci_init();
> >     omap3evm_flash_init();
> > diff --git a/arch/arm/mach-omap2/mmc-pr785.c b/arch/arm/mach-omap2/mmc-
> pr785.c
> > new file mode 100644
> > index 0000000..39b352a
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/mmc-pr785.c
> > @@ -0,0 +1,318 @@
> > +/*
> > + * linux/arch/arm/mach-omap2/mmc-pr785.c
> > + *
> > + * Copyright (C) 2007-2008 Texas Instruments
> > + * Author:
> > + *         Manikandan Pillai <mani.pillai@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio.h>
> > +
> > +#include <mach/hardware.h>
> > +#include <mach/control.h>
> > +#include <mach/mmc.h>
> > +#include <mach/board.h>
> > +
> > +#include "mmc-pr785.h"
> > +
> > +#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
> > +
> > +#define    VMMC1_DEV_GRP           0x27
> > +#define    VMMC1_DEDICATED         0x2A
> > +
> > +#define    VMMC2_DEV_GRP           0x2B
> > +#define    VMMC2_DEDICATED         0x2E
> > +
> > +static u16 control_pbias_offset;
> > +
> > +#define    HSMMC_NAME_LEN          9
> > +
> > +static struct pr785_mmc_controller {
> > +   struct          omap_mmc_platform_data  *mmc;
> > +   u32             devconf_loopback_clock;
> > +   u16             control_devconf_offset;
> > +   u8              pr785_vmmc_dev_grp;
> > +   u8              pr785_mmc_dedicated;
> > +   char            name[HSMMC_NAME_LEN];
> > +} hsmmc[] = {
> > +   {
> > +           .control_devconf_offset         = OMAP2_CONTROL_DEVCONF0,
> > +           .devconf_loopback_clock         = OMAP2_MMCSDIO1ADPCLKISEL,
> > +           .pr785_vmmc_dev_grp             = VMMC1_DEV_GRP,
> > +           .pr785_mmc_dedicated            = VMMC1_DEDICATED,
> > +   },
> > +   {
> > +           /* control_devconf_offset set dynamically */
> > +           .devconf_loopback_clock         = OMAP2_MMCSDIO2ADPCLKISEL,
> > +           .pr785_vmmc_dev_grp             = VMMC2_DEV_GRP,
> > +           .pr785_mmc_dedicated            = VMMC2_DEDICATED,
> > +   },
> > +};
>
> How about try to figure out a way to share the common code with
> mmc-twl4030.c?
[Pillai, Manikandan] Most of the code is derived from mmc-twl4030.c file.
The intention was to have a different file for mmc-pr785.c. Are you suggesting
here that I break the mmc-xxxx.c  into 2 files mmc-shared.c and mmc-twl/pr785.c ?
>
> > +static int pr785_mmc_card_detect(int irq)
> > +{
> > +   unsigned i;
> > +
> > +   for (i = 0; i < ARRAY_SIZE(hsmmc); i++) {
> > +           struct omap_mmc_platform_data *mmc;
> > +
> > +           mmc = hsmmc[i].mmc;
> > +           if (!mmc)
> > +                   continue;
> > +           if (irq != mmc->slots[0].card_detect_irq)
> > +                   continue;
> > +
> > +           /* NOTE: assumes card detect signal is active-low */
> > +           return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
> > +   }
> > +   return -ENOSYS;
> > +}
>
> This code should be shared too.
>
>
> > +/*
> > + * Write protect pin is not supported
> > + * The function below is a place holder
> > +*/
> > +static int pr785_mmc_get_ro(struct device *dev, int slot)
> > +{
> > +   struct omap_mmc_platform_data *mmc = dev->platform_data;
> > +
> > +   /* NOTE: assumes write protect signal is active-high */
> > +   return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
> > +}
> > +
> > +/*
> > + * MMC late Initialization.
> > + */
> > +static int pr785_mmc_late_init(struct device *dev)
> > +{
> > +   struct omap_mmc_platform_data *mmc = dev->platform_data;
> > +   int i;
> > +
> > +   for (i = 0; i < ARRAY_SIZE(hsmmc); i++) {
> > +           if (hsmmc[i].name == mmc->slots[0].name) {
> > +                   hsmmc[i].mmc = mmc;
> > +                   break;
> > +           }
> > +   }
> > +   return 0;
> > +}
> > +
> > +static void pr785_mmc_cleanup(struct device *dev)
> > +{
> > +   /* nothing to cleanup */
> > +   gpio_free(OMAP_PR785_MMC1_CD);
> > +   return;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +
> > +static int pr785_mmc_suspend(struct device *dev, int slot)
> > +{
> > +   struct omap_mmc_platform_data *mmc = dev->platform_data;
> > +
> > +   disable_irq(mmc->slots[0].card_detect_irq);
> > +   return 0;
> > +}
> > +
> > +static int pr785_mmc_resume(struct device *dev, int slot)
> > +{
> > +   struct omap_mmc_platform_data *mmc = dev->platform_data;
> > +
> > +   enable_irq(mmc->slots[0].card_detect_irq);
> > +   return 0;
> > +}
> > +
> > +#else
> > +#define pr785_mmc_suspend  NULL
> > +#define pr785_mmc_resume   NULL
> > +#endif
> > +
> > +/*
> > + * Sets the MMC voltage
> > + * The MMC voltage on PR785 can only be set to 3.15 V due to hardware bug
> > + */
> > +static int pr785_mmc_set_voltage(struct pr785_mmc_controller *c, int vdd)
> > +{
> > +   if (vdd)
> > +           gpio_direction_output(OMAP_PR785_MMC1_VSET, 1);
> > +   else
> > +           gpio_direction_output(OMAP_PR785_MMC1_VSET, 0);
> > +   return 0;
> > +}
> > +
> > +static int pr785_mmc1_set_power(struct device *dev, int slot, int power_on,
> > +                           int vdd)
> > +{
> > +   u32 reg;
> > +   int ret = 0;
> > +   struct pr785_mmc_controller *c = &hsmmc[0];
> > +
> > +   if (power_on) {
> > +           if (cpu_is_omap2430()) {
> > +                   reg = omap_ctrl_readl(OMAP243X_CONTROL_DEVCONF1);
> > +                   if ((1 << vdd) >= MMC_VDD_30_31)
> > +                           reg |= OMAP243X_MMC1_ACTIVE_OVERWRITE;
> > +                   else
> > +                           reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
> > +                   omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
> > +           }
> > +
> > +           /* REVISIT: Loop back clock not needed for 2430? */
> > +           if (!cpu_is_omap2430()) {
> > +                   reg = omap_ctrl_readl(c->control_devconf_offset);
> > +                   reg |= OMAP2_MMCSDIO1ADPCLKISEL;
> > +                   omap_ctrl_writel(reg, c->control_devconf_offset);
> > +           }
> > +
> > +           reg = omap_ctrl_readl(control_pbias_offset);
> > +           reg |= OMAP2_PBIASSPEEDCTRL0;
> > +           reg &= ~OMAP2_PBIASLITEPWRDNZ0;
> > +           omap_ctrl_writel(reg, control_pbias_offset);
> > +
> > +           ret = pr785_mmc_set_voltage(c, vdd);
> > +
> > +           /* 100ms delay required for PBIAS configuration */
> > +           msleep(100);
> > +           reg = omap_ctrl_readl(control_pbias_offset);
> > +           reg |= (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
> > +           if ((1 << vdd) <= MMC_VDD_165_195)
> > +                   reg &= ~OMAP2_PBIASLITEVMODE0;
> > +           else
> > +                   reg |= OMAP2_PBIASLITEVMODE0;
> > +           omap_ctrl_writel(reg, control_pbias_offset);
> > +   } else {
> > +           reg = omap_ctrl_readl(control_pbias_offset);
> > +           reg &= ~OMAP2_PBIASLITEPWRDNZ0;
> > +           omap_ctrl_writel(reg, control_pbias_offset);
> > +
> > +           ret = pr785_mmc_set_voltage(c, 0);
> > +
> > +           /* 100ms delay required for PBIAS configuration */
> > +           msleep(100);
> > +           reg = omap_ctrl_readl(control_pbias_offset);
> > +           reg |= (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
> > +                   OMAP2_PBIASLITEVMODE0);
> > +           omap_ctrl_writel(reg, control_pbias_offset);
> > +   }
> > +
> > +   return ret;
> > +}
>
> And this code.
>
>
> > +static int pr785_mmc2_set_power(struct device *dev, int slot,
> > +                           int power_on, int vdd)
> > +{
> > +   /* MMC2 is not available on OMAP3 EVM */
> > +   return 0;
> > +}
> > +
> > +static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC]
> __initdata;
> > +
> > +void __init pr785_hsmmc_init(struct pr785_hsmmc_info *controllers)
> > +{
> > +   struct pr785_hsmmc_info *c;
> > +   int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
> > +
> > +   if (cpu_is_omap2430()) {
> > +           control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
> > +           hsmmc[1].control_devconf_offset = OMAP243X_CONTROL_DEVCONF1;
> > +           nr_hsmmc = 2;
> > +   } else {
> > +           control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
> > +           hsmmc[1].control_devconf_offset = OMAP343X_CONTROL_DEVCONF1;
> > +   }
>
> At least this part of the init code can be shared too.
>
>
> > +#if defined(CONFIG_MACH_OMAP3EVM) && defined(CONFIG_OAMP3EVM_PR785)
> > +   /* setup the GPIO for MMC for PR785 Rev ES2 power module */
> > +   /* Setup GPIO 0 - MMC1_VSET */
> > +   gpio_direction_output(OMAP_PR785_MMC1_VSET, 1);
> > +   /* Setup GPIO 9 - MMC1_EN */
> > +   gpio_direction_output(OMAP_PR785_MMC1_EN, 1);
> > +
> > +   /* Setup GPIO 140 - MMC1_CD as input */
> > +   if (gpio_request(OMAP_PR785_MMC1_CD, "AF6_34XX_GPIO140_UP") < 0) {
> > +           printk(KERN_ERR "Failed to request MMC IRQ %d \n",
> > +                   OMAP_PR785_MMC1_CD);
> > +           return -1;
> > +   }
> > +   gpio_direction_input(OMAP_PR785_MMC1_CD);
> > +#endif
>
> Why do you need ifdefs here?

[Pillai, Manikandan] OK
>
>
> > +
> > +   for (c = controllers; c->mmc; c++) {
> > +           struct pr785_mmc_controller *pr785 = hsmmc + c->mmc - 1;
> > +           struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
> > +
> > +           if (!c->mmc || c->mmc > nr_hsmmc) {
> > +                   pr_debug("MMC%d: no such controller\n", c->mmc);
> > +                   continue;
> > +           }
> > +           if (mmc) {
> > +                   pr_debug("MMC%d: already configured\n", c->mmc);
> > +                   continue;
> > +           }
> > +
> > +           mmc = kzalloc(sizeof(struct omap_mmc_platform_data),
> > +                           GFP_KERNEL);
> > +           if (!mmc) {
> > +                   pr_err("Cannot allocate memory for mmc device!\n");
> > +                   return;
> > +           }
> > +
> > +           sprintf(pr785->name, "mmc%islot%i", c->mmc, 1);
> > +           mmc->slots[0].name = pr785->name;
> > +           mmc->nr_slots = 1;
> > +           mmc->slots[0].ocr_mask = MMC_VDD_165_195 |
> > +                                   MMC_VDD_26_27 | MMC_VDD_27_28 |
> > +                                   MMC_VDD_29_30 |
> > +                                   MMC_VDD_30_31 | MMC_VDD_31_32;
> > +           mmc->slots[0].wires = c->wires;
> > +           mmc->dma_mask = 0xffffffff;
> > +
> > +           if (c->gpio_cd != -EINVAL) {
> > +                   mmc->init = pr785_mmc_late_init;
> > +                   mmc->cleanup = pr785_mmc_cleanup;
> > +                   mmc->suspend = pr785_mmc_suspend;
> > +                   mmc->resume = pr785_mmc_resume;
> > +
> > +                   mmc->slots[0].switch_pin = OMAP_PR785_MMC1_CD;
> > +                   mmc->slots[0].card_detect_irq = gpio_to_irq(c->gpio_cd);
> > +                   mmc->slots[0].card_detect = pr785_mmc_card_detect;
> > +           } else
> > +                   mmc->slots[0].switch_pin = -EINVAL;
> > +
> > +           /* write protect normally uses an OMAP gpio */
> > +           if (c->gpio_wp != -EINVAL) {
> > +                   gpio_request(c->gpio_wp, "mmc_wp");
> > +                   gpio_direction_input(c->gpio_wp);
> > +
> > +                   mmc->slots[0].gpio_wp = c->gpio_wp;
> > +                   mmc->slots[0].get_ro = pr785_mmc_get_ro;
> > +           } else
> > +                   mmc->slots[0].gpio_wp = -EINVAL;
> > +
> > +           switch (c->mmc) {
> > +           case 1:
> > +                   mmc->slots[0].set_power = pr785_mmc1_set_power;
> > +                   break;
> > +           case 2:
> > +                   mmc->slots[0].set_power = pr785_mmc2_set_power;
> > +                   break;
> > +           default:
> > +                   pr_err("MMC%d configuration not supported!\n", c->mmc);
> > +                   continue;
> > +           }
> > +           hsmmc_data[c->mmc - 1] = mmc;
> > +   }
> > +   omap2_init_mmc(hsmmc_data, OMAP34XX_NR_MMC);
> > +}
> > +
> > +#endif
> > diff --git a/arch/arm/mach-omap2/mmc-pr785.h b/arch/arm/mach-omap2/mmc-
> pr785.h
> > new file mode 100644
> > index 0000000..7178412
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/mmc-pr785.h
> > @@ -0,0 +1,38 @@
> > +/*
> > + * linux/arch/arm/mach-omap2/mmc-pr785.h
> > + *
> > + * Copyright (C) 2007-2008 Texas Instruments
> > + * Author:
> > + *         Manikandan Pillai <mani.pillai@ti.com>
> > + *
> > + * MMC definitions for OMAP2
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#define    OMAP_PR785_MMC1_VSET    0
> > +#define    OMAP_PR785_MMC1_CD      140
> > +#define    OMAP_PR785_MMC1_EN      9
> > +#define    OMAP_PR785_MMC1_CD_MSK  ((1<<12))
> > +
> > +struct pr785_hsmmc_info {
> > +   u8      mmc;            /* controller 1/2/3 */
> > +   u8      wires;          /* 1/4/8 wires */
> > +   int     gpio_cd;        /* or -EINVAL */
> > +   int     gpio_wp;        /* or -EINVAL */
> > +};
> > +
> > +#if        defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
> > +   defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
> > +
> > +void pr785_hsmmc_init(struct pr785_hsmmc_info *);
> > +
> > +#else
> > +
> > +static inline void pr785_hsmmc_init(struct pr785_hsmmc_info *info)
> > +{
> > +}
> > +
> > +#endif
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> > index c1b66ca..8d90c61 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -917,7 +917,7 @@ static int __init omap_mmc_probe(struct platform_device
> *pdev)
> >     struct mmc_host *mmc;
> >     struct mmc_omap_host *host = NULL;
> >     struct resource *res;
> > -   int ret = 0, irq, reg;
> > +   int ret = 0, irq;
> >     u32 hctl, capa;
> >
> >     if (pdata == NULL) {
> > --
> > 1.5.6
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

