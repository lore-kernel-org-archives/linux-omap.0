From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 33/43] ARM: dts: am43xx clock data
Date: Mon, 4 Nov 2013 16:15:19 +0200
Message-ID: <5277ABF7.70104@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-34-git-send-email-t-kristo@ti.com> <52741A2C.1000707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50794 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590Ab3KDOPu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Nov 2013 09:15:50 -0500
In-Reply-To: <52741A2C.1000707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/01/2013 11:16 PM, Nishanth Menon wrote:
> On 10/25/2013 10:57 AM, Tero Kristo wrote:
> [...]
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index 974d103..1fb3ac2 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -67,6 +67,8 @@
>>   		ranges;
>>   		ti,hwmods = "l3_main";
>>
>> +		/include/ "am43xx-clocks.dtsi"
>> +
>>   		edma: edma@49000000 {
>>   			compatible = "ti,edma3";
>>   			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
>> diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
>> new file mode 100644
>> index 0000000..1cc5071
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
>> @@ -0,0 +1,666 @@
>> +/*
>> + * Device Tree Source for AM43xx clock data
>> + *
>> + * Copyright (C) 2013 Texas Instruments, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +scrm: scrm@44e10000 {
>> +	compatible = "ti,scrm";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	reg = <0x44e10000 0x2000>;
>
> here and other dts -> could we keep the scrm, prm, cm devices in
> SoC.dtsi? and clocks.dtsi just contains the clock nodes?

Could do that with some links yea, similar to how the clock data mods 
are done in this rev. Will check it out how it works.

-Tero

>
> [...]
>

