From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: omap4-panda: Add USB Host support
Date: Wed, 19 Jun 2013 17:02:10 +0300
Message-ID: <51C1B9E2.4010807@ti.com>
References: <1371571487-14389-1-git-send-email-rogerq@ti.com> <1371571487-14389-2-git-send-email-rogerq@ti.com> <51C106A1.9030001@ti.com> <51C15F7E.5020305@ti.com> <20130619074605.GW5523@atomide.com> <51C183AC.8040801@ti.com> <51C19011.5050107@ti.com> <51C1963B.2070501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51C1963B.2070501@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/19/2013 02:30 PM, Benoit Cousson wrote:
> On 06/19/2013 06:03 AM, Roger Quadros wrote:
>> On 06/19/2013 01:10 PM, Benoit Cousson wrote:
>>> On 06/19/2013 02:46 AM, Tony Lindgren wrote:
>>>> * Roger Quadros <rogerq@ti.com> [130619 00:42]:
>>>>> Hi Benoit,
>>>>>
>>>>> On 06/19/2013 04:17 AM, Benoit Cousson wrote:
>>>>>> Hi Roger,
>>>>>>
>>>>>> On 06/18/2013 11:04 AM, Roger Quadros wrote:
>>>>>>> Provide the RESET and Power regulators for the USB PHY,
>>>>>>> the USB Host port mode and the PHY device.
>>>>>>>
>>>>>>> Also provide pin multiplexer information for the USB host
>>>>>>> pins.
>>>>>>>
>>>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>>>> ---
>>>>>>>     arch/arm/boot/dts/omap4-panda-common.dtsi |   62 +++++++++++++++++++++++++++++
>>>>>>>     1 files changed, 62 insertions(+), 0 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
>>>>>>> index 00cbaa5..7a21e8e 100644
>>>>>>> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
>>>>>>> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
>>>>>>> @@ -59,6 +59,42 @@
>>>>>>>                 "AFML", "Line In",
>>>>>>>                 "AFMR", "Line In";
>>>>>>>         };
>>>>>>> +
>>>>>>> +    /* HS USB Port 1 RESET */
>>>>>>> +    hsusb1_reset: hsusb1_reset_reg {
>>>>>>> +        compatible = "regulator-fixed";
>>>>>>> +        regulator-name = "hsusb1_reset";
>>>>>>> +        regulator-min-microvolt = <3300000>;
>>>>>>> +        regulator-max-microvolt = <3300000>;
>>>>>>> +        gpio = <&gpio2 30 0>;    /* gpio_62 */
>>>>>>> +        startup-delay-us = <70000>;
>>>>>>> +        enable-active-high;
>>>>>>> +    };
>>>>>>
>>>>>> Is this really a regulator? Or just a GPIO line used to reset the USB PHY?
>>>>>
>>>>> It is in fact a GPIO line used as reset.
>>>>>>
>>>>>> If this is the case, I don't think it should be represented as a regulator.
>>>>>
>>>>> Why not? I think it fits very well in the regulator device model.
>>>
>>> I'm not sure fitting very well is the correct term.
>>> It works, for sure, but it is no different than when we were trying to abuse the regulator fmwk to enable the 32k clock in phoenix.
>>> It is just a hack.
>>>
>>
>> The only difference is there is a dedicated framework for clocks. Since there is nothing specific to
>> handle reset lines it is left to the driver writer how he wants to manage it.
> 
> Well, at that time, it was not available either. The point is still that using a existing fmwk that has nothing to do with the signal you need to handle just because it works is not a very good justification.
> 
>>>>> I couldn't find a better
>>>>> way to represent this. It gives us a way to specify not only the GPIO line but also
>>>>> the polarity. I know mostly reset is active low but still there is flexibility as you never
>>>>> know for sure.
>>>
>>> Mmm, and what about just controlling the gpio from the driver?
>>
>> Yes gpio is possible. But then you need to add additional code in the driver to parse GPIO number and polarity.
>> Using regulator_get() was plain simple for me.
> 
> Maybe, but it is not the right thing to do.
> Can you explain me the commonality between a reset line and a regulator???
> 

I cannot prove that a reset line is a regulator, because it is not. However, the necessary features
required to manage a reset line were provided by the regulator framework e.g. gpio control, polarity,
enable delay time. It was much less hassle for me to use the regulator framework than manage
this in the phy driver.

Now that we have something specific for reset gpio I will migrate the PHY driver to that, when it is
merged.

cheers,
-roger
