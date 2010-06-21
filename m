From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check
	for it on V6
Date: Mon, 21 Jun 2010 16:51:20 +0300
Message-ID: <20100621135120.24299.98499.stgit@baageli.muru.com>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62695 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438Ab0FUNvJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 09:51:09 -0400
In-Reply-To: <20100621133749.24299.36154.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

The TLS register is only available on ARM1136 r1p0 and later.
Set HWCAP_TLS flags if hardware TLS is available.

Note that we now use 0xffff0ff4 for flagging software TLS to
__kuser_get_tls, and 0xffff0ff8 for storing the software TLS value.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/hwcap.h |    1 +
 arch/arm/kernel/entry-armv.S |   29 ++++++++++++++---------------
 arch/arm/kernel/setup.c      |   20 ++++++++++++++++++++
 arch/arm/kernel/traps.c      |   23 +++++++++++++----------
 arch/arm/mm/Kconfig          |   11 -----------
 arch/arm/mm/proc-v6.S        |    6 ++++--
 arch/arm/mm/proc-v7.S        |    2 +-
 7 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/arch/arm/include/asm/hwcap.h b/arch/arm/include/asm/hwcap.h
index f7bd52b..c1062c3 100644
--- a/arch/arm/include/asm/hwcap.h
+++ b/arch/arm/include/asm/hwcap.h
@@ -19,6 +19,7 @@
 #define HWCAP_NEON	4096
 #define HWCAP_VFPv3	8192
 #define HWCAP_VFPv3D16	16384
+#define HWCAP_TLS	32768
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 /*
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 7ee48e7..9de5357 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -739,11 +739,14 @@ ENTRY(__switch_to)
 #ifdef CONFIG_MMU
 	ldr	r6, [r2, #TI_CPU_DOMAIN]
 #endif
-#if defined(CONFIG_HAS_TLS_REG)
-	mcr	p15, 0, r3, c13, c0, 3		@ set TLS register
-#elif !defined(CONFIG_TLS_REG_EMUL)
-	mov	r4, #0xffff0fff
-	str	r3, [r4, #-15]			@ TLS val at 0xffff0ff0
+#if !defined(CONFIG_TLS_REG_EMUL)
+	ldr	r4, =elf_hwcap
+	ldr	r4, [r4, #0]
+	mov	r5, #0xffff0fff
+	tst	r4, #HWCAP_TLS			@ hardware TLS available?
+	mcrne	p15, 0, r3, c13, c0, 3		@ yes, set TLS register
+	streq	r5, [r5, #-11]			@ flag software TLS at 0xffff0ff4
+	streq	r3, [r5, #-7]			@ set TLS value at 0xffff0ff8
 #endif
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
@@ -1009,17 +1012,13 @@ kuser_cmpxchg_fixup:
  */
 
 __kuser_get_tls:				@ 0xffff0fe0
