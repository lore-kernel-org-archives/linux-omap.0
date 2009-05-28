From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/10] ARM: OMAP1: Make 770 LCD work
Date: Thu, 28 May 2009 11:20:48 -0700
Message-ID: <20090528182047.GF32453@atomide.com>
References: <20090519232905.12760.15490.stgit@localhost> <20090519233732.12760.34595.stgit@localhost> <20090525092911.GC28195@n2100.arm.linux.org.uk> <20090525142128.17675cl0tvdr0y1k@lidskialf.net> <20090525174055.127744136qxu9vk0@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54367 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763384AbZE1SVH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 14:21:07 -0400
Content-Disposition: inline
In-Reply-To: <20090525174055.127744136qxu9vk0@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

* Andrew de Quincey <adq_dvb@lidskialf.net> [090525 09:41]:
> Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:
>
>> Quoting Russell King - ARM Linux <linux@arm.linux.org.uk>:
>>
>>> On Tue, May 19, 2009 at 04:37:32PM -0700, Tony Lindgren wrote:
>>>> Make 770 LCD work by passing the clock from platform data.
>>>> Also remove the old unused functions.
>>>
>>> I don't like this - because its passing struct clk's through platform
>>> data.  That's not how things are supposed to work.
>>>
>>> The way PXA solves this problem is to have clock aliases - see
>>> clk_add_alias().
>>
>> Interesting idea - I now have a prototype patch implementing this,  
>> which I'll send when I get home (otherwise it would be an "it  
>> compiles" "test" :)
>>
>> There isn't a common definition of clk_add_alias() though - that  
>> symbol is defined in arch/arm/mach-pxa/clock.c, so I had to copy it  
>> into arch/arm/plat-omap/clock.c
>
> Attached is a patch implementing this method. I don't like the  
> duplication of the clk_alias code, but I imagine that could be resolved 
> if this method was chosen....

Andrew, can you please reply with your Signed-off-by?

Thanks,

Tony

> diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
> index 8780ca6..e70fc7c 100644
> --- a/arch/arm/mach-omap1/board-nokia770.c
> +++ b/arch/arm/mach-omap1/board-nokia770.c
> @@ -33,9 +33,11 @@
>  #include <mach/common.h>
>  #include <mach/dsp_common.h>
>  #include <mach/omapfb.h>
> +#include <mach/hwa742.h>
>  #include <mach/lcd_mipid.h>
>  #include <mach/mmc.h>
>  #include <mach/usb.h>
> +#include <mach/clock.h>
>  
>  #define ADS7846_PENDOWN_GPIO	15
>  
> @@ -163,6 +165,15 @@ static struct spi_board_info nokia770_spi_board_info[] __initdata = {
>  	},
>  };
>  
> +static struct hwa742_platform_data nokia770_hwa742_platform_data = {
> +	.te_connected		= 1,
> +};
> +
> +static void hwa742_dev_init(void)
> +{
> +	clk_add_alias("hwa_sys_ck", NULL, "bclk", NULL);
> +	omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
> +}
>  
>  /* assume no Mini-AB port */
>  
> @@ -371,6 +382,7 @@ static void __init omap_nokia770_init(void)
>  	omap_serial_init();
>  	omap_register_i2c_bus(1, 100, NULL, 0);
>  	omap_dsp_init();
> +	hwa742_dev_init();
>  	ads7846_dev_init();
>  	mipid_dev_init();
>  	omap_usb_init(&nokia770_usb_config);
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 29efc27..862eefd 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -24,6 +24,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/io.h>
>  
> +#include <asm/clkdev.h>
>  #include <mach/clock.h>
>  
>  static LIST_HEAD(clocks);
> @@ -359,6 +360,24 @@ static int __init clk_disable_unused(void)
>  late_initcall(clk_disable_unused);
>  #endif
>  
> +int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
> +	struct device *dev)
> +{
> +	struct clk *r = clk_get(dev, id);
> +	struct clk_lookup *l;
> +
> +	if (!r)
> +		return -ENODEV;
> +
> +	l = clkdev_alloc(r, alias, alias_dev_name);
> +	clk_put(r);
> +	if (!l)
> +		return -ENODEV;
> +	clkdev_add(l);
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_add_alias);												
> +
>  int __init clk_init(struct clk_functions * custom_clocks)
>  {
>  	if (!custom_clocks) {
> diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
> index 073a2c5..b53b047 100644
> --- a/arch/arm/plat-omap/include/mach/clock.h
> +++ b/arch/arm/plat-omap/include/mach/clock.h
> @@ -127,12 +127,14 @@ extern void propagate_rate(struct clk *clk);
>  extern void recalculate_root_clocks(void);
>  extern unsigned long followparent_recalc(struct clk *clk);
>  extern void clk_enable_init_clocks(void);
> +extern int clk_add_alias(const char *alias, const char *alias_dev_name, char *id, struct device *dev); 	
>  #ifdef CONFIG_CPU_FREQ
>  extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
>  #endif
>  
>  extern const struct clkops clkops_null;
>  
> +
>  /* Clock flags */
>  /* bit 0 is free */
>  #define RATE_FIXED		(1 << 1)	/* Fixed clock rate */
> diff --git a/arch/arm/plat-omap/include/mach/hwa742.h b/arch/arm/plat-omap/include/mach/hwa742.h
> index 577f492..886248d 100644
> --- a/arch/arm/plat-omap/include/mach/hwa742.h
> +++ b/arch/arm/plat-omap/include/mach/hwa742.h
> @@ -2,10 +2,6 @@
>  #define _HWA742_H
>  
>  struct hwa742_platform_data {
> -	void		(*power_up)(struct device *dev);
> -	void		(*power_down)(struct device *dev);
> -	unsigned long	(*get_clock_rate)(struct device *dev);
> -
>  	unsigned	te_connected:1;
>  };
>  
> diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
> index 8aa6e47..5d4f348 100644
> --- a/drivers/video/omap/hwa742.c
> +++ b/drivers/video/omap/hwa742.c
> @@ -133,8 +133,7 @@ struct {
>  	struct lcd_ctrl_extif	*extif;
>  	struct lcd_ctrl		*int_ctrl;
>  
> -	void			(*power_up)(struct device *dev);
> -	void			(*power_down)(struct device *dev);
> +	struct clk		*sys_ck;
>  } hwa742;
>  
>  struct lcd_ctrl hwa742_ctrl;
> @@ -915,14 +914,13 @@ static void hwa742_suspend(void)
>  	hwa742_set_update_mode(OMAPFB_UPDATE_DISABLED);
>  	/* Enable sleep mode */
>  	hwa742_write_reg(HWA742_POWER_SAVE, 1 << 1);
> -	if (hwa742.power_down != NULL)
> -		hwa742.power_down(hwa742.fbdev->dev);
> +	clk_disable(hwa742.sys_ck);
>  }
>  
>  static void hwa742_resume(void)
>  {
> -	if (hwa742.power_up != NULL)
> -		hwa742.power_up(hwa742.fbdev->dev);
> +	clk_enable(hwa742.sys_ck);
> +
>  	/* Disable sleep mode */
>  	hwa742_write_reg(HWA742_POWER_SAVE, 0);
>  	while (1) {
> @@ -955,14 +953,13 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
>  	omapfb_conf = fbdev->dev->platform_data;
>  	ctrl_conf = omapfb_conf->ctrl_platform_data;
>  
> -	if (ctrl_conf == NULL || ctrl_conf->get_clock_rate == NULL) {
> +	if (ctrl_conf == NULL) {
>  		dev_err(fbdev->dev, "HWA742: missing platform data\n");
>  		r = -ENOENT;
>  		goto err1;
>  	}
>  
> -	hwa742.power_down = ctrl_conf->power_down;
> -	hwa742.power_up = ctrl_conf->power_up;
> +	hwa742.sys_ck = clk_get(NULL, "hwa_sys_ck");
>  
>  	spin_lock_init(&hwa742.req_lock);
>  
> @@ -972,12 +969,11 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
>  	if ((r = hwa742.extif->init(fbdev)) < 0)
>  		goto err2;
>  
> -	ext_clk = ctrl_conf->get_clock_rate(fbdev->dev);
> +	ext_clk = clk_get_rate(hwa742.sys_ck);
>  	if ((r = calc_extif_timings(ext_clk, &extif_mem_div)) < 0)
>  		goto err3;
>  	hwa742.extif->set_timings(&hwa742.reg_timings);
> -	if (hwa742.power_up != NULL)
> -		hwa742.power_up(fbdev->dev);
> +	clk_enable(hwa742.sys_ck);
>  
>  	calc_hwa742_clk_rates(ext_clk, &sys_clk, &pix_clk);
>  	if ((r = calc_extif_timings(sys_clk, &extif_mem_div)) < 0)
> @@ -1040,8 +1036,7 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
>  
>  	return 0;
>  err4:
> -	if (hwa742.power_down != NULL)
> -		hwa742.power_down(fbdev->dev);
> +	clk_disable(hwa742.sys_ck);
>  err3:
>  	hwa742.extif->cleanup();
>  err2:
> @@ -1055,8 +1050,7 @@ static void hwa742_cleanup(void)
>  	hwa742_set_update_mode(OMAPFB_UPDATE_DISABLED);
>  	hwa742.extif->cleanup();
>  	hwa742.int_ctrl->cleanup();
> -	if (hwa742.power_down != NULL)
> -		hwa742.power_down(hwa742.fbdev->dev);
> +	clk_disable(hwa742.sys_ck);
>  }
>  
>  struct lcd_ctrl hwa742_ctrl = {
