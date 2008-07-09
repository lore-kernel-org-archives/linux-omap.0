From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/9] OMAP2/3 SDRC/clock: control CORE M2 divider, clean
 up SDRC
Date: Tue, 8 Jul 2008 19:06:18 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807081830010.12684@utopia.booyaka.com>
References: <20080708025225.11646.55912.stgit@localhost.localdomain> <02aa01c8e0b4$5c09a450$68bf18ac@ent.ti.com> <alpine.DEB.1.00.0807081611500.12684@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162035BD67429@dlee02.ent.ti.com>
 <alpine.DEB.1.00.0807081730590.12684@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162035BD67456@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47938 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbYGIBGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 21:06:19 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BD67456@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 'Igor Stoppa' <igor.stoppa@nokia.com>

Hello Richard,

On Tue, 8 Jul 2008, Woodruff, Richard wrote:

> If say your I2C failed to raise the voltage or you didn't program in 
> enough setup time into volt control you might try and go fast with out 
> having proper voltage yet.

Thanks for the ideas.  Unfortunately, no access to an SDP with JTAG, so 
can't test via JTAG.  It's unlikely to be a voltage issue, since those 
patches don't touch VDD2.

Added the following patch to mark SRAM as strongly-ordered; no change in 
behavior.


- Paul

---

 arch/arm/mm/mmu.c          |    5 +++++
 arch/arm/plat-omap/sram.c  |    2 +-
 include/asm-arm/mach/map.h |   13 +++++++------
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 2d6d682..5b56539 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -239,6 +239,11 @@ static struct mem_type mem_types[] = {
 		.prot_sect = PMD_TYPE_SECT,
 		.domain    = DOMAIN_KERNEL,
 	},
+	[MT_MEMORY_STRONGLY_ORDERED] = {
+		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE |
+				PMD_SECT_UNCACHED,
+		.domain    = DOMAIN_KERNEL,
+	},
 };
 
 const struct mem_type *get_mem_type(unsigned int type)
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 71472b2..e0d1b7b 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -173,7 +173,7 @@ static struct map_desc omap_sram_io_desc[] __initdata = {
 	{	/* .length gets filled in at runtime */
 		.virtual	= OMAP1_SRAM_VA,
 		.pfn		= __phys_to_pfn(OMAP1_SRAM_PA),
-		.type		= MT_MEMORY
+		.type		= MT_MEMORY_STRONGLY_ORDERED,
 	}
 };
 
diff --git a/include/asm-arm/mach/map.h b/include/asm-arm/mach/map.h
index 7ef3c83..8cb46b7 100644
--- a/include/asm-arm/mach/map.h
+++ b/include/asm-arm/mach/map.h
@@ -19,12 +19,13 @@ struct map_desc {
 };
 
 /* types 0-3 are defined in asm/io.h */
-#define MT_CACHECLEAN		4
-#define MT_MINICLEAN		5
-#define MT_LOW_VECTORS		6
-#define MT_HIGH_VECTORS		7
-#define MT_MEMORY		8
-#define MT_ROM			9
+#define MT_CACHECLEAN			4
+#define MT_MINICLEAN			5
+#define MT_LOW_VECTORS			6
+#define MT_HIGH_VECTORS			7
+#define MT_MEMORY			8
+#define MT_ROM				9
+#define MT_MEMORY_STRONGLY_ORDERED	10
 
 #define MT_NONSHARED_DEVICE	MT_DEVICE_NONSHARED
 #define MT_IXP2000_DEVICE	MT_DEVICE_IXP2000
