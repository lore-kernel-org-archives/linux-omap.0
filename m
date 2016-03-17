From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH 5/5] pwm: pwm-tiehrpwm: Update dt binding document to use
 generic node name
Date: Thu, 17 Mar 2016 14:25:53 -0500
Message-ID: <56EB04C1.3010709@ti.com>
References: <1457380318-15452-1-git-send-email-fcooper@ti.com>
 <1457380318-15452-6-git-send-email-fcooper@ti.com>
 <20160317150305.GA27356@rob-hp-laptop> <56EAE014.8070606@ti.com>
 <CAL_Jsq+3vRMezgrA53jPgMZUYR+DAA_886K1Q6YfxV1bPinoQQ@mail.gmail.com>
 <56EAF562.9060408@ti.com>
 <CAL_JsqLwpvjMHmEwhouiUR1vs4xG2hOn4AovNv1VaFEaSDpMug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLwpvjMHmEwhouiUR1vs4xG2hOn4AovNv1VaFEaSDpMug@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

+Sekhar

On 03/17/2016 01:56 PM, Rob Herring wrote:
> On Thu, Mar 17, 2016 at 1:20 PM, Franklin S Cooper Jr. <fcooper@ti.com> wrote:
>>
>> On 03/17/2016 01:00 PM, Rob Herring wrote:
>>> On Thu, Mar 17, 2016 at 11:49 AM, Franklin S Cooper Jr. <fcooper@ti.com> wrote:
>>>> On 03/17/2016 10:03 AM, Rob Herring wrote:
>>>>> On Mon, Mar 07, 2016 at 01:51:58PM -0600, Franklin S Cooper Jr wrote:
>>>>>> Now that the node name has been changed from ehrpwm to pwm the document
>>>>>> should show this proper usage. Also change the unit address in the example
>>>>>> from 0 to the proper physical address value that should be used.
>>>>>>
>>>>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>>>>> index 9c100b2..20211ed 100644
>>>>>> --- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>>>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>>>>> @@ -15,14 +15,14 @@ Optional properties:
>>>>>>
>>>>>>  Example:
>>>>>>
>>>>>> -ehrpwm0: ehrpwm@0 { /* EHRPWM on am33xx */
>>>>>> +ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
>>>>>>      compatible = "ti,am33xx-ehrpwm";
>>>>>>      #pwm-cells = <3>;
>>>>>>      reg = <0x48300200 0x100>;
>>>>>>      ti,hwmods = "ehrpwm0";
>>>>>>  };
>>>>>>
>>>>>> -ehrpwm0: ehrpwm@0 { /* EHRPWM on da850 */
>>>>>> +ehrpwm0: pwm@01f00000 { /* EHRPWM on da850 */
>>>>> No leading 0s, but more importantly the address is wrong.
>>>> I will remove the leading 0. However, this value was taken
>>>> from the .dtsi and I just double checked and I see the same
>>>> value in the datasheet. I believe DA850,OMAP-L138 and AM18x
>>>> all have the same memory mapping. I'm looking at
>>>> http://www.ti.com/lit/ds/symlink/am1808.pdf page 233 and the
>>>> addresses match up what is seen here and in the .dtsi.
>>>>
>>>> Can you point me to which document your looking at that
>>>> shows a different value?
>>> Ummm, ...
>>>
>>>>>>      compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
>>>>>>      #pwm-cells = <3>;
>>>>>>      reg = <0x300000 0x2000>;
>>> right here.
>> So I don't know the history but the SOC node specifies a
>> ranges value of ranges = <0x0 0x01c00000 0x400000>;. It
>> seems that all child nodes of SOC have a reg property then
>> is based on an offset of 0x01c00000. So this is true for
>> UART, rtc, i2c, wdt, mmc, spi etc... So using a base offset
>> of 0x01c00000 + 0x300000 (reg value of the pwm) equals the
>> physical address of the ehrpwm0 register 0x1f00000.
>>
>> For the child nodes within the SOC node, the unit-address is
>> always based on the physical address not based on the offset
>> address.
> They are all wrong and should be fixed. Unit address should match the
> reg property unless the bus has defined something different (e.g.
> PCI).

I added Sekhar to hopefully comment if it would be better to
try to get the reg properties to use their physical
addresses or change the unit address to use the offset values.

I don't mind shooting a patch that makes this massive switch
for all the various peripherals and documentation. However,
this is a bit beyond this series.  In this series I am not
setting the unit address or reg address I am simply
documenting what is currently being used. This patch set is
a dependency for another patchset to get PWM support for DRA7.

Are you ok with me doing the below?
I submit a v2 that removes the leading 0 in this patch. This
way this patchset and my PWMSS support for DRA7 patchset can
get merged. I can then follow up with another separate
patchset that insures both the unit address and the value in
the reg property are aligned.
>
> Rob

