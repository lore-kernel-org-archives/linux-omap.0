From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 01/25] ARM: mm: Add strongly ordered descriptor support.
Date: Sun, 4 Sep 2011 19:24:02 +0530
Message-ID: <1315144466-9395-2-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47598 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab1IDNzk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Sep 2011 09:55:40 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Woodruff Richard <r-woodruff2@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

On certain architectures, there might be a need to mark certain
addresses with strongly ordered memory attributes to avoid ordering
issues at the interconnect level.

On OMAP4, the asynchronous bridge buffers can only be drained
with strongly ordered accesses and hence the need to mark the
memory strongly ordered.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Woodruff Richard <r-woodruff2@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/map.h |    1 +
 arch/arm/include/asm/pgtable.h  |    3 +++
 arch/arm/mm/mmu.c               |    8 ++++++++
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index d2fedb5..b36f365 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -29,6 +29,7 @@ struct map_desc {
 #define MT_MEMORY_NONCACHED	11
 #define MT_MEMORY_DTCM		12
 #define MT_MEMORY_ITCM		13
+#define MT_MEMORY_SO		14
 
 #ifdef CONFIG_MMU
 extern void iotable_init(struct map_desc *, int);
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 5750704..f1956b2 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -232,6 +232,9 @@ extern pgprot_t		pgprot_kernel;
 #define pgprot_writecombine(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE)
 
+#define pgprot_stronglyordered(prot) \
+	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED)
+
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
 #define pgprot_dmacoherent(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE | L_PTE_XN)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 594d677..ea9c9f3 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -273,6 +273,14 @@ static struct mem_type mem_types[] = {
 		.prot_l1   = PMD_TYPE_TABLE,
 		.domain    = DOMAIN_KERNEL,
 	},
+	[MT_MEMORY_SO] = {
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_MT_UNCACHED,
+		.prot_l1   = PMD_TYPE_TABLE,
+		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_S |
+				PMD_SECT_UNCACHED | PMD_SECT_XN,
+		.domain    = DOMAIN_KERNEL,
+	},
 };
 
 const struct mem_type *get_mem_type(unsigned int type)
-- 
1.7.4.1

