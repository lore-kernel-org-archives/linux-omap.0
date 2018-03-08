From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: insecure W+X mapping at 0xd0050000
Date: Thu, 8 Mar 2018 08:46:52 -0800
Message-ID: <20180308164652.GL5799@atomide.com>
References: <20180308142818.GA9439@amd>
 <20180308162446.GK5799@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308162446.GK5799@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180308 16:25]:
> * Pavel Machek <pavel@ucw.cz> [180308 06:29]:
> > Insecure W+X mappings, who cares about those? I have 7 pages...
> 
> Is this with CONFIG_DEBUG_WX=y?
> 
> My guess is that it's for mapping the PM assembly to SRAM. This
> is already fixed for am335x that is using drivers/misc/sram*.c.
> I think omap2 - omap4 still need fixing if this is the culprit.

Adding Dave to Cc, here's a quick fix for this one.

Regards,

Tony

8< -------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 8 Mar 2018 08:41:16 -0800
Subject: [PATCH] ARM: OMAP: Fix SRAM W+X mapping

We are still using custom SRAM code for some SoCs and are not marking
the PM code mapped to SRAM as read-only and executable after we're
done. With CONFIG_DEBUG_WX=y, we will get "Found insecure W+X mapping
at address" warning.

Let's fix this issue the same way as commit 728bbe75c82f ("misc: sram:
Introduce support code for protect-exec sram type") is doing for
drivers/misc/sram-exec.c.

Note that eventually we should be using sram-exec.c for all SoCs.

Cc: Dave Gerlach <d-gerlach@ti.com>
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/sram.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -23,6 +23,7 @@
 #include <asm/fncpy.h>
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include <asm/mach/map.h>
 
@@ -96,3 +97,21 @@ void __init omap_map_sram(unsigned long start, unsigned long size,
 	memset_io(omap_sram_base + omap_sram_skip, 0,
 		  omap_sram_size - omap_sram_skip);
 }
+
+static int __init omap_sram_lock(void)
+{
+	unsigned long base;
+	int pages;
+
+	if (!omap_sram_base || !omap_sram_size)
+		return 0;
+
+	base = (unsigned long)omap_sram_base;
+	pages = PAGE_ALIGN(omap_sram_size) / PAGE_SIZE;
+
+	set_memory_ro((unsigned long)base, pages);
+	set_memory_x((unsigned long)base, pages);
+
+	return 0;
+}
+late_initcall(omap_sram_lock);
-- 
2.16.2
