From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/8] DSPBRIDGE: Increased DMM size to 256MB
Date: Fri, 8 Jan 2010 08:28:11 -0600
Message-ID: <4B4740FB.6040403@ti.com>
References: <1262912435-30024-1-git-send-email-omar.ramirez@ti.com> <4B4695CB.4080606@ti.com> <8F7AF80515AF0D4D93307E594F3CB40E43C043AC@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45796 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171Ab0AHO2Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 09:28:16 -0500
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E43C043AC@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Aguilar Pena, Leed" <leed.aguilar@ti.com>

Kanigeri, Hari had written, on 01/07/2010 11:16 PM, the following:
> Nishant,
> 
> With 64MB we were seeing cases of running out of DSP virtual memory when running multiple Multimedia use cases in parallel at a time. 
Would it be better that we make this as a board specific memory 
requirement? not all boards will have the same needs right?

> 
> Thank you,
> Best regards,
> Hari  
> 
> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Friday, January 08, 2010 7:48 AM
> To: Ramirez Luna, Omar
> Cc: linux-omap; Hiroshi Doyu; Ameya Palande; Felipe Contreras; Guzman Lugo, Fernando; Ramos Falcon, Ernesto; Kanigeri, Hari; Aguilar Pena, Leed
> Subject: Re: [PATCH 3/8] DSPBRIDGE: Increased DMM size to 256MB
> 
> Ramirez Luna, Omar had written, on 01/07/2010 07:00 PM, the following:
>> From: Hari Kanigeri <h-kanigeri2@ti.com>
>>
>> This patch increases the DMM from 64MB to 256MB.
> 
> begs the question: Why?
> 
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
>> ---
>>  arch/arm/plat-omap/include/dspbridge/dmm.h |    2 +-
>>  drivers/dsp/bridge/pmgr/dmm.c              |    8 ++++----
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/dspbridge/dmm.h b/arch/arm/plat-omap/include/dspbridge/dmm.h
>> index 335edf8..af0c35a 100644
>> --- a/arch/arm/plat-omap/include/dspbridge/dmm.h
>> +++ b/arch/arm/plat-omap/include/dspbridge/dmm.h
>> @@ -41,7 +41,7 @@
>>  		u32 reserved;
>>  	} ;
>>  
>> -#define DMMPOOLSIZE      0x4000000
>> +#define DMMPOOLSIZE      0x10000000
>>  
>>  /*
>>   *  ======== DMM_GetHandle ========
>> diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
>> index 46c05c6..f878855 100644
>> --- a/drivers/dsp/bridge/pmgr/dmm.c
>> +++ b/drivers/dsp/bridge/pmgr/dmm.c
>> @@ -103,10 +103,10 @@ static struct GT_Mask DMM_debugMask = { NULL, NULL };	/* GT trace variable */
>>  
>>  static u32 cRefs;		/* module reference count */
>>  struct MapPage {
>> -	u32   RegionSize:15;
>> -	u32   MappedSize:15;
>> -	u32   bReserved:1;
>> -	u32   bMapped:1;
>> +	u64   RegionSize:31;
>> +	u64   MappedSize:31;
>> +	u64   bReserved:1;
>> +	u64   bMapped:1;

this does not make much sense meanwhile.. what does this have to do with 
the dmmpool size increase and what are these unused fields being used for?

>>  };
>>  
>>  /*  Create the free list */
> 
> 


-- 
Regards,
Nishanth Menon
