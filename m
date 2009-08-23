From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 1/5] ARM: OMAP2/3/4: Split OMAP2_IO_ADDRESS to L3 and L4
Date: Sun, 23 Aug 2009 20:32:25 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F996E313@dbde02.ent.ti.com>
References: <1251034495-10107-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58189 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933613AbZHWPCi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 11:02:38 -0400
In-Reply-To: <1251034495-10107-1-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Santosh

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Shilimkar, Santosh
>Sent: Sunday, August 23, 2009 8:35 AM
>To: tony@atomide.com; khilman@deeprootsystems.com
>Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh
>Subject: [PATCH 1/5] ARM: OMAP2/3/4: Split OMAP2_IO_ADDRESS to L3 and L4

That sure is a big cleanup patch and would take patience to complete!!

>
>This patch splits OMAP2_IO_ADDRESS to OMAP2_L3_IO_ADDRESS and
>OMAP2_L4_IO_ADDRESS to reclaim more IO space.

There is no reclaim of space with this patch. Its done with [2/5]

This patch only changes the macro definitions but the offsets are still the same as in old code.
So the description needs to be more explicit as to why you introduced L3/L4 macro split.

Another suggestion to minimize the so intrusive code change: As per the wiki approach: [1]
Lot of code will remain un-touched if you re-used the existing IO_OFFSET macro as follows --- 
---
#define L3_IO_OFFSET		0x90000000
#define __L3_IO_ADDRESS(pa)	((pa) + L3_IO_OFFSET)/* Works for L3 */
#define __OMAP2_L3_IO_ADDRESS(pa)	((pa) + L3_IO_OFFSET)/* Works for L3 */
#define l3_io_v2p(va)		((va) - L3_IO_OFFSET)/* Works for L3 */
 
#define IO_OFFSET		0xb2000000
#define __IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L4  */
#define __OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L4 */
#define io_v2p(va)		((va) - IO_OFFSET)/* Works for L4*/
---

This way you don't have to introduce new L4 macro at all => much lesser code impact.

[1] http://wiki.davincidsp.com/index.php/HOWTO_Support_512MB_SDRAM

>
>The omap_read*() and omap_write*() functions will work only over
>L4 address space. Current omap kernel stack uses these functions
>only to access registers over L4 io address space

Since the patch touches all IP blocks in OMAP, 
what if put a check in omap_read*/omap_write* if anyone passes an L3 address and return a KERN_ERR

Earlier code it was possible to pass L3 as well as L4 addresses to this function.
An Error log will surely go a long way in debug.

>
>Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>---
> arch/arm/plat-omap/io.c                       |   12 +++---
> 23 files changed, 117 insertions(+), 105 deletions(-)
>
>diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
>index 8d32df3..c475be7 100644
>--- a/arch/arm/plat-omap/include/mach/io.h
>+++ b/arch/arm/plat-omap/include/mach/io.h
>@@ -63,9 +63,11 @@
> #define OMAP1_IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
> #define OMAP1_IO_ADDRESS(pa)	IOMEM((pa) - OMAP1_IO_OFFSET)
>
>-#define OMAP2_IO_OFFSET		0x90000000
>-#define OMAP2_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_IO_OFFSET) /* L3 and L4 */
>+#define OMAP2_L3_IO_OFFSET	0x90000000
>+#define OMAP2_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L3_IO_OFFSET) /* L3 */
>
>+#define OMAP2_L4_IO_OFFSET	0x90000000
>+#define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET) /* L4 */


> /*
>  * ----------------------------------------------------------------------------
>  * Omap1 specific IO mapping
>
>diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
>index b6defa2..35adca8 100644
>--- a/arch/arm/plat-omap/io.c
>+++ b/arch/arm/plat-omap/io.c
>@@ -142,7 +142,7 @@ u8 omap_readb(u32 pa)
> 	if (cpu_class_is_omap1())
> 		return __raw_readb(OMAP1_IO_ADDRESS(pa));
> 	else
>-		return __raw_readb(OMAP2_IO_ADDRESS(pa));
>+		return __raw_readb(OMAP2_L4_IO_ADDRESS(pa));
> }
> EXPORT_SYMBOL(omap_readb);
>
>@@ -151,7 +151,7 @@ u16 omap_readw(u32 pa)
> 	if (cpu_class_is_omap1())
> 		return __raw_readw(OMAP1_IO_ADDRESS(pa));
> 	else
>-		return __raw_readw(OMAP2_IO_ADDRESS(pa));
>+		return __raw_readw(OMAP2_L4_IO_ADDRESS(pa));
> }
> EXPORT_SYMBOL(omap_readw);
>
>@@ -160,7 +160,7 @@ u32 omap_readl(u32 pa)
> 	if (cpu_class_is_omap1())
> 		return __raw_readl(OMAP1_IO_ADDRESS(pa));
> 	else
>-		return __raw_readl(OMAP2_IO_ADDRESS(pa));
>+		return __raw_readl(OMAP2_L4_IO_ADDRESS(pa));
> }
> EXPORT_SYMBOL(omap_readl);
>
>@@ -169,7 +169,7 @@ void omap_writeb(u8 v, u32 pa)
> 	if (cpu_class_is_omap1())
> 		__raw_writeb(v, OMAP1_IO_ADDRESS(pa));
> 	else
>-		__raw_writeb(v, OMAP2_IO_ADDRESS(pa));
>+		__raw_writeb(v, OMAP2_L4_IO_ADDRESS(pa));
> }
> EXPORT_SYMBOL(omap_writeb);
>
>@@ -178,7 +178,7 @@ void omap_writew(u16 v, u32 pa)
> 	if (cpu_class_is_omap1())
> 		__raw_writew(v, OMAP1_IO_ADDRESS(pa));
> 	else
>-		__raw_writew(v, OMAP2_IO_ADDRESS(pa));
>+		__raw_writew(v, OMAP2_L4_IO_ADDRESS(pa));
> }
> EXPORT_SYMBOL(omap_writew);
>
>@@ -187,6 +187,6 @@ void omap_writel(u32 v, u32 pa)
> 	if (cpu_class_is_omap1())
> 		__raw_writel(v, OMAP1_IO_ADDRESS(pa));
> 	else
>-		__raw_writel(v, OMAP2_IO_ADDRESS(pa));
>+		__raw_writel(v, OMAP2_L4_IO_ADDRESS(pa));
> }
> EXPORT_SYMBOL(omap_writel);
