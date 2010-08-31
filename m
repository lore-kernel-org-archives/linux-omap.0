From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 6/8 v2] usb: musb: Offmode fix for idle path
Date: Tue, 31 Aug 2010 11:54:01 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402780D3F97@dbde02.ent.ti.com>
References: <1282140624-29715-1-git-send-email-hemahk@ti.com>
 <87iq2y5j5r.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58445 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756021Ab0HaGYN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 02:24:13 -0400
In-Reply-To: <87iq2y5j5r.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Mankad, Maulik Ojas" <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

 

>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: Thursday, August 26, 2010 5:40 AM
>To: Kalliguddi, Hema
>Cc: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org; 
>Mankad, Maulik Ojas; Felipe Balbi; Tony Lindgren; Cousson, 
>Benoit; Paul Walmsley
>Subject: Re: [PATCH 6/8 v2] usb: musb: Offmode fix for idle path
>
>Hema HK <hemahk@ti.com> writes:
>
>> With OMAP core-off support musb was not functional as 
>context was getting
>> lost after wakeup from core-off. And also musb was blocking 
>the core-off
>> after loading the gadget driver even with no cable connected 
>sometimes.
>>
>> Added the conext save/restore api in the platform layer which will
>> be called in the idle and wakeup path.
>>
>> Changed the usb sysconfig settings as per the usbotg functional spec.
>> When the device is not used, configure to force idle and 
>force standby mode.
>> When it is being used, configure in smart standby and smart 
>idle mode.
>> So while attempting to coreoff the usb is configured to 
>force standby and
>> force idle mode, after wakeup configured in smart idle and 
>smart standby.
>
>You don't describe the new .clk_autogated field added here.  That part
>should be a separate patch as it's not directly related to 
>$SUBJECT patch.
>

In OMAP for USB there is no need to disable the interface clock. But for the other 
platforms like davinci which uses mentor USB IP clock is not auto gated so 
There is a need to disbale the clock when .suspend API defined in the driver is called. 
So introduced a flag in the platform to enable/disable the clock
In .supend and .resume APIs appropriately in the driver code.

Yes. It may not be directly related to $SUBJECT patch, but I am reusing  
.suspend and .resume APIs for context save and restore during idle path. 
Because of that this fix as part of the patch.

