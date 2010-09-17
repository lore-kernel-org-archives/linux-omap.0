From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 01/14] ARM: mmu: Setup MT_MEMORY and MT_MEMORY_NONCACHED L1 entries
Date: Fri, 17 Sep 2010 15:17:45 +0530
Message-ID: <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37170 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab0IQJsL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 05:48:11 -0400
In-Reply-To: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch populates the L1 entries for MT_MEMORY and MT_MEMORY_NONCACHED
types so that at boot-up, we can map memories outside system memory
at page level granularity

Previously the mapping was limiting to section level, which creates
unnecessary addiotional mapping for which physical memory may not
present. On the newer ARM with speculation, this is dangerous and can
result in untraceable aborts.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mm/mmu.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6e1c4f6..3e986a6 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -246,6 +246,9 @@ static struct mem_type mem_types[] = {
 		.domain    = DOMAIN_USER,
 	},
 	[MT_MEMORY] = {
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_USER | L_PTE_EXEC,
+		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
@@ -254,6 +257,9 @@ static struct mem_type mem_types[] = {
 		.domain    = DOMAIN_KERNEL,
 	},
 	[MT_MEMORY_NONCACHED] = {
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+				L_PTE_USER | L_PTE_EXEC | L_PTE_MT_BUFFERABLE,
+		.prot_l1   = PMD_TYPE_TABLE,
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
@@ -411,9 +417,12 @@ static void __init build_mem_type_table(void)
 	 * Enable CPU-specific coherency if supported.
 	 * (Only available on XSC3 at the moment.)
 	 */
-	if (arch_is_coherent() && cpu_is_xsc3())
+	if (arch_is_coherent() && cpu_is_xsc3()) {
 		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
-
+		mem_types[MT_MEMORY].prot_pte |= L_PTE_SHARED;
+		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
+		mem_types[MT_MEMORY_NONCACHED].prot_pte |= L_PTE_SHARED;
+	}
 	/*
 	 * ARMv6 and above have extended page tables.
 	 */
@@ -438,7 +447,9 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
 		mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
 		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
+		mem_types[MT_MEMORY].prot_pte |= L_PTE_SHARED;
 		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
+		mem_types[MT_MEMORY_NONCACHED].prot_pte |= L_PTE_SHARED;
 #endif
 	}
 
@@ -475,6 +486,8 @@ static void __init build_mem_type_table(void)
 	mem_types[MT_LOW_VECTORS].prot_l1 |= ecc_mask;
 	mem_types[MT_HIGH_VECTORS].prot_l1 |= ecc_mask;
 	mem_types[MT_MEMORY].prot_sect |= ecc_mask | cp->pmd;
+	mem_types[MT_MEMORY].prot_pte |= kern_pgprot;
+	mem_types[MT_MEMORY_NONCACHED].prot_sect |= ecc_mask;
 	mem_types[MT_ROM].prot_sect |= cp->pmd;
 
 	switch (cp->pmd) {
-- 
1.6.0.4

