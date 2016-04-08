From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] rtc: omap: Support ext_wakeup configuration
Date: Fri, 8 Apr 2016 13:42:30 +0300
Message-ID: <57078B16.2020402@ti.com>
References: <1459960367-29399-1-git-send-email-m.niestroj@grinn-global.com>
 <1459960367-29399-2-git-send-email-m.niestroj@grinn-global.com>
 <20160406191103.GE27411@atomide.com> <57056352.1060801@grinn-global.com>
 <57063B1A.7080700@ti.com> <570694B0.4040500@grinn-global.com>
 <57077769.1050101@ti.com> <57078313.70803@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <57078313.70803@grinn-global.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>, Tony Lindgren <tony@atomide.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 04/08/2016 01:08 PM, Marcin Niestroj wrote:
> 
> 
> On 08.04.2016 11:18, Grygorii Strashko wrote:
>> On 04/07/2016 08:11 PM, Marcin Niestroj wrote:
>>>
>>> On 07.04.2016 12:48, Grygorii Strashko wrote:
>>>> On 04/06/2016 10:28 PM, Marcin Niestroj wrote:
>>>>> Hi,
>>>>>
>>>>> On 06.04.2016 21:11, Tony Lindgren wrote:
>>>>>> * Marcin Niestroj <m.niestroj@grinn-global.com> [160406 09:34]:
>>>>>>> Support configuration of ext_wakeup sources. This patch makes it
>>>>>>> possible to enable ext_wakeup (and set it's polarity), depending on
>>>>>>> board configuration. AM335x's dedicated PMIC (tps65217) uses
>>>>>>> ext_wakeup
>>>>>>> in SLEEP mode (RTC-only) to notify about power-button presses.
>>>>>>> Handling
>>>>>>> power-button presses enables to recover from RTC-only power states
>>>>>>> correctly.
>>>>>>>
>>>>>>> Implementation uses gpiochip to utilize standard bindings. However,
>>>>>>> configuration is possible only using device-tree (no runtime 
>>>>>>> changes).
>>>>>>
>>>>>> Hey looks good to me, adding linux-omap list to Cc.
>>>>>>
>>>>>> Can you please check that the "depends on GPIOLIB" does not disable
>>>>>> the RTC driver for omap1?
>>>>>
>>>>> Looks ok for omap1. ARCH_OMAP1 selects ARCH_REQUIRE_GPIOLIB, which
>>>>> selects GPIOLIB.
>>>>>
>>>>> Best regards,
>>>>> Marcin
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Tony
>>>>>>
>>>>>>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
>>>>>>> ---
>>>>>>>    Documentation/devicetree/bindings/rtc/rtc-omap.txt |  18 ++-
>>>>>>>    drivers/rtc/Kconfig                                |   2 +-
>>>>>>>    drivers/rtc/rtc-omap.c                             | 137
>>>>>>> ++++++++++++++++++++-
>>>>>>>    3 files changed, 154 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>>>>>>> b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>>>>>>> index bf7d11a..4a7738e 100644
>>>>>>> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
>>>>>>> @@ -18,8 +18,12 @@ Optional properties:
>>>>>>>      through pmic_power_en
>>>>>>>    - clocks: Any internal or external clocks feeding in to rtc
>>>>>>>    - clock-names: Corresponding names of the clocks
>>>>>>> +- gpio-controller: Mark as gpio controller when using ext_wakeup
>>>>>>> +- #gpio-cells: Should be set to 2
>>>>>>> +- ngpios: Number of ext_wakeup sources supported by processor 
>>>>>>> (board)
>>>>>>> +- ext-wakeup-gpios: List of ext_wakeup sources to configure
>>>>>>>
>>>>>>> -Example:
>>>>>>> +Examples:
>>>>>>>
>>>>>>>    rtc@1c23000 {
>>>>>>>        compatible = "ti,da830-rtc";
>>>>>>> @@ -31,3 +35,15 @@ rtc@1c23000 {
>>>>>>>        clocks = <&clk_32k_rtc>, <&clk_32768_ck>;
>>>>>>>        clock-names = "ext-clk", "int-clk";
>>>>>>>    };
>>>>>>> +
>>>>>>> +rtc: rtc@44e3e000 {
>>>>>>> +    compatible = "ti,am3352-rtc", "ti,da830-rtc";
>>>>>>> +    reg = <0x44e3e000 0x1000>;
>>>>>>> +    interrupts = <75
>>>>>>> +              76>;
>>>>>>> +    system-power-controller;
>>>>>>> +    gpio-controller;
>>>>>>> +    #gpio-cells = <2>;
>>>>>>> +    ngpios = <1>;
>>>>>>> +    ext-wakeup-gpios = <&rtc 0 GPIO_ACTIVE_LOW>;
>>>>>>> +};
>>>>
>>>> I'm not sure that rtc can request gpios by itself in this
>>>> way (if i rememberer this can break modules isnmod/rmmod).
>>>>
>>>> cc: linux-gpio
>>>>
>>>> The gpio-hog is more correct way follow if I'm not mistaken)
>>>> - see gpiochip_request_own_desc().
>>>
>>> You are right. It is not possible to rmmod module, as it is "in use"
>>> all the time. I'll try with gpio_requst_own_desc().
>>>
>>>>
>>>> Another question, in commit message you refer to  power-button,
>>>> but i do not see anything related in binding description.
>>>
>>> We don't have power-button connected right to the processor. It is
>>> connected to PMIC. During runtime we receive IRQs about power-button
>>> from PMIC using i2c bus. The only purpose of this patch is to
>>> configure processor's ext_wakeup line, which is triggered during
>>> RTC-only mode (for example when power-button is pressed), causing
>>> device wakeup. On the other hand, it is not possible to use ext_wakeup
>>> during runtime, as we are only able to read it's status, but it
>>> cannot trigger any interrupts.
>>
>> Sry, but I don't like this approach - it could make sense if RTC
>> EXT_WAKEUP will be at least partially mapped on gpiolib interface.
>> But your gpiochip is fake, you do not/can't use GPIO hogging mechanism
>> and you're even parsing DT on your own (in V3).
> 
> With gpio hogging we can't pass polarity to the driver. It is hidden
> in gpiolib.

kirkwood-openrd.dtsi-			p2 {
kirkwood-openrd.dtsi:				gpio-hog;
kirkwood-openrd.dtsi-				gpios = <2 GPIO_ACTIVE_HIGH>;
						[input;]

Sry, if you can't do smth like above - it's just prove that this approach is not right.

> 
>>
>> In general it's more like irqchip than gpiochip, but RTC can
>> trigger IRQ on ext_wakeup :(
>>
>> As per above, your first version of the patch looks more sensible to me.
>>
>> Additional note. Shouldn't EXT_WAKEUP_STATUS be cleared after wake up?
>> This is requested by am57x trm at least: "SW must clear the events before
>> PMIC_PWR_ENABLE can go from 1 - 0. "
> 
> I haven't seen that in am335x TRM. In current implementation if
> EXT_WAKEUP_STATUS is set, we read it and write it back together with 
> EXT_WAKEUP_EN and EXT_WAKEUP_POL, which results in clearing of this
> event.

ok. I found this in omap_rtc_power_off(). Thanks for your explanation.

> 
>>
>>>
>>>>
>>>> Shouldn't some gpio-key node be here, which will consume rtc-gpio?
>>>>
>>>>
>>>>>>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>>>>>>> index 3e84315..f013346 100644
>>>>>>> --- a/drivers/rtc/Kconfig
>>>>>>> +++ b/drivers/rtc/Kconfig
>>
>> [...]
>>
>>
> 


-- 
regards,
-grygorii
