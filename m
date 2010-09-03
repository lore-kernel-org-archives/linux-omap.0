From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/6] ARM: Use SMP and UP macros for cacheflush
Date: Fri, 3 Sep 2010 17:27:25 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7588@dbde02.ent.ti.com>
References: <20100817141210.GJ12184@atomide.com>
 <20100817154035.GD20325@n2100.arm.linux.org.uk>
 <20100819073810.GR12184@atomide.com> <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com> <20100902161940.GL11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42789 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab0ICL5u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 07:57:50 -0400
In-Reply-To: <20100902161940.GL11597@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Thursday, September 02, 2010 9:50 PM
> To: Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Bryan Wu; Will Deacon
> Subject: [PATCH 2/6] ARM: Use SMP and UP macros for cacheflush
> 
> From 16c866489613ef8ea9d28ecf861f5a7ff4d60377 Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Thu, 2 Sep 2010 08:20:02 -0700
> Subject: [PATCH 2/6] ARM: Use SMP and UP macros for cacheflush
> 
> Use SMP and UP macros for cacheflush. Note that __flush_icache_all
> currently won't work properly on ARMv7 SMP if support for ARMv6 is
> compiled in.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/include/asm/cacheflush.h |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cacheflush.h
> b/arch/arm/include/asm/cacheflush.h
> index 4656a24..09a893e 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -16,6 +16,7 @@
>  #include <asm/shmparam.h>
>  #include <asm/cachetype.h>
>  #include <asm/outercache.h>
> +#include <asm/smp_plat.h>
> 
>  #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
> 
> @@ -372,8 +373,10 @@ static inline void __flush_icache_all(void)
>  	extern void v6_icache_inval_all(void);
>  	v6_icache_inval_all();
>  #elif defined(CONFIG_SMP) && __LINUX_ARM_ARCH__ >= 7
> -	asm("mcr	p15, 0, %0, c7, c1, 0	@ invalidate I-cache inner
> shareable\n"
> -	    :
> +	asm(								\
> +	SMP(mcr	p15, 0, %0, c7, c1, 0	@ inv I-cache inner shareable)
> 	\
> +	UP(mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache)		\
> +	    :								\
>  	    : "r" (0));
>  #else
>  	asm("mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache\n"

Since UP/SMP both cases are handled, the above patch can be something like this now... 

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 9792a71..ebdff42 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -16,6 +16,7 @@
 #include <asm/shmparam.h>
 #include <asm/cachetype.h>
 #include <asm/outercache.h>
+#include <asm/smp_plat.h>
 
 #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
 
@@ -394,13 +395,11 @@ static inline void __flush_icache_all(void)
 #ifdef CONFIG_ARM_ERRATA_411920
 	extern void v6_icache_inval_all(void);
 	v6_icache_inval_all();
-#elif defined(CONFIG_SMP) && __LINUX_ARM_ARCH__ >= 7
-	asm("mcr	p15, 0, %0, c7, c1, 0	@ invalidate I-cache inner shareable\n"
-	    :
-	    : "r" (0));
 #else
-	asm("mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache\n"
-	    :
+	asm(								\
+	SMP(mcr	p15, 0, %0, c7, c1, 0	@ inv I-cache inner shareable)	\
+	UP(mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache)		\
+	    :								\
 	    : "r" (0));
 #endif
 }
-- 
1.6.0.4

