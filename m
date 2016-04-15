From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] rtc: omap: Support ext_wakeup configuration
Date: Fri, 15 Apr 2016 19:46:44 +0300
Message-ID: <57111AF4.6070505@ti.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com> <57078A89.3080809@ti.com>
 <20160408151408.GS16484@atomide.com> <5707E764.7050204@ti.com>
 <570D2F79.9040202@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570D2F79.9040202-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/12/2016 08:25 PM, Marcin Niestroj wrote:
> Hi,
> 
> On 08.04.2016 19:16, Grygorii Strashko wrote:
>> On 04/08/2016 06:14 PM, Tony Lindgren wrote:
>>> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [160408 03:41]:
>>>> Hi Tony,
>>>>
>>>> On 04/05/2016 01:40 AM, Tony Lindgren wrote:
>>>>> Hi,
>>>>>
>>>>> * Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> [160404 08:57]:
>>>>>> Support configuration of ext_wakeup sources. This patch makes it
>>>>>> possible to enable ext_wakeup and set it's polarity, depending on 
>>>>>> board
>>>>>> configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
>>>>>> notify about power-button presses. Handling power-button presses 
>>>>>> enables
>>>>>> to recover from RTC-only power states correctly.
>>>>>
>>>>> I suggest you just set this pin up as a minimal gpiochip. That way
>>>>> we can use the standard binding :) And if we get lucky, this pin can
>>>>> also trigger during runtime.
>>>>>
>>>>
>>>> Following my comments on v2 of this patch I propose to rollback to
>>>> this version of the patch.
>>>>
>>>> It seems doesn't fit in gpiochip, it's more likely irqchip, but since
>>>> rtc can't generate IRQ there are nor reasons for these genetic
>>>> experiments and RTC's specific bindings looks more suitable, at 
>>>> least for me.
>>>
>>> Hmm well gpiochips typically are irqchip too. IMO the generic binding
>>> here sounds like "gpio-wakeup" as it's an input with polarity and with
>>> an optional interrupt.
>>>
>>> Plain irqchip would work too in this case if there are no other GPIO
>>> specific features. Some other RTCs may have more GPIO like features.
>>>
>>> In any case, setting the ext_wakeup up as an irqchip means that the
>>> RTC controller can be used as a dedicated wakeirq with Linux :)
>>
>> It can't :( It can't generate IRQ when state of ext_wakeup line has
>> been changed.
>>
>>>
>>> Are you guys sure there's no wake pin events during runtime? AFAIK
>>> the RTCs just typically produce an interrupt when programmed to
>>> do so, they don't know the state of the SoC.
>>>
>>
>> I do not think that It can be fit in gpiochip or irqchip -
>> in my opinion right way is to proceed with bindings proposed by
>> Marcin in this patch v1.
>>
>> But, probably, it could fit in pinctrl:
>> - this is pin's configuration
>> - this is one-time configuration
>> - or - configuration which can be applied before suspend
>>    and resorted after suspend.
>>
>> if you still wanna try some generic framework.
>>
> 
> pinctrl bindings looks ok for our use case (enable/disable input,
> configure debounce), except I don't see any way to pass polarity
> (active low/high) to the driver.
> 

Below code is just a POC that pinctrl can be used here.
It does one time configuration at boot, but more sates can be added
- sleep, poweroff:

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 13ac882..9580c82 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1248,11 +1248,40 @@
 
                rtc: rtc@48838000 {
                        compatible = "ti,am3352-rtc";
-                       reg = <0x48838000 0x100>;
+                       reg = <0x48838000 0x98>;
                        interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
                                     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
                        ti,hwmods = "rtcss";
                        clocks = <&sys_32k_ck>;
+                       #address-cells = <1>;
+                       #size-cells = <1>;
+                       ranges;
+                       
+                       rtc_pmx: pinmux@48838098 {
+                               compatible = "pinctrl-single";
+                               reg = <0x48838098 0x8>;
+                               #address-cells = <1>;
+                               #size-cells = <0>;
+                               pinctrl-single,register-width = <32>;
+                               pinctrl-single,function-mask = <0x007fffff>;
+
+                               pinctrl-names = "default"/*, "sleep"*/;
+                               pinctrl-0 = <&rtc_default>;
+/*                             pinctrl-1 = <&rtc_sleep>;*/
+
+                               rtc_default: rtc_default {
+                                       pinctrl-single,pins = <
+                                               0x0 0x000B0111
+                                               0x4 0x00000004
+                                       >;
+                               };
+/*                             rtc_sleep: rtc_sleep {
+                                       pinctrl-single,pins = <
+                                               0x0 0x00000000
+                                               0x4 0x00000000
+                                       >;
+                               };*/
+                       };
                };
 
                /* OCP2SCP1 */
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index ec2e9c5..28c67a4 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -428,8 +428,10 @@ static void omap_rtc_power_off(void)
 
        rtc->type->unlock(rtc);
        /* enable pmic_power_en control */
+/*
        val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
        rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
+*/
 
        /* set alarm two seconds from now */
        omap_rtc_read_time_raw(rtc, &tm);
@@ -650,6 +652,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
                          reg | OMAP_RTC_OSC_SEL_32KCLK_SRC);
        }
 
+       of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+
        rtc->type->lock(rtc);
 
        device_init_wakeup(&pdev->dev, true);
 

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
