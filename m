From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Tue, 26 Feb 2013 11:01:20 +0100
Message-ID: <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com>
 <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
 <4F47AD08.4030504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38122 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759924Ab3BZKBl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Feb 2013 05:01:41 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so4254041iea.14
        for <linux-omap@vger.kernel.org>; Tue, 26 Feb 2013 02:01:41 -0800 (PST)
In-Reply-To: <4F47AD08.4030504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>, Rob Herring <robherring2@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

On Fri, Feb 24, 2012 at 4:30 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 2/22/2012 7:29 PM, Stephen Warren wrote:
>>
>> Rob Herring wrote at Wednesday, February 22, 2012 10:23 AM:
>>>
>>> On 02/22/2012 08:31 AM, Cousson, Benoit wrote:
>>>>
>>>> On 2/22/2012 3:23 PM, Rob Herring wrote:
>>>>>
>>>>> On 02/15/2012 10:04 AM, Benoit Cousson wrote:
>>>>>>
>>>>>> Adapt the GPIO driver to retrieve information from a DT file.
>>>>>>
>>>>>> Allocate the irq_base dynamically and rename bank->virtual_irq_start
>>>>>> to bank->irq_base.
>>>>>> Change irq_base type to int instead of u16 to match irq_alloc_descs
>>>>>> output.
>>>>>>
>>>>>> Add documentation for GPIO properties specific to OMAP.
>>>>>>
>>>>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>>>>> Cc: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>>>>>
>>>>>
>>>>> One comment below, but otherwise:
>>>>>
>>>>> Acked-by: Rob Herring<rob.herring@calxeda.com>
>>>>>
>>>>>> ---
>>>>>>    .../devicetree/bindings/gpio/gpio-omap.txt         |   30 +++++
>>>>>>    drivers/gpio/gpio-omap.c                           |  121
>>>>>> ++++++++++++++++++--
>>>>>>    2 files changed, 142 insertions(+), 9 deletions(-)
>>>>>>    create mode 100644
>>>>>> Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>>>>> b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..c1b3100
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>>>>> @@ -0,0 +1,30 @@
>>>>>> +OMAP GPIO controller bindings
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible:
>>>>>> +  - "ti,omap2-gpio" for OMAP2 controllers
>>>>>> +  - "ti,omap3-gpio" for OMAP3 controllers
>>>>>> +  - "ti,omap4-gpio" for OMAP4 controllers
>>>>>> +- #gpio-cells : Should be two.
>>>>>> +  - first cell is the pin number
>>>>>> +  - second cell is used to specify optional parameters (unused)
>>>>>> +- gpio-controller : Marks the device node as a GPIO controller.
>>>>>> +- #interrupt-cells : Should be one
>>>>>
>>>>>
>>>>> There's no level/edge settings for gpios?
>>>>
>>>>
>>>> That's a good question, because I was wondering as well :-)
>>>>
>>>> I did no see how it was done in other GPIO implementation.
>>>
>>>
>>> There's not really a good example that I've found. Many gpio nodes don't
>>> even have "interrupt-controller" set.
>>>
>>> So if you have an irq_set_type function for gpio's, then you should have
>>> 2 cells.
>
>
> After checking the OMAP gpio code, I do have a gpio_irq_type and the GPIO do
> support the 4 types. I'm not sure yet about the combinations.
>
>
>> Tegra's GPIO IRQ binding (gpio_nvidia.txt in linux-next at least) says:
>>
>> - #interrupt-cells : Should be 2.
>>    The first cell is the GPIO number.
>>    The second cell is used to specify flags:
>>      bits[3:0] trigger type and level flags:
>>        1 = low-to-high edge triggered.
>>        2 = high-to-low edge triggered.
>>        4 = active high level-sensitive.
>>        8 = active low level-sensitive.
>>        Valid combinations are 1, 2, 3, 4, 8.
>
>
> Indeed, so I'll just copy / paste Tegra's binding...
>
> Thanks,
> Benoit
>
>

Hello,

I was wondering if the level/edge settings for gpios is working on OMAP.

I'm adding DT support for an SMSC911x ethernet chip connected to the
GPMC for an OMAP3 SoC based board.

In the smsc911x driver probe function (smsc911x_drv_probe() in
drivers/net/ethernet/smsc/smsc911x.c), a call to request_irq() with
the flag IRQF_TRIGGER_LOW is needed because of the wiring on my board.

Reading the gpio-omap.txt documentation it says that #interrupt-cells
should be <2> and that a value of 8 is "active low level-sensitive".

So I tried this:

&gpmc {
	ethernet@5,0 {
		pinctrl-names = "default";
		pinctrl-0 = <&smsc911x_pins>;
		compatible = "smsc,lan9221", "smsc,lan9115";
		reg = <5 0 0xff>; /* CS5 */
		interrupt-parent = <&gpio6>;
		interrupts = <16 8>; /* gpio line 176 */
		interrupt-names = "smsc911x irq";
		vmmc-supply = <&vddvario>;
		vmmc_aux-supply = <&vdd33a>;
		reg-io-width = <4>;

		smsc,save-mac-address;
      };
};

But in the smsc911x probe function:

irq_res->flags & IRQF_TRIGGER_MASK;

returns 0 which means that no trigger flags where set.

I took a look to the GPIOs device node definition on omap{3,4,5}.dtsi
and all look like this:

e.g from omap3.dtsi:

                gpio6: gpio@49058000 {
                        compatible = "ti,omap3-gpio";
                        ti,hwmods = "gpio6";
                        gpio-controller;
                        #gpio-cells = <2>;
                        interrupt-controller;
                        #interrupt-cells = <1>;
                };

So, even when the documentation says that all the GPIO device nodes in
OMAP2+ should use a #interrupt-cells property value of <2>, they are
only using <1>. Changing that value to 2 makes hangs the kernel and it
does not boot.

This is not part of my dayjob and I'm working on this in my free time
so it would be great if someone can give me some pointers or at least
confirm that  this is a known issue so I can debug/fix/extend
drivers/gpio/gpio-omap.c to parse and pass the IRQF_TRIGGER_*  flags
to the IORESOURCE_IRQ resource structure.

Thanks a lot and best regards,
Javier
