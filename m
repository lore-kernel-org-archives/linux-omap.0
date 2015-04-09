From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Thu, 9 Apr 2015 14:48:43 +0100
Message-ID: <20150409134843.GQ4027@n2100.arm.linux.org.uk>
References: <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:46136 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbbDINs4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2015 09:48:56 -0400
Content-Disposition: inline
In-Reply-To: <20150408230658.GO4027@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 09, 2015 at 12:06:58AM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 07, 2015 at 08:22:08AM -0700, Tony Lindgren wrote:
> > Works for me. The above needs the following fix folded in to build:
> > 
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -532,7 +532,7 @@ __v7_ca9mp_proc_info:
> >  __v7_ca8_proc_info:
> >  	.long	0x410fc080
> >  	.long	0xff0ffff0
> > -	__v7_proc __v7_ca8mp_proc_info, proc_fns = ca8_processor_functions
> > +	__v7_proc __v7_ca8_proc_info, __v7_setup, proc_fns = ca8_processor_functions
> >  	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
> >  
> >  #endif	/* CONFIG_ARM_LPAE */
> 
> Thanks, merged into the original patch.

Do you want to give me an ack for this, thanks?

8<===
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] ARM: proc-v7: avoid errata 430973 workaround for non-Cortex
 A8 CPUs

Avoid the errata 430973 workaround for non-Cortex A8 CPUs.  Having this
workaround enabled introduces an additional branch target buffer flush
into the context switching path, something we wish to avoid.  To allow
this errata to be enabled in multiplatform kernels while reducing its
impact, rearrange the Cortex-A8 CPU support to avoid impacting on other
Version 7 CPUs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-v7-2level.S | 12 ++++++++----
 arch/arm/mm/proc-v7.S        | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

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
index b1d19ea5e1af..003190ae9cd8 100644
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
+	__v7_proc __v7_ca8_proc_info, __v7_setup, proc_fns = ca8_processor_functions
+	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
+
 #endif	/* CONFIG_ARM_LPAE */
 
 	/*
-- 
1.8.3.1

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
