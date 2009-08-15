From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Sat, 15 Aug 2009 19:17:11 +0100
Message-ID: <20090815181711.GG29616@n2100.arm.linux.org.uk>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com> <20090807220016.GG31543@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com> <20090808170300.GA23481@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com> <20090813173327.GA14872@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com> <20090815153357.GF29616@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52941 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbZHOSRU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 14:17:20 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Aug 15, 2009 at 09:47:18PM +0530, Syed Mohammed, Khasim wrote:
> Backtrace:
> [<c002c884>] (__flush_dcache_page+0x0/0x3c) from [<c002c7c0>] (update_mmu_cache+
> 0x8c/0xb0)
> [<c002c734>] (update_mmu_cache+0x0/0xb0) from [<c008611c>] (handle_mm_fault+0x53
> 4/0x5ac)

Bingo!

void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
{
        unsigned long pfn = pte_pfn(pte);
        struct address_space *mapping;
        struct page *page;

#define pfn_valid(pfn) ((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))
        if (!pfn_valid(pfn))
                return;

        page = pfn_to_page(pfn);
        mapping = page_mapping(page);

The problem with the above is that in your case is that pfn_valid returns
true for pages in the "hole", which causes update_mmu_cache() to try to
dereference a pointer to them.

Normally, when we have such holes, no one ever maps them (because they
tend to be just an alias of existing memory.)

The real answer to all this is to get pfn_valid() working properly in
_every_ case - that'll also solve the problem which Mel Gorman has been
having to fix several times as well.

The question is how best to handle determining if a PFN (which could be
somewhere in the range 0 to 0xfffff for 32-bit address space) is valid
without eating up too much memory.  One simple way would be to allocate
a bitmap.  That'll eat up 128K of memory though, and we know that we
normally have a small amount of that range used...  I think a binary
search of the meminfo struct might be the best all-round solution.

Could you try this patch please?

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 376be1a..cefedf0 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -218,7 +218,6 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
  *
  *  page_to_pfn(page)	convert a struct page * to a PFN number
  *  pfn_to_page(pfn)	convert a _valid_ PFN number to struct page *
- *  pfn_valid(pfn)	indicates whether a PFN number is valid
  *
  *  virt_to_page(k)	convert a _valid_ virtual address to struct page *
  *  virt_addr_valid(k)	indicates whether a virtual address is valid
@@ -227,10 +226,6 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
 
 #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
 
-#ifndef CONFIG_SPARSEMEM
-#define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))
-#endif
-
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 #define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
 
@@ -247,18 +242,6 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
 #define arch_pfn_to_nid(pfn)	PFN_TO_NID(pfn)
 #define arch_local_page_offset(pfn, nid) LOCAL_MAP_NR((pfn) << PAGE_SHIFT)
 
-#define pfn_valid(pfn)						\
-	({							\
-		unsigned int nid = PFN_TO_NID(pfn);		\
-		int valid = nid < MAX_NUMNODES;			\
-		if (valid) {					\
-			pg_data_t *node = NODE_DATA(nid);	\
-			valid = (pfn - node->node_start_pfn) <	\
-				node->node_spanned_pages;	\
-		}						\
-		valid;						\
-	})
-
 #define virt_to_page(kaddr)					\
 	(ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr))
 
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 9c746af..3a32af4 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -194,6 +194,10 @@ typedef unsigned long pgprot_t;
 
 typedef struct page *pgtable_t;
 
+#ifndef CONFIG_SPARSEMEM
+extern int pfn_valid(unsigned long);
+#endif
+
 #include <asm/memory.h>
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 8277802..2542583 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -15,6 +15,7 @@
 #include <linux/mman.h>
 #include <linux/nodemask.h>
 #include <linux/initrd.h>
+#include <linux/sort.h>
 #include <linux/highmem.h>
 
 #include <asm/mach-types.h>
@@ -334,12 +335,42 @@ static void __init bootmem_free_node(int node, struct meminfo *mi)
 	free_area_init_node(node, zone_size, start_pfn, zhole_size);
 }
 
+#ifndef CONFIG_SPARSEMEM
+int pfn_valid(unsigned long pfn)
+{
+	struct meminfo *mi = &meminfo;
+	unsigned int mid, left = 0, right = mi->nr_banks;
+
+	while ((mid = (right - left) / 2) > 0) {
+		struct membank *bank = &mi->bank[mid];
+
+		if (pfn < bank_pfn_start(bank))
+			right = mid;
+		else if (pfn >= bank_pfn_end(bank))
+			left = mid + 1;
+		else
+			return 1;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(pfn_valid);
+#endif
+
+static int __init meminfo_cmp(const void *_a, const void *_b)
+{
+	const struct membank *a = _a, *b = _b;
+	long cmp = bank_pfn_start(b) - bank_pfn_start(a);
+	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
+}
+
 void __init bootmem_init(void)
 {
 	struct meminfo *mi = &meminfo;
 	unsigned long memend_pfn = 0;
 	int node, initrd_node;
 
+	sort(&mi->bank, mi->nr_banks, sizeof(mi->bank[0]), meminfo_cmp, NULL);
+
 	/*
 	 * Locate which node contains the ramdisk image, if any.
 	 */

