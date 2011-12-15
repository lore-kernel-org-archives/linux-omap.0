From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH V2 1/2] mcx: very basic support for HTKW mcx board
Date: Thu, 15 Dec 2011 12:53:55 +0200
Message-ID: <4EE9D1C3.2050903@compulab.co.il>
References: <1323910383-1184-1-git-send-email-yanok@emcraft.com> <1323910383-1184-2-git-send-email-yanok@emcraft.com> <4EE9C31B.7080206@compulab.co.il> <4EE9C957.30504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:36483
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753461Ab1LOKyK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 05:54:10 -0500
In-Reply-To: <4EE9C957.30504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-omap@vger.kernel.org, sasha_d@emcraft.com, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>

On 12/15/11 12:17, Cousson, Benoit wrote:
> Hi Igor,
> 
> On 12/15/2011 10:51 AM, Igor Grinberg wrote:
>> On 12/15/11 02:53, Ilya Yanok wrote:
>>> Very basic support for HTKW mcx board. Able to boot via board-generic
>>> and ramdisk/initramfs, however most of peripherals is unsupported.
>>> Produces tons of twl4030 related errors as this board doesn't have
>>> twl4030 installed.
>>>
>>> Signed-off-by: Ilya Yanok<yanok@emcraft.com>
>>>
>>> ---
>>> Changes from V1:
>>>
>>>   - device tree moved to the separate patch
>>>   - iva node is disabled instead of using custom includes
>>>   - removed bootargs entry
>>>
>>>   arch/arm/boot/dts/mcx.dts |   27 +++++++++++++++++++++++++++
>>>   1 files changed, 27 insertions(+), 0 deletions(-)
>>>   create mode 100644 arch/arm/boot/dts/mcx.dts
>>>
>>> diff --git a/arch/arm/boot/dts/mcx.dts b/arch/arm/boot/dts/mcx.dts
>>> new file mode 100644
>>> index 0000000..66b81bd
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/mcx.dts
>>> @@ -0,0 +1,27 @@
>>> +/*
>>> + * Copyright (C) 2011 Ilya Yanok, EmCraft Systems
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +/dts-v1/;
>>> +
>>> +/include/ "omap3.dtsi"
>>> +
>>> +/ {
>>> +    model = "HTKW mcx";
>>> +    compatible = "htkw,mcx", "ti,omap3";
>>> +
>>> +    memory {
>>> +        device_type = "memory";
>>> +        reg =<0x80000000 0x10000000>; /* 256 MB */
>>> +    };
>>> +
>>> +    /* AM35xx doesn't have IVA */
>>> +    soc {
>>> +        iva {
>>> +            status = "disabled";
>>> +        };
>>> +    };
>>
>> I don't get it...
>> Why SoCs that do not have those IP blocks should poke
>> their configuration inside the h/w description
>> (e.g. disable/enable/workaround/hack)?
> 
> This is indeed the proper way assuming the HW does contain this information. I do not know for this OMAP variant, but this kind of information is not necessarily well exposed inside the HW.
> 
>> This way, why don't we also disable the PCIe which this SoC does not have?
>> Of course, I'm exaggerating, but this just does not scale...
>> Soon you will have a bunch of boards disabling stuff,
>> that they *do not have natively*...
>> Why don't generic OMAP3 DT file disable the EMAC?
>> If we will go this way, we will find ourself fixing it later
>> and producing the renaming/moving "churn", won't we?
> 
> You are indeed exaggerating :-)
> 
> Assuming that device is an OMAP3 variant, it seems OK to me to define it like that. am35xx = omap3 + (new IPs) - (IPs not supported)

I still haven't seen any real cons about my proposed solution:
Have include file for each IP, for example IP1/2/3/4...
omap3 = (include IPs supported: IP1, IP3, IP4)
am35x = (include IPs supported: IP1, IP2, IP4)

This way, we will be able to easily support any mixture of those whenever
TI releases new version of AM/DM3/4/5/6xxx - just include those you have.

Also, OMAP3 is not a variant of OMAP2, but has several same IPs inside
(or am I wrong?). Same probably will stand for OMAP4/5/6...
In my proposed way we can share those IPs without duplicating them.

> 
> The good point with DT is that you can add or *remove* things from an included file.

Yes, but I don't think board DT file should do it...
It contradicts, the DT=="hardware description" statement.

I also think that it is good thing to try and find a common set of IPs,
but it can be done by including those and still stay scalable...


-- 
Regards,
Igor.
