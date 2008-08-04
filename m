From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Mon, 4 Aug 2008 17:40:57 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55551 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbYHDXk6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 19:40:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com


Add the MT_MEMORY_STRONGLY_ORDERED memory type for ARM strongly ordered
memory.

This is used on OMAP3 for on-board SRAM.  On OMAP, SRAM is used for code 
that changes the SDRAM controller's clock, temporarily blocking access to 
SDRAM.  During this period, as code executes from SRAM, the ARM cache 
controller can attempt to write dirty cache lines back to SDRAM to make 
room for SRAM cache lines, causing the MPU subsystem to hang.  To avoid 
this, we mark SRAM as strongly- ordered memory.

Problem noted by Richard Woodruff <r-woodruff2@ti.com>.  Fix derived
from the TI CDP codebase.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mm/mmu.c          |    5 +++++
 include/asm-arm/mach/map.h |   13 +++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

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

