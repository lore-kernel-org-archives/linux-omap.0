From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Add am335x-bonegreen
Date: Fri, 25 Sep 2015 11:20:53 -0500
Message-ID: <CAOCHtYhuLREw_eKbME+Ssvx=JrHWtbFZPQRH5SrmfVTiSqdtWQ@mail.gmail.com>
References: <1443193831-5693-1-git-send-email-robertcnelson@gmail.com> <5605704D.5000404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5605704D.5000404-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 25, 2015 at 11:03 AM, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> wrote:
> On 09/25/2015 10:10 AM, Robert Nelson wrote:
>> SeeedStudio BeagleBone Green (BBG) is clone of the BeagleBone Black (BBB) minus
>> the HDMI port and addition of two Grove connectors (i2c2 and usart2).
>>
>> This board can be identified by the 1A value after A335BNLT (BBB) in the at24 eeprom:
>> 1A: [aa 55 33 ee 41 33 33 35  42 4e 4c 54 1a 00 00 00 |.U3.A335BNLT....|]
>>
>> http://beagleboard.org/green
>> http://www.seeedstudio.com/wiki/Beaglebone_green
>>
>> Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> CC: Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/Makefile             |  1 +
>>  arch/arm/boot/dts/am335x-bonegreen.dts | 53 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 54 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/am335x-bonegreen.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 233159d..e45d771 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -446,6 +446,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
>>       am335x-base0033.dtb \
>>       am335x-bone.dtb \
>>       am335x-boneblack.dtb \
>> +     am335x-bonegreen.dtb \
>>       am335x-sl50.dtb \
>>       am335x-evm.dtb \
>>       am335x-evmsk.dtb \
>> diff --git a/arch/arm/boot/dts/am335x-bonegreen.dts b/arch/arm/boot/dts/am335x-bonegreen.dts
>> new file mode 100644
>> index 0000000..0f65bda
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am335x-bonegreen.dts
>> @@ -0,0 +1,53 @@
>> +/*
>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +/dts-v1/;
>> +
>> +#include "am33xx.dtsi"
>> +#include "am335x-bone-common.dtsi"
>> +
>> +/ {
>> +     model = "TI AM335x BeagleBone Green";
>> +     compatible = "ti,am335x-bone-green", "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
>> +};
>> +
>> +&ldo3_reg {
>> +     regulator-min-microvolt = <1800000>;
>> +     regulator-max-microvolt = <1800000>;
>> +     regulator-always-on;
>> +};
>> +
>> +&mmc1 {
>> +     vmmc-supply = <&vmmcsd_fixed>;
>> +};
>> +
>> +&mmc2 {
>> +     vmmc-supply = <&vmmcsd_fixed>;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&emmc_pins>;
>> +     bus-width = <8>;
>> +     status = "okay";
>> +};
>> +
>> +&am33xx_pinmux {
>> +     uart2_pins: uart2_pins {
>> +             pinctrl-single,pins = <
>> +                     0x150 (PIN_INPUT | MUX_MODE1)   /* spi0_sclk.uart2_rxd */
>> +                     0x154 (PIN_OUTPUT | MUX_MODE1)  /* spi0_d0.uart2_txd */
>> +             >;
>> +     };
>> +};
>> +
>> +&uart2 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&uart2_pins>;
>> +     status = "okay";
>> +};
>> +
>> +&rtc {
>> +     system-power-controller;
>> +};
>>
>
>
> Would still work when https://patchwork.kernel.org/patch/6394821/ gets in?

That will still work, but we need to extend the board identification
to "board-name" + "board-revision", as the Green choose the "A335BNLT"
board name in the eeprom to remain compatible with older 3.8.x images
from last year.. (most of the clones i've talked too want to support
the old image too)...

So with the 1st byte of the board-revision:
All BeagleBone Black's have: 0x30
Seeed's using 0x1A (with the potential to increment the A)

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
