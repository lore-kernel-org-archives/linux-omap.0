From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: kmemleak: Cannot insert 0xff7f1000 into the object search tree
 (overlaps existing)
Date: Fri, 12 Aug 2016 11:04:48 +0100
Message-ID: <20160812100447.GD12939@e104818-lin.cambridge.arm.com>
References: <7f50c137-5c6a-0882-3704-ae9bb7552c30@ti.com>
 <20160811155423.GC18366@e104818-lin.cambridge.arm.com>
 <920709c7-2d5b-ea67-5f1c-4197ef30e3b2@ti.com>
 <20160811170812.GF18366@e104818-lin.cambridge.arm.com>
 <e3495507-abf9-8df6-057d-32016bd4f221@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <e3495507-abf9-8df6-057d-32016bd4f221@ti.com>
Sender: owner-linux-mm@kvack.org
To: Vignesh R <vigneshr@ti.com>
Cc: "Strashko, Grygorii" <grygorii.strashko@ti.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 12, 2016 at 09:45:05AM +0530, Vignesh R wrote:
> On Thursday 11 August 2016 10:38 PM, Catalin Marinas wrote:
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 483197ef613f..7d3361d53ac2 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -723,7 +723,8 @@ int __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
> >  		     (unsigned long long)base + size - 1,
> >  		     (void *)_RET_IP_);
> >  
> > -	kmemleak_free_part(__va(base), size);
> > +	if (base < __pa(high_memory))
> > +		kmemleak_free_part(__va(base), size);
> >  	return memblock_remove_range(&memblock.reserved, base, size);
> >  }
> >  
> > @@ -1152,7 +1153,8 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >  		 * The min_count is set to 0 so that memblock allocations are
> >  		 * never reported as leaks.
> >  		 */
> > -		kmemleak_alloc(__va(found), size, 0, 0);
> > +		if (found < __pa(high_memory))
> > +			kmemleak_alloc(__va(found), size, 0, 0);
> >  		return found;
> >  	}
> >  	return 0;
> > @@ -1399,7 +1401,8 @@ void __init __memblock_free_early(phys_addr_t base, phys_addr_t size)
> >  	memblock_dbg("%s: [%#016llx-%#016llx] %pF\n",
> >  		     __func__, (u64)base, (u64)base + size - 1,
> >  		     (void *)_RET_IP_);
> > -	kmemleak_free_part(__va(base), size);
> > +	if (base < __pa(high_memory))
> > +		kmemleak_free_part(__va(base), size);
> >  	memblock_remove_range(&memblock.reserved, base, size);
> >  }
> >  
> > @@ -1419,7 +1422,8 @@ void __init __memblock_free_late(phys_addr_t base, phys_addr_t size)
> >  	memblock_dbg("%s: [%#016llx-%#016llx] %pF\n",
> >  		     __func__, (u64)base, (u64)base + size - 1,
> >  		     (void *)_RET_IP_);
> > -	kmemleak_free_part(__va(base), size);
> > +	if (base < __pa(high_memory))
> > +		kmemleak_free_part(__va(base), size);
> >  	cursor = PFN_UP(base);
> >  	end = PFN_DOWN(base + size);
> 
> With above change on 4.8-rc1, I see a different warning from kmemleak:
> 
> [    0.002918] kmemleak: Trying to color unknown object at 0xfe800000 as
> Black
> [    0.002943] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 4.8.0-rc1-00121-g4b9eaf33d83d-dirty #59
> [    0.002955] Hardware name: Generic AM33XX (Flattened Device Tree)
> [    0.003000] [<c01100fc>] (unwind_backtrace) from [<c010c264>] (show_stack+0x10/0x14)
> [    0.003027] [<c010c264>] (show_stack) from [<c049040c>] (dump_stack+0xac/0xe0)
> [    0.003052] [<c049040c>] (dump_stack) from [<c02971c0>] (paint_ptr+0x78/0x9c)
> [    0.003074] [<c02971c0>] (paint_ptr) from [<c0b25e20>] (kmemleak_init+0x1cc/0x284)
> [    0.003104] [<c0b25e20>] (kmemleak_init) from [<c0b00bc0>] (start_kernel+0x2d8/0x3b4)
> [    0.003122] [<c0b00bc0>] (start_kernel) from [<8000807c>] (0x8000807c)
> [    0.003133] kmemleak: Early log backtrace:
> [    0.003146]    [<c0b3c9cc>] dma_contiguous_reserve+0x80/0x94
> [    0.003170]    [<c0b06810>] arm_memblock_init+0x130/0x184
> [    0.003191]    [<c0b04210>] setup_arch+0x58c/0xc00
> [    0.003208]    [<c0b00940>] start_kernel+0x58/0x3b4
> [    0.003224]    [<8000807c>] 0x8000807c
> [    0.003239]    [<ffffffff>] 0xffffffff

