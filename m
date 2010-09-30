From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
Date: Thu, 30 Sep 2010 18:46:08 +0200
Message-ID: <4CA4BED0.7020108@ti.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com> <4CA45341.3080300@ti.com> <87vd5njpyq.fsf@deeprootsystems.com> <4CA49ADE.6080202@ti.com>,<20100930150713.GG3117@atomide.com>,<EAF47CD23C76F840A9E7FCE10091EFAB030CCF813E@dbde02.ent.ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB030CCF813F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55877 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756724Ab0I3QqR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 12:46:17 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CCF813F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

On 9/30/2010 6:32 PM, Varadarajan, Charulatha wrote:
> Benoit,
>
> <<snip>>
>
>>> With OMAP2PLUS watchdog implemented in hwmod fw way, the
>>> module is reset during init.
>>
>> In that case hwmod fw just highlighted the real behavior that was hidden
>> so far by the X-loader.
>
> Yes.
>
>>
>> You should as well add a link to the email thread with Kevin that raised
>> the issue.
>
> Okay.
>
> <<snip>>
>
>>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
>>> index 8e2f0aa..9f44fc6 100644
>>> --- a/arch/arm/mach-omap2/devices.c
>>> +++ b/arch/arm/mach-omap2/devices.c
>>> @@ -916,11 +916,55 @@ static inline void omap_init_vout(void) {}
>>>
>>>    /*-------------------------------------------------------------------------*/
>>>
>>> +/*
>>> + * WDT mdoule is reset during init which enables the watchdog.
>>
>> typo: module
>
> Okay will correct it.
>
>>
>> The real explanation is that you should not assume anything from the
>> boot loader at that time, so always stop the wdt.
>
> It is not an assumption from bootloader. After the WDT reset, the
> WDT is enabled and the reset values of WDT registers makes the system to
> reboot (in ~10s) as WDT is enabled.

The implicit assumption in the previous code is that the bootloader 
already stopped it. That exactly for that reason that hwmod is reseting 
every IPs, because we don't have a clue about what X-loader / u-boot can 
do between a cold-reset and the kernel boot.

>
>>
>>> + * Hence it is required to disable the watchdog after the WDT reset
>>> + * during init. Otherwise the system would reboot as per the default
>>> + * watchdog timer registers settings.
>>> + */
>>> +#define OMAP_WDT_WPS	(0x34)
>>> +#define OMAP_WDT_SPR	(0x48)
>>> +
>>> +static int omap2_disable_wdt(struct omap_hwmod *oh, void *user)
>>
>> You should call it unused if the parameter is not used.
>
> Okay.
>
>>
>>> +{
>>> +	void __iomem *base;
>>> +
>>> +	if (!oh)
>>> +		pr_err("Could not look up wdtimer_hwmod\n");
>>> +
>>> +	base = oh->_mpu_rt_va;
>>
>> Paul added an hwmod API to get that va (something like *_get_mpu_rt_va).
>
> Okay. Will use that.
>
>>
>>> +
>>> +	/* Enable the clocks before accessing the WDT registers */
>>> +	omap_hwmod_enable(oh);
>>
>> The enable can fail, so you should check the return value.
>
> Okay.
>
>>
>>> +
>>> +	/* sequence required to disable watchdog */
>>> +	__raw_writel(0xAAAA, base + OMAP_WDT_SPR);	/* TIMER_MODE */
>>> +	while (__raw_readl(base + OMAP_WDT_WPS)&   0x10)
>>> +		cpu_relax();
>>> +
>>> +	__raw_writel(0x5555, base + OMAP_WDT_SPR);	/* TIMER_MODE */
>>> +	while (__raw_readl(base + OMAP_WDT_WPS)&   0x10)
>>> +		cpu_relax();
>>> +
>>> +	omap_hwmod_idle(oh);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void __init omap_disable_wdt(void)
>>> +{
>>> +	if (cpu_class_is_omap2())
>>
>> This code is already in mach-omap2/devices.c, so that test should be
>> useless.
>
> I do not see a cpu_class_is_omap2() check in omap2_init_devices(). Please
> point out where this check is done while/before calling omap_disable_wdt()?
>

And Paul has just answered that one...

Benoit


