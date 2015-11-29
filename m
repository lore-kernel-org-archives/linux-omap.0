From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH 01/18] ARM: am57xx: cl-som-am57x: dts: add basic module
 support
Date: Sun, 29 Nov 2015 14:10:01 +0200
Message-ID: <565AEB19.4050107@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il> <1448433590-1399-2-git-send-email-lifshitz@compulab.co.il> <565629D2.2010401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <565629D2.2010401-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

Thank you for the provided feedback.

On 11/25/2015 11:36 PM, Nishanth Menon wrote:
> On 11/25/2015 12:39 AM, Dmitry Lifshitz wrote:
> [...]
>
>> diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
>> new file mode 100644
>> index 0000000..b11d7da
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> [...]
>
>> +/ {
>> +	model = "CompuLab CL-SOM-AM57x";
>> +	compatible = "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7";
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0x80000000 0x20000000>; /* 512 MB - minimal configuration */
>
> I think if you like to enable LPAE, the format might look a little
> different..
>

We would like to have a basic HW support in the mainline. It might be 
enhanced later, once we get to work on LPAE stuff.

>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&leds_pins_default>;
>> +
>> +		led@0 {
>> +			label = "cl-som-am57x:green";
>> +			gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "heartbeat";
>> +			default-state = "off";
>> +		};
>> +	};
>> +};
>> +
>> +&dra7_pmx_core {
>> +	leds_pins_default: leds_pins_default {
>> +		pinctrl-single,pins = <
>> +			DRA7XX_CORE_IOPAD(0x347c, PIN_OUTPUT | MUX_MODE14)	/* gpmc_a15.gpio2_5 */
>> +		>;
>> +	};
>> +
>> +	i2c1_pins_default: i2c1_pins_default {
>> +		pinctrl-single,pins = <
>> +			DRA7XX_CORE_IOPAD(0x3800, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda.sda */
>> +			DRA7XX_CORE_IOPAD(0x3804, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl.scl */
>> +		>;
>> +	};
>> +
>> +	tps659038_pins_default: tps659038_pins_default {
>> +		pinctrl-single,pins = <
>> +			DRA7XX_CORE_IOPAD(0x3818, PIN_INPUT_PULLUP | MUX_MODE14) /* wakeup0.gpio1_0 */
>> +		>;
>> +	};
>
> Generic comment: As per requirements of the SoC -> all pinctrl must be
> done in bootloader. this was a recommendation that came in too late
> for TI platforms that got introduced in upstream, but that cleanup
> should eventually take place as well.
>

Please, could you provide a reference to those recommendations.
Do you mean pinctrl for PMIC pins only?

>> +};
>> +
>> +&i2c1 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c1_pins_default>;
>> +	clock-frequency = <400000>;
>> +
>> +	tps659038: tps659038@58 {
>> +		compatible = "ti,tps659038";
>> +		reg = <0x58>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>
> Also See: https://patchwork.kernel.org/patch/7596541/ ->
> Documentation/devicetree/bindings/i2c/i2c.txt -> since you seem to
> have a PMIC with power button, you might be able to get wakeup source
> also there.
>

Do you mean just adding "wakeup-source" property?

According to Documentation/devicetree/bindings/i2c/i2c.txt the primary 
interrupt will be used as wakeup interrupt.

>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&tps659038_pins_default>;
>> +
>> +		#interrupt-cells = <2>;
>> +		interrupt-controller;
>> +
>> +		ti,system-power-controller;
>
> Assuming powerhold signal and BOOT0,1 is proper here, else poweroff
> will never work.
>

Please, could you provide more details regarding this issue.

>> +
>> +		tps659038_pmic {
>> +			compatible = "ti,tps659038-pmic";
>> +
>> +			regulators {
>> +				smps12_reg: smps12 {
>> +					/* VDD_MPU */
>> +					regulator-name = "smps12";
>> +					regulator-min-microvolt = < 850000>;
>> +					regulator-max-microvolt = <1250000>;
>> +					regulator-always-on;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				smps3_reg: smps3 {
>> +					/* VDD_DDR */
>> +					regulator-name = "smps3";
>> +					regulator-min-microvolt = <1500000>;
>> +					regulator-max-microvolt = <1500000>;
>> +					regulator-always-on;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				smps45_reg: smps45 {
>> +					/* VDD_DSPEVE */
>> +					regulator-name = "smps45";
>> +					regulator-min-microvolt = < 850000>;
>> +					regulator-max-microvolt = <1160000>;
>
> 1.25v if you want to support OPP_HIGH. as per latest data sheet.

Ok, got it. Voltages will be updated in V2. Thanks.

>
>> +					regulator-always-on;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				smps6_reg: smps6 {
>> +					/* VDD_GPU */
>> +					regulator-name = "smps6";
>> +					regulator-min-microvolt = < 850000>;
>> +					regulator-max-microvolt = <1160000>;
>
> 1.25v if you want to support OPP_HIGH. as per latest data sheet.
>
>> +					regulator-always-on;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				smps7_reg: smps7 {
>> +					/* VDD_CORE */
>> +					regulator-name = "smps7";
>> +					regulator-min-microvolt = < 850000>;
>> +					regulator-max-microvolt = <1160000>;
>> +					regulator-always-on;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				smps8_reg: smps8 {
>> +					/* VDD_IVA */
>> +					regulator-name = "smps8";
>> +					regulator-min-microvolt = < 850000>;
>> +					regulator-max-microvolt = <1160000>;
>> +					regulator-always-on;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				smps9_reg: smps9 {
>> +					/* PMIC_3V3 */
>> +					regulator-name = "smps9";
>> +					regulator-min-microvolt = <3300000>;
>> +					regulator-max-microvolt = <3300000>;
>> +					regulator-always-on;
>> +					regulator-boot-on;
>> +				};
>> +
>> +
>> +				ldo1_reg: ldo1 {
>> +					/* VDD_SD / VDDSHV8  */
>> +					regulator-name = "ldo1";
>> +					regulator-min-microvolt = <1800000>;
>> +					regulator-max-microvolt = <3300000>;
>
> for eventual UHS mode support, it is recommended to keep VDD_SD
> separate from VDDSHV8. many of TI evms also suffer from this issue :(
>

That's the way it is.

>> +					regulator-boot-on;
>> +					regulator-always-on;
>> +				};
>> +
>> +				ldo2_reg: ldo2 {
>> +					/* VDD_1V8 */
>> +					regulator-name = "ldo2";
>> +					regulator-min-microvolt = <1800000>;
>> +					regulator-max-microvolt = <1800000>;
>> +					regulator-always-on;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				ldo3_reg: ldo3 {
>> +					/* VDDA_1V8_PHYA */
>> +					regulator-name = "ldo3";
>> +					regulator-min-microvolt = <1800000>;
>> +					regulator-max-microvolt = <1800000>;
>> +					regulator-always-on;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				ldo4_reg: ldo4 {
>> +					/* VDDA_1V8_PHYB */
>> +					regulator-name = "ldo4";
>> +					regulator-min-microvolt = <1800000>;
>> +					regulator-max-microvolt = <1800000>;
>> +					regulator-always-on;
>> +					regulator-boot-on;
>> +				};
>
> Happy to see this is already split up. you might want to document
> which PHYs are supplied by PHYA/B in comments for future reference
> instead of having to dig through schematics to figure that out..
>

I will provide the comments in V2. Thanks.

>> +
>> +				ldo9_reg: ldo9 {
>> +					/* VDD_RTC */
>> +					regulator-name = "ldo9";
>> +					regulator-min-microvolt = <1050000>;
>> +					regulator-max-microvolt = <1050000>;
>> +					regulator-always-on;
>> +					regulator-boot-on;
> as per data sheet:
> "VD_RTC can optionally be tied to VD_CORE and operate at the VD_CORE
> AVS voltages."
>
> I assume that is not the case here.

Yes indeed.

>
>> +				};
>> +
>> +				ldoln_reg: ldoln {
>> +					/* VDDA_1V8_PLL */
>> +					regulator-name = "ldoln";
>> +					regulator-min-microvolt = <1800000>;
>> +					regulator-max-microvolt = <1800000>;
>> +					regulator-always-on;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				ldousb_reg: ldousb {
>> +					/* VDDA_3V_USB: VDDA_USBHS33 */
>> +					regulator-name = "ldousb";
>> +					regulator-min-microvolt = <3300000>;
>> +					regulator-max-microvolt = <3300000>;
>> +					regulator-boot-on;
>
> All SoC VDDAs must be always-on.

Will be fixed in V2. Thanks.

>
> [...]
>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
