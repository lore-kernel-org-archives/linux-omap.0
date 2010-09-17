From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 09/11] OMAP: DMA: Implement generic errata handling
Date: Fri, 17 Sep 2010 09:24:37 +0200
Message-ID: <4C9317B5.3050308@ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>	<1282647866-6918-10-git-send-email-manjugk@ti.com> <87sk1qtpnu.fsf@deeprootsystems.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A93@dbde02.ent.ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402784DC7D5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59416 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab0IQHYo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 03:24:44 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402784DC7D5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Manjunath,

On 9/17/2010 7:05 AM, G, Manjunath Kondaiah wrote:
> Kevin,
>
>> -----Original Message-----
>> From: G, Manjunath Kondaiah
>> Sent: Tuesday, September 14, 2010 3:42 PM
>> To: G, Manjunath Kondaiah; Kevin Hilman
>> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Shilimkar, Santosh
>> Subject: RE: [PATCH v2 09/11] OMAP: DMA: Implement generic
>> errata handling
>>
>> Kevin,
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org
>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of G, Manjunath
>>> Kondaiah
>>> Sent: Tuesday, September 07, 2010 5:18 PM
>>> To: Kevin Hilman
>>> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Shilimkar, Santosh
>>> Subject: RE: [PATCH v2 09/11] OMAP: DMA: Implement generic errata
>>> handling
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>> Sent: Saturday, September 04, 2010 4:12 AM
>>>> To: G, Manjunath Kondaiah
>>>> Cc: linux-omap@vger.kernel.org; Cousson, Benoit;
>> Shilimkar, Santosh
>>>> Subject: Re: [PATCH v2 09/11] OMAP: DMA: Implement generic errata
>>>> handling
>>>>
>>>> Manjunatha GK<manjugk@ti.com>  writes:
>>>>
>>>>> This patch introduces generic way of handling all OMAP
>>> DMA errata's
>>>>> which are applicable for OMAP1 and OMAP2PLUS processors.
>>>>>
>>>>> Signed-off-by: Manjunatha GK<manjugk@ti.com>
>>>>> Cc: Benoit Cousson<b-cousson@ti.com>
>>>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>>>> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>>>> ---
>>>>>   arch/arm/mach-omap1/dma.c             |    6 ++++
>>>>>   arch/arm/mach-omap2/dma.c             |   34
>>>> +++++++++++++++++++++++
>>>>>   arch/arm/plat-omap/dma.c              |   48
>>>> ++++++++++++++++++--------------
>>>>>   arch/arm/plat-omap/include/plat/dma.h |    9 ++++++
>>>>>   4 files changed, 76 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap1/dma.c
>>> b/arch/arm/mach-omap1/dma.c
>>>>> index 26ab6e3..615c5f5 100644
>>>>> --- a/arch/arm/mach-omap1/dma.c
>>>>> +++ b/arch/arm/mach-omap1/dma.c
>>>>> @@ -170,6 +170,12 @@ static int __init
>> omap1_system_dma_init(void)
>>>>>   		goto exit_device_put;
>>>>>   	}
>>>>>
>>>>> +	/* Errata handling for all omap1 plus processors */
>>>>> +	pdata->errata			= 0;
>>>>
>>>> This isn't needed as you just kzalloc'd pdata.
>>> ok
>>>>
>>>>> +	if (cpu_class_is_omap1()&&  !cpu_is_omap15xx())
>>>>
>>>> You don't need cpu_class_is_omap1() as this is OMAP1
>> specific code.
>>> Ok. Looks like copy, paste issue from plat-omap dma.c. I
>> will fix it.
>>>>
>>>>> +		pdata->errata		|= OMAP3_3_ERRATUM;
>>>>> +
>>>>>   	d = pdata->dma_attr;
>>>>>
>>>>>   	/* Valid attributes for omap1 plus processors
>> */ diff --git
>>>>> a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c index
>>>>> f369bee..8832bd1 100644
>>>>> --- a/arch/arm/mach-omap2/dma.c
>>>>> +++ b/arch/arm/mach-omap2/dma.c
>>>>> @@ -80,6 +80,40 @@ static int __init
>>>> omap2_system_dma_init_dev(struct omap_hwmod *oh, void *user)
>>>>>
>>>>>   	pdata->dma_attr		= (struct omap_dma_dev_attr
>>>> *)oh->dev_attr;
>>>>>
>>>>> +	/* Handling Errata's for all OMAP2PLUS processors */
>>>>> +	pdata->errata			= 0;
>>>>
>>>> not needed, see above
>>> ok
>>>>
>>>>> +	if (cpu_is_omap242x() ||
>>>>> +		(cpu_is_omap243x()&&   omap_type()<=
>>>> OMAP2430_REV_ES1_0))
>>>>> +		pdata->errata		= DMA_CHAINING_ERRATA;
>>>>> +
>>>>> +	/*
>>>>> +	 * Errata: On ES2.0 BUFFERING disable must be set.
>>>>> +	 * This will always fail on ES1.0
>>>>> +	 */
>>>>> +	if (cpu_is_omap24xx())
>>>>> +		pdata->errata		|=
>> DMA_BUFF_DISABLE_ERRATA;
>>>>> +
>>>>> +	/*
>>>>> +	 * Errata: OMAP2: sDMA Channel is not disabled
>>>>> +	 * after a transaction error. So we explicitely
>>>>> +	 * disable the channel
>>>>> +	 */
>>>>> +	if (cpu_class_is_omap2())
>>>>> +		pdata->errata		|=
>> DMA_CH_DISABLE_ERRATA;
>>>>> +
>>>>> +	/* Errata: OMAP3 :
>>>>
>>>> fix multi-line comment style
>>> Ok.
>>>
>>>>
>>>>> +	 * A bug in ROM code leaves IRQ status for channels 0
>>>> and 1 uncleared
>>>>> +	 * after secure sram context save and restore.
>> Hence we need to
>>>>> +	 * manually clear those IRQs to avoid spurious
>> interrupts. This
>>>>> +	 * affects only secure devices.
>>>>> +	 */
>>>>> +	if (cpu_is_omap34xx()&&  (omap_type() !=
>> OMAP2_DEVICE_TYPE_GP))
>>>>> +		pdata->errata		|=
>> DMA_IRQ_STATUS_ERRATA;
>>>>> +
>>>>> +	/* Errata3.3: Applicable for all omap2 plus */
>>>>> +	pdata->errata			|= OMAP3_3_ERRATUM;
>>>>> +
>>>>>   	od = omap_device_build(name, 0, oh, pdata,
>> sizeof(*pdata),
>>>>>   			omap2_dma_latency,
>>>> ARRAY_SIZE(omap2_dma_latency), 0);
>>>>>
>>>>> diff --git a/arch/arm/plat-omap/dma.c
>> b/arch/arm/plat-omap/dma.c
>>>>> index 36c3dde..409586a 100644
>>>>> --- a/arch/arm/plat-omap/dma.c
>>>>> +++ b/arch/arm/plat-omap/dma.c
>>>>> @@ -187,6 +187,25 @@ static inline void set_gdma_dev(int
>>>> req, int dev)
>>>>>   #define set_gdma_dev(req, dev)	do {} while (0)
>>>>>   #endif
>>>>>
>>>>> +static void dma_ocpsysconfig_errata(u32 *sys_cf, bool flag)
>>>>
>>>> Please use (or extend) hwmod layer for modifying device SYSCONFIG.
>>>
>>> I will check this.
>>
>> I propose following options for addressing this errata:
>> Option 1:
>> Creating 2 new API's with 1 static function in omap_hwmod.c
>> for handling midle mode errata issues.
>>
>> static int _get_master_standbymode(oh, u32 *idlemode, u32 v);
>> int omap_hwmod_set_master_idlemode(struct omap_hwmod *oh, u8
>> idlemode); int omap_hwmod_get_master_idlemode(struct
>> omap_hwmod *oh, u32 *idlemode);
>>
>> In dma driver, the api's will be used as:
>> omap_hwmod_get_master_idlemode(oh, midle_mode);
>> omap_hwmod_set_master_idlemode(oh, 1);
>> /* disable channels which completed data transfer */ ...
>> /* Restore original standby mode values */
>> omap_hwmod_set_master_idlemode(oh, *midle_mode)
>>
>>
>> Option 2:
>> Create 1 new exported API for modifying sysconfig standby mode bits.
>> In this case, restoring original standby mode value is
>> through accessing sysc flags and _sysc_cache values through
>> oh in DMA driver.
>>
>> I feel option #1 seems to be cleaner approach since it avoids
>> accessing oh contents in driver. Let me know if you have
>> objections for the same.
>>
>> /Code snippet for option 1 */
>> static int _get_master_standbymode(oh, u32 *idlemode) {
>> 	u32 mstandby_mask;
>> 	u8 mstandby_shift;
>>
>> 	...
>>
>> 	mstandby_shift = oh->class->sysc->sysc_fields->midle_shift;
>> 	mstandby_mask = (0x3<<  mstandby_shift);
>> 	*idle_mode = ((oh->_sysc_cache)&  mstandby_mask)>>
>> mstandby_shift;
>>
>> 	return 0;
>> }
>>
>> int omap_hwmod_set_master_idlemode(struct omap_hwmod *oh, u8
>> idlemode) {
>> 	u32 v;
>> 	int retval = 0;
>> 	...
>> 	v = oh->_sysc_cache;
>>
>> 	retval = _set_master_standbymode(oh, idlemode,&v);
>> 	if (!retval)
>> 		_write_sysconfig(v, oh);
>>
>> 	return retval;
>> }
>>
>> int omap_hwmod_get_master_idlemode(struct omap_hwmod *oh, u32
>> *idlemode) {
>> 	u32 v;
>> 	int retval = 0;
>> 	...
>> 	retval = _get_master_standbymode(oh, idlemode);
>> 	return retval;
>> }
>>
>
> I assume you are ok with option #1. Let me know if you have any
> issues/concenrs with above approach. I am in the process of consolidating
> all the review comments and addressing all applicable review comments.

Not really, the option #1 will still require you to use the oh pointer, 
which is supposed to be private to the omap_device.

What is still not clear is why and when you need to change the sysconfig 
setting.

Do you have a details explanation? Ideally you should try to couple the 
sysconfig change along with pm_runtime / hwmod state change, then we 
will be able to handle that smoothly in the framework.

If you cannot do that, you will need to add an omap_device API as well.

Regards,
Benoit

