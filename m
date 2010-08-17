From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: Allow optional UP processor functions for SMP kernels
Date: Tue, 17 Aug 2010 13:53:25 +0300
Message-ID: <20100817105325.19061.93324.stgit@baageli.muru.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59396 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab0HQKxV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 06:53:21 -0400
In-Reply-To: <20100817104414.19061.38999.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, bryan.wu@canonical.com

Attempt to detect if the hardware is UP hardware, and use the optional
UP specific processors functions in struct proc_info_list if available.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/procinfo.h |    6 +++++
 arch/arm/include/asm/smp_plat.h |    9 ++++++++
 arch/arm/kernel/setup.c         |   45 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/mmu.c               |   20 ++++++++++-------
 4 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/procinfo.h b/arch/arm/include/asm/procinfo.h
index ca52e58..962d01e 100644
--- a/arch/arm/include/asm/procinfo.h
+++ b/arch/arm/include/asm/procinfo.h
@@ -40,6 +40,12 @@ struct proc_info_list {
 	struct cpu_tlb_fns	*tlb;
 	struct cpu_user_fns	*user;
 	struct cpu_cache_fns	*cache;
+
+#ifdef CONFIG_SMP_ON_UP
+	struct processor	*proc_up;
+	struct cpu_tlb_fns	*tlb_up;
+	struct cpu_cache_fns	*cache_up;
+#endif
 };
 
 #else	/* __KERNEL__ */
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index e621530..1c2f587 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -18,4 +18,13 @@ static inline int cache_ops_need_broadcast(void)
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
 }
 
+#ifdef CONFIG_SMP_ON_UP
+extern int smp_on_up(void);
+#else
+static inline int smp_on_up(void)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d5231ae..5f3606c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -289,6 +289,50 @@ static void __init feat_v6_fixup(void)
 		elf_hwcap &= ~HWCAP_TLS;
 }
 
+#ifdef CONFIG_SMP_ON_UP
+
+static int _smp_on_up;
+
+int smp_on_up(void)
+{
+	return _smp_on_up;
+}
+
+static void __init smp_on_up_fixup(struct proc_info_list *list)
+{
+	int id;
+
+	id = read_cpuid_id() & 0xff0f0000;
+	if ((id == 0x41070000) || (id == 0x410f0000)) {
+		int mpidr;
+
+		asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
+		mpidr >>= 30;
+
+		/* SMP hardware? */
+		if (!((mpidr == 0) || (mpidr == 3)))
+			return;
+	}
+
+	_smp_on_up = 1;
+
+	pr_info("CPU: SMP kernel on UP hardware\n");
+
+	if (list->proc_up)
+		processor = *list->proc_up;
+
+	if (list->tlb_up)
+		cpu_tlb = *list->tlb_up;
+
+	if (list->cache_up)
+		cpu_cache = *list->cache_up;
+}
+#else
+static inline void smp_on_up_fixup(struct proc_info_list *list)
+{
+}
+#endif
+
 static void __init setup_processor(void)
 {
 	struct proc_info_list *list;
@@ -331,6 +375,7 @@ static void __init setup_processor(void)
 	elf_hwcap &= ~HWCAP_THUMB;
 #endif
 
+	smp_on_up_fixup(list);
 	feat_v6_fixup();
 
 	cacheid_init();
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6e1c4f6..f320901 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -430,15 +430,17 @@ static void __init build_mem_type_table(void)
 		/*
 		 * Mark memory with the "shared" attribute for SMP systems
 		 */
-		user_pgprot |= L_PTE_SHARED;
-		kern_pgprot |= L_PTE_SHARED;
-		vecs_pgprot |= L_PTE_SHARED;
-		mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
-		mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
-		mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
-		mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
-		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
-		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
+		if (!smp_on_up()) {
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
 #endif
 	}
 

