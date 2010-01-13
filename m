From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing different
 OPP types
Date: Wed, 13 Jan 2010 16:01:01 +0530
Message-ID: <4B4DA0E5.60204@ti.com>
References: <1263299979.1536.7.camel@boson> <87iqb7fdgf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36144 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755572Ab0AMKbL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jan 2010 05:31:11 -0500
In-Reply-To: <87iqb7fdgf.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> 
> I like this idea... but I have some questions about how we should
> cleanly handle SMP and future SoCs.
Actually for OMAP4 AFAICT MPU's share only one set of OPPs (their clocks are
tied). So it should not be a problem there. OTOH, the OPP layer itself is not
thread safe today(I tried to make it thread + SMP safe in the version of the
code I posted earlier). You can look into opp_add and it shows that it is not
thread safe.

If you are talking about future SOCs we need to define the OPP list for the new
SoCs. The exact mechanism can be clear once we have the SRF replacement.
> 
>> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
>> index 9f91ad3..c4d5bf9 100644
>> --- a/arch/arm/plat-omap/include/plat/opp.h
>> +++ b/arch/arm/plat-omap/include/plat/opp.h
>> @@ -13,9 +13,18 @@
>>  #ifndef __ASM_ARM_OMAP_OPP_H
>>  #define __ASM_ARM_OMAP_OPP_H
>>  
>> -extern struct omap_opp *mpu_opps;
>> -extern struct omap_opp *dsp_opps;
>> -extern struct omap_opp *l3_opps;
>> +#ifdef CONFIG_ARCH_OMAP3
>> +#define OPP_TYPES 3
>> +#else
>> +#error "You need to put the number of OPP types for OMAP chip type."
>> +#endif
> 
> Rather than the #ifdef...
>> +enum opp_t {
>> +	OPP_NONE,
>> +	OPP_MPU,
>> +	OPP_L3,
>> +	OPP_DSP
> 
> add OPP_MAX_TYPES here
> 
Yes you are right. I will change the code and re-post.
>> +};
> 
Thanks,
-Romit

