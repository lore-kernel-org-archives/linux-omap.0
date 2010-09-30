From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
Date: Thu, 30 Sep 2010 16:12:46 +0200
Message-ID: <4CA49ADE.6080202@ti.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>	<4CA45341.3080300@ti.com>
	<87vd5njpyq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87vd5njpyq.fsf@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nayak,
	Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan,
	Charulatha" <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

On 9/30/2010 3:55 PM, Kevin Hilman wrote:
> "Cousson, Benoit"<b-cousson@ti.com>  writes:
>
>> Hi Charu,
>>
>> On 9/30/2010 10:11 AM, Varadarajan, Charulatha wrote:
>>> With OMAP2PLUS watchdog implemented in hwmod fw way, the
>>> module is reset during init.
>>
>> In that case hwmod fw just highlighted the real behavior that was
>> hidden so far by the X-loader.
>>
>> You should as well add a link to the email thread with Kevin that
>> raised the issue.
>>
>>> After a watchdog timer module reset, the WDTs are enabled. The
>>> default time for a system reset after a watchdog module reset
>>> is ~10s as per the default value of the WDT registers. Hence
>>> the system would be reset after 10s, if watchdog is not disabled
>>> within 10s.
>>>
>>> This patch fixes the above issue by disabling the watchdog timer
>>> after reset during initialization of devices.
>>
>> I'm still wondering as well what is the expected behavior of the
>> watchdog in a real product. If it is started by default at boot time,
>> this is probably for a good reason (or maybe not...).
>>
>> So, disabling it all the time is maybe not the best solution.
>
> I'm not sure what the other options are.  If you don't have a watchdog
> driver, and the watchdog is armed, it will reboot the system.
>
> The approach in this patch is just to continue the behavior that all
> bootloaders currently do, but make it explicit in the kernel.

Yes, because we are not a building a product, and for us watchdog is a 
pain. But I'm not sure that a real product will disable that at all 
during the boot process.

I think that disabling it should be done only if the CONFIG_OMAP_WDT is 
not set.

But since I don't have a clue about a product can use that, it will be 
good to have such inputs to understand the usecase.

Benoit


> Kevin
>
>> Nishanth (M),
>> Do you have an idea on that topic?
>>
>>>
>>> Signed-off-by: Charulatha V<charu@ti.com>
>>> Reported-by: Kevin Hilman<khilman@deeprootsystems.com>
>>> ---
>>> This patch is dependent on the below patch series (wdt hwmod) and
>>> is created on top of pm-core branch.
>>> http://www.spinics.net/lists/linux-omap/msg37043.html
>>>
>>>    arch/arm/mach-omap2/devices.c |   44 +++++++++++++++++++++++++++++++++++++++++
>>>    1 files changed, 44 insertions(+), 0 deletions(-)
>>>
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
>>
>> The real explanation is that you should not assume anything from the
>> boot loader at that time, so always stop the wdt.
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
>>
>>> +
>>> +	/* Enable the clocks before accessing the WDT registers */
>>> +	omap_hwmod_enable(oh);
>>
>> The enable can fail, so you should check the return value.
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
>>
>> Regards,
>> Benoit
>>
>>> +		omap_hwmod_for_each_by_class("wd_timer",
>>> +						omap2_disable_wdt, NULL);
>>> +	return;
>>> +}
>>> +
>>>    static int __init omap2_init_devices(void)
>>>    {
>>>    	/* please keep these calls, and their implementations above,
>>>    	 * in alphabetical order so they're easier to sort through.
>>>    	 */
>>> +	omap_disable_wdt();
>>>    	omap_hsmmc_reset();
>>>    	omap_init_camera();
>>>    	omap_init_mbox();