>> Signed-off-by: Hema HK <hemahk@ti.com>
>> Signed-off-by: Maulik Mankad <x0082077@ti.com>
>>
>> Cc: Felipe Balbi <felipe.balbi@nokia.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c          |    5 +++
>>  arch/arm/mach-omap2/usb-musb.c        |   42 
>++++++++++++++++++++++++++++-
>>  arch/arm/plat-omap/include/plat/usb.h |    2 +
>>  drivers/usb/musb/musb_core.c          |   10 +++----
>>  drivers/usb/musb/musb_core.h          |    1 -
>>  drivers/usb/musb/omap2430.c           |   48 
>++++++++++++++++++++++++++++++---
>>  include/linux/usb/musb.h              |    6 ++++
>>  7 files changed, 102 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> index fb4994a..7b34201 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -39,6 +39,7 @@
>>  #include <plat/gpmc.h>
>>  #include <plat/dma.h>
>>  #include <plat/dmtimer.h>
>> +#include <plat/usb.h>
>>  
>>  #include <asm/tlbflush.h>
>>  
>> @@ -416,6 +417,8 @@ void omap_sram_idle(void)
>>  		if (core_next_state == PWRDM_POWER_OFF) {
>>  			omap3_core_save_context();
>>  			omap3_prcm_save_context();
>> +			/* Save MUSB context */
>> +			musb_context_save_restore(1);
>>  		}
>>  	}
>>  
>> @@ -458,6 +461,8 @@ void omap_sram_idle(void)
>>  			omap3_prcm_restore_context();
>>  			omap3_sram_restore_context();
>>  			omap2_sms_restore_context();
>> +			/* restore MUSB context */
>> +			musb_context_save_restore(0);
>>  		}
>>  		omap_uart_resume_idle(0);
>>  		omap_uart_resume_idle(1);
>> diff --git a/arch/arm/mach-omap2/usb-musb.c 
>b/arch/arm/mach-omap2/usb-musb.c
>> index c228cc0..9d10440 100644
>> --- a/arch/arm/mach-omap2/usb-musb.c
>> +++ b/arch/arm/mach-omap2/usb-musb.c
>> @@ -35,6 +35,7 @@
>>  
>>  static const char name[] = "musb_hdrc";
>>  #define MAX_OMAP_MUSB_HWMOD_NAME_LEN	16
>> +struct omap_hwmod *oh_p =NULL;
>>  
>>  static struct musb_hdrc_config musb_config = {
>>  	.multipoint	= 1,
>> @@ -59,6 +60,9 @@ static struct musb_hdrc_platform_data musb_plat = {
>>  	 * "mode", and should be passed to usb_musb_init().
>>  	 */
>>  	.power		= 50,			/* up to 100 mA */
>> +
>> +	/* supports clock autogating */
>> +	.clk_autogated	= 1,
>
>This appears unrelated, and should be a separate patch.
>
>>  };
>>  
>>  static u64 musb_dmamask = DMA_BIT_MASK(32);
>> @@ -97,7 +101,7 @@ void __init usb_musb_init(struct 
>omap_musb_board_data *board_data)
>>  	musb_plat.mode = board_data->mode;
>>  	musb_plat.extvbus = board_data->extvbus;
>>  	pdata = &musb_plat;
>> -
>> +	oh_p = oh;
>>  	od = omap_device_build(name, bus_id, oh, pdata,
>>  			       sizeof(struct musb_hdrc_platform_data),
>>  						omap_musb_latency,
>> @@ -116,8 +120,44 @@ void __init usb_musb_init(struct 
>omap_musb_board_data *board_data)
>>  
>>  }
>>  
>> +void musb_context_save_restore(int save)
>> +{
>> +	struct omap_hwmod *oh = oh_p;
>> +	struct omap_device *od;
>> +	struct platform_device *pdev;
>> +	struct device *dev;
>> +	struct device_driver *drv;
>> +	struct musb_hdrc_platform_data *pdata;
>> +	const struct dev_pm_ops *pm;
>> +
>> +	if (!oh)
>> +		return;
>> +	od = oh->od;
>> +	pdev = &od->pdev;
>> +	if (!pdev)
>> +		return;
>> +	dev = &pdev->dev;
>> +	drv = dev->driver;
>> +
>> +	if (drv) {
>> +		pdata = dev->platform_data;
>> +		pm = drv->pm;
>> +
>> +		if (!pdata->is_usb_active(dev)) {
>> +
>> +			if (save)
>> +				pm->suspend(dev);
>> +			else
>> +				pm->resume_noirq(dev);
>
>-ECONFUSED
>
>First, this 'save_restore' function neither saves or restores anything.
>

There are musb_save/restore APIs defined in the driver code and called in a system suspend/resume APIs.
I am just making use of these apis in the idle path aswell.

>Second, I'm thoroughly confused about why you are simulating a system
>suspend/resume here? 

As said, instead of exporting the internal save/restore APIs, I am making use of the pm_ops function pointers
To do the same job.

>
>Kevin
>
>> +		}
>> +	}
>> +}
>> +
>>  #else
>>  void __init usb_musb_init(struct omap_musb_board_data *board_data)
>>  {
>>  }
>> +void musb_context_save_restore(int save)
>> +{
>> +}
>>  #endif /* CONFIG_USB_MUSB_SOC */
>> diff --git a/arch/arm/plat-omap/include/plat/usb.h 
>b/arch/arm/plat-omap/include/plat/usb.h
>> index 2a9427c..ed2b41a 100644
>> --- a/arch/arm/plat-omap/include/plat/usb.h
>> +++ b/arch/arm/plat-omap/include/plat/usb.h
>> @@ -79,6 +79,8 @@ extern void usb_ehci_init(const struct 
>ehci_hcd_omap_platform_data *pdata);
>>  
>>  extern void usb_ohci_init(const struct 
>ohci_hcd_omap_platform_data *pdata);
>>  
>> +/* For saving and restoring the musb context during off/wakeup*/
>> +extern void musb_context_save_restore(int save);
>>  #endif
>>  
>>  
>> diff --git a/drivers/usb/musb/musb_core.c 
>b/drivers/usb/musb/musb_core.c
>> index 2a50d12..8510e55 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -2410,6 +2410,7 @@ static int musb_suspend(struct device *dev)
>>  	struct platform_device *pdev = to_platform_device(dev);
>>  	unsigned long	flags;
>>  	struct musb	*musb = dev_to_musb(&pdev->dev);
>> +	struct musb_hdrc_platform_data *plat = dev->platform_data;
>>  
>>  	if (!musb->clock)
>>  		return 0;
>> @@ -2428,9 +2429,7 @@ static int musb_suspend(struct device *dev)
>>  
>>  	musb_save_context(musb);
>>  
>> -	if (musb->set_clock)
>> -		musb->set_clock(musb->clock, 0);
>> -	else
>> +	if (!plat->clk_autogated)
>>  		clk_disable(musb->clock);
>>  	spin_unlock_irqrestore(&musb->lock, flags);
>>  	return 0;
>> @@ -2440,13 +2439,12 @@ static int musb_resume_noirq(struct 
>device *dev)
>>  {
>>  	struct platform_device *pdev = to_platform_device(dev);
>>  	struct musb	*musb = dev_to_musb(&pdev->dev);
>> +	struct musb_hdrc_platform_data *plat = dev->platform_data;
>>  
>>  	if (!musb->clock)
>>  		return 0;
>>  
>> -	if (musb->set_clock)
>> -		musb->set_clock(musb->clock, 1);
>> -	else
>> +	if (!plat->clk_autogated)
>>  		clk_enable(musb->clock);
>>  
>>  	musb_restore_context(musb);
>> diff --git a/drivers/usb/musb/musb_core.h 
>b/drivers/usb/musb/musb_core.h
>> index 85a92fd..bfdf54d 100644
>> --- a/drivers/usb/musb/musb_core.h
>> +++ b/drivers/usb/musb/musb_core.h
>> @@ -472,7 +472,6 @@ struct musb_context_registers {
>>  
>>  #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
>>      defined(CONFIG_ARCH_OMAP4)
>> -	u32 otg_sysconfig, otg_forcestandby;
>>  #endif
>>  	u8 power;
>>  	u16 intrtxe, intrrxe;
>> diff --git a/drivers/usb/musb/omap2430.c 
>b/drivers/usb/musb/omap2430.c
>> index 3bae428..dcba935 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -188,6 +188,18 @@ int musb_platform_set_mode(struct musb 
>*musb, u8 musb_mode)
>>  
>>  	return 0;
>>  }
>> +int is_musb_active(struct device *dev)
>> +{
>> +	struct musb *musb;
>> +
>> +#ifdef CONFIG_USB_MUSB_HDRC_HCD
>> +	/* usbcore insists dev->driver_data is a "struct hcd *" */
>> +	musb = hcd_to_musb(dev_get_drvdata(dev));
>> +#else
>> +	musb = dev_get_drvdata(dev);
>> +#endif
>> +	return musb->is_active;
>> +}
>>  
>>  int __init musb_platform_init(struct musb *musb)
>>  {
>> @@ -246,6 +258,7 @@ int __init musb_platform_init(struct musb *musb)
>>  	if (is_host_enabled(musb))
>>  		musb->board_set_vbus = omap_set_vbus;
>>  
>> +	plat->is_usb_active = is_musb_active;
>>  	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned 
>long) musb);
>>  
>>  	return 0;
>> @@ -255,15 +268,42 @@ int __init musb_platform_init(struct 
>musb *musb)
>>  void musb_platform_save_context(struct musb *musb,
>>  		struct musb_context_registers *musb_context)
>>  {
>> -	musb_context->otg_sysconfig = musb_readl(musb->mregs, 
>OTG_SYSCONFIG);
>> -	musb_context->otg_forcestandby = 
>musb_readl(musb->mregs, OTG_FORCESTDBY);
>> +	/*
>> +	 * As per the omap-usbotg specification, configure it 
>to forced standby
>> +	 * and  force idle mode when no activity on usb.
>> +	 */
>> +	void __iomem *musb_base = musb->mregs;
>> +
>> +	musb_writel(musb_base, OTG_FORCESTDBY, 0);
>> +
>> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
>> +				OTG_SYSCONFIG) & ~(NOSTDBY | 
>SMARTSTDBY));
>> +
>> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
>> +					OTG_SYSCONFIG) & ~AUTOIDLE);
>> +
>> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
>> +				OTG_SYSCONFIG) & ~(NOIDLE | SMARTIDLE));
>> +
>> +	musb_writel(musb_base, OTG_FORCESTDBY, 1);
>>  }
>>  
>>  void musb_platform_restore_context(struct musb *musb,
>>  		struct musb_context_registers *musb_context)
>>  {
>> -	musb_writel(musb->mregs, OTG_SYSCONFIG, 
>musb_context->otg_sysconfig);
>> -	musb_writel(musb->mregs, OTG_FORCESTDBY, 
>musb_context->otg_forcestandby);
>> +	/*
>> +	 * As per the omap-usbotg specification, configure it 
>smart standby
>> +	 * and smart idle during operation.
>> +	 */
>> +	void __iomem *musb_base = musb->mregs;
>> +
>> +	musb_writel(musb_base, OTG_FORCESTDBY, 0);
>> +
>> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
>> +				OTG_SYSCONFIG) | SMARTSTDBY);
>> +
>> +	musb_writel(musb_base, OTG_SYSCONFIG, musb_readl(musb_base,
>> +				OTG_SYSCONFIG) | SMARTIDLE | 
>ENABLEWAKEUP);
>>  }
>>  #endif
>>  
>> diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
>> index ee2dd1d..da134ab 100644
>> --- a/include/linux/usb/musb.h
>> +++ b/include/linux/usb/musb.h
>> @@ -126,6 +126,12 @@ struct musb_hdrc_platform_data {
>>  
>>  	/* Architecture specific board data	*/
>>  	void		*board_data;
>> +
>> +	/* check usb device active state*/
>> +	int		(*is_usb_active)(struct device *dev);
>> +
>> +	/*  indiates whether clock is autogated */
>> +	int		clk_autogated;
>>  };
>