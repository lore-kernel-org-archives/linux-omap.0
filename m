From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check
 for it on V6
Date: Thu, 18 Mar 2010 18:35:21 -0700
Message-ID: <20100319013521.GP2900@atomide.com>
References: <20100317175731.GE2900@atomide.com>
 <1268849278.19565.28.camel@e102109-lin.cambridge.arm.com>
 <20100317191114.GH2900@atomide.com>
 <1268910826.15334.32.camel@e102109-lin.cambridge.arm.com>
 <20100318170021.GN2900@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jB+02Y6wHc2pEa2x"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60494 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab0CSBdv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 21:33:51 -0400
Content-Disposition: inline
In-Reply-To: <20100318170021.GN2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--jB+02Y6wHc2pEa2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100318 09:55]:
> * Catalin Marinas <catalin.marinas@arm.com> [100318 04:10]:
> > On Wed, 2010-03-17 at 19:11 +0000, Tony Lindgren wrote:
> > > * Catalin Marinas <catalin.marinas@arm.com> [100317 11:04]:
> > > > On Wed, 2010-03-17 at 17:57 +0000, Tony Lindgren wrote:
> > > > > HAS_TLS reg is only on ARM11 starting with r1p0:
> > > > >
> > > > > http://infocenter.arm.com/help/topic/com.arm.doc.ddi0211k/Babeihid.html
> > > > >
> > > > > So that explains why it won't work on omap2420 as it's r0p2.
> > > >
> > > > Same here, would it work with dynamic detection?
> > > 
> > > Hmm I believe here the problem is __switch_to in entry-armv.S.
> > > I don't think we want to dynamically test it every time.. Or
> > > at least it would have to be optimized out in most cases.
> > 
> > But if you disable this, you won't be able to use an SMP build on both
> > v6 and v7. Anyway, I don't think that dynamically checking this would
> > introduce performance penalties, the __switch_to code is pretty complex
> > already with all the notifier calls.
> 
> OK. I'll take a look at setting the TLS a HWCAP flag.

Below is a patch for convert CONFIG_HAS_TLS_REG into HWCAP_TLS.

I've tested it with V6 r0p2 with no HWCAP_TLS, and V7 that has HWCAP_TLS.
I also forced CONFIG_TLS_REG_EMUL and booted on V6 r0p2, and it booted OK.

Could somebody please test this patch on a real CONFIG_TLS_REG_EMUL
system?

Also, I wonder if the change __kuser_get_tls is safe?

I changed it to assume that if 0xffff0ff0 == 0, then we have HWCAP_TLS.

Regards,

Tony

--jB+02Y6wHc2pEa2x
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="arm-check-tls.patch"

>From 81d4bf2481c4ef5fd80261605977b5f55e4515e4 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 18 Mar 2010 12:02:43 -0700
Subject: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check for it on V6

The TLS register is only available on V6 r1p0 and later.
Test for it and use it if available.

Signed-off-by: Tony Lindgren <tony@atomide.com>

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
index 6c5cf36..5a5aac8 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -739,11 +739,13 @@ ENTRY(__switch_to)
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
+	tst	r4, #HWCAP_TLS			@ hardware with TLS?
+	mcrne	p15, 0, r3, c13, c0, 3		@ set TLS register
+	moveq	r4, #0xffff0fff
+	streq	r3, [r4, #-15]			@ TLS val at 0xffff0ff0
 #endif
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
@@ -1009,15 +1011,12 @@ kuser_cmpxchg_fixup:
  */
 
 __kuser_get_tls:				@ 0xffff0fe0
-
-#if !defined(CONFIG_HAS_TLS_REG) && !defined(CONFIG_TLS_REG_EMUL)
-	ldr	r0, [pc, #(16 - 8)]		@ TLS stored at 0xffff0ff0
-#else
-	mrc	p15, 0, r0, c13, c0, 3		@ read TLS register
-#endif
+	ldr     r0, [pc, #(16 - 8)]		@ TLS set at 0xffff0ff0?
+	cmp	r0, #0				@ assume hw TLS if not set
+	mrceq	p15, 0, r0, c13, c0, 3		@ read TLS register
 	usr_ret	lr
 
-	.rep	5
+	.rep	3
 	.word	0			@ pad up to __kuser_helper_version
 	.endr
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c91c77b..de9d2dc 100644
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
index 1621e53..bdffef5 100644
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
+			*((unsigned int *)0xffff0ff0) = regs->ARM_r0;
+		}
 #endif
 		return 0;
 
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c4ed9f9..45e99c1 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -715,17 +715,6 @@ config TLS_REG_EMUL
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

--jB+02Y6wHc2pEa2x--
