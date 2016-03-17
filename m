From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/5] pwm: pwm-tiehrpwm: Update dt binding document to use
 generic node name
Date: Thu, 17 Mar 2016 13:00:53 -0500
Message-ID: <CAL_Jsq+3vRMezgrA53jPgMZUYR+DAA_886K1Q6YfxV1bPinoQQ@mail.gmail.com>
References: <1457380318-15452-1-git-send-email-fcooper@ti.com>
 <1457380318-15452-6-git-send-email-fcooper@ti.com> <20160317150305.GA27356@rob-hp-laptop>
 <56EAE014.8070606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <56EAE014.8070606@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 17, 2016 at 11:49 AM, Franklin S Cooper Jr. <fcooper@ti.com> wrote:
>
>
> On 03/17/2016 10:03 AM, Rob Herring wrote:
>> On Mon, Mar 07, 2016 at 01:51:58PM -0600, Franklin S Cooper Jr wrote:
>>> Now that the node name has been changed from ehrpwm to pwm the document
>>> should show this proper usage. Also change the unit address in the example
>>> from 0 to the proper physical address value that should be used.
>>>
>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>> index 9c100b2..20211ed 100644
>>> --- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>> @@ -15,14 +15,14 @@ Optional properties:
>>>
>>>  Example:
>>>
>>> -ehrpwm0: ehrpwm@0 { /* EHRPWM on am33xx */
>>> +ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
>>>      compatible = "ti,am33xx-ehrpwm";
>>>      #pwm-cells = <3>;
>>>      reg = <0x48300200 0x100>;
>>>      ti,hwmods = "ehrpwm0";
>>>  };
>>>
>>> -ehrpwm0: ehrpwm@0 { /* EHRPWM on da850 */
>>> +ehrpwm0: pwm@01f00000 { /* EHRPWM on da850 */
>> No leading 0s, but more importantly the address is wrong.
>
> I will remove the leading 0. However, this value was taken
> from the .dtsi and I just double checked and I see the same
> value in the datasheet. I believe DA850,OMAP-L138 and AM18x
> all have the same memory mapping. I'm looking at
> http://www.ti.com/lit/ds/symlink/am1808.pdf page 233 and the
> addresses match up what is seen here and in the .dtsi.
>
> Can you point me to which document your looking at that
> shows a different value?

Ummm, ...

>>>      compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
>>>      #pwm-cells = <3>;
>>>      reg = <0x300000 0x2000>;

right here.

>>> --
>>> 2.7.0
>>>
>
