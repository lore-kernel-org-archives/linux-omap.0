From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH] ARM: OMAP4: ID: Improve features detection and check
Date: Thu, 1 Nov 2012 23:58:27 +0530
Message-ID: <5092BF4B.3020004@ti.com>
References: <1351765401-12487-1-git-send-email-ivan.khoronzhuk@ti.com> <50925E7F.7080602@ti.com> <5092A156.4000601@ti.com> <5092A4DF.4080405@ti.com> <20121101170609.GA23552@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121101170609.GA23552@kahuna>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, "ivan.khoronzhuk" <ivan.khoronzhuk@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 01 November 2012 10:36 PM, Nishanth Menon wrote:
> On 22:05-20121101, Santosh Shilimkar wrote:
>> On Thursday 01 November 2012 09:50 PM, ivan.khoronzhuk wrote:
>>> On 11/01/2012 01:35 PM, Santosh Shilimkar wrote:
>>>> On Thursday 01 November 2012 03:53 PM, Ivan Khoronzhuk wrote:
>>>>> Replaces several flags bearing the same meaning. There is no need
>>>>> to set flags due to different omap types here, it can be checked
>>>>> in appropriate places as well.
>>>>>
>>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>>> Cc: linux-omap@vger.kernel.org
>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>>>> ---

[..]
>>>>> +    if (si_type == OMAP4_SILICON_TYPE_PERFORMANCE)
>>>>> +        omap_features = OMAP4_HAS_PERF_SILICON;
>>>>
>>>> Well the detection isn't for performance/standard but there are some
>>>> features depend on it. For example 1 GHz doesn't DPLL DCC enable feature
>>>> where as 1.2 GHz, 1.5 GHz doesn't need. This is the main reason this
>>>> information is also effused. Have you considered this aspect while
>>>> creating this patch ?
>>>>
>>>> Regards
>>>> Santosh
>>>>
>>>
>>> I had considered it. There is no dependency on the features.
>>> DCC usage depends on asked frequency on the fly, not from the features.
>>> Depending on "performance/standard" feature the available frequencies
>>> should be chosen in places where they are needed, for example while
>>> initializing OPPs.
>>>
>> You are correct about the way DCC is handled in the clock code. Infact
>> all these features like L2CACHE, SGX, IVA etc is more for to display
>> boot messages.
>>
>>> Currently we have several features while it is only one indeed.
>>>
>> 1GHz, 1.2GHz, 1.5 GHz are not same since the silicon capability itself
>> is different.
>>
>> git blame tells me that Nishant has sent this update so looping him
>> if above differentiation in boot log helps.
>>
>> Nishant,
>> What's your take on removing above freq prints and marking
>> those silicon as performance silicons as the $subject patch does ?
>>
>> Regards
>> Santosh
> Yes $subject patch is a better approach compared to having freq based
> handling which just increases the number of macros we need to enable
> depending on SoC variants that we spin off the main SoC. This also
> allows us to conserve the features bitfield ahead as well.
>
> I hate to admit, but after a couple of generations of SoC spinoffs,
> my original logic is proving to be was pretty short sighted,
> unfortunately :(
>
> So, approach
> Acked-by: Nishanth Menon <nm@ti.com>
>
Thanks Nishant for clarification and ack.

With the clarification I also like the subject patch.
Feel free add.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
