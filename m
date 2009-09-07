From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Mon, 7 Sep 2009 15:22:10 +0100
Message-ID: <20090907142210.GB23361@n2100.arm.linux.org.uk>
References: <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com> <20090815153357.GF29616@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C65ED@dbde02.ent.ti.com> <20090815181711.GG29616@n2100.arm.linux.org.uk> <20090817173343.GA17323@debian> <20090817174718.GU10764@n2100.arm.linux.org.uk> <20090817180145.GA17378@debian> <20090817180455.GW10764@n2100.arm.linux.org.uk> <A24693684029E5489D1D202277BE89444A8201BE@dlee02.ent.ti.com> <20090818030148.GA2283@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59668 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbZIGOXS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 10:23:18 -0400
Content-Disposition: inline
In-Reply-To: <20090818030148.GA2283@debian>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Aug 18, 2009 at 08:31:49AM +0530, Rabin Vincent wrote:
> Here's a fixed version:

And here's my revised version with these fixes in.  I changed the
while loop to a do..while loop instead (since we will always have
at least one memory bank, it's pointless doing that test for the
first iteration.)

Acks and tested-bys would be useful please.

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
@@ -334,12 +335,43 @@ static void __init bootmem_free_node(int node, struct meminfo *mi)
 	free_area_init_node(node, zone_size, start_pfn, zhole_size);
 }
 
+#ifndef CONFIG_SPARSEMEM
+int pfn_valid(unsigned long pfn)
+{
+	struct meminfo *mi = &meminfo;
+	unsigned int left = 0, right = mi->nr_banks;
+
+	do {
+		unsigned int mid = (right + left) / 2;
+		struct membank *bank = &mi->bank[mid];
+
+		if (pfn < bank_pfn_start(bank))
+			right = mid;
+		else if (pfn >= bank_pfn_end(bank))
+			left = mid + 1;
+		else
+			return 1;
+	} while (left < right);
+	return 0;
+}
+EXPORT_SYMBOL(pfn_valid);
+#endif
+
+static int __init meminfo_cmp(const void *_a, const void *_b)
+{
+	const struct membank *a = _a, *b = _b;
+	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
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
