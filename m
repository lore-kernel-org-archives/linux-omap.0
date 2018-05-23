From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 01/14] memory: ti-emif-sram: Add resume function to recopy
 sram code
Date: Wed, 23 May 2018 14:17:09 +0530
Message-ID: <739d9bbf-2acc-9c90-db43-cf78f5b184e3@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-2-git-send-email-j-keerthy@ti.com>
 <31688cf4-b6ca-e7ce-3407-46262006b38f@oracle.com>
 <d52373eb-1707-17ff-fabb-9f7200cf54c0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d52373eb-1707-17ff-fabb-9f7200cf54c0@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>, linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org



On Monday 16 April 2018 03:59 PM, Keerthy wrote:
> 
> 
> On Thursday 12 April 2018 10:14 PM, santosh.shilimkar@oracle.com wrote:
>> On 4/11/18 9:53 PM, Keerthy wrote:
>>> From: Dave Gerlach <d-gerlach@ti.com>
>>>
>>> After an RTC+DDR cycle we lose sram context so emif pm functions present
>>> in sram are lost. We can check if the first byte of the original
>>> code in DDR contains the same first byte as the code in sram, and if
>>> they do not match we know we have lost context and must recopy the
>>> functions to the previous address to maintain PM functionality.
>>>
>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>>   drivers/memory/ti-emif-pm.c | 24 ++++++++++++++++++++++++
>>>   1 file changed, 24 insertions(+)
>>>
>>> diff --git a/drivers/memory/ti-emif-pm.c b/drivers/memory/ti-emif-pm.c
>>> index 632651f..ec4a62c 100644
>>> --- a/drivers/memory/ti-emif-pm.c
>>> +++ b/drivers/memory/ti-emif-pm.c
>>> @@ -249,6 +249,25 @@ int ti_emif_get_mem_type(void)
>>>   };
>>>   MODULE_DEVICE_TABLE(of, ti_emif_of_match);
>>>   +#ifdef CONFIG_PM_SLEEP
>>> +static int ti_emif_resume(struct device *dev)
>>> +{
>>> +    unsigned long tmp =
>>> +            __raw_readl((void *)emif_instance->ti_emif_sram_virt);
>>> +
>>> +    /*
>>> +     * Check to see if what we are copying is already present in the
>>> +     * first byte at the destination, only copy if it is not which
>>> +     * indicates we have lost context and sram no longer contains
>>> +     * the PM code
>>> +     */
>>
>>> +    if (tmp != ti_emif_sram)
>>> +        ti_emif_push_sram(dev, emif_instance);
>>> +
>>> +    return 0;
>>> +}
>>> +#endif /* CONFIG_PM_SLEEP */
>> Instead of this indirect method , why can't just check the previous
>> deep sleep mode and based on that do copy or not. EMIF power status
>> register should have something like that ?
> 
> I will check if we have a register that tells the previous state of sram.

Unfortunately i do not see any such register for knowing SRAM previous
state in am43 TRM and hence this indirect way of knowing.

http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf

> 
>>
>> Another minor point is even though there is nothing to do in suspend,
>> might be good to have a callback with comment that nothing to do with
>> some explanation why not. Don't have strong preference but may for
>> better readability.

I can add a blank suspend call with comment

"The contents are already present in DDR hence no need to explicitly save"

The comment in resume function pretty much explains the above. So let me
know if i need to add the suspend callback.

Regards,
Keerthy

> 
> Okay. Thanks a lot for the quick feedback!
> 
>>
>> Regards,
>> Santosh
>>
>>
