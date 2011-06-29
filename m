From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP3: run the ASM sleep code from DDR
Date: Wed, 29 Jun 2011 22:54:23 +0100
Message-ID: <20110629215423.GI23312@n2100.arm.linux.org.uk>
References: <1309365623-14704-1-git-send-email-j-pihet@ti.com> <87mxh0tuk2.fsf@ti.com> <20110629180535.GF23312@n2100.arm.linux.org.uk> <8762nosbj4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51768 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab1F2Vyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 17:54:36 -0400
Content-Disposition: inline
In-Reply-To: <8762nosbj4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

On Wed, Jun 29, 2011 at 12:06:07PM -0700, Kevin Hilman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Wed, Jun 29, 2011 at 10:29:49AM -0700, Kevin Hilman wrote:
> >> Russell, if you're OK with it, can you add it to your suspend branch for
> >> the upcoming merge window?
> >
> > Yes - though I think we can go a little bit further - this patch is on
> > top of my code so far, and is untested.  There isn't a need for the
> > saving of these registers to be in assembly because we can read them
> > just as easily from C code.
> 
> Indeed
> 
> > Comments?
> 
> Looks good to me (although untested) care to respin on top of $SUBJECT
> patch?  
> 
> Minor comments below...

Done.

 arch/arm/mach-omap2/pm.h        |    2 +-
 arch/arm/mach-omap2/pm34xx.c    |   19 ++++++++++++++++++-
 arch/arm/mach-omap2/sleep34xx.S |   12 ++----------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index a4ec213..04ee566 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -97,7 +97,7 @@ extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
 extern unsigned int omap24xx_cpu_suspend_sz;
 
 /* 3xxx */
-extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
+extern void omap34xx_cpu_suspend(int save_state);
 
 /* omap3_do_wfi function pointer and size, for copy to SRAM */
 extern void omap3_do_wfi(void);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e1c79ba..7238a63 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -306,9 +306,24 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void omap34xx_save_context(u32 *save)
+{
+	u32 val;
+
+	/* Read Auxiliary Control Register */
+	asm("mrc p15, 0, %0, c1, c0, 1" : "=r" (val));
+	*save++ = 1;
+	*save++ = val;
+
+	/* Read L2 AUX ctrl register */
+	asm("mrc p15, 1, %0, c9, c0, 2" : "=r" (val));
+	*save++ = 1;
+	*save++ = val;
+}
+
 static void omap34xx_do_sram_idle(unsigned long save_state)
 {
-	omap34xx_cpu_suspend(omap3_arm_context, save_state);
+	omap34xx_cpu_suspend(save_state);
 }
 
 void omap_sram_idle(void)
@@ -408,6 +423,8 @@ void omap_sram_idle(void)
 	 * get saved. The rest is placed on the stack, and restored
 	 * from there before resuming.
 	 */
+	if (save_state)
+		omap34xx_save_context(omap3_arm_context);
 	if (save_state == 1 || save_state == 3)
 		cpu_suspend(save_state, omap34xx_do_sram_idle);
 	else
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 17dbc5a..f2ea1bd 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -152,8 +152,7 @@ ENTRY(omap34xx_cpu_suspend)
 	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
 
 	/*
-	 * r0 contains CPU context save/restore pointer in sdram
-	 * r1 contains information about saving context:
+	 * r0 contains information about saving context:
 	 *   0 - No context lost
 	 *   1 - Only L1 and logic lost
 	 *   2 - Only L2 lost (Even L1 is retained we clean it along with L2)
@@ -166,19 +165,12 @@ ENTRY(omap34xx_cpu_suspend)
 	 */
 	ldr	r4, omap3_do_wfi_sram_addr
 	ldr	r5, [r4]
-	cmp	r1, #0x0		@ If no context save required,
+	cmp	r0, #0x0		@ If no context save required,
 	bxeq	r5			@  jump to the WFI code in SRAM
 
 
 	/* Otherwise fall through to the save context code */
 save_context_wfi:
-	mov	r8, r0			@ Store SDRAM address in r8
-	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
-	mov	r4, #0x1		@ Number of parameters for restore call
-	stmia	r8!, {r4-r5}		@ Push parameters for restore call
-	mrc	p15, 1, r5, c9, c0, 2	@ Read L2 AUX ctrl register
-	stmia	r8!, {r4-r5}		@ Push parameters for restore call
-
 	/*
 	 * jump out to kernel flush routine
 	 *  - reuse that code is better
