From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] pinctrl: dra: dt-bindings: Fix output pull up/down
Date: Mon, 3 Nov 2014 11:56:34 -0600
Message-ID: <CAGo_u6p-A4X9ux5RArvziKwYzPQECUwv8tUEJyAXNAPkP+Sjfg@mail.gmail.com>
References: <1414752745-13696-1-git-send-email-rogerq@ti.com>
	<1415009392-6627-1-git-send-email-rogerq@ti.com>
	<20141103143023.GA8260@kahuna>
	<545794CB.5030802@ti.com>
	<54579858.4030605@ti.com>
	<54579A4B.9060301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:52531 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbaKCR4f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2014 12:56:35 -0500
In-Reply-To: <54579A4B.9060301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Balbi, Felipe" <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, dt list <devicetree@vger.kernel.org>

On Mon, Nov 3, 2014 at 9:07 AM, Roger Quadros <rogerq@ti.com> wrote:
> On 11/03/2014 04:59 PM, Nishanth Menon wrote:
>> On 11/03/2014 08:44 AM, Roger Quadros wrote:
>>> On 11/03/2014 04:30 PM, Nishanth Menon wrote:
>>>> On 12:09-20141103, Roger Quadros wrote:
>>>>> For PIN_OUTPUT_PULLUP and PIN_OUTPUT_PULLDOWN we must not set the
>>>>> PULL_DIS bit which disables the PULLs.
>>>>>
>>>>> PULL_ENA is a 0 and using it in an OR operation is a NOP, so don't
>>>>> use it in the PIN_OUTPUT_PULLUP/DOWN macros.
>>>>>
>>>>> Fixes: 23d9cec07c58 ("pinctrl: dra: dt-bindings: Fix pull enable/disable")
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>> ---
>>>>>  include/dt-bindings/pinctrl/dra.h | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
>>>>> index 3d33794..7448edf 100644
>>>>> --- a/include/dt-bindings/pinctrl/dra.h
>>>>> +++ b/include/dt-bindings/pinctrl/dra.h
>>>>> @@ -40,8 +40,8 @@
>>>>>
>>>>>  /* Active pin states */
>>>>>  #define PIN_OUTPUT                (0 | PULL_DIS)
>>>>> -#define PIN_OUTPUT_PULLUP (PIN_OUTPUT | PULL_ENA | PULL_UP)
>>>>> -#define PIN_OUTPUT_PULLDOWN       (PIN_OUTPUT | PULL_ENA)
>>>>> +#define PIN_OUTPUT_PULLUP (PULL_UP)
>>>>> +#define PIN_OUTPUT_PULLDOWN       (0)
>>>>>  #define PIN_INPUT         (INPUT_EN | PULL_DIS)
>>>>>  #define PIN_INPUT_SLEW            (INPUT_EN | SLEWCONTROL)
>>>>>  #define PIN_INPUT_PULLUP  (PULL_ENA | INPUT_EN | PULL_UP)
>>>>
>>>> You are right, we do have an issue with using PIN_OUTPUT along with
>>>> remaining setting.
>>>>
>>>> For a moment, I wondered why input was not impacted - then I realized
>>>> that INPUT_EN was being used instead of PIN_INPUT - following that
>>>> convention. With the intent being explicitly using macros that
>>>> clearly indicate what each setting combination is is, how about the
>>>> following?
>>>>
>>>>
>>>> diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
>>>> index 3d33794..d4037e7 100644
>>>> --- a/include/dt-bindings/pinctrl/dra.h
>>>> +++ b/include/dt-bindings/pinctrl/dra.h
>>>> @@ -34,14 +34,15 @@
>>>>  #define PULL_DIS           (1 << 16)
>>>>  #define PULL_UP                    (1 << 17)
>>>>  #define INPUT_EN           (1 << 18)
>>>> +#define OUTPUT_EN          (0 << 18)
>>>>  #define SLEWCONTROL                (1 << 19)
>>>>  #define WAKEUP_EN          (1 << 24)
>>>>  #define WAKEUP_EVENT               (1 << 25)
>>>>
>>>>  /* Active pin states */
>>>> -#define PIN_OUTPUT         (0 | PULL_DIS)
>>>> -#define PIN_OUTPUT_PULLUP  (PIN_OUTPUT | PULL_ENA | PULL_UP)
>>>> -#define PIN_OUTPUT_PULLDOWN        (PIN_OUTPUT | PULL_ENA)
>>>> +#define PIN_OUTPUT         (OUTPUT_EN | PULL_DIS)
>>>> +#define PIN_OUTPUT_PULLUP  (OUTPUT_EN | PULL_ENA | PULL_UP)
>>>> +#define PIN_OUTPUT_PULLDOWN        (OUTPUT_EN | PULL_ENA)
>>>
>>> To me it adds more confusion and this change is a NOP as we're ORing 0 here
>>> with OUTPUT_EN.
>>
>> look at this this way:
>>
>> PIN_OUTPUT_PULLDOWN   (OUTPUT_EN | PULL_ENA)
>>
>> should probably trigger in mind (what about PULLDOWN?)
>>
>> PIN_OUTPUT_PULLDOWN   (OUTPUT_EN | PULL_ENA | PULL_DOWN)
>>
>> then verify values of each OUTPUT_EN  -> 0 in bit 18, ok, etc.
>>
>>
>> if we ensure that PIN_XX macros use just the basic primitives, it is
>> easier to prevent the mistake like the one I made. the other option of
>> not defining macros whose values are 0 implies that the reviewer has
>> to recheck against trm to ensure all the right "1" bits are set.
>>
>>
>> just my view here.
>
> Aren't the macros defining the bit positions not the actual enable or
> disable actions?
>
> If we go by what you said then you will have to add
> WAKEUP_DIS, SLEWCONTROL_DIS, WAKEUP_EVENT_DIS and so on.
>
> Which again makes no sense as you will have to define them to zero.

WAKEUP should not be defined anyways - pinctrl controls them - should
probably remove them from header.

but your point is probably a valid view w.r.t TI SoC bit definitions -
we just define the "1" states in omap.h as well.
-- 
---
Regards,
Nishanth Menon
