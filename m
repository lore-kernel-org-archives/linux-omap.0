From: Lokesh Vutla <a0131933-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: am335x: Add initial support for ICEv2 board
Date: Tue, 22 Mar 2016 16:59:36 +0530
Message-ID: <56F12CA0.9010808@ti.com>
References: <1458628657-30468-1-git-send-email-lokeshvutla@ti.com>
 <1458628657-30468-2-git-send-email-lokeshvutla@ti.com>
 <56F115F8.8040202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56F115F8.8040202-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 22 March 2016 03:22 PM, Grygorii Strashko wrote:
> On 03/22/2016 08:37 AM, Lokesh Vutla wrote:
>> TI's Industrial Communication Engine EVM is a low cost hardware mainly
>> developed for industrial communication type applications using serial
>> or Ethernet based interfaces. This platform features TI's AM3359 with
>> 800MHz single core Cortex-A8 processor, 256MB DDR3, 64MB SPI flash,
>> 8MB NOR Flash, mmc, usb, can, dual Ethernet ports.
>>
>> For more information, look at HW user guide[1], Data manual[2].
>>
>> Just add basic support for the moment.
>>
>> [1] http://processors.wiki.ti.com/index.php/AM335x_Industrial_Communication_Engine_EVM_Rev2_1_HW_User_Guide
>> [2] http://www.ti.com/lit/ds/symlink/am3359.pdf
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
>> ---
>>   .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>>   arch/arm/boot/dts/Makefile                         |   1 +
>>   arch/arm/boot/dts/am335x-icev2.dts                 | 303 +++++++++++++++++++++
>>   3 files changed, 307 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/am335x-icev2.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
>> index 21e71a5..20f6d71 100644
>> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
>> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
>> @@ -133,6 +133,9 @@ Boards:
>>   - AM335X Bone : Low cost community board
>>     compatible = "ti,am335x-bone", "ti,am33xx", "ti,omap3"
>>   
>> +- AM3359 ICEv2 : Low cost Industrial Communication Engine EVM.
>> +  compatible = "ti,am3359-icev2", "ti,am33xx", "ti,omap3"
>> +
>>   - AM335X OrionLXm : Substation Automation Platform
>>     compatible = "novatech,am335x-lxm", "ti,am33xx"
>>   
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 52b34a0..7dcf55e 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -486,6 +486,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
>>   	am335x-cm-t335.dtb \
>>   	am335x-evm.dtb \
>>   	am335x-evmsk.dtb \
>> +	am335x-icev2.dtb \
>>   	am335x-lxm.dtb \
>>   	am335x-nano.dtb \
>>   	am335x-pepper.dtb \
>> diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
>> new file mode 100644
>> index 0000000..59c91e8
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am335x-icev2.dts
>> @@ -0,0 +1,303 @@
>> +/*
>> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/*
>> + * AM335x ICE V2 board
>> + * http://www.ti.com/tool/tmdsice3359
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "am33xx.dtsi"
>> +
>> +/ {
>> +	model = "TI AM3359 ICE-V2";
>> +	compatible = "ti,am3359-icev2", "ti,am33xx";
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0x80000000 0x10000000>; /* 256 MB */
>> +	};
>> +
>> +	vbat: fixedregulator@0 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vbat";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vtt_fixed: fixedregulator@1 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vtt";
>> +		regulator-min-microvolt = <1500000>;
>> +		regulator-max-microvolt = <1500000>;
>> +		gpio = <&gpio0 18 GPIO_ACTIVE_HIGH>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		enable-active-high;
>> +	};
>> +
>> +	leds {
> 
> Could you split this node on two leds@0 and led@1 and and move
> all tpic2810 leds under leds0 and  all gpio leds under leds@1?
> 
> otherwise gpio leds will not work because tpic2810 is
> configured as module and so leds-gpio will be deferred until
> tpic2810 is loaded (but it can be never loaded ;)
> 
> led@x numeration has to be started from 0 for each leds@Y.

Hmm I get your point. I was always doing insmod of tpic2810 before doing
insmod of leds-gpio. Will fix it and repost.

Thanks and regards,
Lokesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
