From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Fix omap3 booting with thumb2 compiled kernel
Date: Wed, 27 May 2015 15:55:53 -0700
Message-ID: <20150527225553.GC30984@atomide.com>
References: <20150527215545.GA30984@atomide.com>
 <7h7frtmzoh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54214 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbbE0Wz4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2015 18:55:56 -0400
Content-Disposition: inline
In-Reply-To: <7h7frtmzoh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, tyler.baker@linaro.org, Stephen Boyd <sboyd@codeaurora.org>

* Kevin Hilman <khilman@kernel.org> [150527 15:20]:
> [ fix email for Dave Martin, +Tyler ]
> 
> Tony Lindgren <tony@atomide.com> writes:
> 
> > The power management related assembly needs to interact with
> > ARM mode bootrom code, so we need to keep most of the related
> > assembly in ARM mode.
> >
> > Currently we are entering into and ARM mode assembly function
> > from thumb2 mode, so we need to make sure we switch to ARM
> > mode. And we need to do that again after the cache flush.
> >
> > ---
> >
> > Kevin told me about this earlier today.. 
> 
> 
> And for full boot log/panics, see the kernelci.org thumb2 kernel boots
> that fail: http://kernelci.org/boot/?THUMB2_KERNEL&fail
> 
> > Anybody got better ideas for a fix here?
> 
> FWIW, a quick test of this patch makes my omap3-beagle-xm pass a simple
> boot test, but it fails with off idle.

Thanks to Stephen Boyd's suggestion of checking the missing ENDPROC,
here's a better fix :) Now off idle works too.

Regards,

Tony

8 <----------------------
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 27 May 2015 15:33:57 -0700
Subject: [PATCH] ARM: OMAP3: Fix booting with thumb2 kernel

We get a NULL pointer dereference on omap3 for thumb2 compiled kernels:

Internal error: Oops: 80000005 [#1] SMP THUMB2
...
[<c046497b>] (_raw_spin_unlock_irqrestore) from [<c0024375>]
(omap3_enter_idle_bm+0xc5/0x178)
[<c0024375>] (omap3_enter_idle_bm) from [<c0374e63>]
(cpuidle_enter_state+0x77/0x27c)
[<c0374e63>] (cpuidle_enter_state) from [<c00627f1>]
(cpu_startup_entry+0x155/0x23c)
[<c00627f1>] (cpu_startup_entry) from [<c06b9a47>]
(start_kernel+0x32f/0x338)
[<c06b9a47>] (start_kernel) from [<8000807f>] (0x8000807f)

The power management related assembly on moaps needs to interact with
ARM mode bootrom code, so we need to keep most of the related assembly
in ARM mode.

Turns out this error is because of missing ENDPROC for assembly code
as suggested by Stephen Boyd <sboyd@codeaurora.org>. Let's add the
missing ENDPROC in two places to sleep34xx.S, and also remove the
earlier mystery code that was probably also caused by missing ENDPROC
for earlier kernels.

Reported-by: Kevin Hilman <khilman@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -203,23 +203,8 @@ save_context_wfi:
 	 */
 	ldr	r1, kernel_flush
 	blx	r1
-	/*
-	 * The kernel doesn't interwork: v7_flush_dcache_all in particluar will
-	 * always return in Thumb state when CONFIG_THUMB2_KERNEL is enabled.
-	 * This sequence switches back to ARM.  Note that .align may insert a
-	 * nop: bx pc needs to be word-aligned in order to work.
-	 */
- THUMB(	.thumb		)
- THUMB(	.align		)
- THUMB(	bx	pc	)
- THUMB(	nop		)
-	.arm
-
 	b	omap3_do_wfi
-
-/*
- * Local variables
- */
+ENDPROC(omap34xx_cpu_suspend)
 omap3_do_wfi_sram_addr:
 	.word omap3_do_wfi_sram
 kernel_flush:
@@ -364,10 +349,7 @@ exit_nonoff_modes:
  * ===================================
  */
 	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
-
-/*
- * Local variables
- */
+ENDPROC(omap3_do_wfi)
 sdrc_power:
 	.word	SDRC_POWER_V
 cm_idlest1_core:
