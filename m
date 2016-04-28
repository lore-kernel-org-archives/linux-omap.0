From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 2/9] ARM: dts: am437x: Add missing compatibles to PWM
 binding documents
Date: Thu, 28 Apr 2016 16:55:31 -0500
Message-ID: <CAL_JsqLhZvQ9Vd60pNC-4U19qwi23XBC5VYxnPQVZnyYR2V0HQ@mail.gmail.com>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
 <1461710209-6563-3-git-send-email-fcooper@ti.com> <20160428210716.GA12508@rob-hp-laptop>
 <57227C9F.6080705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <57227C9F.6080705@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 28, 2016 at 4:11 PM, Franklin S Cooper Jr. <fcooper@ti.com> wrote:
>
> Rob,
> On 04/28/2016 04:07 PM, Rob Herring wrote:
>> On Tue, Apr 26, 2016 at 05:36:42PM -0500, Franklin S Cooper Jr wrote:
>>> There are several SOC specific compatibles for ECAP, EHRPWM and PWMMS
>>> that are in use but aren't properly documented. Therefore, fix this
>>> by adding the compatibles to the appropriate binding documents.
>>>
>>> While at it make minor corrections to the binding document.
>>>
>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>>> ---
>>>  .../devicetree/bindings/pwm/pwm-tiecap.txt          | 12 ++++++++++--
>>>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt        | 12 ++++++++++--
>>>  .../devicetree/bindings/pwm/pwm-tipwmss.txt         | 21 +++++++++++++++++++--
>>>  3 files changed, 39 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
>>> index fb81179..788da6c 100644
>>> --- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
>>> @@ -2,8 +2,9 @@ TI SOC ECAP based APWM controller
>>>
>>>  Required properties:
>>>  - compatible: Must be "ti,<soc>-ecap".
>>> -  for am33xx - compatible = "ti,am33xx-ecap";
>>> -  for da850  - compatible = "ti,da850-ecap", "ti,am33xx-ecap";
>>> +  for am33xx  - compatible = "ti,am33xx-ecap";
>>> +  for am4372  - compatible = "ti,am4372-ecap", "ti,am33xx-ecap";
>>> +  for da850   - compatible = "ti,da850-ecap", "ti,am33xx-ecap";
>>>  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
>>>    the cells format. The PWM channel index ranges from 0 to 4. The only third
>>>    cell flag supported by this binding is PWM_POLARITY_INVERTED.
>>> @@ -22,6 +23,13 @@ ecap0: ecap@0 { /* ECAP on am33xx */
>>>      ti,hwmods = "ecap0";
>>>  };
>>>
>>> +ecap0: ecap@0 { /* ECAP on am4372 */
>>
>> The unit address is wrong.
>>
>>> +    compatible = "ti,am4372-ecap", "ti,am33xx-ecap";
>>> +    #pwm-cells = <3>;
>>> +    reg = <0x48300100 0x80>;
>>> +    ti,hwmods = "ecap0";
>>> +};
>>> +
>>>  ecap0: ecap@0 { /* ECAP on da850 */
>>>      compatible = "ti,da850-ecap", "ti,am33xx-ecap";
>>>      #pwm-cells = <3>;
>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>> index 9c100b2..99b544f 100644
>>> --- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>> @@ -2,8 +2,9 @@ TI SOC EHRPWM based PWM controller
>>>
>>>  Required properties:
>>>  - compatible: Must be "ti,<soc>-ehrpwm".
>>> -  for am33xx - compatible = "ti,am33xx-ehrpwm";
>>> -  for da850  - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
>>> +  for am33xx  - compatible = "ti,am33xx-ehrpwm";
>>> +  for am4372  - compatible = "ti,am4372-ehrpwm", "ti,am33xx-ehrpwm";
>>> +  for da850   - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
>>>  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
>>>    the cells format. The only third cell flag supported by this binding is
>>>    PWM_POLARITY_INVERTED.
>>> @@ -22,6 +23,13 @@ ehrpwm0: ehrpwm@0 { /* EHRPWM on am33xx */
>>>      ti,hwmods = "ehrpwm0";
>>>  };
>>>
>>> +ehrpwm0: ehrpwm@0 { /* EHRPWM on am4372 */
>>
>> ditto
>>
>> Otherwise,
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
>
>
> Yes, the unit address is wrong but it is wrong in several places. I
> added it like that to match what the other bindings are doing. However,
> patches 3 and 4 fixes these unit address problems for all the bindings
> all together to make things clear.

Okay, that's fine.

Rob
