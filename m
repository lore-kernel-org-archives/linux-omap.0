From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5] pwm: pwm-tiehrpwm: Update dt binding document to use
 generic node name
Date: Thu, 17 Mar 2016 13:20:18 -0500
Message-ID: <56EAF562.9060408@ti.com>
References: <1457380318-15452-1-git-send-email-fcooper@ti.com>
 <1457380318-15452-6-git-send-email-fcooper@ti.com>
 <20160317150305.GA27356@rob-hp-laptop> <56EAE014.8070606@ti.com>
 <CAL_Jsq+3vRMezgrA53jPgMZUYR+DAA_886K1Q6YfxV1bPinoQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+3vRMezgrA53jPgMZUYR+DAA_886K1Q6YfxV1bPinoQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 03/17/2016 01:00 PM, Rob Herring wrote:
> On Thu, Mar 17, 2016 at 11:49 AM, Franklin S Cooper Jr. <fcooper-l0cyMroinI0@public.gmane.org> wrote:
>>
>> On 03/17/2016 10:03 AM, Rob Herring wrote:
>>> On Mon, Mar 07, 2016 at 01:51:58PM -0600, Franklin S Cooper Jr wrote:
>>>> Now that the node name has been changed from ehrpwm to pwm the document
>>>> should show this proper usage. Also change the unit address in the example
>>>> from 0 to the proper physical address value that should be used.
>>>>
>>>> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>>> index 9c100b2..20211ed 100644
>>>> --- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>>>> @@ -15,14 +15,14 @@ Optional properties:
>>>>
>>>>  Example:
>>>>
>>>> -ehrpwm0: ehrpwm@0 { /* EHRPWM on am33xx */
>>>> +ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
>>>>      compatible = "ti,am33xx-ehrpwm";
>>>>      #pwm-cells = <3>;
>>>>      reg = <0x48300200 0x100>;
>>>>      ti,hwmods = "ehrpwm0";
>>>>  };
>>>>
>>>> -ehrpwm0: ehrpwm@0 { /* EHRPWM on da850 */
>>>> +ehrpwm0: pwm@01f00000 { /* EHRPWM on da850 */
>>> No leading 0s, but more importantly the address is wrong.
>> I will remove the leading 0. However, this value was taken
>> from the .dtsi and I just double checked and I see the same
>> value in the datasheet. I believe DA850,OMAP-L138 and AM18x
>> all have the same memory mapping. I'm looking at
>> http://www.ti.com/lit/ds/symlink/am1808.pdf page 233 and the
>> addresses match up what is seen here and in the .dtsi.
>>
>> Can you point me to which document your looking at that
>> shows a different value?
> Ummm, ...
>
>>>>      compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
>>>>      #pwm-cells = <3>;
>>>>      reg = <0x300000 0x2000>;
> right here.

So I don't know the history but the SOC node specifies a
ranges value of ranges = <0x0 0x01c00000 0x400000>;. It
seems that all child nodes of SOC have a reg property then
is based on an offset of 0x01c00000. So this is true for
UART, rtc, i2c, wdt, mmc, spi etc... So using a base offset
of 0x01c00000 + 0x300000 (reg value of the pwm) equals the
physical address of the ehrpwm0 register 0x1f00000.

For the child nodes within the SOC node, the unit-address is
always based on the physical address not based on the offset
address.

So the values documented is simply following the convention
that has already been established in the .dtsi.
>
>>>> --
>>>> 2.7.0
>>>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
