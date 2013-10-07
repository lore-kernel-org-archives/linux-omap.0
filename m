From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: dts: omap3-igep0020: Add HS USB Host support
Date: Mon, 7 Oct 2013 12:06:34 +0300
Message-ID: <5252799A.5030301@ti.com>
References: <1380931479-16142-1-git-send-email-javier.martinez@collabora.co.uk> <1380931479-16142-3-git-send-email-javier.martinez@collabora.co.uk> <525271D5.9070009@ti.com> <525275C8.2050208@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <525275C8.2050208-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+devicetree

Javier,

On 10/07/2013 11:50 AM, Javier Martinez Canillas wrote:
> On Mon, Oct 7, 2013 at 10:33 AM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
>> Hi Javier,
>>
>> On 10/05/2013 03:04 AM, Javier Martinez Canillas wrote:
>>> Add device nodes for the HS USB Host port 1, USB PHY and its
>>> required regulator and also pin mux setup for HS USB1 pins.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>>> ---
>>>  arch/arm/boot/dts/omap3-igep.dtsi    | 22 ++++++++++++++++++++++
>>>  arch/arm/boot/dts/omap3-igep0020.dts | 25 +++++++++++++++++++++++++
>>>  2 files changed, 47 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi
> b/arch/arm/boot/dts/omap3-igep.dtsi
>>> index 0f92224..ec2ecd2 100644
>>> --- a/arch/arm/boot/dts/omap3-igep.dtsi
>>> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
>>> @@ -27,6 +27,11 @@
>>>  };
>>>
>>>  &omap3_pmx_core {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <
>>> +             &hsusbb1_pins
>>> +     >;
>>> +
>>>       uart1_pins: pinmux_uart1_pins {
>>>               pinctrl-single,pins = <
>>>                       0x152 (PIN_INPUT | MUX_MODE0)           /*
> uart1_rx.uart1_rx */
>>> @@ -78,6 +83,23 @@
>>>               >;
>>>       };
>>>
>>> +     hsusbb1_pins: pinmux_hsusbb1_pins {
>>> +             pinctrl-single,pins = <
>>> +                     0x5aa (PIN_OUTPUT | MUX_MODE3)          /*
> etk_ctl.hsusb1_clk */
>>> +                     0x5a8 (PIN_OUTPUT | MUX_MODE3)          /*
> etk_clk.hsusb1_stp */
>>> +                     0x5bc (PIN_INPUT_PULLDOWN | MUX_MODE3)  /*
> etk_d8.hsusb1_dir */
>>> +                     0x5be (PIN_INPUT_PULLDOWN | MUX_MODE3)  /*
> etk_d9.hsusb1_nxt */
>>> +                     0x5ac (PIN_INPUT_PULLDOWN | MUX_MODE3)  /*
> etk_d0.hsusb1_data0 */
>>> +                     0x5ae (PIN_INPUT_PULLDOWN | MUX_MODE3)  /*
> etk_d1.hsusb1_data1 */
>>> +                     0x5b0 (PIN_INPUT_PULLDOWN | MUX_MODE3)  /*
> etk_d2.hsusb1_data2 */
>>> +                     0x5b2 (PIN_INPUT_PULLDOWN | MUX_MODE3)  /*
> etk_d3.hsusb1_data7 */
>>> +                     0x5b4 (PIN_INPUT_PULLDOWN | MUX_MODE3)  /*
> etk_d4.hsusb1_data4 */
>>> +                     0x5b6 (PIN_INPUT_PULLDOWN | MUX_MODE3)  /*
> etk_d5.hsusb1_data5 */
>>> +                     0x5b8 (PIN_INPUT_PULLDOWN | MUX_MODE3)  /*
> etk_d6.hsusb1_data6 */
>>> +                     0x5ba (PIN_INPUT_PULLDOWN | MUX_MODE3)  /*
> etk_d7.hsusb1_data3 */
>>> +             >;
>>> +     };
>>> +
>>
>> Is this pin config required for igep0030 as well? If not then you should move
> these pinmux
>> definitions to omap3-igep0020.dts.
>>
>> All else looks good to me.
>>
> 
> Hi Roger,
> 
> Well that's a very good question indeed.
> 
> The thing is that the IGEP0030 is a Computer-on-Module [1] that is used in
> conjunction with expansion boards and some of them have USB HOST support such as
> IGEP Paris [2] and IGEP Berlin [3].
> 
> Support for this expansion boards is still not in mainline but there are plans
> to add them using Device Tree overlays [4] once/if this land on mainline.
> 

Why would your boards need Device Tree overlays? From the looks of it, the configuration
of SOM + base board don't seem to change at runtime.

> So, answering your question right now this is not required but I thought it
> would be good to have it configured by default in case someone using an IGEP0030
> and a expansion board wants to extend omap3-igep0030.dts to add support for its
> expansion board.

I think all you need is a .dts file for each expansion board that extends
omap3-iegp0030.dts.

That way, the pinmux for USB host pins will come only in those boards that have the USB host port.

> 
> I've no strong opinion on this though and I can send a new patch with those pins
> moved to omap3-igep0020.dts though if you think that would be better.

If you don't put it in omap3-igep0020.dts, how will you handle the case when a omap3-igep0030
SOM is used with an expansion board that doesn't have USB host port and uses it for something
else?

> 
>>>       leds_pins: pinmux_leds_pins { };
>>>  };
>>>
>>> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
> b/arch/arm/boot/dts/omap3-igep0020.dts
>>> index 903e944..180b186 100644
>>> --- a/arch/arm/boot/dts/omap3-igep0020.dts
>>> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
>>> @@ -55,6 +55,23 @@
>>>               regulator-name = "vdd33a";
>>>               regulator-always-on;
>>>       };
>>> +
>>> +       /* HS USB Port 1 Power */
>>> +       hsusb1_power: hsusb1_power_reg {
>>> +               compatible = "regulator-fixed";
>>> +               regulator-name = "hsusb1_vbus";
>>> +               regulator-min-microvolt = <3300000>;
>>> +               regulator-max-microvolt = <3300000>;
>>> +               gpio = <&twl_gpio 18 GPIO_ACTIVE_LOW>;        /* GPIO LEDA */
>>> +               startup-delay-us = <70000>;
>>> +       };
>>> +
>>> +     /* HS USB Host PHY on PORT 1 */
>>> +     hsusb1_phy: hsusb1_phy {
>>> +             compatible = "usb-nop-xceiv";
>>> +             reset-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>; /* gpio_24 */
>>> +             vcc-supply = <&hsusb1_power>;
>>> +     };
>>>  };
>>>
>>>  &leds_pins {
>>> @@ -173,3 +190,11 @@
>>>       mode = <3>;
>>>       power = <50>;
>>>  };
>>> +
>>> +&usbhshost {
>>> +     port1-mode = "ehci-phy";
>>> +};
>>> +
>>> +&usbhsehci {
>>> +     phys = <&hsusb1_phy>;
>>> +};
>>>
>>

cheers,
-roger

>> --
> 
> Thanks a lot and best regards,
> Javier
> 
> [1]: http://www.isee.biz/products/processor-boards/igep-com-module
> [2]: http://www.isee.biz/products/expansion-boards/product-igep-paris
> [3]: http://www.isee.biz/products/expansion-boards/product-igep-berlin
> [4]:
> http://learn.adafruit.com/introduction-to-the-beaglebone-black-device-tree/device-tree-overlays
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
