From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: add BeagleBone Audio Cape (Rev A) dtsi
Date: Mon, 03 Mar 2014 21:41:53 +0100
Message-ID: <5314E911.5090000@baylibre.com>
References: <1390388785-19605-1-git-send-email-ml@embed.me.uk> <20140228221742.GJ13624@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:42665 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbaCCUl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Mar 2014 15:41:59 -0500
Received: by mail-wg0-f49.google.com with SMTP id b13so2090858wgh.32
        for <linux-omap@vger.kernel.org>; Mon, 03 Mar 2014 12:41:58 -0800 (PST)
In-Reply-To: <20140228221742.GJ13624@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Jack Mitchell <ml@embed.me.uk>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jack Mitchell <jack@embed.me.uk>, Matt Porter <mporter@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On 28/02/2014 23:17, Tony Lindgren wrote:
> * Jack Mitchell <ml@embed.me.uk> [140122 03:09]:
>> From: Jack Mitchell <jack@embed.me.uk>
>>
>> Devicetree include file for setting up the am335x mcasp bus, i2c-2
>> bus, and audio codec required for a functioning BeagleBone Audio Cap=
e.
>>
>> Signed-off-by: Jack Mitchell <jack@embed.me.uk>
>> Signed-off-by: Matt Porter <mporter@linaro.org>
>> ---
>>   arch/arm/boot/dts/am335x-bone-audio-cape-reva.dtsi | 124 +++++++++=
++++++++++++
>>   arch/arm/boot/dts/am335x-bone-common.dtsi          |  14 +++
>>   2 files changed, 138 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/am335x-bone-audio-cape-reva.d=
tsi
>>
>> diff --git a/arch/arm/boot/dts/am335x-bone-audio-cape-reva.dtsi b/ar=
ch/arm/boot/dts/am335x-bone-audio-cape-reva.dtsi
>> new file mode 100644
>> index 0000000..b8ec3dc
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am335x-bone-audio-cape-reva.dtsi
>> @@ -0,0 +1,124 @@
>> +/*
>> + * Copyright (C) 2014 Jack Mitchell <jack@embed.me.uk>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * In order to enable the BeagleBone Audio Cape this dtsi must be
>> + * incuded in the top level dts. On BeagleBone Black hardware the
>> + * status of the HDMI dts node must also be set to "disabled".
>
> Seems like this is unsafe to merge then? This probably also needs
> comments from Peter Ujfalusi, added him to Cc.

Maybe, we'd better define a new DTS board (like=20
am335x-boneblack-audio.dts) if we cannot use audio cape without losing=20
the HDMI.
Since we don't have mechanism like overlay, we don't have the choice bu=
t=20
defining several boards for each cape variant.

BTW, what is the conflict source with HDMI?
At some point I remember that the mcasp for audio cape was broken=20
because of changes in the mcasp for the HDMI, but it is not the case=20
anymore, thanks to the cleanup from Jyri.

>
>> + * --- a/arch/arm/boot/dts/am335x-bone.dts
>> + * +++ b/arch/arm/boot/dts/am335x-bone.dts
>> + * @@ -9,6 +9,7 @@
>> + *
>> + *  #include "am33xx.dtsi"
>> + *  #include "am335x-bone-common.dtsi"
>> + * +#include "am335x-bone-audio-cape-reva.dtsi"
>> + *
>> + *  &ldo3_reg {
>> + *  	regulator-min-microvolt =3D <1800000>;
>> + *
>> + * On BeagleBone Black hardware the status of the HDMI dts node mus=
t
>> + * also be set to "disabled"
>> + *
>> + * --- a/arch/arm/boot/dts/am335x-boneblack.dts
>> + * +++ b/arch/arm/boot/dts/am335x-boneblack.dts
>> + * @@ -73,6 +74,6 @@
>> + *  		pinctrl-names =3D "default", "off";
>> + *  		pinctrl-0 =3D <&nxp_hdmi_bonelt_pins>;
>> + *  		pinctrl-1 =3D <&nxp_hdmi_bonelt_off_pins>;
>> + * -		status =3D "okay";
>> + * +		status =3D "disabled";
>> + *  	};
>> + *  };
>> + */
>> +
>> +/ {
>> +	sound {
>> +		compatible =3D "ti,da830-evm-audio";
>> +		ti,model =3D "AM335x BeagleBone Audio Cape Rev. A";
>> +		ti,audio-codec =3D <&tlv320aic3106>;
>> +		ti,mcasp-controller =3D <&mcasp0>;
>> +		ti,codec-clock-rate =3D <12000000>;
>> +		ti,audio-routing =3D
>> +			"Headphone Jack",       "HPLOUT",
>> +			"Headphone Jack",       "HPROUT",
>> +			"LINE1L",               "Line In",
>> +			"LINE1R",               "Line In";
>> +	};
>> +
>> +	audio-cape-gpio-leds {
>> +		compatible =3D "gpio-leds";
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&bone_audio_cape_led_pins>;
>> +
>> +		audio-led0 {
>> +			label =3D "audio:green:usr0";
>> +			gpios =3D <&gpio1 18 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger =3D "heartbeat";
>> +			default-state =3D "off";
>> +		};
>> +
>> +		audio-led1 {
>> +			label =3D "audio:green:usr1";
>> +			gpios =3D <&gpio1 19 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger =3D "mmc0";
>> +			default-state =3D "off";
>> +		};
>> +	};
>> +};
>> +
>> +&am33xx_pinmux {
>> +	bone_audio_cape_led_pins: pinmux_bone_audio_cape_led_pins {
>> +		pinctrl-single,pins =3D <
>> +			0x48 (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpmc_a2.gpio1_18 */
>> +			0x4c (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpmc_a3.gpio1_19 */
>> +		>;
>> +	};
>> +
>> +	bone_audio_cape_pins: bone_audio_cape_pins {
>> +		pinctrl-single,pins =3D <
>> +			0x190 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclk=
x */
>> +			0x194 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
>> +			0x19c (PIN_INPUT_PULLUP | MUX_MODE2)	/* mcasp0_ahclkr.mcasp0_axr=
2 */
>> +			0x1ac (PIN_INPUT_PULLUP | MUX_MODE2)	/* mcasp0_ahclkx.mcasp0_axr=
3 */
>> +		>;
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&i2c2_pins>;
>> +
>> +	status =3D "okay";
>> +	clock-frequency =3D <100000>;
>> +
>> +	tlv320aic3106: tlv320aic3106@1b {

A more generic name will be prefered here.

Regards,
Benoit

--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
