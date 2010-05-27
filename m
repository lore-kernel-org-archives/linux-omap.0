From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 6/6] omap: move generic omap3 features to generic
Date: Thu, 27 May 2010 18:21:40 +0200
Message-ID: <4BFE9C14.9040703@ti.com>
References: <1274585799-16226-1-git-send-email-nm@ti.com>	<1274585799-16226-2-git-send-email-nm@ti.com>	<1274585799-16226-3-git-send-email-nm@ti.com>	<1274585799-16226-4-git-send-email-nm@ti.com>	<1274585799-16226-5-git-send-email-nm@ti.com>	<1274585799-16226-6-git-send-email-nm@ti.com>	<1274585799-16226-7-git-send-email-nm@ti.com> <AANLkTinsrRAYX4dvB8A8wPayfRc7wkULQtUSiJ9RxbWh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54325 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab0E0QVv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 May 2010 12:21:51 -0400
In-Reply-To: <AANLkTinsrRAYX4dvB8A8wPayfRc7wkULQtUSiJ9RxbWh@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

On 05/27/2010 01:24 PM, S, Venkatraman wrote:
> Nishanth Menon<nm@ti.com>  wrote:

[..]
>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>> index 809e13a..01555b6 100644
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -161,7 +161,7 @@ static void __init omap24xx_check_revision(void)
>>   #define OMAP3_CHECK_FEATURE(status,feat)                               \
>>         if (((status&  OMAP3_ ##feat## _MASK)                           \
>>                 >>  OMAP3_ ##feat## _SHIFT) != FEAT_ ##feat## _NONE) {   \
>> -               omap3_features |= OMAP3_HAS_ ##feat;                    \
>> +               omap_features |= OMAP_HAS_ ##feat;                      \
>>         }
>
> "CHECK" sounds like a querying API, whereas the macro populates data.
> Maybe UPDATE or SET ?
>
Depends on where you are looking at it from: overall it is checking the 
status bits from OMAP and deciding what features it has - this is 
specifically important for 35xx series of processors. it is indeed a 
check in that sense. if you look at it from features variable, yeah it 
is updating it, but the idea of usage of the Macro is: check in status 
if feature X is available.. which is what it does ;). btw, the intent of 
the current patch was not meant to rename CHECK_FEATURE as it was very 
OMAP3 specific ;)

>>   static void __init omap3_check_features(void)
>> @@ -310,20 +310,20 @@ static void __init omap3_cpuinfo(void)
>>                 /*
[...]

>> +OMAP_HAS_FEATURE(, l2cache, L2CACHE)
>> +OMAP_HAS_FEATURE(, sgx, SGX)
>> +OMAP_HAS_FEATURE(, iva, IVA)
>> +OMAP_HAS_FEATURE(, neon, NEON)
>> +OMAP_HAS_FEATURE(, isp, ISP)
>> +
>> +/*
>>   * Runtime detection of OMAP3 features
>>   */
>>   extern u32 omap3_features;
>>
>> -#define OMAP3_HAS_L2CACHE              BIT(0)
>> -#define OMAP3_HAS_IVA                  BIT(1)
>> -#define OMAP3_HAS_SGX                  BIT(2)
>> -#define OMAP3_HAS_NEON                 BIT(3)
>> -#define OMAP3_HAS_ISP                  BIT(4)
>>   #define OMAP3_HAS_192MHZ_CLK           BIT(5)
>>
>> -OMAP_HAS_FEATURE(3, l2cache, L2CACHE)
>> -OMAP_HAS_FEATURE(3, sgx, SGX)
>> -OMAP_HAS_FEATURE(3, iva, IVA)
>> -OMAP_HAS_FEATURE(3, neon, NEON)
>> -OMAP_HAS_FEATURE(3, isp, ISP)
>>   OMAP_HAS_FEATURE(3, 192mhz_clk, 192MHZ_CLK)
>>
>>   #endif
>> --
>
> What about feature detection for OMAP2 and OMAP4 (similar to
> omap3_check_features) ?
> At least a dummy implementation with warning messages would be good,
> so that they are not used without initialization.

there is no need for warning messages, they will return as feature not 
present. cpu.h is a common header and variable omap_features is in 
common.c, the check_feature and id.c has not set that bit, the variable 
will remain 0, hence omap_has_sgx() will return 0 unless someone enables 
that for lets say OMAP4 -> feel free to do it, as I mentioned in 0/6, 
this series was meant solely to reorganize and provide an infrastructure 
for further development.

Regards,
Nishanth Menon
