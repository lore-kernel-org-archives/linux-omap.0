From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: insecure W+X mapping at 0xd0050000
Date: Wed, 21 Mar 2018 08:24:06 -0700
Message-ID: <20180321152406.GC5799@atomide.com>
References: <20180308142818.GA9439@amd>
 <20180308162446.GK5799@atomide.com>
 <20180308164652.GL5799@atomide.com>
 <20180308180516.GB16940@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308180516.GB16940@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180308 18:06]:
> Hi!
> 
> > > * Pavel Machek <pavel@ucw.cz> [180308 06:29]:
> > > > Insecure W+X mappings, who cares about those? I have 7 pages...
> > > 
> > > Is this with CONFIG_DEBUG_WX=y?
> > > 
> > > My guess is that it's for mapping the PM assembly to SRAM. This
> > > is already fixed for am335x that is using drivers/misc/sram*.c.
> > > I think omap2 - omap4 still need fixing if this is the culprit.
> > 
> > Adding Dave to Cc, here's a quick fix for this one.
> 
> I did a quick testing and warning is gone. Thanks!

Turns out init time configuration is not enough here.
It causes an oops on omap3 after off mode coming back
from idle. So we need to reconfigure things when
omap_sram_push() is called after idle too.

Below is an updated patch.

Regards,

Tony

8< ----------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 21 Mar 2018 08:16:29 -0700
Subject: [PATCH] ARM: OMAP: Fix SRAM W+X mapping

We are still using custom SRAM code for some SoCs and are not marking
the PM code mapped to SRAM as read-only and executable after we're
done. With CONFIG_DEBUG_WX=y, we will get "Found insecure W+X mapping
at address" warning.

Let's fix this issue the same way as commit 728bbe75c82f ("misc: sram:
Introduce support code for protect-exec sram type") is doing for
drivers/misc/sram-exec.c.

On omap3, we need to restore SRAM when returning from off mode after
idle, so init time configuration is not enough.

And as we no longer have users for omap_sram_push_address() we can
make it static while at it.

Note that eventually we should be using sram-exec.c for all SoCs.

Cc: stable@vger.kernel.org	# v4.12+
Cc: Dave Gerlach <d-gerlach@ti.com>
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/sram.h | 11 +----------
 arch/arm/plat-omap/sram.c              | 36 +++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -5,13 +5,4 @@ void omap_map_sram(unsigned long start, unsigned long size,
 			unsigned long skip, int cached);
 void omap_sram_reset(void);
 
-extern void *omap_sram_push_address(unsigned long size);
-
-/* Macro to push a function to the internal SRAM, using the fncpy API */
-#define omap_sram_push(funcp, size) ({				\
-	typeof(&(funcp)) _res = NULL;				\
-	void *_sram_address = omap_sram_push_address(size);	\
-	if (_sram_address)					\
-		_res = fncpy(_sram_address, &(funcp), size);	\
-	_res;							\
-})
+extern void *omap_sram_push(void *funcp, unsigned long size);
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -23,6 +23,7 @@
 #include <asm/fncpy.h>
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include <asm/mach/map.h>
 
@@ -42,7 +43,7 @@ static void __iomem *omap_sram_ceil;
  * Note that fncpy requires the returned address to be aligned
  * to an 8-byte boundary.
  */
-void *omap_sram_push_address(unsigned long size)
+static void *omap_sram_push_address(unsigned long size)
 {
 	unsigned long available, new_ceil = (unsigned long)omap_sram_ceil;
 
@@ -60,6 +61,30 @@ void *omap_sram_push_address(unsigned long size)
 	return (void *)omap_sram_ceil;
 }
 
+void *omap_sram_push(void *funcp, unsigned long size)
+{
+	void *sram;
+	unsigned long base;
+	int pages;
+	void *dst = NULL;
+
+	sram = omap_sram_push_address(size);
+	if (!sram)
+		return NULL;
+
+	base = (unsigned long)sram & PAGE_MASK;
+	pages = PAGE_ALIGN(size) / PAGE_SIZE;
+
+	set_memory_rw(base, pages);
+
+	dst = fncpy(sram, funcp, size);
+
+	set_memory_ro(base, pages);
+	set_memory_x(base, pages);
+
+	return dst;
+}
+
 /*
  * The SRAM context is lost during off-idle and stack
  * needs to be reset.
@@ -75,6 +100,9 @@ void omap_sram_reset(void)
 void __init omap_map_sram(unsigned long start, unsigned long size,
 				 unsigned long skip, int cached)
 {
+	unsigned long base;
+	int pages;
+
 	if (size == 0)
 		return;
 
@@ -95,4 +123,10 @@ void __init omap_map_sram(unsigned long start, unsigned long size,
 	 */
 	memset_io(omap_sram_base + omap_sram_skip, 0,
 		  omap_sram_size - omap_sram_skip);
+
+	base = (unsigned long)omap_sram_base;
+	pages = PAGE_ALIGN(omap_sram_size) / PAGE_SIZE;
+
+	set_memory_ro(base, pages);
+	set_memory_x(base, pages);
 }
-- 
2.16.2
