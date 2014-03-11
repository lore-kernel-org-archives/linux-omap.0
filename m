From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 5/9] ARM: dts: omap3-overo: Add HSUSB PHY
Date: Tue, 11 Mar 2014 11:43:08 +0200
Message-ID: <531EDAAC.8030509@ti.com>
References: <1394220139-1760-1-git-send-email-florian.vaussard@epfl.ch> <1394220139-1760-6-git-send-email-florian.vaussard@epfl.ch> <531D9452.6040501@ti.com> <531DD6A8.7010406@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46360 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbaCKJnj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Mar 2014 05:43:39 -0400
In-Reply-To: <531DD6A8.7010406@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/10/2014 05:13 PM, Florian Vaussard wrote:
> Hi Roger,
> 
> On 03/10/2014 11:30 AM, Roger Quadros wrote:
>> Hi Florian,
>>
>> On 03/07/2014 09:22 PM, Florian Vaussard wrote:
>>> Add the High-Speed USB PHY.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>>> ---
>>>  arch/arm/boot/dts/omap3-overo-base.dtsi  | 44 ++++++++++++++++++++++++++++++++
>>>  arch/arm/boot/dts/omap3-overo-storm.dtsi | 16 ++++++++++++
>>>  arch/arm/boot/dts/omap3-overo.dtsi       | 16 ++++++++++++
>>>  3 files changed, 76 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
>>> index edac70e..13d1ad2 100644
>>> --- a/arch/arm/boot/dts/omap3-overo-base.dtsi
>>> +++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
>>> @@ -30,6 +30,24 @@
>>>  		ti,codec = <&twl_audio>;
>>>  	};
>>>  
>>> +	/* HS USB Port 2 Power */
>>> +	hsusb2_power: hsusb2_power_reg {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "hsusb2_vbus";
>>> +		regulator-min-microvolt = <5000000>;
>>> +		regulator-max-microvolt = <5000000>;
>>> +		gpio = <&gpio6 8 0>;				/* gpio_168: vbus enable */
>>> +		startup-delay-us = <70000>;
>>> +		enable-active-high;
>>> +	};
>>> +
>>> +	/* HS USB Host PHY on PORT 2 */
>>> +	hsusb2_phy: hsusb2_phy {
>>> +		compatible = "usb-nop-xceiv";
>>> +		reset-gpios = <&gpio6 23 GPIO_ACTIVE_LOW>;	/* gpio_183 */
>>> +		vcc-supply = <&hsusb2_power>;
>>> +	};
>>> +
>>>  	/* Regulator to trigger the nPoweron signal of the Wifi module */
>>>  	w3cbw003c_npoweron: regulator-w3cbw003c-npoweron {
>>>  		compatible = "regulator-fixed";
>>> @@ -64,6 +82,11 @@
>>>  };
>>>  
>>>  &omap3_pmx_core {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <
>>> +			&hsusb2_pins
>>> +	>;
>>> +
>>>  	uart2_pins: pinmux_uart2_pins {
>>>  		pinctrl-single,pins = <
>>>  			OMAP3_CORE1_IOPAD(0x216c, PIN_INPUT | MUX_MODE1)	/* mcbsp3_dx.uart2_cts */
>>> @@ -116,6 +139,19 @@
>>>  			OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE4)		/* uart3_rts_sd.gpio_164 */
>>>  		>;
>>>  	};
>>> +
>>> +	hsusb2_pins: pinmux_hsusb2_pins {
>>> +		pinctrl-single,pins = <
>>> +			OMAP3_CORE1_IOPAD(0x21d4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
>>> +			OMAP3_CORE1_IOPAD(0x21d6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
>>> +			OMAP3_CORE1_IOPAD(0x21d8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
>>> +			OMAP3_CORE1_IOPAD(0x21da, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_somi.hsusb2_data5 */
>>> +			OMAP3_CORE1_IOPAD(0x21dc, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs0.hsusb2_data6 */
>>> +			OMAP3_CORE1_IOPAD(0x21de, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 */
>>> +			OMAP3_CORE1_IOPAD(0x21be, PIN_OUTPUT | MUX_MODE4)		/* i2c2_scl.gpio_168 */
>>> +			OMAP3_CORE1_IOPAD(0x21c0, PIN_OUTPUT | MUX_MODE4)		/* i2c2_sda.gpio_183 */
>>> +		>;
>>> +	};
>>>  };
>>>  
>>>  &i2c1 {
>>> @@ -177,6 +213,14 @@
>>>  	power = <50>;
>>>  };
>>>  
>>> +&usbhshost {
>>> +	port2-mode = "ehci-phy";
>>> +};
>>> +
>>> +&usbhsehci {
>>> +	phys = <0 &hsusb2_phy>;
>>> +};
>>> +
>>>  &uart2 {
>>>  	pinctrl-names = "default";
>>>  	pinctrl-0 = <&uart2_pins>;
>>> diff --git a/arch/arm/boot/dts/omap3-overo-storm.dtsi b/arch/arm/boot/dts/omap3-overo-storm.dtsi
>>> index c235ae8..6cb418b 100644
>>> --- a/arch/arm/boot/dts/omap3-overo-storm.dtsi
>>> +++ b/arch/arm/boot/dts/omap3-overo-storm.dtsi
>>> @@ -10,6 +10,22 @@
>>>  #include "omap3-overo-base.dtsi"
>>>  
>>>  &omap3_pmx_core2 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <
>>> +			&hsusb2_2_pins
>>> +	>;
>>> +
>>> +	hsusb2_2_pins: pinmux_hsusb2_2_pins {
>>> +		pinctrl-single,pins = <
>>> +			OMAP3630_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
>>> +			OMAP3630_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
>>> +			OMAP3630_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
>>> +			OMAP3630_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
>>> +			OMAP3630_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
>>> +			OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
>>
>> If you don't use the OMAP3x30_CORE2_IOPAD() macro then these definitions can fit in omap3-overo-base.dtsi.
>> The offsets will be taken care of if you place them within &omap3_pmx_core2 {} . e.g.
>>
>> +                       0x50 (PIN_OUTPUT | MUX_MODE3)           /* etk_d10.hsusb2_clk */
>> +                       0x52 (PIN_OUTPUT | MUX_MODE3)           /* etk_d11.hsusb2_stp */
>> +                       0x54 (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* etk_d12.hsusb2_dir */
>> +                       0x56 (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* etk_d13.hsusb2_nxt */
>> +                       0x58 (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* etk_d14.hsusb2_data0 */
>> +                       0x5a (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* etk_d15.hsusb2_data1 */
>>
>> Do you think this is better?
>>
> 
> I do not think that this could work. Let's take for example hsusb2_clk
> et let's do the math. Here, 0x50 is the offset inside omap3_pmx_core2
> pinctrl, so:
> 
>         hsusb2_clk  omap3_pmx_core2      hsusb2_clk
>          offset        base addr.       PADCONF addr.
>           ----        ----------         ----------
> OMAP34xx: 0x50        0x480025d8         0x48002628  *NO*
> OMAP36xx: 0x50        0x480025a0         0x480025F0  *ok*
> 
> Looking at the TRM, the PADCONF address for hsusb2_clk is 0x480025F0 in
> both cases. Thus we will be wrong on OMAP34xx (offset should be 0x18
> instead of 0x50). Thus so far, I do not see any magical solution apart
> putting the omap3_pmx_core2 pins in a SoC-dependant .dtsi file.
> 
> I already expressed my concerns [1] about having a different base
> address for omap3_pmx_core2 depending on the SoC (although I do
> understand the rational behind). This makes cross-SoC platforms more
> difficult to maintain.

Any sane design would maintain register offsets but it doesn't seem so with
omap34xx vs omap36xx. So my assumption was wrong.

I'll ack this patch.

cheers,
-roger
