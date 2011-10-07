From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/4] ARM: Add __arm_ioremap_exec for mapping external
 memory as MT_MEMORY
Date: Fri, 07 Oct 2011 23:09:39 +0530
Message-ID: <4E8F395B.9070203@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local> <20111005004539.26980.52409.stgit@kaulin.local> <alpine.LFD.2.02.1110042059110.9106@xanadu.home> <20111005220619.GC6324@atomide.com> <4E8E9EE8.8010106@ti.com> <20111007144349.GE6324@atomide.com> <4E8F14A6.5050402@ti.com> <20111007151116.GI6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:60588 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753716Ab1JGRjq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 13:39:46 -0400
Received: by ggnm2 with SMTP id m2so3674632ggn.36
        for <linux-omap@vger.kernel.org>; Fri, 07 Oct 2011 10:39:44 -0700 (PDT)
In-Reply-To: <20111007151116.GI6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 07 October 2011 08:41 PM, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [111007 07:29]:
>> On Friday 07 October 2011 08:13 PM, Tony Lindgren wrote:
>>>
>>> ..so I think we should just have a separate static mapping for
>>> the omap4 errata fix SO page, and just limit the memory available
>>> for SRAM code to ioremap.
>>>
>>> How does that sounds to you?
>>>
>> That's more or less what the patch is already doing.
>> Instead of static mapping, I was dynamically stealing one
>> page ( SZ_4K) and mapping it as MT_MEMORY_SO and rest
>> of the memory as MT_MEMORY for OMAP4.
> 
> Yeah cool.
>  
>> It should be doable with your updates as well,
>> I guess with or without static mapping since the only
>> requisite is to keep one page of SRAM free on OMAP4 and
>> them map them using  iotable_init() with MT_MEMORY_SO.
> 
> How about something like the following, this won't compile
> without at least moving the defines around a bit, but shows
> what I had in mind:
> 
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -238,6 +238,14 @@ static struct map_desc omap44xx_io_desc[] __initdata = {
>  		.length		= L4_EMU_44XX_SIZE,
>  		.type		= MT_DEVICE,
>  	},
> +#ifdef CONFIG_OMAP4_ERRATA_I688
> +	{
> +		.virtual	= OMAP4_SRAM_VA,
> +		.pfn		= __phys_to_pfn(OMAP4_SRAM_PA),
> +		.length		= PAGE_SIZE,
> +		.type		= MT_MEMORY_SO,
> +	},
> +#endif
>  };

I initially tried some thing similar but the issue was GP and
HS devices. SRAM_PA isn't same on GP and EMU device and hence
did that dynamically. One way is I can make GP and HS
device SRAM_PA same for OMAP4 (Will loose 16 KB of
SRAM on OMAP4 GP). It's ok to loose that 16 KB SRAM
for OMAP4 with errata enabled.

Below change works on both GP and HS device
If you are OK with it, I can update errata patch accordingly.

diff --git a/arch/arm/plat-omap/include/plat/sram.h
b/arch/arm/plat-omap/include/plat/sram.h
index f500fc3..111b1a8 100644
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -95,6 +95,11 @@ static inline void omap_push_sram_idle(void) {}
  */
 #define OMAP2_SRAM_PA		0x40200000
 #define OMAP3_SRAM_PA           0x40200000
+#ifdef CONFIG_OMAP4_ERRATA_I688
+#define OMAP4_SRAM_PA		0x40304000
+#else
 #define OMAP4_SRAM_PA		0x40300000
+#endif
+#define OMAP4_SRAM_VA		0xfe404000

 #endif
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 363c91e..cdd303f 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -48,9 +48,13 @@
 #define OMAP3_SRAM_VA           0xfe400000
 #define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
 #define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
-#define OMAP4_SRAM_VA		0xfe400000
+#ifdef CONFIG_OMAP4_ERRATA_I688
+#define OMAP4_SRAM_PUB_PA	OMAP4_SRAM_PA
+#define OMAP4_SRAM_PUB_VA	OMAP4_SRAM_VA
+#else
 #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
 #define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)
+#endif

 #if defined(CONFIG_ARCH_OMAP2PLUS)
 #define SRAM_BOOTLOADER_SZ	0x00
@@ -203,6 +207,11 @@ static void __init omap_map_sram(void)
 	if (omap_sram_size == 0)
 		return;

+#ifdef CONFIG_OMAP4_ERRATA_I688
+		omap_sram_base += PAGE_SIZE;
+		omap_sram_start += PAGE_SIZE;
+		omap_sram_size -= SZ_16K;
+#endif
 	if (cpu_is_omap34xx()) {
 		/*
 		 * SRAM must be marked as non-cached on OMAP3 since the

Regards
Santosh
