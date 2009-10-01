From: Amit Kucheria <amit.kucheria@canonical.com>
Subject: Re: [PATCH v3 01/04] OMAP4: PMIC: Add support for twl6030 irq
 framework
Date: Thu, 1 Oct 2009 16:16:16 +0300
Message-ID: <20091001131616.GU32041@smtp.gmail.com>
References: <1254399807-3909-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:58193 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962AbZJANQd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 09:16:33 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1738016fge.1
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 06:16:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1254399807-3909-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balajitk@ti.com
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, p_gortmaker@yahoo.com, a.zummo@towertech.it, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Balaji,

Some comments inline.

On 09 Oct 01, balajitk@ti.com wrote:
> From: Balaji T K <balajitk@ti.com>
> 
> This version of patch series enables RUN TIME selection of TWL4030 or TWL6030.
> CONFIG_TWL4030_CORE and CONFIG_TWL6030_CORE is replaced by CONFIG_TWL_CORE
> 
> This patch adds support for phoenix interrupt framework. New Interrupt status
> register A, B, C are introduced in Phoenix and are cleared on write.
> Due to difference in interrupt handling with respect to TWL4030,
> twl6030-irq.c is created for TWL6030 PMIC
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/include/mach/irqs.h |   18 ++-
>  drivers/mfd/Kconfig                    |    6 +-
>  drivers/mfd/Makefile                   |    2 +-
>  drivers/mfd/twl-core.c                 |  124 ++++++++++++--
>  drivers/mfd/twl4030-irq.c              |    4 +-
>  drivers/mfd/twl6030-irq.c              |  299 ++++++++++++++++++++++++++++++++
>  include/linux/i2c/twl.h                |   62 +++++++
>  7 files changed, 495 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/mfd/twl6030-irq.c
> 
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
> index fb7cb77..e9e0500 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -531,7 +531,7 @@
>  
>  /* External TWL4030 can handle interrupts on 2430 and 34xx boards */
>  #define	TWL4030_IRQ_BASE	(OMAP_FPGA_IRQ_END)
> -#ifdef	CONFIG_TWL4030_CORE
> +#ifdef	CONFIG_TWL_CORE
>  #define	TWL4030_BASE_NR_IRQS	8
>  #define	TWL4030_PWR_NR_IRQS	8
>  #else
> @@ -551,8 +551,22 @@
>  #endif
>  #define TWL4030_GPIO_IRQ_END	(TWL4030_GPIO_IRQ_BASE + TWL4030_GPIO_NR_IRQS)
>  
> +#define	TWL6030_IRQ_BASE	(OMAP_FPGA_IRQ_END)
> +#ifdef CONFIG_TWL_CORE
> +#define	TWL6030_BASE_NR_IRQS	20
> +#else
> +#define	TWL6030_BASE_NR_IRQS	0
> +#endif
> +#define TWL6030_IRQ_END		(TWL6030_IRQ_BASE + TWL6030_BASE_NR_IRQS)
> +
>  /* Total number of interrupts depends on the enabled blocks above */
> -#define NR_IRQS			TWL4030_GPIO_IRQ_END
> +#if (TWL4030_GPIO_IRQ_END > TWL6030_IRQ_END)
> +#define TWL_IRQ_END 		TWL4030_GPIO_IRQ_END
> +#else
> +#define TWL_IRQ_END		TWL6030_IRQ_END
> +#endif
> +
> +#define NR_IRQS			TWL_IRQ_END
>  
>  #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
>  
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 491ac0f..c714281 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -94,11 +94,11 @@ config MENELAUS
>  	  and other features that are often used in portable devices like
>  	  cell phones and PDAs.
>  
> -config TWL4030_CORE
> -	bool "Texas Instruments TWL4030/TPS659x0 Support"
> +config TWL_CORE
> +	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
>  	depends on I2C=y && GENERIC_HARDIRQS
>  	help
> -	  Say yes here if you have TWL4030 family chip on your board.
> +	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
>  	  This core driver provides register access and IRQ handling
>  	  facilities, and registers devices for the various functions
>  	  so that function-specific drivers can bind to them.
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 4e9d513..c733440 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -22,7 +22,7 @@ obj-$(CONFIG_MFD_WM8350_I2C)	+= wm8350-i2c.o
>  obj-$(CONFIG_TPS65010)		+= tps65010.o
>  obj-$(CONFIG_MENELAUS)		+= menelaus.o
>  
> -obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o
> +obj-$(CONFIG_TWL_CORE)		+= twl-core.o twl4030-irq.o twl6030-irq.o
>  
>  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
>  
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 62ace48..73d50c9 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -158,6 +158,33 @@
>  /* Triton Core internal information (END) */
>  
>  
> +/* subchip/slave 0 0x48 - POWER */
> +#define TWL6030_BASEADD_RTC		0x0000
> +#define TWL6030_BASEADD_MEM		0x0017
> +#define TWL6030_BASEADD_PM_MASTER	0x001F
> +#define TWL6030_BASEADD_PM_SLAVE_MISC	0x0031
> +#define TWL6030_BASEADD_PM_SLAVE_SMPS	0x0040
> +#define TWL6030_BASEADD_PM_SLAVE_LDO	0x0080
> +#define TWL6030_BASEADD_PM_SLAVE_RES	0x00AD
> +#define TWL6030_BASEADD_PM_MISC		0x00E2
> +#define TWL6030_BASEADD_PM_PUPD		0x00F0
> +
> +/* subchip/slave 1 0x49 - FEATURE */
> +#define TWL6030_BASEADD_USB		0x0000
> +#define TWL6030_BASEADD_GPADC_CTRL	0x002E
> +#define TWL6030_BASEADD_AUX		0x0090
> +#define TWL6030_BASEADD_PWM		0x00BA
> +#define TWL6030_BASEADD_GASGAUGE	0x00C0
> +#define TWL6030_BASEADD_PIH		0x00D0
> +#define TWL6030_BASEADD_CHARGER		0x00E0
> +
> +/* subchip/slave 2 0x4A - DFT */
> +#define TWL6030_BASEADD_DIEID		0x00C0
> +
> +/* subchip/slave 3 0x4B - AUDIO */
> +#define TWL6030_BASEADD_AUDIO		0x0000
> +#define TWL6030_BASEADD_RSV		0x0000
> +
>  /* Few power values */
>  #define R_CFG_BOOT			0x05
>  #define R_PROTECT_KEY			0x0E
> @@ -177,13 +204,19 @@
>  /* chip-specific feature flags, for i2c_device_id.driver_data */
>  #define TWL4030_VAUX2		BIT(0)	/* pre-5030 voltage ranges */
>  #define TPS_SUBSET		BIT(1)	/* tps659[23]0 have fewer LDOs */
> +#define TWL6030_CLASS	BIT(2)	/* TWL6030 class */
>  
>  /*----------------------------------------------------------------------*/
>  
>  /* is driver active, bound to a chip? */
>  static bool inuse;
>  
> -/* Structure for each TWL4030 Slave */
> +static unsigned int twl_id;
> +unsigned int twl_rev(void)
> +{
> +	return twl_id;
> +}
> +/* Structure for each TWL4030/TWL6030 Slave */
>  struct twl_client {
>  	struct i2c_client *client;
>  	u8 address;
> @@ -203,11 +236,12 @@ struct twl_mapping {
>  	unsigned char sid;	/* Slave ID */
>  	unsigned char base;	/* base address */
>  };
> +struct twl_mapping *twl_map;
>  
>  static struct twl_mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
>  	/*
>  	 * NOTE:  don't change this table without updating the
> -	 * <linux/i2c/twl4030.h> defines for TWL4030_MODULE_*
> +	 * <linux/i2c/twl.h> defines for TWL4030_MODULE_*
>  	 * so they continue to match the order in this table.
>  	 */
>  
> @@ -238,6 +272,48 @@ static struct twl_mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
>  	{ 3, TWL4030_BASEADD_SECURED_REG },
>  };
>  
> +static struct twl_mapping twl6030_map[] = {
> +	/*
> +	 * NOTE:  don't change this table without updating the
> +	 * <linux/i2c/twl.h> defines for TWL6030_MODULE_*
> +	 * so they continue to match the order in this table.
> +	 */
> +	{ SUB_CHIP_ID1, TWL6030_BASEADD_USB },
> +	{ SUB_CHIP_ID3, TWL6030_BASEADD_AUDIO },
> +	{ SUB_CHIP_ID2, TWL6030_BASEADD_DIEID },
> +	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> +	{ SUB_CHIP_ID1, TWL6030_BASEADD_PIH },
> +
> +	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> +	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> +	{ SUB_CHIP_ID1, TWL6030_BASEADD_GPADC_CTRL },
> +	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> +	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> +
> +	{ SUB_CHIP_ID1, TWL6030_BASEADD_CHARGER },
> +	{ SUB_CHIP_ID1, TWL6030_BASEADD_GASGAUGE },
> +	{ SUB_CHIP_ID1, TWL6030_BASEADD_PWM },
> +	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> +	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> +
> +	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> +	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> +	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> +	{ SUB_CHIP_ID0, TWL6030_BASEADD_PM_MASTER },
> +	{ SUB_CHIP_ID0, TWL6030_BASEADD_PM_SLAVE_MISC },
> +
> +	{ SUB_CHIP_ID0, TWL6030_BASEADD_RTC },
> +	{ SUB_CHIP_ID0, TWL6030_BASEADD_PM_SLAVE_SMPS },
> +	{ SUB_CHIP_ID0, TWL6030_BASEADD_PM_SLAVE_LDO },
> +	{ SUB_CHIP_ID0, TWL6030_BASEADD_MEM },
> +
> +	{ SUB_CHIP_ID0, TWL6030_BASEADD_PM_SLAVE_RES },
> +	{ SUB_CHIP_ID0, TWL6030_BASEADD_PM_MISC },
> +	{ SUB_CHIP_ID0, TWL6030_BASEADD_PM_PUPD },
> +	{ SUB_CHIP_ID1, TWL6030_BASEADD_AUX },
> +
> +};
> +
>  /*----------------------------------------------------------------------*/
>  
>  /* Exported Functions */
> @@ -265,7 +341,7 @@ int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
>  		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
>  		return -EPERM;
>  	}
> -	sid = twl4030_map[mod_no].sid;
> +	sid = twl_map[mod_no].sid;
>  	twl = &twl_modules[sid];
>  
>  	if (unlikely(!inuse)) {
> @@ -283,7 +359,7 @@ int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
>  	msg->flags = 0;
>  	msg->buf = value;
>  	/* over write the first byte of buffer with the register address */
> -	*value = twl4030_map[mod_no].base + reg;
> +	*value = twl_map[mod_no].base + reg;
>  	ret = i2c_transfer(twl->client->adapter, twl->xfer_msg, 1);
>  	mutex_unlock(&twl->xfer_lock);
>  
> @@ -315,7 +391,7 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
>  		pr_err("%s: invalid module number %d\n", DRIVER_NAME, mod_no);
>  		return -EPERM;
>  	}
> -	sid = twl4030_map[mod_no].sid;
> +	sid = twl_map[mod_no].sid;
>  	twl = &twl_modules[sid];
>  
>  	if (unlikely(!inuse)) {
> @@ -328,7 +404,7 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
>  	msg->addr = twl->address;
>  	msg->len = 1;
>  	msg->flags = 0;	/* Read the register value */
> -	val = twl4030_map[mod_no].base + reg;
> +	val = twl_map[mod_no].base + reg;
>  	msg->buf = &val;
>  	/* [MSG2] fill the data rx buffer */
>  	msg = &twl->xfer_msg[1];
> @@ -445,6 +521,7 @@ add_regulator_linked(int num, struct regulator_init_data *pdata,
>  		struct regulator_consumer_supply *consumers,
>  		unsigned num_consumers)
>  {
> +	unsigned sub_chip_id;
>  	/* regulator framework demands init_data ... */
>  	if (!pdata)
>  		return NULL;
> @@ -455,7 +532,8 @@ add_regulator_linked(int num, struct regulator_init_data *pdata,
>  	}
>  
>  	/* NOTE:  we currently ignore regulator IRQs, e.g. for short circuits */
> -	return add_numbered_child(3, "twl_reg", num,
> +	sub_chip_id = twl_map[TWL_MODULE_PM_MASTER].sid;
> +	return add_numbered_child(sub_chip_id, "twl_reg", num,
>  		pdata, sizeof(*pdata), false, 0, 0);
>  }
>  
> @@ -476,6 +554,7 @@ add_children(struct twl_platform_data *pdata, unsigned long features)
>  {
>  	struct device	*child;
>  	struct device	*usb_transceiver = NULL;
> +	unsigned sub_chip_id;
>  
>  	if (twl_has_bci() && pdata->bci && !(features & TPS_SUBSET)) {
>  		child = add_child(3, "twl4030_bci",
> @@ -520,7 +599,8 @@ add_children(struct twl_platform_data *pdata, unsigned long features)
>  		 * Eventually, Linux might become more aware of such
>  		 * HW security concerns, and "least privilege".
>  		 */
> -		child = add_child(3, "twl_rtc",
> +		sub_chip_id = twl_map[TWL_MODULE_RTC].sid;
> +		child = add_child(sub_chip_id, "twl_rtc",
>  				NULL, 0,
>  				true, pdata->irq_base + RTC_INTR_OFFSET, 0);
>  		if (IS_ERR(child))
> @@ -726,15 +806,21 @@ static void clocks_init(struct device *dev)
>  
>  /*----------------------------------------------------------------------*/
>  
> -int twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
> -int twl_exit_irq(void);
> +int twl4030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
> +int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
> +int twl4030_exit_irq(void);
> +int twl6030_exit_irq(void);
>  
>  static int twl_remove(struct i2c_client *client)
>  {
>  	unsigned i;
>  	int status;
>  
> -	status = twl_exit_irq();
> +	if (twl_class_is_4030())
> +		status = twl4030_exit_irq();
> +	else
> +		status = twl6030_exit_irq();
> +
>  	if (status < 0)
>  		return status;
>  
> @@ -793,6 +879,13 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		mutex_init(&twl->xfer_lock);
>  	}
>  	inuse = true;
> +	if ((id->driver_data) & TWL6030_CLASS) {
> +		twl_id = TWL6030_CLASS_ID;
> +		twl_map = &twl6030_map[0];
> +	} else {
> +		twl_id = TWL4030_CLASS_ID;
> +		twl_map = &twl4030_map[0];
> +	}
>  
>  	/* setup clock framework */
>  	clocks_init(&client->dev);
> @@ -801,7 +894,13 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	if (client->irq
>  			&& pdata->irq_base
>  			&& pdata->irq_end > pdata->irq_base) {
> -		status = twl_init_irq(client->irq, pdata->irq_base, pdata->irq_end);
> +		if (twl_class_is_4030()) {
> +			status = twl4030_init_irq(client->irq, pdata->irq_base,
> +			pdata->irq_end);
> +		} else {
> +			status = twl6030_init_irq(client->irq, pdata->irq_base,
> +			pdata->irq_end);
> +		}
>  		if (status < 0)
>  			goto fail;
>  	}
> @@ -819,6 +918,7 @@ static const struct i2c_device_id twl_ids[] = {
>  	{ "tps65950", 0 },		/* catalog version of twl5030 */
>  	{ "tps65930", TPS_SUBSET },	/* fewer LDOs and DACs; no charger */
>  	{ "tps65920", TPS_SUBSET },	/* fewer LDOs; no codec or charger */
> +	{ "twl6030", TWL6030_CLASS },	/* "Phoenix power chip" */
>  	{ /* end of list */ },
>  };
>  MODULE_DEVICE_TABLE(i2c, twl_ids);
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index 2b0cdff..abe99ae 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -668,7 +668,7 @@ int twl4030_sih_setup(int module)
>  /* FIXME pass in which interrupt line we'll use ... */
>  #define twl_irq_line	0
>  
> -int twl_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
> +int twl4030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
>  {
>  	static struct irq_chip	twl4030_irq_chip;
>  
> @@ -747,7 +747,7 @@ fail:
>  	return status;
>  }
>  
> -int twl_exit_irq(void)
> +int twl4030_exit_irq(void)
>  {
>  	/* FIXME undo twl_init_irq() */
>  	if (twl4030_irq_base) {
> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
> new file mode 100644
> index 0000000..4293c02
> --- /dev/null
> +++ b/drivers/mfd/twl6030-irq.c
> @@ -0,0 +1,299 @@
> +/*
> + * twl6030-irq.c - TWL6030 irq support
> + *
> + * Copyright (C) 2005-2009 Texas Instruments, Inc.
> + *
> + * Modifications to defer interrupt handling to a kernel thread:
> + * Copyright (C) 2006 MontaVista Software, Inc.
> + *
> + * Based on tlv320aic23.c:
> + * Copyright (c) by Kai Svahn <kai.svahn@nokia.com>
> + *
> + * Code cleanup and modifications to IRQ handler.
> + * by syed khasim <x0khasim@ti.com>
> + *
> + * TWL6030 specific code and IRQ handling changes by
> + * Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> + * Balaji T K <balajitk@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kthread.h>
> +#include <linux/i2c/twl.h>
> +
> +/*
> + * TWL6030 (unlike its predecessors, which had two level interrupt handling)
> + * three interrupt registers INT_STS_A, INT_STS_B and INT_STS_C.
> + * It exposes status bits saying who has raised an interrupt. There are
> + * three mask registers that corresponds to these status registers, that
> + * enables/disables these interrupts.
> + *
> + * We set up IRQs starting at a platform-specified base. An interrupt map table,
> + * specifies mapping between interrupt number and the associated module.
> + *
> + */
> +
> +static int twl6030_interrupt_mapping[24] = {
> +	PWR_INTR_OFFSET,	/* Bit 0	PWRON			*/
> +	PWR_INTR_OFFSET,	/* Bit 1	RPWRON			*/
> +	PWR_INTR_OFFSET,	/* Bit 2	BAT_VLOW		*/
> +	PWR_INTR_OFFSET,	/* Bit 3	VBAT			*/
> +	RTC_INTR_OFFSET,	/* Bit 4	RTC_ALARM		*/
> +	RTC_INTR_OFFSET,	/* Bit 5	RTC_PERIOD		*/
> +	HOTDIE_INTR_OFFSET,	/* Bit 6	HOT_DIE			*/
> +	RSV_INTR_OFFSET,  	/* Bit 7	Reserved		*/
> +
> +	SMPSLDO_INTR_OFFSET,	/* Bit 8	VXXX_SHORT		*/
> +	SMPSLDO_INTR_OFFSET,	/* Bit 9	VMMC_SHORT		*/
> +	SMPSLDO_INTR_OFFSET,	/* Bit 10	VUSIM_SHORT		*/
> +	SIMDETECT_INTR_OFFSET,	/* Bit 11	SIM			*/
> +	MMCDETECT_INTR_OFFSET,	/* Bit 12	MMC			*/
> +	GPADC_INTR_OFFSET,	/* Bit 13	GPADC_RT_EOC		*/
> +	GPADC_INTR_OFFSET,	/* Bit 14	GPADC_SW_EOC		*/
> +	GASGAUGE_INTR_OFFSET,	/* Bit 15	CC_AUTOCAL		*/
> +
> +	USBOTG_INTR_OFFSET,	/* Bit 16	ID_WKUP			*/
> +	USBOTG_INTR_OFFSET,	/* Bit 17	VBUS_WKUP		*/
> +	USBOTG_INTR_OFFSET,	/* Bit 18	ID			*/
> +	USBOTG_INTR_OFFSET,	/* Bit 19	VBUS			*/
> +	CHARGER_INTR_OFFSET,	/* Bit 20	CHRG_CTRL		*/
> +	CHARGER_INTR_OFFSET,	/* Bit 21	EXT_CHRG		*/
> +	CHARGER_INTR_OFFSET,	/* Bit 22	INT_CHRG		*/
> +	CHARGER_INTR_OFFSET,	/* Bit 23	BAT_OVT			*/
> +};
> +/*----------------------------------------------------------------------*/
> +
> +static unsigned twl6030_irq_base;
> +
> +static struct completion irq_event;
> +
> +/*
> + * This thread processes interrupts reported by the Primary Interrupt Handler.
> + */
> +static int twl6030_irq_thread(void *data)
> +{
> +	long irq = (long)data;
> +	static unsigned i2c_errors;
> +	static const unsigned max_i2c_errors = 100;
> +	int ret;
> +
> +	current->flags |= PF_NOFREEZE;
> +
> +	while (!kthread_should_stop()) {

This should not be necessary anymore with threaded irqs. See below.
>
> +		int i;
> +		union {
> +		u8 bytes[4];
> +		u32 int_sts;
> +		} sts;
> +
> +		/* Wait for IRQ, then read PIH irq status (also blocking) */
> +		wait_for_completion_interruptible(&irq_event);
> +
> +		/* read INT_STS_A, B and C in one shot using a burst read */
> +		ret = twl_i2c_read(TWL_MODULE_PIH, sts.bytes,
> +				REG_INT_STS_A, 3);
> +		if (ret) {
> +			pr_warning("twl6030: I2C error %d reading PIH ISR\n",
> +					ret);
> +			if (++i2c_errors >= max_i2c_errors) {
> +				printk(KERN_ERR "Maximum I2C error count"
> +						" exceeded.  Terminating %s.\n",
> +						__func__);
> +				break;
> +			}
> +			complete(&irq_event);
> +			continue;
> +		}
> +
> +
> +
> +		sts.bytes[3] = 0; /* Only 24 bits are valid*/
> +
> +		for (i = 0; sts.int_sts; sts.int_sts >>= 1, i++) {
> +			local_irq_disable();
> +			if (sts.int_sts & 0x1) {
> +				int module_irq = TWL6030_IRQ_BASE +
> +					twl6030_interrupt_mapping[i];
> +				struct irq_desc *d = irq_to_desc(module_irq);
> +
> +				if (!d) {
> +					pr_err("twl6030: Invalid SIH IRQ: %d\n",
> +					       module_irq);
> +					return -EINVAL;
> +				}
> +
> +				/* These can't be masked ... always warn
> +				 * if we get any surprises.
> +				 */
> +				if (d->status & IRQ_DISABLED)
> +					note_interrupt(module_irq, d,
> +							IRQ_NONE);
> +				else
> +					d->handle_irq(module_irq, d);
> +
> +			}
> +		local_irq_enable();
> +		}
> +		ret = twl_i2c_write(TWL_MODULE_PIH, sts.bytes,
> +				REG_INT_STS_A, 3); /* clear INT_STS_A */
> +		if (ret)
> +			pr_warning("twl6030: I2C error in clearing PIH ISR\n");
> +
> +		enable_irq(irq);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * handle_twl6030_int() is the desc->handle method for the twl6030 interrupt.
> + * This is a chained interrupt, so there is no desc->action method for it.
> + * Now we need to query the interrupt controller in the twl6030 to determine
> + * which module is generating the interrupt request.  However, we can't do i2c
> + * transactions in interrupt context, so we must defer that work to a kernel
> + * thread.  All we do here is acknowledge and mask the interrupt and wakeup
> + * the kernel thread.
> + */
> +static irqreturn_t handle_twl6030_pih(int irq, void *devid)
> +{
> +	disable_irq_nosync(irq);
> +	complete(devid);
> +	return IRQ_HANDLED;
> +}
> +
> +/*----------------------------------------------------------------------*/
> +
> +static inline void activate_irq(int irq)
> +{
> +#ifdef CONFIG_ARM
> +	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
> +	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
> +	 */
> +	set_irq_flags(irq, IRQF_VALID);
> +#else
> +	/* same effect on other architectures */
> +	set_irq_noprobe(irq);
> +#endif
> +}
> +
> +/*----------------------------------------------------------------------*/
> +
> +static unsigned twl6030_irq_next;
> +
> +/*----------------------------------------------------------------------*/
> +int twl6030_interrupt_unmask(u8 bit_mask, u8 offset)
> +{
> +	int ret;
> +	u8 unmask_value;
> +	ret = twl_i2c_read_u8(TWL_MODULE_PIH, &unmask_value,
> +			REG_INT_STS_A + offset);
> +	unmask_value &= (~(bit_mask));
> +	ret |= twl_i2c_write_u8(TWL_MODULE_PIH, unmask_value,
> +			REG_INT_STS_A + offset); /* unmask INT_MSK_A/B/C */
> +	return ret;
> +}
> +
> +int twl6030_interrupt_mask(u8 bit_mask, u8 offset)
> +{
> +	int ret;
> +	u8 mask_value;
> +	ret = twl_i2c_read_u8(TWL_MODULE_PIH, &mask_value,
> +			REG_INT_STS_A + offset);
> +	mask_value |= (bit_mask);
> +	ret |= twl_i2c_write_u8(TWL_MODULE_PIH, mask_value,
> +			REG_INT_STS_A + offset); /* mask INT_MSK_A/B/C */
> +	return ret;
> +}
> +
> +int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
> +{
> +
> +	int	status = 0;
> +	int	i;
> +	struct task_struct	*task;
> +	int ret;
> +	u8 mask[4];
> +
> +	static struct irq_chip	twl6030_irq_chip;
> +	mask[1] = 0xFF;
> +	mask[2] = 0xFF;
> +	mask[3] = 0xFF;
> +	ret = twl_i2c_write(TWL_MODULE_PIH, &mask[0],
> +			REG_INT_MSK_LINE_A, 3); /* MASK ALL INT LINES*/
> +
> +	mask[1] = 0;
> +	mask[2] = 0;
> +	mask[3] = 0;
> +	ret = twl_i2c_write(TWL_MODULE_PIH, &mask[0],
> +			REG_INT_STS_A, 3); /* clear INT_STS_A,B,C */
> +
> +	twl6030_irq_base = irq_base;
> +
> +	/* install an irq handler for each of the modules;
> +	 * clone dummy irq_chip since PIH can't *do* anything
> +	 */
> +	twl6030_irq_chip = dummy_irq_chip;
> +	twl6030_irq_chip.name = "twl6030";
> +	twl6030_irq_chip.set_type = NULL;
> +
> +	for (i = irq_base; i < irq_end; i++) {
> +		set_irq_chip_and_handler(i, &twl6030_irq_chip,
> +				handle_simple_irq);
> +		activate_irq(i);
> +	}
> +
> +	twl6030_irq_next = i;
> +	pr_info("twl6030: %s (irq %d) chaining IRQs %d..%d\n", "PIH",
> +			irq_num, irq_base, twl6030_irq_next - 1);
> +	/* install an irq handler to demultiplex the TWL6030 interrupt */
> +	init_completion(&irq_event);
> +	task = kthread_run(twl6030_irq_thread, (void *)irq_num, "twl6030-irq");
> +	if (IS_ERR(task)) {
> +		pr_err("twl6030: could not create irq %d thread!\n", irq_num);
> +		status = PTR_ERR(task);
> +		goto fail_kthread;
> +	}
> +
> +	status = request_irq(irq_num, handle_twl6030_pih, IRQF_DISABLED,
> +				"TWL6030-PIH", &irq_event);

There is no need for the kthread hack anymore now that threaded irqs are
available to everyone (2.6.32-rc1)

So above would become, 
        status = request_threaded_irq(irq_num, handle_twl6030_pih, twl6030_irq_thread, IRQF_DISABLED,
                             "TWL6030-PIH", &irq_event);
where,
 handle_twl6030_pih is the hard irq handler that mask the interrupt
 twl6030_irq_thread is a sleeping call called by the irq framework

You might also be able to do away with handle_twl6030_pih entirely and pass
NULL. That along with a IRQF_ONESHOT flag the the request_threaded_irq
routine should automatically mask the irq until the sleeping call returns.

I am working on doing this to the twl4030 driver currently, if anybody else
isn't.

Regards,
Amit

-- 
-------------------------------------------------------------------------
Amit Kucheria,				 Kernel Developer, Verdurent
-------------------------------------------------------------------------