-
-#if !defined(CONFIG_HAS_TLS_REG) && !defined(CONFIG_TLS_REG_EMUL)
-	ldr	r0, [pc, #(16 - 8)]		@ TLS stored at 0xffff0ff0
-#else
-	mrc	p15, 0, r0, c13, c0, 3		@ read TLS register
-#endif
+	ldr     r0, [pc, #(20 - 8)]		@ software TLS set in 0xffff0ff4?
+	cmp	r0, #0				@ hardware TLS if flag not set
+	mrceq	p15, 0, r0, c13, c0, 3		@ read hardware TLS register
+	ldrne	r0, [pc, #(12 - 8)]		@ software TLS val at 0xffff0ff8
 	usr_ret	lr
-
-	.rep	5
-	.word	0			@ pad up to __kuser_helper_version
-	.endr
+	.word	0				@ non-zero for software TLS
+	.word	0				@ software TLS value
 
 /*
  * Reference declaration:
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 122d999..fcfa9c2 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -269,6 +269,24 @@ static void __init cacheid_init(void)
 extern struct proc_info_list *lookup_processor_type(unsigned int);
 extern struct machine_desc *lookup_machine_type(unsigned int);
 
+#ifdef CONFIG_CPU_V6
+static void __init feat_v6_fixup(void)
+{
+	int id = read_cpuid_id();
+
+	if (id & 0x000f0000 != 0x00070000)
+		return;
+
+	/* HWCAP_TLS is available only on V6 r1p0 and later */
+	if (((id >> 20) & 3) == 0)
+		elf_hwcap &= ~HWCAP_TLS;
+}
+#else
+static inline void feat_v6_fixup(void)
+{
+}
+#endif
+
 static void __init setup_processor(void)
 {
 	struct proc_info_list *list;
@@ -311,6 +329,8 @@ static void __init setup_processor(void)
 	elf_hwcap &= ~HWCAP_THUMB;
 #endif
 
+	feat_v6_fixup();
+
 	cacheid_init();
 	cpu_proc_init();
 }
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1621e53..3dd72b7 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -518,16 +518,19 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 
 	case NR(set_tls):
 		thread->tp_value = regs->ARM_r0;
-#if defined(CONFIG_HAS_TLS_REG)
-		asm ("mcr p15, 0, %0, c13, c0, 3" : : "r" (regs->ARM_r0) );
-#elif !defined(CONFIG_TLS_REG_EMUL)
-		/*
-		 * User space must never try to access this directly.
-		 * Expect your app to break eventually if you do so.
-		 * The user helper at 0xffff0fe0 must be used instead.
-		 * (see entry-armv.S for details)
-		 */
-		*((unsigned int *)0xffff0ff0) = regs->ARM_r0;
+#if !defined(CONFIG_TLS_REG_EMUL)
+		if (elf_hwcap & HWCAP_TLS) {
+			asm ("mcr p15, 0, %0, c13, c0, 3"
+				: : "r" (regs->ARM_r0));
+		} else {
+			/*
+			 * User space must never try to access this directly.
+			 * Expect your app to break eventually if you do so.
+			 * The user helper at 0xffff0fe0 must be used instead.
+			 * (see entry-armv.S for details)
+			 */
+			*((unsigned int *)0xffff0ff8) = regs->ARM_r0;
+		}
 #endif
 		return 0;
 
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 346ae14..71d5d5e 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -717,17 +717,6 @@ config TLS_REG_EMUL
 	  a few prototypes like that in existence) and therefore access to
 	  that required register must be emulated.
 
-config HAS_TLS_REG
-	bool
-	depends on !TLS_REG_EMUL
-	default y if SMP || CPU_32v7
-	help
-	  This selects support for the CP15 thread register.
-	  It is defined to be available on some ARMv6 processors (including
-	  all SMP capable ARMv6's) or later processors.  User space may
-	  assume directly accessing that register and always obtain the
-	  expected value only on ARMv7 and above.
-
 config NEEDS_SYSCALL_FOR_CMPXCHG
 	bool
 	help
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 7a5337e..e10626a 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -239,7 +239,8 @@ __v6_proc_info:
 	b	__v6_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_JAVA
+	/* See also feat_v6_fixup() for HWCAP_TLS */
+	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_JAVA|HWCAP_TLS
 	.long	cpu_v6_name
 	.long	v6_processor_functions
 	.long	v6wbi_tlb_fns
@@ -262,7 +263,8 @@ __pj4_v6_proc_info:
 	b	__v6_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
+	/* See also feat_v6_fixup() for HWCAP_TLS */
+	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
 	.long	cpu_pj4_name
 	.long	v6_processor_functions
 	.long	v6wbi_tlb_fns
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7aaf88a..8071bcd 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -344,7 +344,7 @@ __v7_proc_info:
 	b	__v7_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
+	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
 	.long	cpu_v7_name
 	.long	v7_processor_functions
 	.long	v7wbi_tlb_fns

