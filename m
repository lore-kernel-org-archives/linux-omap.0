From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: n900 in next-20170901
Date: Fri, 15 Sep 2017 15:56:09 +0900
Message-ID: <20170915065608.GA8567@js1304-P5Q-DELUXE>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170907161650.GP5024@atomide.com>
 <20170913075516.GA25036@js1304-P5Q-DELUXE>
 <20170913163126.GS5024@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170913163126.GS5024@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 13, 2017 at 09:31:27AM -0700, Tony Lindgren wrote:
> * Joonsoo Kim <iamjoonsoo.kim@lge.com> [170913 00:54]:
> > On Thu, Sep 07, 2017 at 09:16:51AM -0700, Tony Lindgren wrote:
> > > I doubt that QEMU n900 boots in secure mode but instead shows
> > > the SoC as general purpose SoC. If so, you'd have to patch the
> > > omap3_save_secure_ram_context() to attempt to save secure RAM
> > > context in all cases. If that works then debugging with any
> > > omap3 board like beagleboard in QEMU should work.
> > 
> > Sorry for late response.
> > 
> > I tried to emulate beagle board by using QEMU and now I find the way
> > and it works. However, it doesn't call omap3_save_secure_ram_context()
> > due to different omap_type(). And, even if I call it forcibly, the
> > system dies with prefetch abort regardless of commit 9caf25f996e8.
> 
> OK
> 
> > Could you let me know the better way to test your situation?
> 
> Hmm yeah it seems to always return 0x19 on GP devices at least
> with the following test hack. But maybe that's enough for you
> to still see some differences with your patches.

Hmm... I cannot see any difference with this test hack.
Without 'smc' instruction, r0 should always be 0x19 (#25) and
it's not possible to see any difference.

Anyway, I did various test in my QEMU and I cannot see any difference
with my patches. It seems that I need to ask your help more.

> 
> > Anyway, could you test linux-next with 'CONFIG_HIGHMEM = n'?
> > I'd like to know if the issue is related to the change that
> > all CMA memory is managed like as highmem.
> 
> Yes I disabled CONFIG_HIGHMEM and n900 boots. To disable it,
> you need to remove it from arch/arm/mach-omap2/Kconfig that
> selects it if ARCH_OMAP2PLUS_TYPICAL is selected.

Okay. Problem would be related to address traslation. I'd like to
check address traslation more. Could you apply following patch and
test it? And, please send me the dmesg log and your kernel config.
Please test this with CONFIG_DEBUG_VIRTUAL = n and CONFIG_CMA_DEBUG=y and
CONFIG_HIGHMEM=y and with kernel bootparam 'ignore_loglevel'.

It would be really appreciate if you send me two logs for before/after
commit 9caf25f996e8.

Thanks.


-------------------->8------------------------
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 1f54e4e..545993d 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -220,6 +220,9 @@ extern const void *__pv_table_begin, *__pv_table_end;
 	: "r" (x), "I" (__PV_BITS_31_24)		\
 	: "cc")
 
+extern void __virt_to_phys_debug(unsigned long x, phys_addr_t t);
+extern void __phys_to_virt_debug(phys_addr_t x, unsigned long t);
+
 static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
 {
 	phys_addr_t t;
@@ -230,6 +233,8 @@ static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
 		__pv_stub_mov_hi(t);
 		__pv_add_carry_stub(x, t);
 	}
+
+	__virt_to_phys_debug(x, t);
 	return t;
 }
 
@@ -244,6 +249,8 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 	 * in place where 'r' 32 bit operand is expected.
 	 */
 	__pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
+
+	__phys_to_virt_debug(x, t);
 	return t;
 }
 
@@ -265,8 +272,7 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 #endif
 
 #define virt_to_pfn(kaddr) \
-	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
-	 PHYS_PFN_OFFSET)
+	PHYS_PFN(__virt_to_phys_nodebug((unsigned long)kaddr))
 
 #define __pa_symbol_nodebug(x)	__virt_to_phys_nodebug((x))
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 841ba19..7728535 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -103,6 +103,21 @@ static void omap3_core_restore_context(void)
 	omap_dma_global_context_restore();
 }
 
