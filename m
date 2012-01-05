From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 1/2] mt_ventoux: very basic support for TeeJet Mt.Ventoux
 board
Date: Thu, 05 Jan 2012 10:40:21 +0200
Message-ID: <4F0561F5.4020700@compulab.co.il>
References: <1324940912-18164-1-git-send-email-yanok@emcraft.com> <1324940912-18164-2-git-send-email-yanok@emcraft.com> <20120104195412.GG15503@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:38399
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754857Ab2AEIkj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 03:40:39 -0500
In-Reply-To: <20120104195412.GG15503@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sasha_d@emcraft.com

Hi Grant,

On 01/04/12 21:54, Grant Likely wrote:
> On Tue, Dec 27, 2011 at 12:08:31AM +0100, Ilya Yanok wrote:
>> Very basic support for TeeJet Mt.Ventoux board. Able to boot via
>> board-generic and ramdisk/initramfs, however most of peripherals are
>> not supported. Produces tons of twl4030 related errors as this board
>> doesn't have twl4030 installed.
>>
>> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> 
> Comment below, but otherwise:
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Though nothing fundamentally different in regard to DT, but
there is a v3 of this patch set available at [1]

> 
>> ---
>>  arch/arm/boot/dts/am3517_mt_ventoux.dts |   27 +++++++++++++++++++++++++++
>>  1 files changed, 27 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/am3517_mt_ventoux.dts
>>
>> diff --git a/arch/arm/boot/dts/am3517_mt_ventoux.dts b/arch/arm/boot/dts/am3517_mt_ventoux.dts
>> new file mode 100644
>> index 0000000..5eb26d7
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am3517_mt_ventoux.dts
>> @@ -0,0 +1,27 @@
>> +/*
>> + * Copyright (C) 2011 Ilya Yanok, EmCraft Systems
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +/dts-v1/;
>> +
>> +/include/ "omap3.dtsi"
>> +
>> +/ {
>> +	model = "TeeJet Mt.Ventoux";
>> +	compatible = "teejet,mt_ventoux", "ti,omap3";
>> +
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0x80000000 0x10000000>; /* 256 MB */
>> +	};
>> +
>> +	/* AM35xx doesn't have IVA */
> 
> Perhaps the AM35xx should have a separate .dtsi file?

In that case there is a possibility you will get multiple
<SoC>.dtsi files with the same copy/pasted "disable" stuff.
Of course this is better than having multiple board files doing this.

What do you think on splitting the whole thing into <IP>.dtsi files,
Like I have explained here [2]?

> 
>> +	soc {
>> +		iva {
>> +			status = "disabled";
>> +		};
>> +	};
>> +};

[1] http://www.spinics.net/lists/linux-omap/msg62185.html
[2] http://www.spinics.net/lists/linux-omap/msg61975.html


-- 
Regards,
Igor.
