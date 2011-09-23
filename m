From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] mfd: OMAP4460+: System control module driver
Date: Fri, 23 Sep 2011 00:50:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109230016190.10719@utopia.booyaka.com>
References: <1316710311-14075-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33585 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab1IWGue (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 02:50:34 -0400
In-Reply-To: <1316710311-14075-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org

Hi

some comments:

On Thu, 22 Sep 2011, Keerthy wrote:

> The system control module has several components. On die temperature is a part
> of system control module. The system control module driver registers the
> temperature sensor as a client. A hwmon driver for temperature sensor to
> route the temperature and the thresholds to the user space.
> 
> The system control module driver patch depends on the following series
> found here: http://comments.gmane.org/gmane.linux.ports.arm.omap/64436
> 
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Cc:sameo@linux.intel.com 

This should also be sent to the linux-arm-kernel@lists.infradead.org and 
linux-kernel@vger.kernel.org lists as well as the linux-omap list.

> ---
>  drivers/mfd/Kconfig            |    9 +
>  drivers/mfd/Makefile           |    2 +-
>  drivers/mfd/omap4460plus_scm.c |  581 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 591 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/mfd/omap4460plus_scm.c
> 
> Index: linux-omap-2.6/drivers/mfd/Kconfig
> ===================================================================
> --- linux-omap-2.6.orig/drivers/mfd/Kconfig	2011-09-22 18:35:25.636575640 +0530
> +++ linux-omap-2.6/drivers/mfd/Kconfig	2011-09-22 18:35:43.412576517 +0530
> @@ -212,6 +212,15 @@
>  	  and other features that are often used in portable devices like
>  	  cell phones and PDAs.
>  
> +config OMAP4460PLUS_SCM
> +	bool "Texas Instruments OMAP4460 System control module"
> +	depends on ARCH_OMAP && OMAP_SCM_DEV
> +	help
> +	  If you say yes here you get support for the Texas Instruments
> +	  OMAP4460 system control module. This includes support for
> +	  on die temperature sensor which is a part of System control
> +	  module.
> +

It seems to me that this driver should work for the OMAP4430 as well.  Is 
there a reason why this is marked as OMAP4460 all over?

>  config TWL4030_CORE
>  	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
>  	depends on I2C=y && GENERIC_HARDIRQS
> Index: linux-omap-2.6/drivers/mfd/Makefile
> ===================================================================
> --- linux-omap-2.6.orig/drivers/mfd/Makefile	2011-09-22 18:35:25.604576115 +0530
> +++ linux-omap-2.6/drivers/mfd/Makefile	2011-09-22 18:35:43.416576975 +0530
> @@ -42,7 +42,7 @@
>  obj-$(CONFIG_MFD_TPS65912_I2C)	+= tps65912-i2c.o
>  obj-$(CONFIG_MFD_TPS65912_SPI)  += tps65912-spi.o
>  obj-$(CONFIG_MENELAUS)		+= menelaus.o
> -
> +obj-$(CONFIG_OMAP4460PLUS_SCM)	+= omap4460plus_scm.o
>  obj-$(CONFIG_TWL4030_CORE)	+= twl-core.o twl4030-irq.o twl6030-irq.o
>  obj-$(CONFIG_TWL4030_MADC)      += twl4030-madc.o
>  obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
> Index: linux-omap-2.6/drivers/mfd/omap4460plus_scm.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-omap-2.6/drivers/mfd/omap4460plus_scm.c	2011-09-22 18:53:05.132583900 +0530

Please split this file into at least two files, as is the standard 
practice for MFD drivers.  There should be one omap4-scm-core.c file, and 
one omap4-scm-tempsensor.c file.  Everything temperature sensor-specific 
should go into the omap4-scm-tempsensor.c file.

> @@ -0,0 +1,581 @@
> +/*
> + * OMAP4 system control module driver file
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + * Author: J Keerthy <j-keerthy@ti.com>
> + * Author: Moiz Sonasath <m-sonasath@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <plat/omap_device.h>
> +#include <linux/kernel.h>
> +#include <linux/jiffies.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <plat/scm.h>
> +
> +#define TSHUT_HOT		920	/* 122 deg C */
> +#define TSHUT_COLD		866	/* 100 deg C */
> +#define T_HOT			800	/* 73 deg C */
> +#define T_COLD			795	/* 71 deg C */
> +#define MAX_FREQ		2000000
> +#define MIN_FREQ		1000000
> +#define MIN_TEMP		-40000
> +#define MAX_TEMP		123000
> +#define HYST_VAL		5000

Are any of these definitions specific to one chip?  Or do they apply to 
all OMAP4 chips?

> +
> +static u32 omap4460plus_scm_readl(struct scm
> +					    *scm_ptr, u32 reg)
> +{
> +	return __raw_readl(scm_ptr->phy_base + reg);
> +}
> +
> +static void omap4460plus_scm_writel(struct scm *scm_ptr, u32 val, u32 reg)
> +{
> +	__raw_writel(val, scm_ptr->phy_base + reg);
> +}
> +
> +static int adc_to_temp_conversion(int adc_val)
> +{
> +	return adc_to_temp[adc_val - OMAP_ADC_START_VALUE];
> +}
> +
> +static int temp_to_adc_conversion(long temp)
> +{
> +	int high, low, mid;
> +
> +	if (temp < adc_to_temp[0] ||
> +	    temp > adc_to_temp[OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE])
> +		return -EINVAL;
> +
> +	high = OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE;
> +	low = 0;
> +	mid = (high + low) / 2;
> +
> +	while (low < high) {
> +		if (temp < adc_to_temp[mid])
> +			high = mid - 1;
> +		else
> +			low = mid + 1;
> +		mid = (low + high) / 2;
> +	}
> +
> +	return OMAP_ADC_START_VALUE + low;
> +}
> +
> +static void temp_sensor_unmask_interrupts(struct scm *scm_ptr, int id,
> +					  u32 t_hot, u32 t_cold)
> +{
> +	struct omap_temp_sensor_registers *tsr;
> +	u32 temp, reg_val;
> +
> +	/* Read the current on die temperature */
> +	tsr = scm_ptr->registers[id];
> +	temp = omap4460plus_scm_readl(scm_ptr, tsr->temp_sensor_ctrl);
> +	temp &= tsr->bgap_dtemp_mask;
> +
> +	reg_val = omap4460plus_scm_readl(scm_ptr, tsr->bgap_mask_ctrl);
> +	if (temp < t_hot)
> +		reg_val |= tsr->mask_hot_mask;
> +	else
> +		reg_val &= ~tsr->mask_hot_mask;
> +
> +	if (t_cold < temp)
> +		reg_val |= tsr->mask_cold_mask;
> +	else
> +		reg_val &= ~tsr->mask_cold_mask;
> +
> +	omap4460plus_scm_writel(scm_ptr, reg_val, tsr->bgap_mask_ctrl);
> +}
> +
> +static int add_hyst(int adc_val, int hyst_val)
> +{
> +	int temp = adc_to_temp_conversion(adc_val);
> +
> +	temp += hyst_val;
> +
> +	return temp_to_adc_conversion(temp);
> +}
> +
> +static void temp_sensor_configure_thot(struct scm *scm_ptr, int id, int t_hot)
> +{
> +	int cold, thresh_val;
> +	struct omap_temp_sensor_registers *tsr;
> +	u32 reg_val;
> +
> +	tsr = scm_ptr->registers[id];
> +	/* obtain the T cold value */
> +	thresh_val = omap4460plus_scm_readl(scm_ptr, tsr->bgap_threshold);
> +	cold = (thresh_val & tsr->threshold_tcold_mask) >>
> +	    __ffs(tsr->threshold_tcold_mask);
> +
> +	if (t_hot <= cold) {
> +		/* change the t_cold to t_hot - 5000 millidegrees */
> +		cold = add_hyst(t_hot, -HYST_VAL);
> +		/* write the new t_cold value */
> +		reg_val = thresh_val & (~tsr->threshold_tcold_mask);
> +		reg_val |= cold << __ffs(tsr->threshold_tcold_mask);
> +		omap4460plus_scm_writel(scm_ptr, reg_val,
> +					tsr->bgap_threshold);
> +		thresh_val = reg_val;
> +	}
> +
> +	/* write the new t_hot value */
> +	reg_val = thresh_val & ~tsr->threshold_thot_mask;
> +	reg_val |= (t_hot << __ffs(tsr->threshold_thot_mask));
> +	omap4460plus_scm_writel(scm_ptr, reg_val, tsr->bgap_threshold);
> +	temp_sensor_unmask_interrupts(scm_ptr, id, t_hot, cold);
> +}
> +
> +static void temp_sensor_configure_tcold(struct scm *scm_ptr, int id, int t_cold)
> +{
> +	int hot, thresh_val;
> +	u32 reg_val;
> +	struct omap_temp_sensor_registers *tsr;
> +
> +	tsr = scm_ptr->registers[id];
> +	/* obtain the T cold value */
> +	thresh_val = omap4460plus_scm_readl(scm_ptr, tsr->bgap_threshold);
> +	hot = (thresh_val & tsr->threshold_thot_mask) >>
> +	    __ffs(tsr->threshold_thot_mask);
> +
> +	if (t_cold >= hot) {
> +		/* change the t_hot to t_cold + 5000 millidegrees */
> +		hot = add_hyst(t_cold, HYST_VAL);
> +		/* write the new t_hot value */
> +		reg_val = thresh_val & (~tsr->threshold_thot_mask);
> +		reg_val |= hot << __ffs(tsr->threshold_thot_mask);
> +		omap4460plus_scm_writel(scm_ptr, reg_val,
> +					tsr->bgap_threshold);
> +		thresh_val = reg_val;
> +	}
> +
> +	/* write the new t_cold value */
> +	reg_val = thresh_val & ~tsr->threshold_tcold_mask;
> +	reg_val |= (t_cold << __ffs(tsr->threshold_tcold_mask));
> +	omap4460plus_scm_writel(scm_ptr, reg_val, tsr->bgap_threshold);
> +	temp_sensor_unmask_interrupts(scm_ptr, id, hot, t_cold);
> +}
> +
> +static void configure_temp_sensor_counter(struct scm *scm_ptr, int id,
> +					  u32 counter)
> +{
> +	u32 val;
> +
> +	val = omap4460plus_scm_readl(scm_ptr,
> +				     scm_ptr->registers[id]->bgap_counter);
> +	val &= ~scm_ptr->registers[id]->counter_mask;
> +	val |= counter << __ffs(scm_ptr->registers[id]->counter_mask);
> +	omap4460plus_scm_writel(scm_ptr, val,
> +				scm_ptr->registers[id]->bgap_counter);
> +
> +}
> +
> +int omap4460plus_scm_show_temp_max(struct scm *scm_ptr, int id)
> +{
> +	struct omap_temp_sensor_registers *tsr;
> +	int temp;
> +
> +	tsr = scm_ptr->registers[id];
> +	temp = omap4460plus_scm_readl(scm_ptr, tsr->bgap_threshold);
> +	temp = (temp & tsr->threshold_thot_mask)
> +	    >> __ffs(tsr->threshold_thot_mask);
> +	temp = adc_to_temp_conversion(temp);
> +
> +	return temp;
> +}
> +EXPORT_SYMBOL(omap4460plus_scm_show_temp_max);
> +
> +int omap4460plus_scm_set_temp_max(struct scm *scm_ptr, int id, int val)
> +{
> +	struct omap_temp_sensor_registers *tsr;
> +	u32 t_hot;
> +	tsr = scm_ptr->registers[id];
> +
> +	if (val < MIN_TEMP - HYST_VAL)
> +		return -EINVAL;
> +	t_hot = temp_to_adc_conversion(val);
> +	if (t_hot < 0)
> +		return t_hot;
> +
> +	mutex_lock(&scm_ptr->scm_mutex);
> +	temp_sensor_configure_thot(scm_ptr, id, t_hot);
> +	mutex_unlock(&scm_ptr->scm_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap4460plus_scm_set_temp_max);
> +
> +int omap4460plus_scm_show_temp_max_hyst(struct scm *scm_ptr, int id)
> +{
> +	struct omap_temp_sensor_registers *tsr;
> +	int temp;
> +
> +	tsr = scm_ptr->registers[id];
> +	temp = omap4460plus_scm_readl(scm_ptr, tsr->bgap_threshold);
> +	temp = (temp & tsr->threshold_tcold_mask)
> +	    >> __ffs(tsr->threshold_tcold_mask);
> +	temp = adc_to_temp_conversion(temp);
> +
> +	return temp;
> +}
> +EXPORT_SYMBOL(omap4460plus_scm_show_temp_max_hyst);
> +
> +int omap4460plus_scm_set_temp_max_hyst(struct scm *scm_ptr,
> +				       int id, int val)
> +{
> +	struct omap_temp_sensor_registers *tsr;
> +	u32 t_cold;
> +	tsr = scm_ptr->registers[id];
> +
> +	if (val < MIN_TEMP + HYST_VAL)
> +		return -EINVAL;
> +	t_cold = temp_to_adc_conversion(val);
> +	if (t_cold < 0)
> +		return t_cold;
> +
> +	mutex_lock(&scm_ptr->scm_mutex);
> +	temp_sensor_configure_tcold(scm_ptr, id, t_cold);
> +	mutex_unlock(&scm_ptr->scm_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap4460plus_scm_set_temp_max_hyst);
> +
> +void omap4460plus_scm_set_update_interval(struct scm *scm_ptr,
> +					  u32 interval, int id)
> +{
> +	interval = interval * scm_ptr->clk_rate / 1000;
> +	mutex_lock(&scm_ptr->scm_mutex);
> +	configure_temp_sensor_counter(scm_ptr, id, interval);
> +	mutex_unlock(&scm_ptr->scm_mutex);
> +}
> +EXPORT_SYMBOL(omap4460plus_scm_set_update_interval);
> +
> +int omap4460plus_scm_show_update_interval(struct scm *scm_ptr, int id)
> +{
> +	struct omap_temp_sensor_registers *tsr;
> +	int time;
> +	tsr = scm_ptr->registers[id];
> +
> +	time = omap4460plus_scm_readl(scm_ptr, tsr->bgap_counter);
> +	time = (time & tsr->counter_mask) >> __ffs(tsr->counter_mask);
> +	time = time * 1000 / scm_ptr->clk_rate;
> +
> +	return time;
> +}
> +EXPORT_SYMBOL(omap4460plus_scm_show_update_interval);
> +
> +int omap4460plus_scm_read_temp(struct scm *scm_ptr, int id)
> +{
> +	struct omap_temp_sensor_registers *tsr;
> +	int temp;
> +	tsr = scm_ptr->registers[id];
> +
> +	temp = omap4460plus_scm_readl(scm_ptr, tsr->temp_sensor_ctrl);
> +	temp &= tsr->bgap_dtemp_mask;
> +
> +	/* look up for temperature in the table and return the temperature */
> +	if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VALUE)
> +		return -EIO;
> +
> +	return adc_to_temp_conversion(temp);
> +}
> +EXPORT_SYMBOL(omap4460plus_scm_read_temp);
> +
> +/**
> + * enable_continuous_mode() - One time enbaling of continuous conversion mode
> + * @scm_ptr - pointer to scm instance
> + */
> +static void enable_continuous_mode(struct scm *scm_ptr)
> +{
> +	u32 val;
> +	int i;
> +
> +	for (i = 0; i < scm_ptr->cnt; i++) {
> +		val = omap4460plus_scm_readl(scm_ptr,
> +					     scm_ptr->registers[i]->
> +					     bgap_mode_ctrl);
> +
> +		val |= 1 << __ffs(scm_ptr->registers[i]->mode_ctrl_mask);
> +
> +		omap4460plus_scm_writel(scm_ptr, val,
> +					scm_ptr->registers[i]->bgap_mode_ctrl);
> +	}
> +}
> +
> +static irqreturn_t talert_irq_handler(int irq, void *data)
> +{
> +	struct scm *scm_ptr;
> +	int t_hot = 0, t_cold, temp, i;
> +	struct omap_temp_sensor_registers *tsr;
> +
> +	scm_ptr = data;
> +	mutex_lock(&scm_ptr->scm_mutex);
> +	/* Read the status of t_hot */
> +	for (i = 0; i < scm_ptr->cnt; i++) {
> +		tsr = scm_ptr->registers[i];
> +		t_hot = omap4460plus_scm_readl(scm_ptr, tsr->bgap_status)
> +		    & tsr->status_hot_mask;
> +
> +		/* Read the status of t_cold */
> +		t_cold = omap4460plus_scm_readl(scm_ptr, tsr->bgap_status)
> +		    & tsr->status_cold_mask;
> +
> +		temp = omap4460plus_scm_readl(scm_ptr, tsr->bgap_mask_ctrl);
> +		/*
> +		 * One TALERT interrupt: Two sources
> +		 * If the interrupt is due to t_hot then mask t_hot and
> +		 * and unmask t_cold else mask t_cold and unmask t_hot
> +		 */
> +		if (t_hot) {
> +			temp &= ~tsr->mask_hot_mask;
> +			temp |= tsr->mask_cold_mask;
> +		} else if (t_cold) {
> +			temp &= ~tsr->mask_cold_mask;
> +			temp |= tsr->mask_hot_mask;
> +		}
> +
> +		omap4460plus_scm_writel(scm_ptr, temp, tsr->bgap_mask_ctrl);
> +
> +		if (t_hot || t_cold)
> +			/* kobject_uvent to user space threshold crossed */
> +			kobject_uevent(&scm_ptr->tsh_ptr[i].pdev->dev.kobj,
> +				       KOBJ_CHANGE);
> +	}
> +
> +	mutex_unlock(&scm_ptr->scm_mutex);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +void omap4460plus_scm_client_dev_register(struct temp_sensor_hwmon *tsh_ptr,
> +					  int i, const char *name)
> +{
> +	int ret;
> +
> +	tsh_ptr->pdev = platform_device_alloc(name, i);
> +	if (tsh_ptr->pdev == NULL) {
> +		dev_err(tsh_ptr->scm_ptr->dev, "Failed to allocate %s\n", name);
> +		return;
> +	}
> +
> +	tsh_ptr->pdev->dev.parent = tsh_ptr->scm_ptr->dev;
> +	platform_set_drvdata(tsh_ptr->pdev, tsh_ptr);
> +	ret = platform_device_add(tsh_ptr->pdev);
> +	if (ret != 0) {
> +		dev_err(tsh_ptr->scm_ptr->dev, "Failed to register %s: %d\n",
> +			name, ret);
> +		platform_device_put(tsh_ptr->pdev);
> +		tsh_ptr->pdev = NULL;
> +	}
> +}
> +
> +static int __devinit omap4460plus_scm_probe(struct platform_device *pdev)
> +{
> +	struct omap4460plus_scm_pdata *pdata = pdev->dev.platform_data;
> +	struct scm *scm_ptr;
> +	struct resource *mem;
> +	int ret = 0, i;
> +	int clk_rate;
> +	u32 max_freq, min_freq;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "platform data missing\n");
> +		return -EINVAL;
> +	}
> +
> +	scm_ptr = kzalloc(sizeof(*scm_ptr), GFP_KERNEL);
> +	if (!scm_ptr) {
> +		dev_err(&pdev->dev, "Memory allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	scm_ptr->tsh_ptr = kzalloc(sizeof(*scm_ptr->tsh_ptr) * pdata->cnt,
> +					GFP_KERNEL);
> +	if (!scm_ptr) {
> +		dev_err(&pdev->dev, "Memory allocation failed for tsh\n");
> +		kfree(scm_ptr);
> +		return -ENOMEM;
> +	}
> +
> +	mutex_init(&scm_ptr->scm_mutex);
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		dev_err(&pdev->dev, "no mem resource\n");
> +		ret = -ENOMEM;
> +		goto plat_res_err;
> +	}
> +
> +	scm_ptr->irq = platform_get_irq_byname(pdev, "thermal_alert");
> +	if (scm_ptr->irq < 0) {
> +		dev_err(&pdev->dev, "get_irq_byname failed\n");
> +		ret = scm_ptr->irq;
> +		goto plat_res_err;
> +	}
> +
> +	scm_ptr->phy_base = ioremap(mem->start, resource_size(mem));

Isn't this a virtual address?

> +	if (!scm_ptr->phy_base) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		ret = -ENOMEM;
> +		goto plat_res_err;
> +	}
> +
> +	scm_ptr->registers = pdata->registers;
> +	scm_ptr->name = pdata->name;
> +	scm_ptr->dev = &pdev->dev;
> +	scm_ptr->cnt = pdata->cnt;
> +
> +	if (pdata->max_freq && pdata->min_freq) {
> +		max_freq = pdata->max_freq;
> +		min_freq = pdata->min_freq;
> +	} else {
> +		max_freq = MAX_FREQ;
> +		min_freq = MIN_FREQ;
> +	}
> +
> +	/*
> +	 * check if the efuse has a non-zero value if not
> +	 * it is an untrimmed sample and the temperatures
> +	 * may not be accurate
> +	 */
> +	if (omap4460plus_scm_readl(scm_ptr, scm_ptr->registers[0]->bgap_efuse))
> +		dev_info(&pdev->dev,
> +			 "Invalid EFUSE, Non-trimmed BGAP, Temp not accurate\n");
> +	dev_set_drvdata(&pdev->dev, scm_ptr);
> +	scm_ptr->fclock = clk_get(&pdev->dev, "fck");
> +	scm_ptr->div_clk = clk_get(&pdev->dev, "div_ck");
> +	clk_enable(scm_ptr->fclock);
> +
> +	clk_rate = clk_round_rate(scm_ptr->div_clk, max_freq);
> +	if (clk_rate < min_freq || clk_rate == 0xffffffff) {
> +		ret = -ENODEV;
> +		goto clken_err;
> +	}
> +
> +	ret = clk_set_rate(scm_ptr->div_clk, clk_rate);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot set clock rate\n");
> +		goto clken_err;
> +	}
> +
> +	scm_ptr->clk_rate = clk_rate;
> +
> +	enable_continuous_mode(scm_ptr);
> +	/* 1 clk cycle */
> +	for (i = 0; i < pdata->cnt; i++)
> +		configure_temp_sensor_counter(scm_ptr, i, 1);
> +
> +	/* Wait till the first conversion is done wait for at least 1ms */
> +	usleep_range(1000, 2000);

