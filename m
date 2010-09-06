From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Mon, 6 Sep 2010 11:06:32 +0100
Message-ID: <20100906100632.GC20903@n2100.arm.linux.org.uk>
References: <4C6CFBAF.6020407@canonical.com> <20100819095705.GU12184@atomide.com> <20100819102025.GA32151@n2100.arm.linux.org.uk> <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com> <20100902133637.GJ26319@n2100.arm.linux.org.uk> <20100902161659.GJ11597@atomide.com> <1283765333.1926.2.camel@e102109-lin.cambridge.arm.com> <20100906093424.GB20903@n2100.arm.linux.org.uk> <1283765910.1926.4.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34328 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab0IFKGq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 06:06:46 -0400
Content-Disposition: inline
In-Reply-To: <1283765910.1926.4.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>

On Mon, Sep 06, 2010 at 10:38:30AM +0100, Catalin Marinas wrote:
> On Mon, 2010-09-06 at 10:34 +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 06, 2010 at 10:28:53AM +0100, Catalin Marinas wrote:
> > > I haven't followed your patches closely but can we restrict the ARMv6
> > > SMP/UP support to only those cores that have TEX remapping (most of them
> > > probably)?
> > 
> > We don't support TEX remapping on ARMv6.
> 
> I know but it's easy to enable if useful for the SMP/UP v6/v7
> combination (with some restrictions).

It'll make proc-v6.S much more complicated than it already is, requiring
it to carry both the non-remap and remapping code selected via an ifdef.

Is it worth it?  For the sake of one conditional in mmu.c, I don't think
so - and the view is that using TEX remapping to get rid of the shared
bit is a horrible hack anyway.

In any case, it's unnecessary.  We can use my word-replacement to modify
a variable to indicate whether we're running on SMP or not, and so have
the test for SMP-on-UP in just one place.  Like this:

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index e621530..7de5aa5 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -18,4 +18,19 @@ static inline int cache_ops_need_broadcast(void)
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
 }
 
+/*
+ * Return true if we are running on a SMP platform
+ */
+static inline bool is_smp(void)
+{
+#ifndef CONFIG_SMP
+	return false;
+#elif defined(CONFIG_SMP_ON_UP)
+	extern unsigned int smp_on_up;
+	return !!smp_on_up;
+#else
+	return true;
+#endif
+}
+
 #endif
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 26ec521..360bf06 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -343,7 +343,7 @@ __fixup_smp:
 	orr	r7, r7, #0x41000000	@ val 0x41070000
 	and	r0, r9, r6
 	teq	r0, r7			@ ARM CPU and ARMv6/v7?
-	bne	smp_on_up		@ no, assume UP
+	bne	fixup_smp_on_up		@ no, assume UP
 
 	orr	r6, r6, #0x0000ff00
 	orr	r6, r6, #0x000000f0	@ mask 0xff07fff0
@@ -357,7 +357,7 @@ __fixup_smp:
 	tst	r0, #1 << 31
 	movne	pc, lr			@ bit 31 => SMP
 
-smp_on_up:
+fixup_smp_on_up:
 	adr	r0, 1f
 	ldmia	r0, {r3, r6, r7}
 	sub	r3, r0, r3
@@ -373,6 +373,14 @@ ENDPROC(__fixup_smp)
 1:	.word	.
 	.word	__smpalt_begin
 	.word	__smpalt_end
+
+	.pushsection .data
+	.globl	smp_on_up
+smp_on_up:
+	SMP(.long	1)
+	UP(.long	0)
+	.popsection
+
 #endif
 
 #include "head-common.S"
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d5231ae..fe94467 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -36,6 +36,7 @@
 #include <asm/procinfo.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
+#include <asm/smp_plat.h>
 #include <asm/mach-types.h>
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
@@ -824,9 +825,8 @@ void __init setup_arch(char **cmdline_p)
 	paging_init(mdesc);
 	request_standard_resources(&meminfo, mdesc);
 
-#ifdef CONFIG_SMP
-	smp_init_cpus();
-#endif
+	if (is_smp())
+		smp_init_cpus();
 	reserve_crashkernel();
 
 	cpu_init();
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6e1c4f6..a789320 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -303,9 +303,8 @@ static void __init build_mem_type_table(void)
 			cachepolicy = CPOLICY_WRITEBACK;
 		ecc_mask = 0;
 	}
-#ifdef CONFIG_SMP
-	cachepolicy = CPOLICY_WRITEALLOC;
-#endif
+	if (is_smp())
+		cachepolicy = CPOLICY_WRITEALLOC;
 
 	/*
 	 * Strip out features not present on earlier architectures.
@@ -399,13 +398,11 @@ static void __init build_mem_type_table(void)
 	cp = &cache_policies[cachepolicy];
 	vecs_pgprot = kern_pgprot = user_pgprot = cp->pte;
 
-#ifndef CONFIG_SMP
 	/*
 	 * Only use write-through for non-SMP systems
 	 */
-	if (cpu_arch >= CPU_ARCH_ARMv5 && cachepolicy > CPOLICY_WRITETHROUGH)
+	if (!is_smp() && cpu_arch >= CPU_ARCH_ARMv5 && cachepolicy > CPOLICY_WRITETHROUGH)
 		vecs_pgprot = cache_policies[CPOLICY_WRITETHROUGH].pte;
-#endif
 
 	/*
 	 * Enable CPU-specific coherency if supported.
@@ -426,20 +423,21 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_MINICLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 
-#ifdef CONFIG_SMP
-		/*
-		 * Mark memory with the "shared" attribute for SMP systems
-		 */
-		user_pgprot |= L_PTE_SHARED;
-		kern_pgprot |= L_PTE_SHARED;
-		vecs_pgprot |= L_PTE_SHARED;
-		mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
-		mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
-		mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
-		mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
-		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
-		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
-#endif
+		if (is_smp()) {
+			/*
+			 * Mark memory with the "shared" attribute
+			 * for SMP systems
+			 */
+			user_pgprot |= L_PTE_SHARED;
+			kern_pgprot |= L_PTE_SHARED;
+			vecs_pgprot |= L_PTE_SHARED;
+			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
+			mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
+			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
+			mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
+			mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
+			mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
+		}
 	}
 
 	/*
@@ -802,8 +800,7 @@ static void __init sanity_check_meminfo(void)
 			 * rather difficult.
 			 */
 			reason = "with VIPT aliasing cache";
-#ifdef CONFIG_SMP
-		} else if (tlb_ops_need_broadcast()) {
+		} else if (is_smp() && tlb_ops_need_broadcast()) {
 			/*
 			 * kmap_high needs to occasionally flush TLB entries,
 			 * however, if the TLB entries need to be broadcast
@@ -813,7 +810,6 @@ static void __init sanity_check_meminfo(void)
 			 *   (must not be called with irqs off)
 			 */
 			reason = "without hardware TLB ops broadcasting";
-#endif
 		}
 		if (reason) {
 			printk(KERN_CRIT "HIGHMEM is not supported %s, ignoring high memory\n",

