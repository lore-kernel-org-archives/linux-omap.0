From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+ PM: Add support for TPS62361
Date: Mon, 7 May 2012 10:38:19 +0300
Message-ID: <1336376299.2149.249.camel@sokoban>
References: <1336139842-845-1-git-send-email-t-kristo@ti.com>
	 <1336139842-845-4-git-send-email-t-kristo@ti.com>
	 <20120504220046.GA20795@senorita.am.dhcp.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47692 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194Ab2EGHi0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 03:38:26 -0400
In-Reply-To: <20120504220046.GA20795@senorita.am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Fri, 2012-05-04 at 17:00 -0500, Nishanth Menon wrote:
> On 16:57-20120504, Tero Kristo wrote:
> > From: Vishwanath BS <vishwanath.bs@ti.com>
> > 
> > TPS62361 is a new PMIC used with OMAP4460 on SDP4430 platform
> > and panda board ES to supply MPU VDD.
> > Rest of the VDDs continue to be supplied via TWL6030.
> > 
> > As part of this, the following have been moved to common
> > location in voltage.h
> > OMAP4_VP_CONFIG_ERROROFFSET, OMAP4_VP_VSTEPMIN_VSTEPMIN,
> > OMAP4_VP_VSTEPMAX_VSTEPMAX, OMAP4_VP_VLIMITTO_TIMEOUT_US
> > 
> > [nm@ti.com: cleaned up TPS to handle board variations]
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > [t-kristo@ti.com: minor cleanup, added panda board support]
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/Kconfig            |    9 ++
> >  arch/arm/mach-omap2/Makefile           |    1 +
> >  arch/arm/mach-omap2/board-4430sdp.c    |   10 ++
> >  arch/arm/mach-omap2/board-omap4panda.c |    8 +
> >  arch/arm/mach-omap2/omap_tps6236x.c    |  247 ++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/omap_twl.c         |    5 -
> >  arch/arm/mach-omap2/twl-common.c       |    1 +
> >  arch/arm/mach-omap2/twl-common.h       |   16 ++
> >  arch/arm/mach-omap2/voltage.h          |    5 +
> >  9 files changed, 297 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/omap_tps6236x.c
> > 
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index 8141b76..a147f00 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -334,6 +334,7 @@ config MACH_OMAP_4430SDP
> >  	select OMAP_PACKAGE_CBL
> >  	select OMAP_PACKAGE_CBS
> >  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
> > +	select OMAP_TPS6236X
> >  
> >  config MACH_OMAP4_PANDA
> >  	bool "OMAP4 Panda Board"
> > @@ -342,6 +343,7 @@ config MACH_OMAP4_PANDA
> >  	select OMAP_PACKAGE_CBL
> >  	select OMAP_PACKAGE_CBS
> >  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
> > +	select OMAP_TPS6236X
> >  
> >  config OMAP3_EMU
> >  	bool "OMAP3 debugging peripherals"
> > @@ -384,6 +386,13 @@ config OMAP4_ERRATA_I688
> >  	  In MPU case, L3 T2ASYNC FIFO and DDR T2ASYNC FIFO needs to be drained.
> >  	  IO barrier ensure that there is no synchronisation loss on initiators
> >  	  operating on both interconnect port simultaneously.
> > +
> > +config OMAP_TPS6236X
> > +	bool "OMAP4 support for TPS6236X power IC"
> > +	help
> > +	  TPS62361 is a PMIC used with OMAP4460 to supply MPU VDD voltage.
> > +	  Rest of the VDDs continue to be supplied via TWL6030.
> > +
> >  endmenu
> >  
> >  endif
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > index 49f92bc..58861a2 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -22,6 +22,7 @@ obj-y += mcbsp.o
> >  endif
> >  
> >  obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
> > +obj-$(CONFIG_OMAP_TPS6236X) += omap_tps6236x.o
> >  
> >  # SMP support ONLY available for OMAP4
> >  obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> > index a39fc4b..58fbf64 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -63,6 +63,8 @@
> >  #define GPIO_WIFI_PMENA		54
> >  #define GPIO_WIFI_IRQ		53
> >  
> > +#define TPS62361_GPIO   7
> > +
> >  static const int sdp4430_keymap[] = {
> >  	KEY(0, 0, KEY_E),
> >  	KEY(0, 1, KEY_R),
> > @@ -958,6 +960,14 @@ static void __init omap_4430sdp_init(void)
> >  		pr_err("Keypad initialization failed: %d\n", status);
> >  
> >  	omap_4430sdp_display_init();
> > +
> > +	if (cpu_is_omap446x()) {
> > +		/* Vsel0 = gpio, vsel1 = gnd */
> > +		status = omap_tps6236x_board_setup(true, TPS62361_GPIO, -1,
> > +					OMAP_PIN_OFF_OUTPUT_HIGH, -1);
> > +		if (status)
> > +			pr_err("TPS62361 initialization failed: %d\n", status);
> > +	}
> >  }
> >  
> >  MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
> > diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> > index d8c0e89..5b5a6bc 100644
> > --- a/arch/arm/mach-omap2/board-omap4panda.c
> > +++ b/arch/arm/mach-omap2/board-omap4panda.c
> > @@ -55,6 +55,7 @@
> >  #define HDMI_GPIO_CT_CP_HPD 60 /* HPD mode enable/disable */
> >  #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
> >  #define HDMI_GPIO_HPD  63 /* Hotplug detect */
> > +#define TPS62361_GPIO 7 /* Vsel0 control for TPS62361 */
> >  
> >  /* wl127x BT, FM, GPS connectivity chip */
> >  static int wl1271_gpios[] = {46, -1, -1};
> > @@ -572,6 +573,13 @@ static void __init omap4_panda_init(void)
> >  	omap4_ehci_init();
> >  	usb_musb_init(&musb_board_data);
> >  	omap4_panda_display_init();
> > +	if (cpu_is_omap446x()) {
> > +		/* vsel0 = gpio, vsel1 = gnd */
> > +		ret = omap_tps6236x_board_setup(true, TPS62361_GPIO, -1,
> > +				OMAP_PIN_OFF_OUTPUT_HIGH, -1);
> > +		if (ret)
> > +			pr_err("TPS62361 initialization failed: %d\n", ret);
> > +	}
> >  }
> >  
> >  MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
> > diff --git a/arch/arm/mach-omap2/omap_tps6236x.c b/arch/arm/mach-omap2/omap_tps6236x.c
> > new file mode 100644
> > index 0000000..84b07c2
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/omap_tps6236x.c
> > @@ -0,0 +1,247 @@
> > +/*
> > + * OMAP and TPS6236x specific initialization
> > + *
> > + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> > + * Vishwanath BS
> > + * Nishanth Menon
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/gpio.h>
> > +#include <linux/i2c/twl.h>
> > +
> > +#include "pm.h"
> > +#include "vc.h"
> > +#include "mux.h"
> > +#include "twl-common.h"
> > +
> > +/* Voltage limits supported */
> > +#define MIN_VOLTAGE_TPS62360_62_UV	770000
> > +#define MAX_VOLTAGE_TPS62360_62_UV	1400000
> > +
> > +#define MIN_VOLTAGE_TPS62361_UV		500000
> > +#define MAX_VOLTAGE_TPS62361_UV		1770000
> > +
> > +#define MAX_VOLTAGE_RAMP_TPS6236X_UV	32000
> > +
> > +/*
> > + * This is the voltage delta between 2 values in voltage register.
> > + * when switching voltage V1 to V2, TPS62361 can ramp up or down
> > + * initially with step sizes of 20mV with a last step of 10mV.
> > + * In the case of TPS6236[0|2], it is a constant 10mV steps
> > + * we choose the 10mV step for linearity when SR is configured.
> > + */
> > +#define STEP_SIZE_TPS6236X		10000
> > +
> > +/* I2C access parameters */
> > +#define I2C_TPS6236X_SLAVE_ADDR		0x60
> > +
> > +#define DEF_SET_REG(VSEL0, VSEL1)	(((VSEL1) << 1 | (VSEL0) << 0) & 0x3)
> > +#define REG_TPS6236X_SET_0		0x00
> > +#define REG_TPS6236X_SET_1		0x01
> > +#define REG_TPS6236X_SET_2		0x02
> > +#define REG_TPS6236X_SET_3		0x03
> > +#define REG_TPS6236X_CTRL		0x04
> > +#define REG_TPS6236X_TEMP		0x05
> > +#define REG_TPS6236X_RAMP_CTRL		0x06
> > +#define REG_TPS6236X_CHIP_ID0		0x08
> > +#define REG_TPS6236X_CHIP_ID1		0x09
> > +
> > +#define MODE_TPS6236X_AUTO_PFM_PWM	0x00
> > +#define MODE_TPS6236X_FORCE_PWM		BIT(7)
> > +
> > +/* We use Auto PFM/PWM mode currently seems to have the best trade off */
> > +#define VOLTAGE_PFM_MODE_VAL		MODE_TPS6236X_AUTO_PFM_PWM
> > +
> > +#define REG_TPS6236X_RAMP_CTRL_RMP_MASK	(0x7 << 5)
> > +#define REG_TPS6236X_RAMP_CTRL_EN_DISC	BIT(2)
> > +#define REG_TPS6236X_RAMP_CTRL_RAMP_PFM	BIT(1)
> > +
> > +#define REG_TPS6236X_CTRL_PD_EN		BIT(7)
> > +#define REG_TPS6236X_CTRL_PD_VSEL0	BIT(6)
> > +#define REG_TPS6236X_CTRL_PD_VSEL1	BIT(5)
> These should be used appropriately. we have reg defines without usage.
> suggestion is - please port over the changes from the original source as
> well as there are configurations of thermal shutdown, and other
> configurations that are necessary as well.

