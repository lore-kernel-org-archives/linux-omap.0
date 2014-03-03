From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v3 4/7] ARM: dts: omap3-overo: Add HSUSB PHY
Date: Mon, 03 Mar 2014 13:48:25 +0100
Message-ID: <53147A19.5070009@epfl.ch>
References: <1393839247-6516-1-git-send-email-florian.vaussard@epfl.ch> <1393839247-6516-5-git-send-email-florian.vaussard@epfl.ch> <53146166.4050906@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:37926 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbaCCMsc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Mar 2014 07:48:32 -0500
In-Reply-To: <53146166.4050906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Roger,

On 03/03/2014 12:03 PM, Roger Quadros wrote:
> Hi Florian,
> 
> 
> On 03/03/2014 11:34 AM, Florian Vaussard wrote:
>> Add the High-Speed USB PHY.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>  arch/arm/boot/dts/omap3-overo-storm-tobi.dts | 16 ++++++++++
>>  arch/arm/boot/dts/omap3-overo-tobi.dts       | 16 ++++++++++
>>  arch/arm/boot/dts/omap3-overo.dtsi           | 44 ++++++++++++++++++++++++++++
>>  3 files changed, 76 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
>> index 2033b52..eb93e3a 100644
>> --- a/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
>> +++ b/arch/arm/boot/dts/omap3-overo-storm-tobi.dts
>> @@ -21,6 +21,22 @@
>>  };
>>  
>>  &omap3_pmx_core2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <
>> +			&hsusb2_2_pins
>> +	>;
>> +
>> +	hsusb2_2_pins: pinmux_hsusb2_2_pins {
>> +		pinctrl-single,pins = <
>> +			OMAP3630_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
>> +			OMAP3630_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
>> +			OMAP3630_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
>> +			OMAP3630_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
>> +			OMAP3630_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
>> +			OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
>> +		>;
>> +	};
>> +
>>  	w3cbw003c_2_pins: pinmux_w3cbw003c_2_pins {
>>  		pinctrl-single,pins = <
>>  			OMAP3630_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4)		/* etk_d2.gpio_16 */
>> diff --git a/arch/arm/boot/dts/omap3-overo-tobi.dts b/arch/arm/boot/dts/omap3-overo-tobi.dts
>> index 21de31d..e77be26 100644
>> --- a/arch/arm/boot/dts/omap3-overo-tobi.dts
>> +++ b/arch/arm/boot/dts/omap3-overo-tobi.dts
>> @@ -21,6 +21,22 @@
>>  };
>>  
>>  &omap3_pmx_core2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <
>> +			&hsusb2_2_pins
>> +	>;
>> +
>> +	hsusb2_2_pins: pinmux_hsusb2_2_pins {
>> +		pinctrl-single,pins = <
>> +			OMAP3430_CORE2_IOPAD(0x25f0, PIN_OUTPUT | MUX_MODE3)		/* etk_d10.hsusb2_clk */
>> +			OMAP3430_CORE2_IOPAD(0x25f2, PIN_OUTPUT | MUX_MODE3)		/* etk_d11.hsusb2_stp */
>> +			OMAP3430_CORE2_IOPAD(0x25f4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d12.hsusb2_dir */
>> +			OMAP3430_CORE2_IOPAD(0x25f6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d13.hsusb2_nxt */
>> +			OMAP3430_CORE2_IOPAD(0x25f8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d14.hsusb2_data0 */
>> +			OMAP3430_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_data1 */
>> +		>;
>> +	};
>> +
>>  	w3cbw003c_2_pins: pinmux_w3cbw003c_2_pins {
>>  		pinctrl-single,pins = <
>>  			OMAP3430_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX_MODE4)		/* etk_d2.gpio_16 */
>> diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
>> index 07467cc..8f810db 100644
>> --- a/arch/arm/boot/dts/omap3-overo.dtsi
>> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
>> @@ -30,6 +30,24 @@
>>  		ti,codec = <&twl_audio>;
>>  	};
>>  
>> +	/* HS USB Port 2 Power */
>> +	hsusb2_power: hsusb2_power_reg {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "hsusb2_vbus";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		gpio = <&gpio6 8 0>;				/* gpio_168: vbus enable */
>> +		startup-delay-us = <70000>;
>> +		enable-active-high;
>> +	};
>> +
>> +	/* HS USB Host PHY on PORT 2 */
>> +	hsusb2_phy: hsusb2_phy {
>> +		compatible = "usb-nop-xceiv";
>> +		reset-gpios = <&gpio6 23 GPIO_ACTIVE_LOW>;	/* gpio_183 */
>> +		vcc-supply = <&hsusb2_power>;
>> +	};
>> +
>>  	/* Regulator to trigger the nPoweron signal of the Wifi module */
>>  	w3cbw003c_npoweron: regulator-w3cbw003c-npoweron {
>>  		compatible = "regulator-fixed";
>> @@ -64,6 +82,11 @@
>>  };
>>  
>>  &omap3_pmx_core {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <
>> +			&hsusb2_pins
>> +	>;
>> +
>>  	uart3_pins: pinmux_uart3_pins {
>>  		pinctrl-single,pins = <
>>  			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | PIN_OFF_WAKEUPENABLE | MUX_MODE0)	/* uart3_rx_irrx.uart3_rx_irrx */
>> @@ -107,6 +130,19 @@
>>  			OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE4)		/* uart3_rts_sd.gpio_164 */
>>  		>;
>>  	};
>> +
>> +	hsusb2_pins: pinmux_hsusb2_pins {
>> +		pinctrl-single,pins = <
>> +			OMAP3_CORE1_IOPAD(0x21d4, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi1_cs3.hsusb2_data2 */
>> +			OMAP3_CORE1_IOPAD(0x21d6, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_clk.hsusb2_data7 */
>> +			OMAP3_CORE1_IOPAD(0x21d8, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_simo.hsusb2_data4 */
>> +			OMAP3_CORE1_IOPAD(0x21da, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_somi.hsusb2_data5 */
>> +			OMAP3_CORE1_IOPAD(0x21dc, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs0.hsusb2_data6 */
>> +			OMAP3_CORE1_IOPAD(0x21de, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* mcspi2_cs1.hsusb2_data3 */
>> +			OMAP3_CORE1_IOPAD(0x21be, PIN_OUTPUT | MUX_MODE4)		/* i2c2_scl.gpio_168 */
>> +			OMAP3_CORE1_IOPAD(0x21c0, PIN_OUTPUT | MUX_MODE4)		/* i2c2_sda.gpio_183 */
>> +		>;
>> +	};
> 
> Does this mean all overo variants use the USB host feature on hsusb2 pins? If not then this can't be here.
> 

Yes, they all does have USB host on hsusb2.

> If yes then I didn't understand why the hsusb2 pinmux is split up half here and half in "omap3-overo-tobi.dts"
> and "omap3-overo-storm-tobi.dts"
> 

Some of the pads are in the omap3_pmx_core2 domain. The exact offset of
the pin inside the pinctrl domain depends on the OMAP3 version, hence
the use of OMAP3430_CORE2_IOPAD and OMAP3630_CORE2_IOPAD macros.

Now some Overo depends on omap34xx (regular overo), others on omap36xx
(overo-storm). Commit f03ef09 "ARM: dts: Add support for both OMAP35xx
and OMAP36xx Overo/Tobi" made omap3-overo.dtsi independent from the
OMAP3 revision, and pushed these details down to the Tobi board files.
This is why the pinmux related to the omap3_pmx_core2 domain is there.

As long as we have only one expansion board, I think that this is ok. I
wanted to avoid an excessive fragmentation of the DTSI files. But when
adding new expansion boards, it will be necessary to create yet another
indirection layer to address this issue and avoid duplicated DT data.

Regards,
Florian
