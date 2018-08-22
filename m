From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH] soc: ti: pm33xx: Enable DS0 for the platforms on which it
 is functional
Date: Wed, 22 Aug 2018 13:50:29 +0530
Message-ID: <ae71d45f-9260-3547-5ff2-355c084fcf8e@ti.com>
References: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
 <20180822073409.GK14967@localhost> <20180822073719.GL14967@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180822073719.GL14967@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: tony@atomide.com, d-gerlach@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 8/22/2018 1:07 PM, Johan Hovold wrote:
> On Wed, Aug 22, 2018 at 09:34:09AM +0200, Johan Hovold wrote:
>> On Wed, Aug 22, 2018 at 11:02:31AM +0530, Keerthy wrote:
>>> Enable DS0 for only those platforms on which it is functional
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/pm33xx-core.c    | 5 +++++
>>>   drivers/soc/ti/pm33xx.c              | 9 +++++++++
>>>   include/linux/platform_data/pm33xx.h | 2 ++
>>>   3 files changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
>>> index f4971e4..f0f6e8e 100644
>>> --- a/arch/arm/mach-omap2/pm33xx-core.c
>>> +++ b/arch/arm/mach-omap2/pm33xx-core.c
>>> @@ -135,6 +135,11 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
>>>   {
>>>   	int ret = 0;
>>>   
>>> +	if (!(args & WFI_FLAG_DEEP_SLEEP0)) {
>>> +		pr_err("DS0 mode not supported\n");
>>> +		return -ENOTSUPP;
>>> +	}
>>> +
>>>   	amx3_pre_suspend_common();
>>>   	scu_power_mode(scu_base, SCU_PM_POWEROFF);
>>>   	ret = cpu_suspend(args, fn);
>>> diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
>>> index d0dab32..53238d7 100644
>>> --- a/drivers/soc/ti/pm33xx.c
>>> +++ b/drivers/soc/ti/pm33xx.c
>>> @@ -324,6 +324,15 @@ static int am33xx_pm_probe(struct platform_device *pdev)
>>>   	suspend_wfi_flags |= WFI_FLAG_SAVE_EMIF;
>>>   	suspend_wfi_flags |= WFI_FLAG_WAKE_M3;
>>>   
>>> +	/*
>>> +	 * Deep Sleep0 mode is currently functional only on am437x-gp-evm,
>>> +	 * am33xx-evm and boneblack family. Hence set the DS0 flag
>>> +	 */
>>> +	if (of_machine_is_compatible("ti,am437x-gp-evm") ||
>>> +	    of_machine_is_compatible("ti,am335x-bone-black") ||
>>> +	    of_machine_is_compatible("ti,am335x-evm"))
>>> +		suspend_wfi_flags |= WFI_FLAG_DEEP_SLEEP0;
>>
>> What about other (out-of-tree) machines which supports DS0 and which
>> this change would break?
>>
>> I think this needs to be a blacklist if anything.
>>
>> Please also expand in the commit message why you think this is needed.

Currently when one does echo mem > /sys/power/state on unsuppored 
machines there can be a crash or a hang. So bail out with a message.

>>
>> Last, what tree is this against? There's no am43xx_suspend() in
>> linux-next (and you add compatibles above for am33xx too).
> 
> Sorry, there is indeed an am43xx_suspend(), but you are adding
> compatibles for am33xx which use am33xx_suspend().

am33xx_pm_probe is a common probe function for both am33 and am43.
AFAIK for am33 family am335x-evm and am335x-bone-black support Deep 
Sleep mode. For am43 family am43tx-gp-evm alone supports at the moment.

Can you let me know of other am33 machines that support DS0 mode?
I could have simply used ti,am33xx compatible which covers entire am33 
family but then am33xx-bone (bone white) does not support this mode.

> 
> Johan
> 
