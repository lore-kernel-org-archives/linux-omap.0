From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: AM571x-IDK Initial Support
Date: Tue, 22 Nov 2016 09:41:49 +0530
Message-ID: <2245614b-1589-9844-7409-44326b13f771@ti.com>
References: <20161121055801.573-1-lokeshvutla@ti.com>
 <20161121173613.h2d2j4z2hqnioslx@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161121173613.h2d2j4z2hqnioslx@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, spatton-l0cyMroinI0@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Monday 21 November 2016 11:06 PM, Rob Herring wrote:
> On Mon, Nov 21, 2016 at 11:28:01AM +0530, Lokesh Vutla wrote:
>> From: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
>>
>> The AM571x-IDK board is a board based on TI's AM5718 SOC
>> which has a single core 1.5GHz A15 processor. This board is a
>> development platform for the Industrial market with:
>> - 1GB of DDR3L
>> - Dual 1Gbps Ethernet
>> - HDMI,
>> - PRU-ICSS
>> - uSD
>> - 16GB eMMC
>> - CAN
>> - RS-485
>> - PCIe
>> - USB3.0
>> - Video Input Port
>> - Industrial IO port and expansion connector
>>
>> The link to the data sheet and TRM can be found here:
>>
>> http://www.ti.com/product/AM5718
>>
>> Initial support is only for basic peripherals.
>>
>> Signed-off-by: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
>> ---
>>
>> Logs: http://pastebin.ubuntu.com/23510390/
>>
>>  .../devicetree/bindings/arm/omap/omap.txt          |  3 +
>>  arch/arm/boot/dts/Makefile                         |  1 +
>>  arch/arm/boot/dts/am571x-idk.dts                   | 82 ++++++++++++++++++++++
>>  3 files changed, 86 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/am571x-idk.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
>> index f53e2ee..647ffd3 100644
>> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
>> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
>> @@ -175,6 +175,9 @@ Boards:
>>  - AM5728 IDK
>>    compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
>>  
>> +- AM5718 IDK
>> +  compatible = "ti,am5718-idk", "ti,am5728", "ti,dra722", "ti,dra72", "ti,dra7"
> 
> I've said this before I think, but 5 compat string is a bit much. Some 
> of these genericish ones should be dropped. Doesn't really hurt though.

Yeah dra722, dra72 can be dropped from this. Will do it.

> 
> A couple of nits below, otherwise:
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> 
>> +
>>  - DRA742 EVM:  Software Development Board for DRA742
>>    compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7"
>>  
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index befcd26..c298078 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -588,6 +588,7 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
>>  	am57xx-cl-som-am57x.dtb \
>>  	am57xx-sbc-am57x.dtb \
>>  	am572x-idk.dtb \
>> +	am571x-idk.dtb \
>>  	dra7-evm.dtb \
>>  	dra72-evm.dtb \
>>  	dra72-evm-revc.dtb
>> diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
>> new file mode 100644
>> index 0000000..a6a743e
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am571x-idk.dts
>> @@ -0,0 +1,82 @@
>> +/*
>> + * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +/dts-v1/;
>> +
>> +#include "dra72x.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include "am57xx-idk-common.dtsi"
>> +
>> +/ {
>> +	model = "TI AM5718 IDK";
>> +	compatible = "ti,am5718-idk", "ti,am5718", "ti,dra722",
>> +		     "ti,dra72", "ti,dra7";
>> +
>> +	memory@0 {
> 
> unit address is wrong.

okay.

> 
>> +		device_type = "memory";
>> +		reg = <0x0 0x80000000 0x0 0x40000000>;
>> +	};
>> +
>> +	status-leds {
> 
> Just "leds"

okay. Will update it and send a v2.

Thanks and regards,
Lokesh

> 
>> +		compatible = "gpio-leds";
>> +		cpu0-led {
>> +			label = "status0:red:cpu0";
>> +			gpios = <&gpio2 25 GPIO_ACTIVE_HIGH>;
>> +			default-state = "off";
>> +			linux,default-trigger = "cpu0";
>> +		};
>> +
>> +		usr0-led {
>> +			label = "status0:green:usr";
>> +			gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
>> +			default-state = "off";
>> +		};
>> +
>> +		heartbeat-led {
>> +			label = "status0:blue:heartbeat";
>> +			gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
>> +			default-state = "off";
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +
>> +		usr1-led {
>> +			label = "status1:red:usr";
>> +			gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
>> +			default-state = "off";
>> +		};
>> +
>> +		usr2-led {
>> +			label = "status1:green:usr";
>> +			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
>> +			default-state = "off";
>> +		};
>> +
>> +		mmc0-led {
>> +			label = "status1:blue:mmc0";
>> +			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>> +			default-state = "off";
>> +			linux,default-trigger = "mmc0";
>> +		};
>> +	};
>> +
>> +	extcon_usb2: extcon_usb2 {
>> +	     compatible = "linux,extcon-usb-gpio";
>> +	     id-gpio = <&gpio5 7 GPIO_ACTIVE_HIGH>;
>> +	};
>> +};
>> +
>> +&mmc1 {
>> +	status = "okay";
>> +	vmmc-supply = <&ldo1_reg>;
>> +	bus-width = <4>;
>> +	cd-gpios = <&gpio6 27 0>; /* gpio 219 */
>> +};
>> +
>> +&omap_dwc3_2 {
>> +	extcon = <&extcon_usb2>;
>> +};
>> -- 
>> 2.10.1
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