+static void omap3_print_secure_ram_context(void)
+{
+	int i;
+	int *sram_ctx_api_params;
+
+	sram_ctx_api_params = (int *)_omap_save_secure_sram;
+	sram_ctx_api_params += (save_secure_ram_context_sz / 4);
+	sram_ctx_api_params -= 5;
+
+	for (i = 0; i < 5; i++) {
+		pr_err("save_secure_sram()'s param: %d: 0x%x\n",
+			i, sram_ctx_api_params[i]);
+	}
+}
+
 /*
  * FIXME: This function should be called before entering off-mode after
  * OMAP3 secure services have been accessed. Currently it is only called
@@ -127,6 +142,7 @@ static void omap3_save_secure_ram_context(void)
 		/* Following is for error tracking, it should not happen */
 		if (ret) {
 			pr_err("save_secure_sram() returns %08x\n", ret);
+			omap3_print_secure_ram_context();
 			while (1)
 				;
 		}
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 38f0fde..519c294 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -615,6 +615,9 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 	struct page *page;
 	void *ptr = NULL;
 
+	printk("%s\n", __func__);
+	dump_stack();
+
 	page = dma_alloc_from_contiguous(dev, count, order, gfp);
 	if (!page)
 		return NULL;
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e46a6a4..1793024 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1651,3 +1651,23 @@ void __init early_mm_init(const struct machine_desc *mdesc)
 	build_mem_type_table();
 	early_paging_init(mdesc);
 }
+
+extern bool cma_check_addr(phys_addr_t x);
+
+void __virt_to_phys_debug(unsigned long x, phys_addr_t t)
+{
+	if (!cma_check_addr(t))
+		return;
+
+	printk("CMA_ADDR: %s: 0x%lx to 0x%lx\n", __func__, x, (unsigned long)t);
+	dump_stack();
+}
+
+void __phys_to_virt_debug(phys_addr_t x, unsigned long t)
+{
+	if (!cma_check_addr(x))
+		return;
+
+	printk("CMA_ADDR: %s: 0x%lx to 0x%lx\n", __func__, (unsigned long)x, t);
+	dump_stack();
+}
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a5bc92d..1fc7487 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -57,6 +57,9 @@ void *omap_sram_push_address(unsigned long size)
 	new_ceil = ROUND_DOWN(new_ceil, FNCPY_ALIGN);
 	omap_sram_ceil = IOMEM(new_ceil);
 
+	printk("SRAM_ADDR: %s: 0x%lx - 0x%lx\n",
+		__func__, omap_sram_ceil, omap_sram_ceil + size);
+
 	return (void *)omap_sram_ceil;
 }
 
@@ -89,6 +92,11 @@ void __init omap_map_sram(unsigned long start, unsigned long size,
 
 	omap_sram_reset();
 
+	printk("SRAM_ADDR: %s: P: 0x%lx - 0x%lx\n",
+		__func__, start, start + size);
+	printk("SRAM_ADDR: %s: V: 0x%lx - 0x%lx\n",
+		__func__, omap_sram_base, omap_sram_base + size);
+
 	/*
 	 * Looks like we need to preserve some bootloader code at the
 	 * beginning of SRAM for jumping to flash for reboot to work...
diff --git a/mm/cma.c b/mm/cma.c
index a8ababb..33a0455 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -577,3 +577,21 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 
 	return 0;
 }
+
+bool cma_check_addr(phys_addr_t x)
+{
+	int i;
+	struct cma *cma;
+	phys_addr_t s, e;
+
+	for (i = 0; i < cma_area_count; i++) {
+		cma = &cma_areas[i];
+		s = cma_get_base(cma);
+		e = s + cma_get_size(cma);
+
+		if (s <= x && x < e)
+			return true;
+	}
+
+	return false;
+}
