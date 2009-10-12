From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] [RFC] omap: 3630: default cpu_is_omap3630 to zero
Date: Tue, 13 Oct 2009 02:37:56 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA0D37E8@dbde02.ent.ti.com>
References: <1255380685-26765-1-git-send-email-vikram.pandita@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012A856FA5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53469 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbZJLVIj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 17:08:39 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9CL7xLQ023943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 16:08:02 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9CL7xvN016382
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 02:37:59 +0530 (IST)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012A856FA5@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Menon, Nishanth
>Sent: Monday, October 12, 2009 4:05 PM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org
>Subject: RE: [PATCH] [RFC] omap: 3630: default cpu_is_omap3630 to zero
>
>> -----Original Message-----
>> From: Pandita, Vikram
>> Sent: Monday, October 12, 2009 3:51 PM
>>
>> make default cpu_is_omap3630() return zero
>>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> ---
>>  arch/arm/plat-omap/include/mach/cpu.h |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-
>> omap/include/mach/cpu.h
>> index da9e8f8..940946e 100644
>> --- a/arch/arm/plat-omap/include/mach/cpu.h
>> +++ b/arch/arm/plat-omap/include/mach/cpu.h
>> @@ -322,6 +322,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>>  #define cpu_is_omap2423()		0
>>  #define cpu_is_omap2430()		0
>>  #define cpu_is_omap3430()		0
>> +#define cpu_is_omap3630()		0
>>
>>  /*
>>   * Whether we have MULTI_OMAP1 or not, we still need to distinguish
>> @@ -386,6 +387,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>>  						(omap3_has_sgx()) &	\
>>  						(!omap3_has_iva()))
>>  # define cpu_is_omap3530		(cpu_is_omap3430())
>> +# undef cpu_is_omap3630()
>>  # define cpu_is_omap3630()		is_omap363x()
>>  #endif
>Dumb question: why is this needed? cpu_is_omap3530,15,25,03 don't seems to declare these..

If in some file, you want to distinguish between 3630 vs 3430, 
and the build is for 3430 only, then cpu_is_omap3630() should return 0.

Eg: opp table allocation based on run time check

Omap35xx may also need it for the opp in future I guess.


>
>Regards,
>Nishanth Menon

