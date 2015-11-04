From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: edma: fix build without CONFIG_OF
Date: Wed, 4 Nov 2015 11:05:54 +0200
Message-ID: <5639CA72.4050604@ti.com>
References: <17811472.bY8CqmdEVy@wuerfel> <5639B6EB.8030101@ti.com>
 <16166945.0Jm7Xdjkb9@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <16166945.0Jm7Xdjkb9@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/04/2015 10:46 AM, Arnd Bergmann wrote:
> On Wednesday 04 November 2015 09:42:35 Peter Ujfalusi wrote:
>> On 11/03/2015 04:00 PM, Arnd Bergmann wrote:
>>> During the edma rework, a build error was introduced for the
>>> case that CONFIG_OF is disabled:
>>>
>>> drivers/built-in.o: In function `edma_tc_set_pm_state':
>>> :(.text+0x43bf0): undefined reference to `of_find_device_by_node'
>>>
>>> As the edma_tc_set_pm_state() function does nothing in case
>>> we are running without OF, this adds an IS_ENABLED() check
>>> that turns the function into an empty stub then and avoids the
>>> link error.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Fixes: ca304fa9bb76 ("ARM/dmaengine: edma: Public API to use private struct pointer")
>>
>> The actual commit this patch is fixing is:
>> 1be5336bc7ba dmaengine: edma: New device tree binding
> 
> That's what I first thought, but it seems to just move around the
> call to of_find_device_by_node that was first introduced in the
> commit I mentioned. Did you build-test it successfully with
> ca304fa9bb76 and CONFIG_OF enabled? I have to admit that I
> was just guessing from the contents and did not bisect this
> fully.

Ah, I see. That of_find_device_by_node() was used by the function used to
build the unused channel list for the legacy old code. The whole unused
channel list has been removed by the new DT binding patch since it was bogus
to start with and there is no need for it anymore.

> 
>>> ---
>>> Found on ARM randconfig builds with today's linux-next
>>
>> I have sanity built the kernel with omap2plus_defconfig and
>> davinci_all_defconfig since eDMA is used by these platforms and did not faced
>> with this issue, as obviously these defconfigs will result OF to be enabled.
> 
> Right. The defconfigs were all fine, and this is hard to hit
> even in the randconfig builds.

I just did a sanity clean _defconfig builds and they both built fine (even w/o
this patch), phew.

>>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>>> index 31722d436a42..16713a93da10 100644
>>> --- a/drivers/dma/edma.c
>>> +++ b/drivers/dma/edma.c
>>> @@ -1560,7 +1560,7 @@ static void edma_tc_set_pm_state(struct edma_tc *tc, bool enable)
>>>       struct platform_device *tc_pdev;
>>>       int ret;
>>>  
>>> -     if (!tc)
>>> +     if (!IS_ENABLED(CONFIG_OF) || !tc)
>>>               return;
>>
>> Should we instead put the function inside of:
>> #if IS_ENABLED(CONFIG_OF)
>> static void edma_tc_set_pm_state(struct edma_tc *tc, bool enable)
>> {
>> ...
>> }
>> #else
>> static inline void edma_tc_set_pm_state(struct edma_tc *tc, bool enable)
>> {
>> }
>> #endif /* IS_ENABLED(CONFIG_OF) */
> 
> I think that would be less readable, and gives no compile-time coverage
> to the contents of the edma_tc_set_pm_state function.

Hrm, if the compiler knows that there is no need to compile the code after the:
if (!IS_ENABLED(CONFIG_OF) || !tc)
when OF is disabled, then it does not give more compile coverage then have
empty inline function in case of !OF.
Not sure about it, but if we disable all optimization in gcc, then we might
get the same missing symbol?

> The effect is the same, so I'd rather stay with my version.

I'm fine with both. It is up to Vinod to decide which one he prefers (I prefer
the #if #else #endif version).

Anyways:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
