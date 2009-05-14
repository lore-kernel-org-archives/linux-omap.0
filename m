From: Tony Lindgren <tony@atomide.com>
Subject: Re: Patch "REMOVE OMAP LEGACY CODE: Reset mach-omap1/board-*.c
	files to mainline" breaks nokia770
Date: Thu, 14 May 2009 16:57:26 -0700
Message-ID: <20090514235726.GZ5593@atomide.com>
References: <20090514004651.77342rqoq5tz86ww@lidskialf.net> <20090514002335.GA9538@nokia.com> <20090514014413.GE5593@atomide.com> <20090514080458.GC10386@nokia.com> <20090514153048.GH5593@atomide.com> <20090515001855.11164yyhzqzya58g@lidskialf.net> <20090514232649.GY5593@atomide.com> <20090515003725.756541wklitmzww0@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61104 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbZENX52 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 19:57:28 -0400
Content-Disposition: inline
In-Reply-To: <20090515003725.756541wklitmzww0@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>, Imre Deak <imre.deak@nokia.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Andrew de Quincey <adq_dvb@lidskialf.net> [090514 16:37]:
> Quoting Tony Lindgren <tony@atomide.com>:
>
>> * Andrew de Quincey <adq_dvb@lidskialf.net> [090514 16:19]:
>>> Quoting Tony Lindgren <tony@atomide.com>:
>>>
>>>> * Felipe Balbi <felipe.balbi@nokia.com> [090514 01:15]:
>>>>> On Thu, May 14, 2009 at 03:44:14AM +0200, ext Tony Lindgren wrote:
>>>>> > * Felipe Balbi <felipe.balbi@nokia.com> [090513 17:33]:
>>>>> > > On Thu, May 14, 2009 at 01:46:51AM +0200, ext Andrew de Quincey wrote:
>>>>> > > > Hi, I've just discovered that the patch at:
>>>>> > > >
>>>>> > > >
>>>>> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=3eae3ea7c443fc4330574dffea65b6f2f53a2574
>>>>> > > >
>>>>> > > > Breaks the nokia770's framebuffer as it removes the  
>>>>> platform data for
>>>>> > > > the HWA742 LCD controller.
>>>>> > > >
>>>>> > > > As the patch says "Patches against the mainline tree are welcome to
>>>>> > > > add back the missing functionality if needed!", I'm happy  
>>>>> to do this.
>>>>> > > >
>>>>> > > > However, since I'm fairly new to the linux-omap project, is simply
>>>>> > > > extracting the removed nokia770 code and generating a patch against
>>>>> > > > the mainline kernel sufficient? or is there a newer style  
>>>>> of some sort
>>>>> > > > that should be adopted for this?
>>>>> > >
>>>>> > > You can start by generating the new patch against mainline and running
>>>>> > > scripts/checkpatch.pl, then you should probably find out if there are
>>>>> > > any API changes and stuff like that. Then send the patch to lkml ccing
>>>>> > > linux-omap and let's see what comments do you get from those guys :-)
>>>>> >
>>>>> > Please change the code to pass the struct clock to
>>>>> drivers/video/omap/hwa742.c
>>>>> > in hwa742_platform_data. The hw742.c can just do standard
>>>>> clk_enable/disable
>>>>> > there. Otherwise we won't be able to get this missing part to  
>>>>> the mainline
>>>>> > kernel.
>>>>>
>>>>> how about clkdev then ? are we gonna support that for omap1 still ?
>>>>
>>>> Yeah the clkdev is there, but in the case of the LCD the clock can be
>>>> any clock, so we cannot set just one "fck" for all the omap1 LCD panels.
>>>>
>>>> In this case the "bclk" is used for the LCD, but "bclk" could be used
>>>> for other devices as well, not just LCD.
>>>
>>> Hi, is the attached patch the sort of thing you had in mind? This is
>>> against linux-omap-2.6, latest git.
>>
>> Hey, that's pretty cool! Just one comment below.
>>
>>> Unfortunately, both mainline linux-2.6 and linux-omap-2.6 gits lock up
>>> on bootup before the LCD is initialised. However, the linux-omap 2.6.29
>>> that is compiled by openembedded still boots ok, and with the attached
>>> patch applied, the LCD works again!
>>
>> OK, good to hear. Need to debug that then.
>>
>>> I guess my next task is to figure out why the mainline kernels freeze;
>>> I've seen that before, and it seemed to be something to do with changes
>>> to the mcbsp support.
>>
>> OK
>>
>>> Reinstate HWA742 platform data for nokia 770 platform.
>>>
>>> Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
>>>
>>> diff --git a/arch/arm/mach-omap1/board-nokia770.c  
>>> b/arch/arm/mach-omap1/board-nokia770.c
>>> index 8780ca6..df5f38b 100644
>>> --- a/arch/arm/mach-omap1/board-nokia770.c
>>> +++ b/arch/arm/mach-omap1/board-nokia770.c
>>> @@ -33,6 +33,7 @@
>>>  #include <mach/common.h>
>>>  #include <mach/dsp_common.h>
>>>  #include <mach/omapfb.h>
>>> +#include <mach/hwa742.h>
>>>  #include <mach/lcd_mipid.h>
>>>  #include <mach/mmc.h>
>>>  #include <mach/usb.h>
>>> @@ -163,6 +164,26 @@ static struct spi_board_info  
>>> nokia770_spi_board_info[] __initdata = {
>>>  	},
>>>  };
>>>
>>> +static struct hwa742_platform_data nokia770_hwa742_platform_data = {
>>> +	.sys_ck 		= NULL,
>>> +	.te_connected		= 1,
>>> +};
>>> +
>>> +static int hwa742_get_clocks(void)
>>> +{
>>> +	nokia770_hwa742_platform_data.sys_ck = clk_get(NULL, "bclk");
>>> +	if (IS_ERR(nokia770_hwa742_platform_data.sys_ck)) {
>>> +		printk(KERN_ERR "can't get HWA742 clock\n");
>>> +		return PTR_ERR(nokia770_hwa742_platform_data.sys_ck);
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static void hwa742_dev_init(void)
>>> +{
>>> +	hwa742_get_clocks();
>>> +	omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
>>> +}
>>
>> You can now get rid of the hwa742_get_clocks(), and move that code
>> to hwa742_dev_init() instead.
>
> [snip]
>
> Done! v2 attached.

Looks good to me.

Acked-by: Tony Lindgren <tony@atomide.com>

Imre, want to update your git branch for fbdev list with this one?

Regards,

Tony


> Reinstate HWA742 platform data for nokia 770 platform.
> 
> Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
> 
> diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
> index 8780ca6..2c4785e 100644
> --- a/arch/arm/mach-omap1/board-nokia770.c
> +++ b/arch/arm/mach-omap1/board-nokia770.c
> @@ -33,6 +33,7 @@
>  #include <mach/common.h>
>  #include <mach/dsp_common.h>
>  #include <mach/omapfb.h>
> +#include <mach/hwa742.h>
>  #include <mach/lcd_mipid.h>
>  #include <mach/mmc.h>
>  #include <mach/usb.h>
> @@ -163,6 +164,20 @@ static struct spi_board_info nokia770_spi_board_info[] __initdata = {
>  	},
>  };
>  
> +static struct hwa742_platform_data nokia770_hwa742_platform_data = {
> +	.sys_ck 		= NULL,
> +	.te_connected		= 1,
> +};
> +
> +static void hwa742_dev_init(void)
> +{
> +	nokia770_hwa742_platform_data.sys_ck = clk_get(NULL, "bclk");
> +	if (IS_ERR(nokia770_hwa742_platform_data.sys_ck)) {
> +		printk(KERN_ERR "can't get HWA742 clock\n");
> +	} else {
> +		omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
> +	}
> +}
>  
>  /* assume no Mini-AB port */
>  
> @@ -371,6 +386,7 @@ static void __init omap_nokia770_init(void)
>  	omap_serial_init();
>  	omap_register_i2c_bus(1, 100, NULL, 0);
>  	omap_dsp_init();
> +	hwa742_dev_init();
>  	ads7846_dev_init();
>  	mipid_dev_init();
>  	omap_usb_init(&nokia770_usb_config);
> diff --git a/arch/arm/plat-omap/include/mach/hwa742.h b/arch/arm/plat-omap/include/mach/hwa742.h
> index 577f492..c00e05d 100644
> --- a/arch/arm/plat-omap/include/mach/hwa742.h
> +++ b/arch/arm/plat-omap/include/mach/hwa742.h
> @@ -2,10 +2,7 @@
>  #define _HWA742_H
>  
>  struct hwa742_platform_data {
> -	void		(*power_up)(struct device *dev);
> -	void		(*power_down)(struct device *dev);
> -	unsigned long	(*get_clock_rate)(struct device *dev);
> -
> +	struct clk 	*sys_ck;
>  	unsigned	te_connected:1;
>  };
>  
> diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
> index 8aa6e47..1230476 100644
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
> +	if (ctrl_conf == NULL || ctrl_conf->sys_ck == NULL) {
>  		dev_err(fbdev->dev, "HWA742: missing platform data\n");
>  		r = -ENOENT;
>  		goto err1;
>  	}
>  
> -	hwa742.power_down = ctrl_conf->power_down;
> -	hwa742.power_up = ctrl_conf->power_up;
> +	hwa742.sys_ck = ctrl_conf->sys_ck;
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
