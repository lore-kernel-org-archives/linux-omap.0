From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
 check for it on V6
Date: Tue, 29 Jun 2010 17:18:36 +0300
Message-ID: <20100629141836.GM2822@atomide.com>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
 <20100621135120.24299.98499.stgit@baageli.muru.com>
 <20100622170020.GF4371@shareable.org>
 <20100623073912.GA12255@atomide.com>
 <20100623133636.GC7058@shareable.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="61jdw2sOBCFtR2d/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62463 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919Ab0F2OSb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 10:18:31 -0400
Content-Disposition: inline
In-Reply-To: <20100623133636.GC7058@shareable.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Jamie Lokier <jamie@shareable.org> [100623 16:30]:
> Tony Lindgren wrote:
> > * Jamie Lokier <jamie@shareable.org> [100622 19:54]:
> > > Tony Lindgren wrote:
> > > >  __kuser_get_tls:				@ 0xffff0fe0
> > > > -
> > > > -#if !defined(CONFIG_HAS_TLS_REG) && !defined(CONFIG_TLS_REG_EMUL)
> > > > -	ldr	r0, [pc, #(16 - 8)]		@ TLS stored at 0xffff0ff0
> > > > -#else
> > > > -	mrc	p15, 0, r0, c13, c0, 3		@ read TLS register
> > > > -#endif
> > > > +	ldr     r0, [pc, #(20 - 8)]		@ software TLS set in 0xffff0ff4?
> > > > +	cmp	r0, #0				@ hardware TLS if flag not set
> > > > +	mrceq	p15, 0, r0, c13, c0, 3		@ read hardware TLS register
> > > > +	ldrne	r0, [pc, #(12 - 8)]		@ software TLS val at 0xffff0ff8
> > > >  	usr_ret	lr
> > > > -
> > > > -	.rep	5
> > > > -	.word	0			@ pad up to __kuser_helper_version
> > > > -	.endr
> > > > +	.word	0				@ non-zero for software TLS
> > > > +	.word	0				@ software TLS value
> > > 
> > > It'd be nice not to waste instructions checking for HWCAP_TLS on archs
> > > which definitely don't have it.  I guess it doesn't matter elsewhere;
> > > I'd expect this to be a warm path for some programs making extensive
> > > use of TLS (I haven't measured though).
> > 
> > OK, but let's try to figure out a way that does not add more ifdef else
> > code as that makes it harder to build support for multiple ARM cores.
> >  
> > > As it's only a single instruction, and the code is in a writable page
> > > already (copied at init), how about just patching the instruction
> > > when ELF_HWCAP is set?
> > 
> > Yeah that can be done for __kuser_get_tls if it's always writable.
> > But __switch_to is trickier because of the CONFIG_MMU ifdefs there.
> 
> __kuser_get_tls must be writable in kernels where !HAS_TLS_REG is
> supported, because the TLS value is written to the same page.
> 
> I was thinking of changing *only* __kuser_get_tls, by the way.  Out of
> all the different places, that's the only one I'd expect to be a hot
> path in some TLS-using programs.

OK. Sorry for the delay again. Here's an updated version that sets
__kuser_get_tls instruction dynamically. Does this do what you were
thinking, or did I miss something?

Also, can we detect somehow the hardware that uses CONFIG_TLS_REG_EMUL?
Might be possible to remove that Kconfig option too later on..

Regards,

Tony

--61jdw2sOBCFtR2d/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="arm-tls-v3.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 29 Jun 2010 13:34:53 +0300
Subject: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check for it on V6

The TLS register is only available on ARM1136 r1p0 and later.
Set HWCAP_TLS flags if hardware TLS is available.

Note that we set the TLS instruction in __kuser_get_tls
dynamically as suggested by Jamie Lokier <jamie@shareable.org>.

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
index 7ee48e7..949df9b 100644
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
+	mov	r5, #0xffff0fff
+	tst	r4, #HWCAP_TLS			@ hardware TLS available?
+	mcrne	p15, 0, r3, c13, c0, 3		@ yes, set TLS register
+	streq	r3, [r5, #-15]			@ set TLS value at 0xffff0ff0
 #endif
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
@@ -1009,16 +1011,13 @@ kuser_cmpxchg_fixup:
  */
 
 __kuser_get_tls:				@ 0xffff0fe0
-
-#if !defined(CONFIG_HAS_TLS_REG) && !defined(CONFIG_TLS_REG_EMUL)
-	ldr	r0, [pc, #(16 - 8)]		@ TLS stored at 0xffff0ff0
-#else
-	mrc	p15, 0, r0, c13, c0, 3		@ read TLS register
-#endif
+	nop				@ read TLS, set in kuser_get_tls_init
 	usr_ret	lr
-
-	.rep	5
-	.word	0			@ pad up to __kuser_helper_version
+	mrc	p15, 0, r0, c13, c0, 3	@ 0xffff0fe8 hardware TLS code
+	ldr	r0, [pc, #(16 - 8)]	@ 0xffff0fec software TLS code
+	.word	0			@ 0xffff0ff0 software TLS value
+	nop				@ pad up to __kuser_helper_version
+	nop
 	.endr
 
 /*
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 122d999..a675260 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -269,6 +269,27 @@ static void __init cacheid_init(void)
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
+	/*
+	 * HWCAP_TLS is available only on 1136 r1p0 and later,
+	 * see also kuser_get_tls_init.
+	 */
+	if ((((id >> 4) & 0xfff) == 0xb36) && (((id >> 20) & 3) == 0))
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
@@ -311,6 +332,8 @@ static void __init setup_processor(void)
 	elf_hwcap &= ~HWCAP_THUMB;
 #endif
 
+	feat_v6_fixup();
+
 	cacheid_init();
 	cpu_proc_init();
 }
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1621e53..85dd001 100644
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
 
@@ -743,6 +746,21 @@ void __init trap_init(void)
 	return;
 }
 
+#if defined(CONFIG_TLS_REG_EMUL)
+static void __init kuser_get_tls_init(unsigned long vectors)
+{
+	memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfe8, 4);
+}
+#else
+static void __init kuser_get_tls_init(unsigned long vectors)
+{
+	if (elf_hwcap & HWCAP_TLS)
+		memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfe8, 4);
+	else
+		memcpy((void *)vectors + 0xfe0, (void *)vectors + 0xfec, 4);
+}
+#endif
+
 void __init early_trap_init(void)
 {
 	unsigned long vectors = CONFIG_VECTORS_BASE;
@@ -761,6 +779,11 @@ void __init early_trap_init(void)
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

--61jdw2sOBCFtR2d/--