Please use macros for these constants.  Maybe add some comments why the 
upper range should be bounded at 2000 microseconds?  If there's no obvious 
rationale, it might be best to increase this to something much higher? 

> +
> +	/* Set 2 seconds time as default counter */
> +	for (i = 0; i < pdata->cnt; i++)
> +		configure_temp_sensor_counter(scm_ptr, i,
> +					      scm_ptr->clk_rate * 2);

This should be a macro.  Also maybe a quick comment on why it is 2 
seconds?

Also I'd suggest dropping in a brief comment here about other SCM 
subdevices, to help the MFD maintainer out understand why this is an MFD 
device.  For example, child drivers should eventually be added for eFuses 
and debobs/hwobs.


> +	for (i = 0; i < pdata->cnt; i++) {
> +		scm_ptr->tsh_ptr[i].scm_ptr = scm_ptr;
> +		scm_ptr->tsh_ptr[i].name = scm_ptr->name[i];
> +		omap4460plus_scm_client_dev_register(&(scm_ptr->tsh_ptr[i]),
> +						     i, "temp_sensor_hwmon");
> +		temp_sensor_configure_thot(scm_ptr, i, T_HOT);
> +		temp_sensor_configure_tcold(scm_ptr, i, T_COLD);
> +	}
> +
> +	ret = request_threaded_irq(scm_ptr->irq, NULL,
> +				   talert_irq_handler,
> +				   IRQF_TRIGGER_RISING | IRQF_ONESHOT, "TAlert",
> +				   scm_ptr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Request threaded irq failed.\n");
> +		goto req_irq_err;
> +	}
> +
> +	mutex_lock(&scm_ptr->scm_mutex);
> +
> +	for (i = 0; i < pdata->cnt; i++)
> +		temp_sensor_unmask_interrupts(scm_ptr, i, OMAP_ADC_END_VALUE,
> +						OMAP_ADC_START_VALUE);
> +
> +	mutex_unlock(&scm_ptr->scm_mutex);
> +
> +	return 0;
> +
> +req_irq_err:
> +	clk_disable(scm_ptr->fclock);
> +clken_err:
> +	clk_put(scm_ptr->fclock);
> +	clk_put(scm_ptr->div_clk);
> +	iounmap(scm_ptr->phy_base);
> +plat_res_err:
> +	dev_set_drvdata(&pdev->dev, NULL);
> +	mutex_destroy(&scm_ptr->scm_mutex);
> +	kfree(scm_ptr->tsh_ptr);
> +	kfree(scm_ptr);
> +
> +	return ret;
> +}
> +
> +static int __devexit omap4460plus_scm_remove(struct platform_device *pdev)
> +{
> +	struct scm *scm_ptr = platform_get_drvdata(pdev);
> +
> +	free_irq(scm_ptr->irq, scm_ptr);
> +	clk_disable(scm_ptr->fclock);
> +	clk_put(scm_ptr->fclock);
> +	clk_put(scm_ptr->div_clk);
> +	iounmap(scm_ptr->phy_base);
> +	dev_set_drvdata(&pdev->dev, NULL);
> +	mutex_destroy(&scm_ptr->scm_mutex);
> +	kfree(scm_ptr);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver omap4460plus_scm_driver = {
> +	.probe = omap4460plus_scm_probe,
> +	.remove = omap4460plus_scm_remove,
> +	.driver = {
> +		   .name = "omap4460plus_scm",
> +		   },
> +};
> +
> +int __init omap4460plus_scm_init(void)
> +{
> +	return platform_driver_register(&omap4460plus_scm_driver);
> +}
> +
> +module_init(omap4460plus_scm_init);
> +
> +static void __exit omap4460plus_scm_exit(void)
> +{
> +	platform_driver_unregister(&omap4460plus_scm_driver);
> +}
> +
> +module_exit(omap4460plus_scm_exit);
> +
> +MODULE_DESCRIPTION("OMAP446X plus system control module Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
