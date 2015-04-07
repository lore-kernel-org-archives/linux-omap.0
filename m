From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Tue, 7 Apr 2015 14:57:13 +0100
Message-ID: <20150407135713.GL4027@n2100.arm.linux.org.uk>
References: <20150403225212.GY10805@atomide.com>
 <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:41174 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031AbbDGN5b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2015 09:57:31 -0400
Content-Disposition: inline
In-Reply-To: <20150406174245.GJ18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Matthijs van Duin <matthijsvanduin@gmail.com>

On Mon, Apr 06, 2015 at 10:42:45AM -0700, Tony Lindgren wrote:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [150406 10:15]:
> > On  6.04.2015 18:40, Tony Lindgren wrote:
> > >
> > >Oops sorry, wrong numbers for errata above.. s/458693/430973/, here's
> > >a better version:
> > >
> > >1. For cortex-a8 revisions affected by 430973, we can do a custom
> > >    cpu_v7_switch_mm function that always does flush BTAC/BTB.
> > >
> > 
> > Why custom function, if IBE bit is zero, BTB invalidate instruction is a
> > NOP. Do you think that "mcr p15, 0, r2, c7, c5, 6" executed as a NOP will
> > put so much overhead, that it deserves a custom function?
> 
> Hmm but it still seems to do something also on cortex-a8 r3p2 that
> is supposedly not affected by 430973.. Based on my tests so far, at least
> armhf running cpuburn-a8 in the background and doing apt-get update
> segfaults constantly without flush BTAC/BTB. This seems to be the case
> no matter how the aux ctrl reg bits are set.. This should be reproducable
> on any pandboard xm BTW.
>  
> > >2. For HS cortex-a8 processors other than n900 affected by 430973,
> > >    we need to implement functions similar to rx51_secure_update_aux_cr,
> > >    the bootrom on n900 is different from TI HS omaps so the SMC call
> > >    numbering may be different.
> > >
> > >3. For later cortex-a8 processors not affected by 430973, we need
> > >    to clear IBE bit to avoid erratum 687067.
> > >
> > 
> > Maybe it should be implemented something like:
> > 
> > 1. if Cortex-A8, always execute invalidate BTB instruction in
> >    cpu_v7_switch_mm
> 
> This part still seems to need more investigating for why it's still
> needed also r3p2 as I describe above. Otherwise we may be hiding some
> other bug.
>  
> > 2. For Cortex-A8 revisions affected by 430973, set IBE bit to 1, set it
> >    to 0 for all others. That should happen as soon as possible,
> >    otherwise kernel may crash on affected revisions if thumb-
> >    compiled.
> 
> Yes this makes sense.

Well, one thing we can do is to tweak the proc-v7*.S such that we detect
Cortex-A8 separately, and only execute the BTB flush for CA8 processors
if the errata is enabled.  Something like this (untested):

diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index bc86be205c04..fa385140715f 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -37,15 +37,18 @@
  *	It is assumed that:
  *	- we are not using split page tables
  */
-ENTRY(cpu_v7_switch_mm)
+ENTRY(cpu_ca8_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
-	mmid	r1, r1				@ get mm->context.id
-	ALT_SMP(orr	r0, r0, #TTB_FLAGS_SMP)
-	ALT_UP(orr	r0, r0, #TTB_FLAGS_UP)
 #ifdef CONFIG_ARM_ERRATA_430973
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
 #endif
+#endif
+ENTRY(cpu_v7_switch_mm)
+#ifdef CONFIG_MMU
+	mmid	r1, r1				@ get mm->context.id
+	ALT_SMP(orr	r0, r0, #TTB_FLAGS_SMP)
+	ALT_UP(orr	r0, r0, #TTB_FLAGS_UP)
 #ifdef CONFIG_PID_IN_CONTEXTIDR
 	mrc	p15, 0, r2, c13, c0, 1		@ read current context ID
 	lsr	r2, r2, #8			@ extract the PID
@@ -61,6 +64,7 @@ ENTRY(cpu_v7_switch_mm)
 #endif
 	bx	lr
 ENDPROC(cpu_v7_switch_mm)
+ENDPROC(cpu_ca8_switch_mm)
 
 /*
  *	cpu_v7_set_pte_ext(ptep, pte)
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b1d19ea5e1af..6bec3cfbea39 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -153,6 +153,21 @@ ENDPROC(cpu_v7_do_resume)
 #endif
 
 /*
+ * Cortex-A8
+ */
+	globl_equ	cpu_ca8_proc_init,	cpu_v7_proc_init
+	globl_equ	cpu_ca8_proc_fin,	cpu_v7_proc_fin
+	globl_equ	cpu_ca8_reset,		cpu_v7_reset
+	globl_equ	cpu_ca8_do_idle,	cpu_v7_do_idle
+	globl_equ	cpu_ca8_dcache_clean_area, cpu_v7_dcache_clean_area
+	globl_equ	cpu_ca8_set_pte_ext,	cpu_v7_set_pte_ext
+	globl_equ	cpu_ca8_suspend_size,	cpu_v7_suspend_size
+#ifdef CONFIG_ARM_CPU_SUSPEND
+	globl_equ	cpu_ca8_do_suspend,	cpu_v7_do_suspend
+	globl_equ	cpu_ca8_do_resume,	cpu_v7_do_resume
+#endif
+
+/*
  * Cortex-A9 processor functions
  */
 	globl_equ	cpu_ca9mp_proc_init,	cpu_v7_proc_init
@@ -471,7 +486,10 @@ __v7_setup_stack:
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+#ifndef CONFIG_ARM_LPAE
+	define_processor_functions ca8, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 	define_processor_functions ca9mp, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+#endif
 #ifdef CONFIG_CPU_PJ4B
 	define_processor_functions pj4b, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 #endif
@@ -527,6 +545,16 @@ __v7_ca9mp_proc_info:
 	__v7_proc __v7_ca9mp_proc_info, __v7_ca9mp_setup, proc_fns = ca9mp_processor_functions
 	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
 
+	/*
+	 * ARM Ltd. Cortex A8 processor.
+	 */
+	.type	__v7_ca8_proc_info, #object
+__v7_ca8_proc_info:
+	.long	0x410fc080
+	.long	0xff0ffff0
+	__v7_proc __v7_ca8mp_proc_info, proc_fns = ca8_processor_functions
+	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
+
 #endif	/* CONFIG_ARM_LPAE */
 
 	/*


-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
