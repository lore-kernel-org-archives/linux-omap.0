From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 02/25] ARM: pm: arrange for cpu_proc_init() to be called on
 resume
Date: Thu, 23 Jun 2011 20:09:42 +0100
Message-ID: <E1QZpHa-0005lk-Kn@rmk-PC.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

cpu_proc_init() does processor specific initialization, which we do
at boot time.  We have been omitting to do this on resume, which
causes some of this initialization to be skipped.  We've also been
skipping this on SMP initialization too.

Ensure that cpu_proc_init() is always called appropriately by
moving it into cpu_init(), and move cpu_init() to a more appropriate
point in the boot initialization.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c   |   99 +++++++++++++++++++++++----------------------
 arch/arm/mm/proc-sa1100.S |    4 +-
 2 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ed11fb0..edcab02 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -342,54 +342,6 @@ static void __init feat_v6_fixup(void)
 		elf_hwcap &= ~HWCAP_TLS;
 }
 
-static void __init setup_processor(void)
-{
-	struct proc_info_list *list;
-
-	/*
-	 * locate processor in the list of supported processor
-	 * types.  The linker builds this table for us from the
-	 * entries in arch/arm/mm/proc-*.S
-	 */
-	list = lookup_processor_type(read_cpuid_id());
-	if (!list) {
-		printk("CPU configuration botched (ID %08x), unable "
-		       "to continue.\n", read_cpuid_id());
-		while (1);
-	}
-
-	cpu_name = list->cpu_name;
-
-#ifdef MULTI_CPU
-	processor = *list->proc;
-#endif
-#ifdef MULTI_TLB
-	cpu_tlb = *list->tlb;
-#endif
-#ifdef MULTI_USER
-	cpu_user = *list->user;
-#endif
-#ifdef MULTI_CACHE
-	cpu_cache = *list->cache;
-#endif
-
-	printk("CPU: %s [%08x] revision %d (ARMv%s), cr=%08lx\n",
-	       cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
-	       proc_arch[cpu_architecture()], cr_alignment);
-
-	sprintf(init_utsname()->machine, "%s%c", list->arch_name, ENDIANNESS);
-	sprintf(elf_platform, "%s%c", list->elf_name, ENDIANNESS);
-	elf_hwcap = list->elf_hwcap;
-#ifndef CONFIG_ARM_THUMB
-	elf_hwcap &= ~HWCAP_THUMB;
-#endif
-
-	feat_v6_fixup();
-
-	cacheid_init();
-	cpu_proc_init();
-}
-
 /*
  * cpu_init - initialise one CPU.
  *
@@ -405,6 +357,8 @@ void cpu_init(void)
 		BUG();
 	}
 
+	cpu_proc_init();
+
 	/*
 	 * Define the placement constraint for the inline asm directive below.
 	 * In Thumb-2, msr with an immediate value is not allowed.
@@ -441,6 +395,54 @@ void cpu_init(void)
 	    : "r14");
 }
 
+static void __init setup_processor(void)
+{
+	struct proc_info_list *list;
+
+	/*
+	 * locate processor in the list of supported processor
+	 * types.  The linker builds this table for us from the
+	 * entries in arch/arm/mm/proc-*.S
+	 */
+	list = lookup_processor_type(read_cpuid_id());
+	if (!list) {
+		printk("CPU configuration botched (ID %08x), unable "
+		       "to continue.\n", read_cpuid_id());
+		while (1);
+	}
+
+	cpu_name = list->cpu_name;
+
+#ifdef MULTI_CPU
+	processor = *list->proc;
+#endif
+#ifdef MULTI_TLB
+	cpu_tlb = *list->tlb;
+#endif
+#ifdef MULTI_USER
+	cpu_user = *list->user;
+#endif
+#ifdef MULTI_CACHE
+	cpu_cache = *list->cache;
+#endif
+
+	printk("CPU: %s [%08x] revision %d (ARMv%s), cr=%08lx\n",
+	       cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
+	       proc_arch[cpu_architecture()], cr_alignment);
+
+	sprintf(init_utsname()->machine, "%s%c", list->arch_name, ENDIANNESS);
+	sprintf(elf_platform, "%s%c", list->elf_name, ENDIANNESS);
+	elf_hwcap = list->elf_hwcap;
+#ifndef CONFIG_ARM_THUMB
+	elf_hwcap &= ~HWCAP_THUMB;
+#endif
+
+	feat_v6_fixup();
+
+	cacheid_init();
+	cpu_init();
+}
+
 void __init dump_machine_table(void)
 {
 	struct machine_desc *p;
@@ -913,7 +915,6 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	reserve_crashkernel();
 
-	cpu_init();
 	tcm_init();
 
 #ifdef CONFIG_MULTI_IRQ_HANDLER
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 184a9c9..e9c4727 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -34,7 +34,7 @@
  */
 #define DCACHELINESIZE	32
 
-	__INIT
+	.section .text
 
 /*
  * cpu_sa1100_proc_init()
@@ -45,8 +45,6 @@ ENTRY(cpu_sa1100_proc_init)
 	mcr	p15, 0, r0, c9, c0, 5		@ Allow read-buffer operations from userland
 	mov	pc, lr
 
-	.section .text
-
 /*
  * cpu_sa1100_proc_fin()
  *
-- 
1.7.4.4
