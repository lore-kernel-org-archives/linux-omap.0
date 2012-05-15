From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 2/2] arm: omap3: am35x: Disable hlt when using Davinci
 EMAC
Date: Tue, 15 May 2012 15:42:09 +0300
Message-ID: <4FB24F21.2010009@compulab.co.il>
References: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com> <1336770778-23044-3-git-send-email-mgreer@animalcreek.com> <4FB0C06A.5030503@compulab.co.il> <20120514165456.GA28976@animalcreek.com> <87ehqmqwhm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:53814
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932092Ab2EOMmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 08:42:19 -0400
In-Reply-To: <87ehqmqwhm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/15/12 00:32, Kevin Hilman wrote:
> "Mark A. Greer" <mgreer@animalcreek.com> writes:
> 
>> On Mon, May 14, 2012 at 11:20:58AM +0300, Igor Grinberg wrote:
>>> Hi Mark,
>>
>> Hi Igor.
>>
>>> Thanks for the great work!
>>>
>>> On 05/12/12 00:12, Mark A. Greer wrote:
>>>> From: "Mark A. Greer" <mgreer@animalcreek.com>
>>>>
>>>> The am35x family of SoCs has a Davinci EMAC ethernet
>>>> controller on-chip.  Unfortunately, the EMAC is unable
>>>> to wake the PRCM when there is network activity which
>>>> leads to a hung or extremely slow system when the MPU
>>>> has executed a 'wfi' instruction (because of pm_idle
>>>> or CPUidle).  To prevent this, add hooks to the EMAC
>>>> pm_runtime suspend/resume calls so that hlt is disabled
>>>> whenever the EMAC is in use.
>>>>
>>>> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
>>>> ---
>>>>  arch/arm/mach-omap2/am35xx-emac.c     |   44 +++++++++++++++++++++++++++++----
>>>>  arch/arm/mach-omap2/am35xx-emac.h     |   16 +++++++++---
>>>>  arch/arm/mach-omap2/board-am3517evm.c |    3 ++-
>>>>  arch/arm/mach-omap2/board-cm-t3517.c  |    3 ++-
>>>>  4 files changed, 56 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
>>>> index 3bb5cb3..22ff968 100644
>>>> --- a/arch/arm/mach-omap2/am35xx-emac.c
>>>> +++ b/arch/arm/mach-omap2/am35xx-emac.c
>>>> @@ -23,6 +23,37 @@
>>>>  #include "control.h"
>>>>  #include "am35xx-emac.h"
>>>>  
>>>> +/*
>>>> + * Default pm_lats for the am35x.
>>>> + * The net effect of using am35xx_emac_pm_lats[] is that
>>>> + * pm_idle or CPUidle won't be called while the emac
>>>> + * interface is open.  This is required because the
>>>> + * EMAC can't wake up PRCM so if the MPU is executing
>>>> + * a 'wfi' instruction (e.g., from pm_idle or CPUidle),
>>>> + * it won't break out of it due to emac activity.
>>>> + */
>>>> +static int am35xx_emac_deactivate_func(struct omap_device *od)
>>>> +{
>>>> +	enable_hlt();
>>>> +	return omap_device_idle_hwmods(od);
>>>> +}
>>>> +
>>>> +static int am35xx_emac_activate_func(struct omap_device *od)
>>>> +{
>>>> +	disable_hlt();
>>>> +	return omap_device_enable_hwmods(od);
>>>> +}
>>>> +
>>>> +struct omap_device_pm_latency am35xx_emac_pm_lats[] = {
>>>> +	{
>>>> +		.deactivate_func	= am35xx_emac_deactivate_func,
>>>> +		.activate_func		= am35xx_emac_activate_func,
>>>> +		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
>>>> +	},
>>>> +};
>>>> +
>>>> +int am35xx_emac_pm_lats_size = ARRAY_SIZE(am35xx_emac_pm_lats);
>>>> +
>>>>  static void am35xx_enable_emac_int(void)
>>>>  {
>>>>  	u32 regval;
>>>> @@ -61,12 +92,13 @@ static struct emac_platform_data am35xx_emac_pdata = {
>>>>  static struct mdio_platform_data am35xx_mdio_pdata;
>>>>  
>>>>  static int __init omap_davinci_emac_dev_init(struct omap_hwmod *oh,
>>>> -		void *pdata, int pdata_len)
>>>> +		void *pdata, int pdata_len,
>>>> +		struct omap_device_pm_latency *pm_lats, int pm_lats_size)
>>>>  {
>>>>  	struct platform_device *pdev;
>>>>  
>>>>  	pdev = omap_device_build(oh->class->name, 0, oh, pdata, pdata_len,
>>>> -			NULL, 0, false);
>>>> +			pm_lats, pm_lats_size, false);
>>>>  	if (IS_ERR(pdev)) {
>>>>  		WARN(1, "Can't build omap_device for %s:%s.\n",
>>>>  					oh->class->name, oh->name);
>>>> @@ -76,7 +108,8 @@ static int __init omap_davinci_emac_dev_init(struct omap_hwmod *oh,
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
>>>> +void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en,
>>>> +		struct omap_device_pm_latency *pm_lats, int pm_lats_size)
>>>>  {
>>>>  	struct omap_hwmod *oh;
>>>>  	u32 regval;
>>>> @@ -91,7 +124,7 @@ void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
>>>>  	am35xx_mdio_pdata.bus_freq = mdio_bus_freq;
>>>>  
>>>>  	ret = omap_davinci_emac_dev_init(oh, &am35xx_mdio_pdata,
>>>> -					 sizeof(am35xx_mdio_pdata));
>>>> +					 sizeof(am35xx_mdio_pdata), NULL, 0);
>>>>  	if (ret) {
>>>>  		pr_err("Could not build davinci_mdio hwmod device\n");
>>>>  		return;
>>>> @@ -106,7 +139,8 @@ void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
>>>>  	am35xx_emac_pdata.rmii_en = rmii_en;
>>>>  
>>>>  	ret = omap_davinci_emac_dev_init(oh, &am35xx_emac_pdata,
>>>> -					 sizeof(am35xx_emac_pdata));
>>>> +					 sizeof(am35xx_emac_pdata),
>>>> +					 pm_lats, pm_lats_size);
>>>>  	if (ret) {
>>>>  		pr_err("Could not build davinci_emac hwmod device\n");
>>>>  		return;
>>>> diff --git a/arch/arm/mach-omap2/am35xx-emac.h b/arch/arm/mach-omap2/am35xx-emac.h
>>>> index 15c6f9c..7c23808 100644
>>>> --- a/arch/arm/mach-omap2/am35xx-emac.h
>>>> +++ b/arch/arm/mach-omap2/am35xx-emac.h
>>>> @@ -6,10 +6,20 @@
>>>>   * published by the Free Software Foundation.
>>>>   */
>>>>  
>>>> +#include <plat/omap_device.h>
>>>> +
>>>>  #define AM35XX_DEFAULT_MDIO_FREQUENCY	1000000
>>>>  
>>>> -#if defined(CONFIG_TI_DAVINCI_EMAC) || defined(CONFIG_TI_DAVINCI_EMAC_MODULE)
>>>> -void am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en);
>>>> +#if IS_ENABLED(CONFIG_TI_DAVINCI_EMAC)
>>>> +extern struct omap_device_pm_latency am35xx_emac_pm_lats[];
>>>> +extern int am35xx_emac_pm_lats_size;
>>>> +
>>>> +void am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en,
>>>> +		struct omap_device_pm_latency *pm_lats, int pm_lats_size);
>>>>  #else
>>>> -static inline void am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en) {}
>>>> +#define am35xx_emac_pm_lats		NULL
>>>> +#define am35xx_emac_pm_lats_size	0
>>>> +
>>>> +static inline void am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en,
>>>> +		struct omap_device_pm_latency *pm_lats, int pm_lats_size) {}
>>>>  #endif
>>>> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
>>>> index 3645285..fe3a304 100644
>>>> --- a/arch/arm/mach-omap2/board-am3517evm.c
>>>> +++ b/arch/arm/mach-omap2/board-am3517evm.c
>>>> @@ -385,7 +385,8 @@ static void __init am3517_evm_init(void)
>>>>  	i2c_register_board_info(1, am3517evm_i2c1_boardinfo,
>>>>  				ARRAY_SIZE(am3517evm_i2c1_boardinfo));
>>>>  	/*Ethernet*/
>>>> -	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);
>>>> +	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1,
>>>> +			 am35xx_emac_pm_lats, am35xx_emac_pm_lats_size);
>>>
>>> Why is it essential for board file to pass these pm structures?
>>> Is it something board specific?
>>> Can't you just use them inside the am35xx-emac.c file?
>>
>> Great question.  I went back & forth on this mayself (I have 3 different
>> versions sitting in my repo :).  I ended up passing the pm structures in
>> case there is a variant that comes along that doesn't need this fixup (or
>> a board that wants to do this plus additional things).
>>
>> The variants that I have are:
>>
>> 1) Leave am35xx_emac_init() interface the way it is and automatically
>> add the necessary things.  The problem is lack of flexibility if & when
>> some other variant comes along.
>>
>> 2) Add pm_lats & pm_lats_size to am35xx_emac_init() but if they're NULL
>> or 0, then use the defaults that are the same as what's in this patch.
>> More flexible but doesn't easily allow a board file to NULL out the pm
>> structure (have to make up and pass NULL version).
>>
>> 3) Pass the pm struct via am35xx_emac_init() and just make the default
>> available for use.  This is what I submitted since it was the most flexible.
>>
>> Which one do you prefer or do you have something else in mind?
>>
> 
> For now, I suggest you stick with (1) until we have a reason to make it
> more flexible.  AFAIK, all usages of this IP in OMAP-derivative parts
> have this same limitation.

I agree with Kevin - (1) should be used.

There is no need to complicate things in favor of something that might
or might not exist some day, because even if it will exist some day,
we probably anyway will see a better solution to this and will change
the existing one.


-- 
Regards,
Igor.