That's because I missed the CMA kmemleak call:

diff --git a/mm/cma.c b/mm/cma.c
index bd0e1412475e..7c0ef3037415 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -336,7 +336,8 @@ int __init cma_declare_contiguous(phys_addr_t base,
 		 * kmemleak scans/reads tracked objects for pointers to other
 		 * objects but this address isn't mapped and accessible
 		 */
-		kmemleak_ignore(phys_to_virt(addr));
+		if (addr < __pa(high_memory))
+			kmemleak_ignore(phys_to_virt(addr));
 		base = addr;
 	}
 

Anyway, a better workaround is to add kmemleak_*_phys() static inline
functions and do the __pa(high_memory) check in there:

-----------------8<---------------------------
>From b8b9141fffc1fd3c73583c1fd50a724c4a6452e1 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 12 Aug 2016 10:43:06 +0100
Subject: [PATCH] mm: kmemleak: Avoid using __va() on addresses that don't have
 a lowmem mapping

Some of the kmemleak_*() callbacks in memblock, bootmem, CMA convert a
physical address to a virtual one using __va(). However, such physical
addresses may sometimes be located in highmem and using __va() is
incorrect, leading to inconsistent object tracking in kmemleak.

The following functions have been added to the kmemleak API and they
take a physical address as the object pointer. They only perform the
corresponding action if the address has a lowmem mapping:

kmemleak_alloc_phys
kmemleak_free_part_phys
kmemleak_not_leak_phys
kmemleak_ignore_phys

The affected calling placess have been updated to use the new kmemleak
API.

Reported-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/kmemleak.txt |  9 +++++++++
 include/linux/kmemleak.h   | 26 ++++++++++++++++++++++++++
 mm/bootmem.c               |  6 +++---
 mm/cma.c                   |  2 +-
 mm/memblock.c              |  8 ++++----
 mm/nobootmem.c             |  2 +-
 6 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/Documentation/kmemleak.txt b/Documentation/kmemleak.txt
index 18e24abb3ecf..35e1a8891e3a 100644
--- a/Documentation/kmemleak.txt
+++ b/Documentation/kmemleak.txt
@@ -155,6 +155,15 @@ kmemleak_erase		 - erase an old value in a pointer variable
 kmemleak_alloc_recursive - as kmemleak_alloc but checks the recursiveness
 kmemleak_free_recursive	 - as kmemleak_free but checks the recursiveness
 
+The following functions take a physical address as the object pointer
+and only perform the corresponding action if the address has a lowmem
+mapping:
+
+kmemleak_alloc_phys
+kmemleak_free_part_phys
+kmemleak_not_leak_phys
+kmemleak_ignore_phys
+
 Dealing with false positives/negatives
 --------------------------------------
 
diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index 4894c6888bc6..380f72bc3657 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -21,6 +21,7 @@
 #ifndef __KMEMLEAK_H
 #define __KMEMLEAK_H
 
+#include <linux/mm.h>
 #include <linux/slab.h>
 
 #ifdef CONFIG_DEBUG_KMEMLEAK
@@ -109,4 +110,29 @@ static inline void kmemleak_no_scan(const void *ptr)
 
 #endif	/* CONFIG_DEBUG_KMEMLEAK */
 
+static inline void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
+				       int min_count, gfp_t gfp)
+{
+	if (!IS_ENABLED(CONFIG_HIGHMEM) || phys < __pa(high_memory))
+		kmemleak_alloc(__va(phys), size, min_count, gfp);
+}
+
+static inline void kmemleak_free_part_phys(phys_addr_t phys, size_t size)
+{
+	if (!IS_ENABLED(CONFIG_HIGHMEM) || phys < __pa(high_memory))
+		kmemleak_free_part(__va(phys), size);
+}
+
+static inline void kmemleak_not_leak_phys(phys_addr_t phys)
+{
+	if (!IS_ENABLED(CONFIG_HIGHMEM) || phys < __pa(high_memory))
+		kmemleak_not_leak(__va(phys));
+}
+
+static inline void kmemleak_ignore_phys(phys_addr_t phys)
+{
+	if (!IS_ENABLED(CONFIG_HIGHMEM) || phys < __pa(high_memory))
+		kmemleak_ignore(__va(phys));
+}
+
 #endif	/* __KMEMLEAK_H */
