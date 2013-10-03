From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 05/10] ARM: dts: omap3-beagle: Use reset-gpios for
 hsusb2_reset
Date: Thu, 03 Oct 2013 16:25:03 +0200
Message-ID: <524D7E3F.6010609@baylibre.com>
References: <1380012836-29900-1-git-send-email-rogerq@ti.com> <1380012836-29900-6-git-send-email-rogerq@ti.com> <524D483D.9040907@ti.com> <524D5D88.9020308@baylibre.com> <524D74A5.7010604@baylibre.com> <524D780C.1090708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524D780C.1090708-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/10/2013 15:58, Roger Quadros wrote:
> Hi Benoit,
>
> On 10/03/2013 04:44 PM, Benoit Cousson wrote:
>> On 03/10/2013 14:05, Benoit Cousson wrote:
>>> Hi Roger,
>>>
>>> Yes, I will. I've been waiting for these ones for so long :-)
>>
>> In fact it does not apply correctly on my for_3.13/dts branch :-(
>>
>> error: arch/arm/boot/dts/omap3-beagle.dts: patch does not apply
>> Patch failed at 0004 ARM: dts: omap3-beagle: Make USB host pin naming consistent
>>
>> Could you rebase it?
>
> Looks like it was already applied before. Could you please skip that and use the rest?
> I've checked that the remaining patches apply fine on top of your for_3.13/dts
> branch.

Indeed, it was already there :-)

Sorry for the noise.

Benoit

>
> cheers,
> -roger
>
>>>
>>> On 03/10/2013 12:34, Roger Quadros wrote:
>>>> Hi Benoit,
>>>>
>>>> Could you please take the device tree related patches [5 to 10] in
>>>> this series?
>>>> Thanks.
>>>>
>>>> cheers,
>>>> -roger
>>>>
>>>> On 09/24/2013 11:53 AM, Roger Quadros wrote:
>>>>> We no longer need to model the RESET line as a regulator since
>>>>> the USB phy-nop driver accepts "reset-gpios" property.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>>> ---
>>>>>    arch/arm/boot/dts/omap3-beagle.dts |   13 +------------
>>>>>    1 files changed, 1 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/omap3-beagle.dts
>>>>> b/arch/arm/boot/dts/omap3-beagle.dts
>>>>> index dfd8310..71bde47 100644
>>>>> --- a/arch/arm/boot/dts/omap3-beagle.dts
>>>>> +++ b/arch/arm/boot/dts/omap3-beagle.dts
>>>>> @@ -44,17 +44,6 @@
>>>>>            };
>>>>>        };
>>>>>
>>>>> -    /* HS USB Port 2 RESET */
>>>>> -    hsusb2_reset: hsusb2_reset_reg {
>>>>> -        compatible = "regulator-fixed";
>>>>> -        regulator-name = "hsusb2_reset";
>>>>> -        regulator-min-microvolt = <3300000>;
>>>>> -        regulator-max-microvolt = <3300000>;
>>>>> -        gpio = <&gpio5 19 0>;    /* gpio_147 */
>>>>> -        startup-delay-us = <70000>;
>>>>> -        enable-active-high;
>>>>> -    };
>>>>> -
>>>>>        /* HS USB Port 2 Power */
>>>>>        hsusb2_power: hsusb2_power_reg {
>>>>>            compatible = "regulator-fixed";
>>>>> @@ -68,7 +57,7 @@
>>>>>        /* HS USB Host PHY on PORT 2 */
>>>>>        hsusb2_phy: hsusb2_phy {
>>>>>            compatible = "usb-nop-xceiv";
>>>>> -        reset-supply = <&hsusb2_reset>;
>>>>> +        reset-gpios = <&gpio5 19 GPIO_ACTIVE_LOW>;    /* gpio_147 */
>>>>>            vcc-supply = <&hsusb2_power>;
>>>>>        };
>>>>>
>>>>>
>>>>
>>>
>>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
