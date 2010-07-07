From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 4/9] omap: improve OMAP3_HAS_FEATURE
Date: Wed, 7 Jul 2010 08:15:22 -0500
Message-ID: <4C347DEA.6090206@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com> <1277259375-18521-5-git-send-email-nm@ti.com> <20100707122804.GR1920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46191 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698Ab0GGNP3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jul 2010 09:15:29 -0400
In-Reply-To: <20100707122804.GR1920@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

Tony Lindgren had written, on 07/07/2010 07:28 AM, the following:
> * Nishanth Menon <nm@ti.com> [100623 05:10]:
>> Replace OMAP3_HAS_FEATURE with OMAP_HAS_FEATURE allowing
>> us to support multiple chip features
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Angelo Arrifano <miknix@gmail.com>
>> Cc: "Zebediah C. McClure" <zmc@lurian.net>
>> Cc: Alistair Buxton <a.j.buxton@gmail.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Sanjeev Premi <premi@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Senthilvadivu Gurusamy <svadivu@ti.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>> Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
>> Cc: Vikram Pandita <vikram.pandita@ti.com>
>> Cc: Vishwanath S <vishwa.s@ti.com>
>> Cc: linux-omap@vger.kernel.org
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  arch/arm/plat-omap/include/plat/cpu.h |   24 ++++++++++++------------
>>  1 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
>> index 5f12a0b..c71dbf4 100644
>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>> @@ -444,6 +444,12 @@ static inline void omap1_check_revision(void) {}
>>  #endif
>>  void omap_check_revision(void);
>>  
>> +#define OMAP_HAS_FEATURE(rev, feat, flag)				\
>> +static inline unsigned int omap##rev##_has_ ##feat(void)		\
>> +{									\
>> +	return omap##rev##_features & OMAP##rev##_HAS_ ##flag;		\
>> +}									\
>> +
>>  /*
>>   * Runtime detection of OMAP3 features
>>   */
>> @@ -456,17 +462,11 @@ extern u32 omap3_features;
>>  #define OMAP3_HAS_ISP			BIT(4)
>>  #define OMAP3_HAS_192MHZ_CLK		BIT(5)
>>  
>> -#define OMAP3_HAS_FEATURE(feat,flag)			\
>> -static inline unsigned int omap3_has_ ##feat(void)	\
>> -{							\
>> -	return (omap3_features & OMAP3_HAS_ ##flag);	\
>> -}							\
>> -
>> -OMAP3_HAS_FEATURE(l2cache, L2CACHE)
>> -OMAP3_HAS_FEATURE(sgx, SGX)
>> -OMAP3_HAS_FEATURE(iva, IVA)
>> -OMAP3_HAS_FEATURE(neon, NEON)
>> -OMAP3_HAS_FEATURE(isp, ISP)
>> -OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
>> +OMAP_HAS_FEATURE(3, l2cache, L2CACHE)
>> +OMAP_HAS_FEATURE(3, sgx, SGX)
>> +OMAP_HAS_FEATURE(3, iva, IVA)
>> +OMAP_HAS_FEATURE(3, neon, NEON)
>> +OMAP_HAS_FEATURE(3, isp, ISP)
>> +OMAP_HAS_FEATURE(3, 192mhz_clk, 192MHZ_CLK)
> 
> Why don't you just rename u32 omap3_features to omap_features?
> 
> Then maybe move omap_features to plat-omap/common.c, and have
> a generic function for getting features?
> 
> There should not be any need to have separate features variable
> for each omap.
192Mhz_clk is a OMAP3 only feature(differentiator b/w omap3430,35xx and 
3630, 37xx).

overall, we will face this in the future. there are OMAP generic 
features and OMAP family specific features. currently OMAP3 has 34xx, 
35xx series and 3630 and 37xx series. in future we may see similar 
things for OMAP4+ as well.. we need a differentiator when it comes to 
omap3 specific features Vs omap generic feature.
-- 
Regards,
Nishanth Menon