diff --git a/mm/bootmem.c b/mm/bootmem.c
index 0aa7dda52402..80f1d70bad2d 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -158,7 +158,7 @@ void __init free_bootmem_late(unsigned long physaddr, unsigned long size)
 {
 	unsigned long cursor, end;
 
-	kmemleak_free_part(__va(physaddr), size);
+	kmemleak_free_part_phys(physaddr, size);
 
 	cursor = PFN_UP(physaddr);
 	end = PFN_DOWN(physaddr + size);
@@ -402,7 +402,7 @@ void __init free_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
 {
 	unsigned long start, end;
 
-	kmemleak_free_part(__va(physaddr), size);
+	kmemleak_free_part_phys(physaddr, size);
 
 	start = PFN_UP(physaddr);
 	end = PFN_DOWN(physaddr + size);
@@ -423,7 +423,7 @@ void __init free_bootmem(unsigned long physaddr, unsigned long size)
 {
 	unsigned long start, end;
 
-	kmemleak_free_part(__va(physaddr), size);
+	kmemleak_free_part_phys(physaddr, size);
 
 	start = PFN_UP(physaddr);
 	end = PFN_DOWN(physaddr + size);
diff --git a/mm/cma.c b/mm/cma.c
index bd0e1412475e..384c2cb51b56 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -336,7 +336,7 @@ int __init cma_declare_contiguous(phys_addr_t base,
 		 * kmemleak scans/reads tracked objects for pointers to other
 		 * objects but this address isn't mapped and accessible
 		 */
-		kmemleak_ignore(phys_to_virt(addr));
+		kmemleak_ignore_phys(addr);
 		base = addr;
 	}
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 483197ef613f..30ecea7b45d1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -723,7 +723,7 @@ int __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
 		     (unsigned long long)base + size - 1,
 		     (void *)_RET_IP_);
 
-	kmemleak_free_part(__va(base), size);
+	kmemleak_free_part_phys(base, size);
 	return memblock_remove_range(&memblock.reserved, base, size);
 }
 
@@ -1152,7 +1152,7 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 		 * The min_count is set to 0 so that memblock allocations are
 		 * never reported as leaks.
 		 */
-		kmemleak_alloc(__va(found), size, 0, 0);
+		kmemleak_alloc_phys(found, size, 0, 0);
 		return found;
 	}
 	return 0;
@@ -1399,7 +1399,7 @@ void __init __memblock_free_early(phys_addr_t base, phys_addr_t size)
 	memblock_dbg("%s: [%#016llx-%#016llx] %pF\n",
 		     __func__, (u64)base, (u64)base + size - 1,
 		     (void *)_RET_IP_);
-	kmemleak_free_part(__va(base), size);
+	kmemleak_free_part_phys(base, size);
 	memblock_remove_range(&memblock.reserved, base, size);
 }
 
@@ -1419,7 +1419,7 @@ void __init __memblock_free_late(phys_addr_t base, phys_addr_t size)
 	memblock_dbg("%s: [%#016llx-%#016llx] %pF\n",
 		     __func__, (u64)base, (u64)base + size - 1,
 		     (void *)_RET_IP_);
-	kmemleak_free_part(__va(base), size);
+	kmemleak_free_part_phys(base, size);
 	cursor = PFN_UP(base);
 	end = PFN_DOWN(base + size);
 
diff --git a/mm/nobootmem.c b/mm/nobootmem.c
index bd05a70f44b9..a056d31dff7e 100644
--- a/mm/nobootmem.c
+++ b/mm/nobootmem.c
@@ -81,7 +81,7 @@ void __init free_bootmem_late(unsigned long addr, unsigned long size)
 {
 	unsigned long cursor, end;
 
-	kmemleak_free_part(__va(addr), size);
+	kmemleak_free_part_phys(addr, size);
 
 	cursor = PFN_UP(addr);
 	end = PFN_DOWN(addr + size);

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
