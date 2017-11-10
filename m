From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Thu, 9 Nov 2017 19:26:10 -0800
Message-ID: <20171110032610.GJ28152@atomide.com>
References: <20171107053313.GA12447@js1304-P5Q-DELUXE>
 <20171107154842.GP28152@atomide.com>
 <20171108074645.GA18747@js1304-P5Q-DELUXE>
 <20171108163413.GU28152@atomide.com>
 <20171109000801.GA23982@js1304-P5Q-DELUXE>
 <20171109001113.GZ28152@atomide.com>
 <20171109003639.GB23982@js1304-P5Q-DELUXE>
 <20171109035031.GA24383@js1304-P5Q-DELUXE>
 <20171109150854.GC28152@atomide.com>
 <20171110001315.GA29669@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171110001315.GA29669@js1304-P5Q-DELUXE>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Joonsoo Kim <iamjoonsoo.kim@lge.com> [171110 00:10]:
> On Thu, Nov 09, 2017 at 07:08:54AM -0800, Tony Lindgren wrote:
> > Hmm OK. Does your first patch above now have the initcall issue too?
> > It boots if I make that also subsys_initcall and then I get:
> 
> > [    2.078094] vmalloc_pool_init: DMA: get vmalloc area: d0010000
> 
> Yes, first patch has the initcall issue and it's intentional in order
> to check the theory. I checked following log for this.
> 
> - Boot failure
> SRAM_ADDR: omap_map_sram: P: 0x40208000 - 0x4020f000
> SRAM_ADDR: omap_map_sram: V: 0xd0050000 - 0xd0057000
> 
> - Boot success
> SRAM_ADDR: omap_map_sram: P: 0x40208000 - 0x4020f000
> SRAM_ADDR: omap_map_sram: V: 0xd0008000 - 0xd000f000
> 
> When failure, virtual address for sram is higher than normal one due
> to vmalloc area allocation in __dma_alloc_remap(). If it is deferred,
> virtual address is the same with success case and then the system work.
> 
> So, my next theory is that there is n900 specific assumption that sram
> should have that address. Could you check if any working tree for n900
> which doesn't have my CMA series work or not with adding
> "arm/dma: vmalloc area allocation"?

Oh I see, sorry I was not following you earlier. So you mean that
by adding the vmalloc_pool_init() initcall the va mapping for SRAM
changes.

And yes, save_secure_ram_context seems to be doing some sketchy
virt to phys calculation with sram_phy_addr_mask. Here's a small
patch to fix that for your CMA series, maybe you can merge it
with your series to avoid breaking booting for git bisect.

Then I'll follow up on cleaning up save_secure_ram_context later.

Regards,

Tony

8< -------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 9 Nov 2017 17:05:34 -0800
Subject: [PATCH] ARM: OMAP2+: Add static SRAM mapping for
 save_secure_ram_context

With the CMA changes from Joonsoo Kim <iamjoonsoo.kim@lge.com>, it
was noticed that n900 stopped booting. After investigating it turned
out that n900 save_secure_ram_context does some whacky virtual to
physical address translation for the SRAM data address.

Let's fix this for CMA changes by adding a static mapping for SRAM
on omap3. Then we can follow up with a patch to clean up the address
translation in save_secure_ram_context later on.

Debugged-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c    | 6 ++++++
 arch/arm/mach-omap2/iomap.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -139,6 +139,12 @@ static struct map_desc omap243x_io_desc[] __initdata = {
 
 #ifdef	CONFIG_ARCH_OMAP3
 static struct map_desc omap34xx_io_desc[] __initdata = {
+	{
+		.virtual	= OMAP34XX_SRAM_VIRT,
+		.pfn		= __phys_to_pfn(OMAP34XX_SRAM_PHYS),
+		.length		= OMAP34XX_SRAM_SIZE,
+		.type		= MT_DEVICE
+	},
 	{
 		.virtual	= L3_34XX_VIRT,
 		.pfn		= __phys_to_pfn(L3_34XX_PHYS),
diff --git a/arch/arm/mach-omap2/iomap.h b/arch/arm/mach-omap2/iomap.h
--- a/arch/arm/mach-omap2/iomap.h
+++ b/arch/arm/mach-omap2/iomap.h
@@ -123,6 +123,10 @@
  * VPOM3430 was not working for Int controller
  */
 
+#define OMAP34XX_SRAM_PHYS	0x40200000
+#define OMAP34XX_SRAM_VIRT	0xd0010000
+#define OMAP34XX_SRAM_SIZE	0x10000
+
 #define L4_PER_34XX_PHYS	L4_PER_34XX_BASE
 						/* 0x49000000 --> 0xfb000000 */
 #define L4_PER_34XX_VIRT	(L4_PER_34XX_PHYS + OMAP2_L4_IO_OFFSET)
-- 
2.15.0