I'll drop these out if they are not used in the current version of the
patch, I may have missed parts like this.

> 
> > +
> > +/* TWL usage */
> > +#define TWL6030_REG_SYSEN_CFG_GRP			0xB3
> > +#define TWL6030_BIT_APE_GRP				BIT(0)
> You dont really need 6030 defines here in tps file now do you?

Yea true, similar to above.

> > +
> > +/* Which register do we use by default? */
> > +static int __initdata default_reg = -1;
> > +
> > +/* Do we need to setup internal pullups? */
> > +static int __initdata pd_vsel0 = -1;
> > +static int __initdata pd_vsel1 = -1;
> > +
> > +static int __init _bd_setup(char *name, int gpio_vsel, int *pull, int *pd_vsel)
> > +{
> > +	int pull_dir;
> > +	int r;
> > +
> > +	if (gpio_vsel == -1) {
> > +		if (*pull != -1) {
> > +			*pd_vsel = (*pull == OMAP_PIN_OFF_OUTPUT_HIGH);
> I think a better mechanism to choose the pull should be used IMHO.

Hmm, I'll look at this and see if I can figure out something better.

> > +			*pull = *pd_vsel;
> > +		} else {
> > +			*pull = 0;
> > +		}
> > +		return 0;
> > +	}
> > +
> > +	/* if we have a pull gpio, with bad dir, pull low */
> > +	if (*pull == -1 || (*pull != OMAP_PIN_OFF_OUTPUT_HIGH &&
> > +				*pull != OMAP_PIN_OFF_OUTPUT_LOW))
> > +		*pull = OMAP_PIN_OFF_OUTPUT_LOW;
> We dont need to set OFF_OUTPUT on OMAP4 as these are automatically
> latched when going to OFF.

True again, I'll drop these out.

> > +
> > +	r = omap_mux_init_gpio(gpio_vsel, *pull);
> > +	if (r) {
> > +		pr_err("%s: unable to mux gpio%d=%d\n", __func__,
> > +			gpio_vsel, r);
> > +		goto out;
> > +	}
> > +
> > +	pull_dir = (*pull == OMAP_PIN_OFF_OUTPUT_HIGH);
> > +	*pull = pull_dir;
> note below
> > +
> > +	r = gpio_request(gpio_vsel, name);
> > +	if (r) {
> > +		pr_err("%s: unable to req gpio%d=%d\n", __func__,
> > +			gpio_vsel, r);
> > +		goto out;
> > +	}
> > +	r = gpio_direction_output(gpio_vsel, pull_dir);
> > +	if (r) {
> > +		pr_err("%s: unable to pull[%d] gpio%d=%d\n", __func__,
> > +			gpio_vsel, pull_dir, r);
> > +		gpio_free(gpio_vsel);
> > +		goto out;
> > +	}
> > +out:
> > +	return r;
> > +}
> > +
> > +static unsigned long tps6236x_vsel_to_uv(const u8 vsel);
> > +static u8 tps6236x_uv_to_vsel(unsigned long uv);
> > +
> > +static struct omap_voltdm_pmic omap4_mpu_pmic = {
> > +	.slew_rate		= 8000,
> without programing the slew rate, it is a bad idea to use the default
> here considering we can go to 32mV/uSec by programing the
> register

Well, the main point with this patch is to provide minimal support for
tps chip, I don't want to try and put all possible features in the first
version. The missing features / optimizations can be added later once we
have at least something in.

> > +	.step_size		= STEP_SIZE_TPS6236X,
> > +	.startup_time		= 1000,
> > +	.shutdown_time		= 1,
> > +	.vddmin			= MIN_VOLTAGE_TPS62361_UV,
> > +	.vddmax			= MAX_VOLTAGE_TPS62361_UV,
> > +	.volt_setup_time	= 0,
> > +	.vp_erroroffset		= OMAP4_VP_CONFIG_ERROROFFSET,
> > +	.vp_vstepmin		= OMAP4_VP_VSTEPMIN_VSTEPMIN,
> > +	.vp_vstepmax		= OMAP4_VP_VSTEPMAX_VSTEPMAX,
> > +	.vp_timeout_us		= OMAP4_VP_VLIMITTO_TIMEOUT_US,
> > +	.i2c_slave_addr		= I2C_TPS6236X_SLAVE_ADDR,
> > +	.volt_reg_addr		= REG_TPS6236X_SET_0,
> > +	.cmd_reg_addr		= REG_TPS6236X_SET_0,
> > +	.i2c_high_speed		= true,
> > +	.vsel_to_uv		= tps6236x_vsel_to_uv,
> > +	.uv_to_vsel		= tps6236x_uv_to_vsel,
> > +};
> > +
> > +static unsigned long tps6236x_vsel_to_uv(const u8 vsel)
> > +{
> > +	return omap4_mpu_pmic.vddmin +
> > +		(STEP_SIZE_TPS6236X * (vsel & ~VOLTAGE_PFM_MODE_VAL));
> > +}
> > +
> > +static u8 tps6236x_uv_to_vsel(unsigned long uv)
> > +{
> > +	if (!uv)
> > +		return 0;
> > +
> > +	/* Round off requests to limits */
> > +	if (uv > omap4_mpu_pmic.vddmax) {
> > +		pr_err("%s:Request for overvoltage[%ld] than supported[%u]\n",
> > +				__func__, uv, omap4_mpu_pmic.vddmax);
> > +		uv = omap4_mpu_pmic.vddmax;
> > +	}
> > +	if (uv < omap4_mpu_pmic.vddmin) {
> > +		pr_err("%s:Request for undervoltage[%ld] than supported[%u]\n",
> > +				__func__, uv, omap4_mpu_pmic.vddmin);
> > +		uv = omap4_mpu_pmic.vddmin;
> > +	}
> > +	return DIV_ROUND_UP(uv - omap4_mpu_pmic.vddmin, STEP_SIZE_TPS6236X) |
> > +			VOLTAGE_PFM_MODE_VAL;
> > +}
> > +
> > +static __initdata struct omap_pmic_map omap_tps_map[] = {
> > +	{
> > +		.name = "mpu",
> > +		.cpu = PMIC_CPU_OMAP4460,
> > +		.pmic_data = &omap4_mpu_pmic,
> > +	},
> > +	/* Terminator */
> > +	{ .name = NULL, .pmic_data = NULL},
> > +};
> > +
> > +int __init omap_tps6236x_init(void)
> > +{
> > +	struct omap_pmic_map *map;
> > +
> > +	/* Without registers, I wont proceed */
> > +	if (default_reg == -1)
> > +		return -EINVAL;
> > +
> > +	map = omap_tps_map;
> > +
> > +	/* setup all the pmic's voltage addresses to the default one */
> > +	while (map->name) {
> > +		map->pmic_data->volt_reg_addr = default_reg;
> > +		map->pmic_data->cmd_reg_addr = default_reg;
> > +		map++;
> > +	}
> > +
> > +	return omap_pmic_register_data(omap_tps_map);
> > +}
> > +
> > +/**
> > + * omap_tps6236x_board_setup() - provide the board config for TPS connect
> > + * @use_62361:	Do we use TPS62361 variant?
> > + * @gpio_vsel0:	If using GPIO to control VSEL0, provide gpio number, else -1
> > + * @gpio_vsel1:	If using GPIO to control VSEL1, provide gpio number, else -1
> > + * @pull0:	If using GPIO, provide mux mode OMAP_PIN_OFF_OUTPUT_[HIGH|LOW]
> > + *		else provide any internal pull required, -1 if unused.
> > + * @pull1:	If using GPIO, provide mux mode OMAP_PIN_OFF_OUTPUT_[HIGH|LOW]
> > + *		else provide any internal pull required, -1 if unused.
> > + *
> > + * TPS6236x variants of PMIC can be hooked in numerous combinations on to the
> > + * board. Some platforms can choose to hardwire and save on a GPIO for other
> > + * uses, while others may hook a single line for GPIO control and may ground
> > + * the other line. support these configurations.
> > + *
> > + * WARNING: for platforms using GPIO, be careful to provide MUX setting
> > + * considering OFF mode configuration as well.
> > + */
> > +int __init omap_tps6236x_board_setup(bool use_62361, int gpio_vsel0,
> > +		int gpio_vsel1, int pull0, int pull1)
> > +{
> > +	int r;
> > +
> > +	r = _bd_setup("tps6236x_vsel0", gpio_vsel0, &pull0, &pd_vsel0);
> > +	if (r)
> > +		goto out;
> > +	r = _bd_setup("tps6236x_vsel1", gpio_vsel1, &pull1, &pd_vsel1);
> > +	if (r) {
> > +		if (gpio_vsel0 != -1)
> > +			gpio_free(gpio_vsel0);
> > +		goto out;
> > +	}
> > +
> > +	default_reg = ((pull1 & 0x1) << 1) | (pull0 & 0x1);
> it is a better idea not to reuse the same old variable as the meaning
> changes at this point from pointing at OFF state config. the variable no
> longer contains the pull param passed as input as it has been modified
> by _bd_setup

Not sure what you mean by this, default_reg only is used for indicating
the register address used for voltage control. It is initialized based
on the vsel0 and vsel1 values going to the tps chip.... A comment here
would be good though.

> > +
> > +	if (!use_62361) {
> > +		omap4_mpu_pmic.vddmin = MIN_VOLTAGE_TPS62360_62_UV;
> > +		omap4_mpu_pmic.vddmax = MAX_VOLTAGE_TPS62360_62_UV;
> > +	}
> > +out:
> > +	return r;
> > +}
> > diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> > index c8e418e..fef14df 100644
> > --- a/arch/arm/mach-omap2/omap_twl.c
> > +++ b/arch/arm/mach-omap2/omap_twl.c
> > @@ -38,11 +38,6 @@
> >  #define OMAP4_VDD_CORE_SR_VOLT_REG	0x61
> >  #define OMAP4_VDD_CORE_SR_CMD_REG	0x62
> >  
> > -#define OMAP4_VP_CONFIG_ERROROFFSET	0x00
> > -#define OMAP4_VP_VSTEPMIN_VSTEPMIN	0x01
> > -#define OMAP4_VP_VSTEPMAX_VSTEPMAX	0x04
> > -#define OMAP4_VP_VLIMITTO_TIMEOUT_US	200
> > -
> >  static bool is_offset_valid;
> >  static u8 smps_offset;
> >  /*
> > diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> > index 2588e04..ec802d8 100644
> > --- a/arch/arm/mach-omap2/twl-common.c
> > +++ b/arch/arm/mach-omap2/twl-common.c
> > @@ -78,6 +78,7 @@ void __init omap_pmic_late_init(void)
> >  		return;
> >  
> >  	omap_twl_init();
> > +	omap_tps6236x_init();
> >  }
> >  
> >  #if defined(CONFIG_ARCH_OMAP3)
> > diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
> > index 2f805a3..0655efc 100644
> > --- a/arch/arm/mach-omap2/twl-common.h
> > +++ b/arch/arm/mach-omap2/twl-common.h
> > @@ -86,4 +86,20 @@ struct omap_pmic_map {
> >  extern int omap_pmic_register_data(struct omap_pmic_map *map);
> >  extern void omap_pmic_data_init(void);
> >  
> > +#ifdef CONFIG_OMAP_TPS6236X
> > +extern int omap_tps6236x_board_setup(bool use_62361, int gpio_vsel0,
> > +			int gpio_vsel1, int pull0, int pull1);
> > +extern int omap_tps6236x_init(void);
> > +#else
> > +static inline int omap_tps6236x_board_setup(bool use_62361, int gpio_vsel0,
> > +			int gpio_vsel1, int pull0, int pull1)
> > +{
> > +	return -EINVAL;
> > +}
> > +static inline int omap_tps6236x_init(void)
> > +{
> > +	return -EINVAL;
> > +}
> > +#endif
> makes no sense to have this in twl-common.h - this is a different PMIC.
> This standard is not scalable if I need to define a new set of PMICs to
> use.

How about renaming twl-common.* to omap-pmic.*? I was thinking about
doing this before posting the patch but decided to drop the idea for
this version.

> 
> > +
> >  #endif /* __OMAP_PMIC_COMMON__ */
> > diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> > index 54b959c..ac68a0e 100644
> > --- a/arch/arm/mach-omap2/voltage.h
> > +++ b/arch/arm/mach-omap2/voltage.h
> > @@ -138,6 +138,11 @@ struct omap_volt_data {
> >  #define OMAP4_VP_CORE_VLIMITTO_VDDMIN	830000
> >  #define OMAP4_VP_CORE_VLIMITTO_VDDMAX	1200000
> >  
> > +#define OMAP4_VP_CONFIG_ERROROFFSET	0x00
> > +#define OMAP4_VP_VSTEPMIN_VSTEPMIN	0x01
> > +#define OMAP4_VP_VSTEPMAX_VSTEPMAX	0x04
> > +#define OMAP4_VP_VLIMITTO_TIMEOUT_US	200
> > +
> >  /**
> >   * struct omap_voltdm_pmic - PMIC specific data required by voltage driver.
> >   * @slew_rate:	PMIC slew rate (in uv/us)
> 
> One more point to consider is that with this - we *should* disable
> VCORE3 and VMEM else we can have weird behavior such as those seen
> by pandaboard-ES early adopters.

In what case are we seeing such? If the regulators should be disabled,
maybe we should do it already in bootloader.

-Tero

