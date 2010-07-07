From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 4/9] omap: improve OMAP3_HAS_FEATURE
Date: Wed, 7 Jul 2010 08:50:32 -0500
Message-ID: <4C348628.80307@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com> <1277259375-18521-5-git-send-email-nm@ti.com> <20100707122804.GR1920@atomide.com> <4C347DEA.6090206@ti.com> <20100707133024.GX1920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39429 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755628Ab0GGNuk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jul 2010 09:50:40 -0400
In-Reply-To: <20100707133024.GX1920@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "S, Venkatraman" <svenkatr@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

Tony Lindgren had written, on 07/07/2010 08:30 AM, the following:
> * Nishanth Menon <nm@ti.com> [100707 16:09]:
>>> Why don't you just rename u32 omap3_features to omap_features?
>>>
>>> Then maybe move omap_features to plat-omap/common.c, and have
>>> a generic function for getting features?
>>>
>>> There should not be any need to have separate features variable
>>> for each omap.
>> 192Mhz_clk is a OMAP3 only feature(differentiator b/w omap3430,35xx
>> and 3630, 37xx).
> 
> Hmm, maybe it should be defined as l3_max_clk or similar instead?
it was meant as special feature of DPLL4 as i recollect
Reference:
http://marc.info/?t=126578936600005&r=1&w=2

>  
>> overall, we will face this in the future. there are OMAP generic
>> features and OMAP family specific features. currently OMAP3 has
>> 34xx, 35xx series and 3630 and 37xx series. in future we may see
>> similar things for OMAP4+ as well.. we need a differentiator when it
>> comes to omap3 specific features Vs omap generic feature.
> 
> Sounds it will get more complex.. We should probably set it up
> with something like this then:
> 
> #define FEAT_MPU_L2_OUTER	BIT(1)
> #define FEAT_MPU_L2		BIT(0)
> ...
> 
> #define FEAT_IVA2		BIT(1)
> #define FEAT_IVA		BIT(0)
> ...
> 
> #define FEAT_L3_192		BIT(0)
> ...
> 
> struct omap_feature {
> 	u32	mpu;		/* MPU features */
> 	u32	iva;		/* IVA features */
> 	u32	l3_max_clk;
> 	...
> };
I think I understand your intent here is to introduce per IP based 
feature - that is really not necessary yet (we dont really have a 
usecase needing this level of complexity yet). it will be a natural 
evolution when we need to have such a feature handling.

currently a need for errata handling per ip is required, and we have a 
mechanism (quirks) to handle it on a IP basis. here the intent was to 
identify OMAP specific features in some common way.


> 
> Regards,
> 
> Tony


-- 
Regards,
Nishanth Menon
