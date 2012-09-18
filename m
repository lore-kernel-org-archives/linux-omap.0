From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH V3] ARM: LPAE: Fix mapping in alloc_init_pte for unaligned addresses.
Date: Tue, 18 Sep 2012 16:40:08 +0530
Message-ID: <1347966608-14780-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48740 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757113Ab2IRLK2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Sep 2012 07:10:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: r.sricharan@ti.com, santosh.shilimkar@ti.com, Catalin Marinas <catalin.marinas@arm.com>

With LPAE, When either the start address or end address
or physical address to be mapped is unaligned,
alloc_init_section creates page granularity mappings.
alloc_init_section calls alloc_init_pte which populates
one pmd entry and sets up the ptes. But if the size is
greater than what can be mapped by one pmd entry,
then the rest remains unmapped.

The issue becomes visible when LPAE is enabled, where we have
the 3 levels with seperate pgd and pmd's.
When a static mapping for 3MB is requested, only 2MB is mapped
and the remaining 1MB is unmapped. Fixing this here, by looping
in to map the entire unaligned address range.

Also the issue can be reproduced by enabling CMA + LPAE.
CMA tries to map 16MB with 2 level tables during boot.

Boot tested on OMAP5 evm with both LPAE enabled/disabled
and verified that static mappings with unaligned addresses
are properly mapped. Also the verified the boot with CMA and LPAE
enabled.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 [V2] Moved the loop to alloc_init_pte as per Russell's
     feedback and changed the subject accordingly.
     Using PMD_XXX instead of SECTION_XXX to avoid
     different loop increments with/without LPAE.

 [v3] Removed the dummy variable phys and updated
      the commit log for CMA case.

 arch/arm/mm/mmu.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index c2fa21d..53c9787 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -579,11 +579,23 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
 				  const struct mem_type *type)
 {
-	pte_t *pte = early_pte_alloc(pmd, addr, type->prot_l1);
+	unsigned long next;
+	pte_t *pte;
+
 	do {
-		set_pte_ext(pte, pfn_pte(pfn, __pgprot(type->prot_pte)), 0);
-		pfn++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+		if ((end-addr) & PMD_MASK)
+			next = (addr + PMD_SIZE) & PMD_MASK;
+		else
+			next = end;
+
+		pte = early_pte_alloc(pmd, addr, type->prot_l1);
+		do {
+			set_pte_ext(pte, pfn_pte(pfn,
+					__pgprot(type->prot_pte)), 0);
+			pfn++;
+		} while (pte++, addr += PAGE_SIZE, addr != next);
+
+	} while (pmd++, addr = next, addr != end);
 }
 
 static void __init alloc_init_section(pud_t *pud, unsigned long addr,
-- 
1.7.9.5

