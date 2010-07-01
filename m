From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
 check for it on V6
Date: Thu, 1 Jul 2010 12:25:10 +0300
Message-ID: <20100701092510.GH2822@atomide.com>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
 <20100621135120.24299.98499.stgit@baageli.muru.com>
 <20100622170020.GF4371@shareable.org>
 <20100623073912.GA12255@atomide.com>
 <20100623133636.GC7058@shareable.org>
 <20100629141836.GM2822@atomide.com>
 <alpine.LFD.2.00.1006291355520.24097@xanadu.home>
 <20100630110828.GZ2822@atomide.com>
 <20100630131737.GF2822@atomide.com>
 <alpine.LFD.2.00.1006301011520.24097@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GBDnBH7+ZvLx8QD4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61144 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab0GAJZG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 05:25:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1006301011520.24097@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jamie Lokier <jamie@shareable.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Nicolas Pitre <nico@fluxnic.net> [100630 17:36]:
> On Wed, 30 Jun 2010, Tony Lindgren wrote:
> 
> > * Tony Lindgren <tony@atomide.com> [100630 14:02]:
> > > * Nicolas Pitre <nico@fluxnic.net> [100629 22:14]:
> > > 
> > > Updated patch below.
> > 
> > And a bug crept in..
> > 
> > > +	.macro set_tls_v6, tp, tmp1, tmp2
> > > +	ldr	\tmp1, =elf_hwcap
> > > +	ldr	\tmp1, [\tmp1, #0]
> > > +	mov	\tmp2, #0xffff0fff
> > > +	tst	\tmp2, #HWCAP_TLS		@ hardware TLS available?
> > > +	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
> > > +	streq	\tp, [\tmp2, #-15]		@ set TLS value at 0xffff0ff0
> > > +	.endm
> > 
> > The tst	\tmp2, #HWCAP_TLS should of course use \tmp1.
> > 
> > Also fixed a warning about adding parentheses around comparison
> > if (id & 0x410f0000) != 0x41070000).
> 
> Here you probably want (id & 0xff0f0000) and not (id & 0x410f0000).

Thanks, fixed.
 
> > Again, updated patch below.
> 
> I like it.  However, in proc-v6.S, you don't need to add a reference to 
> feat_v6_fixup() to the __pj4_v6_proc_info block.  Simply adding 
> HWCAP_TLS in that case should be fine as PJ4 always has the TLS reg.

Fixed that too.
 
> With the above fixes, you can add
> 
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks, updated patch below.

Tony

--GBDnBH7+ZvLx8QD4
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="arm-tls-v6.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 29 Jun 2010 13:34:53 +0300
Subject: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check for it on V6

The TLS register is only available on ARM1136 r1p0 and later.
Set HWCAP_TLS flags if hardware TLS is available and test for
it if CONFIG_CPU_32v6K is not set for V6.

Note that we set the TLS instruction in __kuser_get_tls
dynamically as suggested by Jamie Lokier <jamie@shareable.org>.

Also the __switch_to code is optimized out in most cases as
suggested by Nicolas Pitre <nico@fluxnic.net>.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>

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
diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
new file mode 100644
index 0000000..e565f33
--- /dev/null
+++ b/arch/arm/include/asm/tls.h
@@ -0,0 +1,46 @@
+#ifndef __ASMARM_TLS_H
+#define __ASMARM_TLS_H
+
+#ifdef __ASSEMBLY__
+	.macro set_tls_none, tp, tmp1, tmp2
+	.endm
+
+	.macro set_tls_v6k, tp, tmp1, tmp2
+	mcr	p15, 0, \tp, c13, c0, 3		@ set TLS register
+	.endm
+
+	.macro set_tls_v6, tp, tmp1, tmp2
+	ldr	\tmp1, =elf_hwcap
+	ldr	\tmp1, [\tmp1, #0]
+	mov	\tmp2, #0xffff0fff
+	tst	\tmp1, #HWCAP_TLS		@ hardware TLS available?
+	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
+	streq	\tp, [\tmp2, #-15]		@ set TLS value at 0xffff0ff0
+	.endm
+
+	.macro set_tls_software, tp, tmp1, tmp2
+	mov	\tmp1, #0xffff0fff
+	str	\tp, [\tmp1, #-15]		@ set TLS value at 0xffff0ff0
+	.endm
+#endif
+
+#ifdef CONFIG_TLS_REG_EMUL
+#define tls_emu		1
+#define has_tls		1
+#define set_tls		set_tls_none
+#elif __LINUX_ARM_ARCH__ >= 7 ||					\
+	(__LINUX_ARM_ARCH__ == 6 && defined(CONFIG_CPU_32v6K))
+#define tls_emu		0
+#define has_tls		1
+#define set_tls		set_tls_v6k
+#elif __LINUX_ARM_ARCH__ == 6
+#define tls_emu		0
+#define has_tls		(elf_hwcap & HWCAP_TLS)
+#define set_tls		set_tls_v6
+#else
+#define tls_emu		0
+#define has_tls		0
+#define set_tls		set_tls_software
+#endif
+
+#endif	/* __ASMARM_TLS_H */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 7ee48e7..a6cfb17 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -22,6 +22,7 @@
 #include <asm/thread_notify.h>
 #include <asm/unwind.h>
 #include <asm/unistd.h>
+#include <asm/tls.h>
 
 #include "entry-header.S"
 
@@ -739,12 +740,7 @@ ENTRY(__switch_to)
 #ifdef CONFIG_MMU
 	ldr	r6, [r2, #TI_CPU_DOMAIN]
 #endif
-#if defined(CONFIG_HAS_TLS_REG)
-	mcr	p15, 0, r3, c13, c0, 3		@ set TLS register
-#elif !defined(CONFIG_TLS_REG_EMUL)
-	mov	r4, #0xffff0fff
-	str	r3, [r4, #-15]			@ TLS val at 0xffff0ff0
-#endif
+	set_tls	r3, r4, r5
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
 #endif
@@ -1009,17 +1005,12 @@ kuser_cmpxchg_fixup:
  */
 
 __kuser_get_tls:				@ 0xffff0fe0
-
-#if !defined(CONFIG_HAS_TLS_REG) && !defined(CONFIG_TLS_REG_EMUL)
-	ldr	r0, [pc, #(16 - 8)]		@ TLS stored at 0xffff0ff0
-#else
-	mrc	p15, 0, r0, c13, c0, 3		@ read TLS register
-#endif
+	ldr	r0, [pc, #(16 - 8)]	@ read TLS, set in kuser_get_tls_init
 	usr_ret	lr
-
-	.rep	5
-	.word	0			@ pad up to __kuser_helper_version
-	.endr
+	mrc	p15, 0, r0, c13, c0, 3	@ 0xffff0fe8 hardware TLS code
+	.rep	4
+	.word	0			@ 0xffff0ff0 software TLS value, then
+	.endr				@ pad up to __kuser_helper_version
 
 /*
  * Reference declaration:
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 122d999..73921f1 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -269,6 +269,21 @@ static void __init cacheid_init(void)
 extern struct proc_info_list *lookup_processor_type(unsigned int);
 extern struct machine_desc *lookup_machine_type(unsigned int);
 
+static void __init feat_v6_fixup(void)
+{
+	int id = read_cpuid_id();
+
+	if ((id & 0xff0f0000) != 0x41070000)
+		return;
+
+	/*
+	 * HWCAP_TLS is available only on 1136 r1p0 and later,
+	 * see also kuser_get_tls_init.
+	 */
+	if ((((id >> 4) & 0xfff) == 0xb36) && (((id >> 20) & 3) == 0))
+		elf_hwcap &= ~HWCAP_TLS;
+}
+
 static void __init setup_processor(void)
 {
 	struct proc_info_list *list;
@@ -311,6 +326,8 @@ static void __init setup_processor(void)
 	elf_hwcap &= ~HWCAP_THUMB;
 #endif
 
+	feat_v6_fixup();
+
 	cacheid_init();
 	cpu_proc_init();
 }
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1621e53..e84d210 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -30,6 +30,7 @@
 #include <asm/unistd.h>
 #include <asm/traps.h>
 #include <asm/unwind.h>
+#include <asm/tls.h>
 
 #include "ptrace.h"
 #include "signal.h"
@@ -518,17 +519,20 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 
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
-#endif
+		if (tls_emu)
+			return 0;
+		if (has_tls) {
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
 		return 0;
 
 #ifdef CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG
@@ -743,6 +747,16 @@ void __init trap_init(void)
 	return;
 }
 
+static void __init kuser_get_tls_init(unsigned long vectors)
+{
+	/*
+	 * vectors + 0xfe0 = __kuser_get_tls
+	 * vectors + 0xfe8 = hardware TLS instruction at 0xffff0fe8
+	 */
+	if (tls_emu || has_tls)
+		memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfe8, 4);
+}
+
 void __init early_trap_init(void)
 {
 	unsigned long vectors = CONFIG_VECTORS_BASE;
@@ -761,6 +775,11 @@ void __init early_trap_init(void)
 	memcpy((void *)vectors + 0x1000 - kuser_sz, __kuser_helper_start, kuser_sz);
 
 	/*
+	 * Do processor specific fixups for the kuser helpers
+	 */
+	kuser_get_tls_init(vectors);
+
+	/*
 	 * Copy signal return handlers into the vector page, and
 	 * set sigreturn to be a pointer to these.
 	 */
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
index 7a5337e..2f5a3c2 100644
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
@@ -262,7 +263,7 @@ __pj4_v6_proc_info:
 	b	__v6_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
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

--GBDnBH7+ZvLx8QD4--
