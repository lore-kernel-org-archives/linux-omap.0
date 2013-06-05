From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 2/4] ARM: dts: omap5-uevm: Add USB Host support
Date: Wed, 5 Jun 2013 14:42:20 +0530
Message-ID: <51AF00F4.3010105@ti.com>
References: <1370414770-1485-1-git-send-email-r.sricharan@ti.com> <1370414770-1485-3-git-send-email-r.sricharan@ti.com> <51AEEFE0.50107@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37824 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010Ab3FEJMy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jun 2013 05:12:54 -0400
In-Reply-To: <51AEEFE0.50107@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, Roger Quadros <rogerq@ti.com>

Hi,
On Wednesday 05 June 2013 01:29 PM, Florian Vaussard wrote:
> Hello,
>
> Some very minor comments.
>
> On 06/05/2013 08:46 AM, Sricharan R wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> Provide the RESET regulators for the USB PHYs, the USB Host
>> port modes and the PHY devices.
>>
>> Also provide pin multiplexer information for the USB host
>> pins.
>>
>> Cc: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> [Sricharan R <r.sricharan@ti.com>: Replaced constants with preprocessor macros]
>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>> ---
>>   arch/arm/boot/dts/omap5-uevm.dts |   77 ++++++++++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/omap5.dtsi     |   30 +++++++++++++++
>>   2 files changed, 107 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index 843a001..cf862df 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -25,6 +25,47 @@
>>           regulator-max-microvolt = <3000000>;
>>       };
>>
>> +    /* HS USB Port 2 RESET */
>> +    hsusb2_reset: hsusb2_reset_reg {
>> +        compatible = "regulator-fixed";
>> +        regulator-name = "hsusb2_reset";
>> +        regulator-min-microvolt = <3300000>;
>> +        regulator-max-microvolt = <3300000>;
>> +        gpio = <&gpio3 16 GPIO_ACTIVE_HIGH>; /* gpio3_80 HUB_NRESET */
>> +        startup-delay-us = <70000>;
>> +        enable-active-high;
>> +    };
>> +
>> +    /* HS USB Host PHY on PORT 2 */
>> +    hsusb2_phy: hsusb2_phy {
>> +        compatible = "usb-nop-xceiv";
>> +        reset-supply = <&hsusb2_reset>;
>> +    };
>> +
>> +    /* HS USB Port 3 RESET */
>> +    hsusb3_reset: hsusb3_reset_reg {
>> +        compatible = "regulator-fixed";
>> +        regulator-name = "hsusb3_reset";
>> +        regulator-min-microvolt = <3300000>;
>> +        regulator-max-microvolt = <3300000>;
>> +        gpio = <&gpio3 15 GPIO_ACTIVE_HIGH>; /* gpio3_79 ETH_NRESET */
>> +        startup-delay-us = <70000>;
>> +        enable-active-high;
>> +    };
>> +
>> +    /* HS USB Host PHY on PORT 3 */
>> +    hsusb3_phy: hsusb3_phy {
>> +        compatible = "usb-nop-xceiv";
>> +        reset-supply = <&hsusb3_reset>;
>> +    };
>> +
>> +    /* hsusb2_phy is clocked by FREF_CLK1 i.e. auxclk1 */
>> +    clock_alias {
>> +        clock-name = "auxclk1_ck";
>> +        clock-alias = "main_clk";
>> +        device = <&hsusb2_phy>;
>> +        clock-frequency = <19200000>; /* 19.2 MHz */
>> +    };
>>   };
>>
>>   &omap5_pmx_core {
>> @@ -35,6 +76,7 @@
>>               &dmic_pins
>>               &mcbsp1_pins
>>               &mcbsp2_pins
>> +            &usbhost_pins
>>       >;
>>
>>       twl6040_pins: pinmux_twl6040_pins {
>> @@ -120,6 +162,32 @@
>>               0x16c (PIN_INPUT | MUX_MODE1)        /*  mcspi2_cs */
>>           >;
>>       };
>> +
>> +    usbhost_pins: pinmux_usbhost_pins {
>> +        pinctrl-single,pins = <
>> +            0x84 (PIN_INPUT | MUX_MODE0) /* usbb2_hsic_strobe INPUT | MODE 0 */
>> +            0x86 (PIN_INPUT | MUX_MODE0) /* usbb2_hsic_data INPUT | MODE 0 */
>
> Comments are redundant with the constants, so maybe you can leave this part out.
> Same for a few others below.
>
Ok, I agree here for attributes like pulls, i/o etc, comments are now not required.
But comment is still good to describe just the mux mode functionality ?
One module will use different pins, like data, clk, gpios, etc. Just MUX_MODEX does not
complete it..
>> +
>> +            0x19e (PIN_INPUT | MUX_MODE0) /* usbb3_hsic_strobe INPUT | MODE 0 */
>> +            0x1a0 (PIN_INPUT | MUX_MODE0) /* usbb3_hsic_data INPUT | MODE 0 */
>> +
>> +            0x70 (PIN_OUTPUT | MUX_MODE6) /* gpio3_80 OUTPUT | MODE 6 HUB_NRESET */
>> +            0x6e (PIN_OUTPUT | MUX_MODE6) /* gpio3_79 OUTPUT | MODE 6 ETH_NRESET */
>> +        >;
>> +    };
>> +};
>> +
>> +&omap5_pmx_wkup {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <
>> +            &usbhost_wkup_pins
>> +    >;
>> +
>> +    usbhost_wkup_pins: pinmux_usbhost_wkup_pins {
>> +        pinctrl-single,pins = <
>> +            0x1A (PIN_OUTPUT | MUX_MODE0) /* fref_clk1_out OUTPUT | MODE 7 for USB hub clk */
>
> Mismatch between constants and comments, which mode should it be?
>
  MODE 0. I see safe mode for 7. Comment should be corrected.
>> +        >;
>> +    };
>>   };
>>
>>   &mmc1 {
>> @@ -164,6 +232,15 @@
>>       status = "disabled";
>>   };
>>
>> +&usbhshost {
>> +    port2-mode = "ehci-hsic";
>> +    port3-mode = "ehci-hsic";
>> +};
>> +
>> +&usbhsehci {
>> +    phys = <0 &hsusb2_phy &hsusb3_phy>;
>> +};
>> +
>>   &mcspi1 {
>>
>>   };
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index 1e84db8..67d6e1f 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -666,5 +666,35 @@
>>                   ctrl-module = <&omap_control_usb>;
>>               };
>>           };
>> +
>> +        usbhstll: usbhstll@4a062000 {
>> +            compatible = "ti,usbhs-tll";
>> +            reg = <0x4a062000 0x1000>;
>> +            interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
>
> I guess that here you can replace '0' with GIC_SPI.
>
 Thanks. Will replace here and below.

Regards,
 Sricharan
