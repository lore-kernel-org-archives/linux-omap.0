From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 3/10] OPP layer and additional cleanups.
Date: Thu, 07 Jan 2010 18:20:35 +0530
Message-ID: <4B45D89B.8090108@ti.com>
References: <1262266152.20175.179.camel@boson> <4B42663F.6040501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57309 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab0AGMum (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 07:50:42 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o07CodTh020497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 06:50:41 -0600
In-Reply-To: <4B42663F.6040501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>> diff --git a/arch/arm/plat-omap/omap-pm-srf.c b/arch/arm/plat-omap/omap-pm-srf.c
>> index f7bf353..0736d6a 100644
>> --- a/arch/arm/plat-omap/omap-pm-srf.c
>> +++ b/arch/arm/plat-omap/omap-pm-srf.c
>> @@ -25,10 +25,6 @@
>>  #include <plat/resource.h>
>>  #include <plat/omap_device.h>
>>  
>> -struct omap_opp *dsp_opps;
>> -struct omap_opp *mpu_opps;
>> -struct omap_opp *l3_opps;
>> -
>>  #define LAT_RES_POSTAMBLE "_latency"
>>  #define MAX_LATENCY_RES_NAME 30
>>  
>> @@ -78,16 +74,17 @@ void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
>>  		WARN_ON(1);
>>  		return;
>>  	};
>> +#warning "Convert throughput to L3 frequency before invoking resource_request"
>>  
>>  	if (r == 0) {
>>  		pr_debug("OMAP PM: remove min bus tput constraint: "
>>  			 "dev %s for agent_id %d\n", dev_name(dev), agent_id);
>> -		resource_release("vdd2_opp", dev);
>> +		resource_release("l3_freq", dev);
>>  	} else {
>>  		pr_debug("OMAP PM: add min bus tput constraint: "
>>  			 "dev %s for agent_id %d: rate %ld KiB\n",
>>  			 dev_name(dev), agent_id, r);
>> -		resource_request("vdd2_opp", dev, r);
>> +		resource_request("l3_freq", dev, r);
>>  	}
>>  }
>>  
>> @@ -168,42 +165,27 @@ void omap_pm_set_max_sdma_lat(struct device *dev, long t)
>>
> 
> you may want to split this out.

Yes, there is still a TODO on this patch. I will split it out once this is done.
>

