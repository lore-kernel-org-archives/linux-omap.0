From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 3/3] ARM: dts: Add support for both OMAP35xx and OMAP36xx
 Overo/Tobi
Date: Thu, 06 Feb 2014 16:13:05 +0100
Message-ID: <52F3A681.9050300@epfl.ch>
References: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch> <1391677818-21154-4-git-send-email-florian.vaussard@epfl.ch> <52F39DCC.8000006@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:37664 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849AbaBFPNK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Feb 2014 10:13:10 -0500
In-Reply-To: <52F39DCC.8000006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@linaro.org>, Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org



On 02/06/2014 03:35 PM, Nishanth Menon wrote:
> On 02/06/2014 03:10 AM, Florian Vaussard wrote:
>> Unfortunatly the device tree for older OMAP35xx Overo cannot be used
> Unfortunately ?

Indeed

>> with newer OMAP36xx and vice-versa. To address this issue, move most of
>> the Tobi DTS to a common include file, and create model-specific Tobi
>> DTS.
>>
> [...]
>> diff --git a/arch/arm/boot/dts/omap3-overo-tobi.dts b/arch/arm/boot/dts/omap3-overo-tobi.dts
>> new file mode 100644
>> index 0000000..2f82192
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap3-overo-tobi.dts
>> @@ -0,0 +1,22 @@
>> +/*
>> + * Copyright (C) 2012 Florian Vaussard, EPFL Mobots group
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/*
>> + * Tobi expansion board is manufactured by Gumstix Inc.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "omap34xx.dtsi"
>> +#include "omap3-overo-tobi-common.dtsi"
>> +
>> +/ {
>> +	model = "OMAP35xx Gumstix Overo on Tobi";
>> +	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3";
> To reduce any future problems, I suggest:
> compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo",
> "ti,omap3430", "ti,omap3";
> 

This was also my first thought, but "ti,omap3430" is not documented in
Documentation/devicetree/bindings/arm/omap/omap.txt. It is said that
"ti,omap3" defaults to OMAP3430. I do not know if omap35xx would be more
accurate, as these Overo are using OMAP3503 and OMAP3530.

Regards,
Florian
