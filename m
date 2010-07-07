From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/9 v3] omap: generic: introduce a single check_revision
Date: Wed, 7 Jul 2010 12:24:16 -0500
Message-ID: <4C34B840.3060907@ti.com>
References: <1277483122-3616-1-git-send-email-nm@ti.com> <20100707123633.GT1920@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------000906030609080203050406"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35119 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394Ab0GGRY0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Jul 2010 13:24:26 -0400
In-Reply-To: <20100707123633.GT1920@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

--------------000906030609080203050406
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit

Tony Lindgren had written, on 07/07/2010 07:36 AM, the following:
> * Nishanth Menon <nm@ti.com> [100625 19:19]:
>> --- a/arch/arm/mach-omap2/io.c
>> +++ b/arch/arm/mach-omap2/io.c
>> @@ -238,7 +238,7 @@ static void __init _omap2_map_common_io(void)
>>  	local_flush_tlb_all();
>>  	flush_cache_all();
>>  
>> -	omap2_check_revision();
>> +	omap_check_revision();
>>  	omap_sram_init();
>>  }
>>  
>> diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
>> index fca73cd..4a0e333 100644
>> --- a/arch/arm/plat-omap/common.c
>> +++ b/arch/arm/plat-omap/common.c
>> @@ -89,6 +89,12 @@ void __init omap_reserve(void)
>>  	omap_vram_reserve_sdram_lmb();
>>  }
>>  
>> +void __init omap_check_revision(void)
>> +{
>> +	omap1_check_revision();
>> +	omap2_check_revision();
>> +}
>> +
>>  /*
>>   * 32KHz clocksource ... always available, on pretty most chips except
>>   * OMAP 730 and 1510.  Other timers could be used as clocksources, with
>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
>> index 7514174..5f12a0b 100644
>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>> @@ -431,7 +431,18 @@ IS_OMAP_TYPE(3517, 0x3517)
>>  
>>  
>>  int omap_chip_is(struct omap_chip_id oci);
>> -void omap2_check_revision(void);
>> +#ifdef CONFIG_ARCH_OMAP2PLUS
>> +extern void omap2_check_revision(void);
>> +#else
>> +static inline void omap2_check_revision(void) {}
>> +#endif
>> +
>> +#ifdef CONFIG_ARCH_OMAP1
>> +extern void omap1_check_revision(void);
>> +#else
>> +static inline void omap1_check_revision(void) {}
>> +#endif
>> +void omap_check_revision(void);
> 
> Hmm, to me it seems like we should have static omap_check_revision
> in both mach-omap1/id.c and mach-omap2/id.c. Or do we need to call
> these anywhere else outside both id.c files?
check_revision is called from mach-omap[12]/io.c - so no chance of the 
check_revision to be static..

> 
> Then these can set u32 omap_revision flags in plat-omap/common.c,
> and then we can have a common omap_get_revision() or something
> in plat-omap/common.c?
i think I managed to get rid of it entirely.. ref: attached patch

If we are ok with this, I will repost the series (i squashed 
omap1-rename-check_revision into this patch).

> 
> There should not be need for cpu_is_omapxxxx tests for getting
> the revision after it's initialized.
I am not sure.. if you would like drivers to be modprobabe, there may be 
quirks that you'd want to enable based on cpu_is_omapxxx checks. so it 
probably does not make sense to __initdata the revision/feature variables.


-- 
Regards,
Nishanth Menon

--------------000906030609080203050406
Content-Type: text/x-patch;
	name="0002-omap-generic-introduce-a-single-check_revision.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0002-omap-generic-introduce-a-single-check_revision.patch"

>From f72070e575433ad07ed018aef5c43677424003d0 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Fri, 21 May 2010 12:09:33 -0500
Subject: [PATCH 2/7] omap: generic: introduce a single check_revision

Introduce a single omap generic check_revision that routes the
request to the right revision of check_revision.

Note: OMAP1 and OMAP2+ are not built into a single kernel.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Angelo Arrifano <miknix@gmail.com>
Cc: "Zebediah C. McClure" <zmc@lurian.net>
Cc: Alistair Buxton <a.j.buxton@gmail.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Senthilvadivu Gurusamy <svadivu@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Cc: Vishwanath S <vishwa.s@ti.com>
Cc: linux-omap@vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap1/io.c              |    1 -
 arch/arm/mach-omap2/id.c              |    2 +-
 arch/arm/mach-omap2/io.c              |    2 +-
 arch/arm/plat-omap/include/plat/cpu.h |    3 ++-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 0ce3fec..4f9ee73 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -20,7 +20,6 @@
 
 #include "clock.h"
 
-extern void omap_check_revision(void);
 extern void omap_sram_init(void);
 
 /*
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index c7bf0e1..80f0950 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -371,7 +371,7 @@ static void __init omap3_cpuinfo(void)
 /*
  * Try to detect the exact revision of the omap we're running on
  */
-void __init omap2_check_revision(void)
+void __init omap_check_revision(void)
 {
 	/*
 	 * At this point we have an idea about the processor revision set
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b9ea70b..75883fe 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -238,7 +238,7 @@ static void __init _omap2_map_common_io(void)
 	local_flush_tlb_all();
 	flush_cache_all();
 
-	omap2_check_revision();
+	omap_check_revision();
 	omap_sram_init();
 }
 
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 7514174..d25ba40 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -431,7 +431,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 
 
 int omap_chip_is(struct omap_chip_id oci);
-void omap2_check_revision(void);
+
+void omap_check_revision(void);
 
 /*
  * Runtime detection of OMAP3 features
-- 
1.6.3.3


--------------000906030609080203050406--
