From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
Date: Thu, 30 Sep 2010 06:55:25 -0700
Message-ID: <87vd5njpyq.fsf@deeprootsystems.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>
	<4CA45341.3080300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47209 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123Ab0I3Nz2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 09:55:28 -0400
In-Reply-To: <4CA45341.3080300@ti.com> (Benoit Cousson's message of "Thu, 30
	Sep 2010 11:07:13 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "Menon, Nishanth" <nm@ti.com>, "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Charu,
>
> On 9/30/2010 10:11 AM, Varadarajan, Charulatha wrote:
>> With OMAP2PLUS watchdog implemented in hwmod fw way, the
>> module is reset during init.
>
> In that case hwmod fw just highlighted the real behavior that was
> hidden so far by the X-loader.
>
> You should as well add a link to the email thread with Kevin that
> raised the issue.
>
>> After a watchdog timer module reset, the WDTs are enabled. The
>> default time for a system reset after a watchdog module reset
>> is ~10s as per the default value of the WDT registers. Hence
>> the system would be reset after 10s, if watchdog is not disabled
>> within 10s.
>>
>> This patch fixes the above issue by disabling the watchdog timer
>> after reset during initialization of devices.
>
> I'm still wondering as well what is the expected behavior of the
> watchdog in a real product. If it is started by default at boot time,
> this is probably for a good reason (or maybe not...).
>
> So, disabling it all the time is maybe not the best solution.

I'm not sure what the other options are.  If you don't have a watchdog
driver, and the watchdog is armed, it will reboot the system.

The approach in this patch is just to continue the behavior that all
bootloaders currently do, but make it explicit in the kernel.

Kevin

> Nishanth (M),
> Do you have an idea on that topic?
>
>>
>> Signed-off-by: Charulatha V<charu@ti.com>
>> Reported-by: Kevin Hilman<khilman@deeprootsystems.com>
>> ---
>> This patch is dependent on the below patch series (wdt hwmod) and
>> is created on top of pm-core branch.
>> http://www.spinics.net/lists/linux-omap/msg37043.html
>>
>>   arch/arm/mach-omap2/devices.c |   44 +++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 44 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
>> index 8e2f0aa..9f44fc6 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -916,11 +916,55 @@ static inline void omap_init_vout(void) {}
>>
>>   /*-------------------------------------------------------------------------*/
>>
>> +/*
>> + * WDT mdoule is reset during init which enables the watchdog.
>
> typo: module
>
> The real explanation is that you should not assume anything from the
> boot loader at that time, so always stop the wdt.
>
>> + * Hence it is required to disable the watchdog after the WDT reset
>> + * during init. Otherwise the system would reboot as per the default
>> + * watchdog timer registers settings.
>> + */
>> +#define OMAP_WDT_WPS	(0x34)
>> +#define OMAP_WDT_SPR	(0x48)
>> +
>> +static int omap2_disable_wdt(struct omap_hwmod *oh, void *user)
>
> You should call it unused if the parameter is not used.
>
>> +{
>> +	void __iomem *base;
>> +
>> +	if (!oh)
>> +		pr_err("Could not look up wdtimer_hwmod\n");
>> +
>> +	base = oh->_mpu_rt_va;
>
> Paul added an hwmod API to get that va (something like *_get_mpu_rt_va).
>
>> +
>> +	/* Enable the clocks before accessing the WDT registers */
>> +	omap_hwmod_enable(oh);
>
> The enable can fail, so you should check the return value.
>
>> +
>> +	/* sequence required to disable watchdog */
>> +	__raw_writel(0xAAAA, base + OMAP_WDT_SPR);	/* TIMER_MODE */
>> +	while (__raw_readl(base + OMAP_WDT_WPS)&  0x10)
>> +		cpu_relax();
>> +
>> +	__raw_writel(0x5555, base + OMAP_WDT_SPR);	/* TIMER_MODE */
>> +	while (__raw_readl(base + OMAP_WDT_WPS)&  0x10)
>> +		cpu_relax();
>> +
>> +	omap_hwmod_idle(oh);
>> +
>> +	return 0;
>> +}
>> +
>> +static void __init omap_disable_wdt(void)
>> +{
>> +	if (cpu_class_is_omap2())
>
> This code is already in mach-omap2/devices.c, so that test should be
> useless.
>
> Regards,
> Benoit
>
>> +		omap_hwmod_for_each_by_class("wd_timer",
>> +						omap2_disable_wdt, NULL);
>> +	return;
>> +}
>> +
>>   static int __init omap2_init_devices(void)
>>   {
>>   	/* please keep these calls, and their implementations above,
>>   	 * in alphabetical order so they're easier to sort through.
>>   	 */
>> +	omap_disable_wdt();
>>   	omap_hsmmc_reset();
>>   	omap_init_camera();
>>   	omap_init_mbox();
