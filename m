From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 32/43] ARM: dts: AM35xx: use DT clock data
Date: Tue, 5 Nov 2013 10:12:16 +0200
Message-ID: <5278A860.4040305@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-33-git-send-email-t-kristo@ti.com> <52741A97.3070103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33141 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab3KEIMn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Nov 2013 03:12:43 -0500
In-Reply-To: <52741A97.3070103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/01/2013 11:18 PM, Nishanth Menon wrote:
> On 10/25/2013 10:57 AM, Tero Kristo wrote:
> [...]
>
>> diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
>> new file mode 100644
>> index 0000000..c555443
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am3517.dtsi
>> @@ -0,0 +1,31 @@
>> +/*
>> + * Device Tree Source for AM3517 SoC
>> + *
>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This file is licensed under the terms of the GNU General Public License
>> + * version 2.  This program is licensed "as is" without any warranty of any
>> + * kind, whether express or implied.
>> + */
>> +
>> +#include "omap3.dtsi"
>> +
>> +/ {
>> +	cpus {
>> +		cpu@0 {
>> +			/* OMAP343x/OMAP35xx variants OPP1-5 */
>
> ^^ you could fix the comment since this is OMAP35xx variant :)

Ok. :)

>
>> +			operating-points = <
>> +				/* kHz    uV */
>> +				125000   975000
>> +				250000  1075000
>> +				500000  1200000
>> +				550000  1270000
>> +				600000  1350000
>> +			>;
>> +			clock-latency = <300000>; /* From legacy driver */
>> +		};
>> +	};
>> +};
>
> [..]
>
>

