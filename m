From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 2/3] arm: mach-omap2: sdram-nokia: add 200 MHz memory
 timings info
Date: Fri, 9 Dec 2011 21:41:17 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1112092136370.7393@kernel.research.nokia.com>
References: <1323443211-3648-1-git-send-email-aaro.koskinen@nokia.com> <1323443211-3648-3-git-send-email-aaro.koskinen@nokia.com> <20111209180641.GS31337@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:41848 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954Ab1LITnD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 14:43:03 -0500
In-Reply-To: <20111209180641.GS31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Dmitriev <ext-dmitriev.igor@nokia.com>

Hi,

On Fri, 9 Dec 2011, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@nokia.com> [111209 06:33]:
>> From: Igor Dmitriev <ext-dmitriev.igor@nokia.com>
>>
>> Add memory timing info regarding the 200 MHz memory in sdram-nokia.
>>
>> Signed-off-by: Igor Dmitriev <ext-dmitriev.igor@nokia.com>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
>> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
>> ---
>>  arch/arm/mach-omap2/sdram-nokia.c |   25 ++++++++++++++++++++++++-
>>  1 files changed, 24 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
>> index 14caa22..b394a0e 100644
>> --- a/arch/arm/mach-omap2/sdram-nokia.c
>> +++ b/arch/arm/mach-omap2/sdram-nokia.c
>> @@ -1,7 +1,7 @@
>>  /*
>>   * SDRC register values for Nokia boards
>>   *
>> - * Copyright (C) 2008, 2010 Nokia Corporation
>> + * Copyright (C) 2008, 2010-2011 Nokia Corporation
>>   *
>>   * Lauri Leukkunen <lauri.leukkunen@nokia.com>
>>   *
>> @@ -107,14 +107,37 @@ static const struct sdram_timings nokia_195dot2mhz_timings[] = {
>>  	},
>>  };
>>
>> +static const struct sdram_timings nokia_200mhz_timings[] = {
>> +	{
>> +		.casl = 3,
>> +		.tDAL = 30000,
>> +		.tDPL = 15000,
>> +		.tRRD = 10000,
>> +		.tRCD = 20000,
>> +		.tRP = 15000,
>> +		.tRAS = 40000,
>> +		.tRC = 55000,
>> +		.tRFC = 140000,
>> +		.tXSR = 200000,
>> +
>> +		.tREF = 7800,
>> +
>> +		.tXP = 2,
>> +		.tCKE = 4,
>> +		.tWTR = 2
>> +	},
>> +};
>> +
>>  static const struct {
>>  	long rate;
>>  	struct sdram_timings const *data;
>>  } nokia_timings[] = {
>>  	{ 83000000, nokia_166mhz_timings },
>>  	{ 97600000, nokia_97dot6mhz_timings },
>> +	{ 100000000, nokia_200mhz_timings },
>
> Is that a typo above? Should it say nokia_100mhz_timings?

No, it's not a typo, same data is used. (Like 83/166 already in the table)

>>  	{ 166000000, nokia_166mhz_timings },
>>  	{ 195200000, nokia_195dot2mhz_timings },
>> +	{ 200000000, nokia_200mhz_timings },
>>  };
>>  static struct omap_sdrc_params nokia_sdrc_params[ARRAY_SIZE(nokia_timings) + 1];
>
> Regards,
>
> Tony

A.
