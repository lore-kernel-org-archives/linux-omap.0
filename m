From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: DRA7: dts: Add the dts files for dra7 SoC and  dra7-evm
 board
Date: Wed, 14 Aug 2013 16:34:33 +0530
Message-ID: <520B6441.6030200@ti.com>
References: <1376475929-26050-1-git-send-email-rnayak@ti.com> <18ceeaca6539d2c2ef88bf5a560a77f3@www.loen.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46922 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab3HNLFH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Aug 2013 07:05:07 -0400
In-Reply-To: <18ceeaca6539d2c2ef88bf5a560a77f3@www.loen.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: bcousson@baylibre.com, mark.rutland@arm.com, nm@ti.com, paul@pwsan.com, khilman@linaro.org, R Sricharan <r.sricharan@ti.com>, tony@atomide.com, santosh.shilimkar@ti.com, Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 14 August 2013 04:04 PM, Marc Zyngier wrote:
> On 2013-08-14 11:25, Rajendra Nayak wrote:
>> From: R Sricharan <r.sricharan@ti.com>
>>
>> Add minimal device tree source needed for DRA7 based SoCs.
>> Also add a board dts file for the dra7-evm (based on dra752)
>> which contains 1.5G of memory with 1G interleaved and 512MB
>> non-interleaved. Also added in the board file are pin configuration
>> details for i2c, mcspi and uart devices on board.
>>
>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> ---
>> Benoit, I am reposting the dts files for dra so you can pick it up
>> for 3.12.
>> Rest of the core support is already pulled in by Tony.
> 
> [...]
> 
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> new file mode 100644
>> index 0000000..ad18fb2
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -0,0 +1,574 @@
>> +/*
>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + * Based on "omap4.dtsi"
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/pinctrl/dra.h>
>> +
>> +#include "skeleton.dtsi"
>> +
>> +/ {
>> +    #address-cells = <1>;
>> +    #size-cells = <1>;
>> +
>> +    compatible = "ti,dra7xx";
>> +    interrupt-parent = <&gic>;
>> +
>> +    aliases {
>> +        serial0 = &uart1;
>> +        serial1 = &uart2;
>> +        serial2 = &uart3;
>> +        serial3 = &uart4;
>> +        serial4 = &uart5;
>> +        serial5 = &uart6;
>> +    };
>> +
>> +    cpus {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        cpu@0 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a15";
>> +            reg = <0>;
>> +        };
>> +        cpu@1 {
>> +            device_type = "cpu";
>> +            compatible = "arm,cortex-a15";
>> +            reg = <1>;
>> +        };
>> +    };
>> +
>> +    timer {
>> +        compatible = "arm,armv7-timer";
>> +        interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
>> +    };
>> +
>> +    gic: interrupt-controller@48211000 {
>> +        compatible = "arm,cortex-a15-gic";
>> +        interrupt-controller;
>> +        #interrupt-cells = <3>;
>> +        reg = <0x48211000 0x1000>,
>> +              <0x48212000 0x1000>,
>> +              <0x48214000 0x2000>,
>> +              <0x48216000 0x2000>;
> 
> If you have the virtualization extensions, where is the maintenance interrupt?

missing indeed, will add. thanks.

> 
>         M.

